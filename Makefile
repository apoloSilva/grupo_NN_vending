# ==========================================
# Diretórios
# ==========================================
RTL_DIR   := rtl
TB_DIR    := sim
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

TB_FILES := $(TB_DIR)/tb_vending.sv

# ==========================================
# Módulos de topo
# ==========================================
RTL_TOP := vending_top
TOP     := tb_vending

# Arquivo de formas de onda gerado pelo testbench
WAVE_FILE := waves.fsdb

# ==========================================
# Flags das ferramentas comerciais
# ==========================================
VLOGAN_FLAGS = -full64 \
               -sverilog \
               -kdb \
               +lint=all

VCS_FLAGS = -full64 \
            -timescale=$(TIMESCALE) \
            -debug_access+all \
            -kdb

# ==========================================
# Verificação de sintaxe
# ==========================================
syntax:
	vlogan $(VLOGAN_FLAGS) $(RTL_FILES) $(TB_FILES)

# ==========================================
# Compilação / Elaboração
# ==========================================
compile: syntax
	vcs $(VCS_FLAGS) -top $(TOP)

# ==========================================
# Simulação
# ==========================================
run: compile
	./simv

# ==========================================
# Abrir waveform
# ==========================================
wave:
	verdi -ssf $(WAVE_FILE) &

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
# Limpeza da simulação
# ==========================================
clean_sim:
	rm -rf \
	    csrc \
	    simv* \
	    obj_dir \
	    *.daidir \
	    novas* \
	    AN.DB \
	    ucli.key \
	    verdi* \
	    DVEfiles \
	    .vlogan* \
	    *.fsdb \
	    *.fst \
	    *.vcd \
	    *.log \
	    *.out \
	    *.fls \
	    *.gz \
	    *.fdb_latexmk \
	    *.aux


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


