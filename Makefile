# ==========================================
# Diretórios
# ==========================================
RTL_DIR   := rtl
SYNTH_DIR := synth
FORMAL_DIR := fm

# ==========================================
# Arquivos
# ==========================================
RTL_FILES := \
    $(RTL_DIR)/vending_pkg.sv \
    $(RTL_DIR)/credit_reg.sv \
    $(RTL_DIR)/memory.sv \
    $(RTL_DIR)/comparator.sv \
    $(RTL_DIR)/subtractor.sv \
    $(RTL_DIR)/control_unit.sv \
    $(RTL_DIR)/vending_top.sv

# ==========================================
# Módulos de topo
# ==========================================
RTL_TOP := vending_top


# Arquivo de formas de onda gerado pelo testbench
WAVE_FILE := waves.fsdb

# ==========================================
# Flags das ferramentas comerciais
# ==========================================
VLOGAN_FLAGS = -full64 \
               -sverilog \
               -kdb \
               +lint=all

# ==========================================
# Verificação de sintaxe
# ==========================================
syntax:
	vlogan $(VLOGAN_FLAGS) $(RTL_FILES) $(TB_FILES)

# ==========================================
# Síntese
# ==========================================
synth: clean_synth
	CLK_PERIOD=6 dc_shell -f $(SYNTH_DIR)/synth.tcl

# ==========================================
# Verificação formal usando formality
# ==========================================

gen_fm:
	fm_mk_script $(FORMAL_DIR)/reports/default.svf -output $(FORMAL_DIR)/formality_auto.tcl

fm_run: clean_fm
	fm_shell -f $(FORMAL_DIR)/formality.tcl | tee -i $(FORMAL_DIR)/reports/formality.log
#	fm_shell -f $(FORMAL_DIR)/formality_auto.tcl | tee -i $(FORMAL_DIR)/reports/formality_auto.log

rungui:
	fm_shell -gui

# ==========================================
# Limpeza da síntese
# ==========================================
clean_synth:
	rm -rf \
	    ./alib-52 \
	    ./default.svf \
	    $(FORMAL_DIR)/reports/default.svf \
	    ./work*

	# Remove relatórios e arquivos intermediários antigos de síntese.

	find "$(SYNTH_DIR)" -type f \( \
	    -name "*.log" -o \
	    -name "*.db" -o \
	    -name "*.rpt" -o \
	    -name "*.ddc" -o \
	    -name "*.v" \
	\) -delete

# ========================================== 
# Limpeza da verificação formal
# ==========================================
clean_fm :
	rm -f *.log *.conf ; rm -rf  default.svf formality_svf FM_INFO sysProgressPLog post_verify.fss

	# Remove relatórios e arquivos intermediários antigos da verificação formal.
	find $(FORMAL_DIR) -type f \( \
	    -name "*.log" -o \
	    -name "*.rpt" \
	\) -delete

# ==========================================
# Limpeza total
# ==========================================
clean: clean_sim clean_synth clean_fm

.PHONY: syntax compile run wave synth clean clean_sim clean_synth gen_fm fm_run rungui clean_fm


