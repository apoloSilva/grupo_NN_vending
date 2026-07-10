# ==========================================
# Diretórios
# ==========================================
RTL_DIR   := rtl
TB_DIR    := sim
SYNTH_DIR := synth

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
# (mantidas apenas como referência)
# ==========================================
TIMESCALE = 1ns/1ps

VLOGAN_FLAGS = -full64 \
               -sverilog \
               -kdb \
               +lint=all

VCS_FLAGS = -full64 -timescale=$(TIMESCALE) \
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
synth:
	dc_shell -f $(SYNTH_DIR)/synth.tcl # padrão
#	CLK_PERIOD=18 dc_shell -f $(SYNTH_DIR)/synth.tcl

# ==========================================
# Limpeza da síntese
# ==========================================
clean_synth:
	rm -rf \
		./alib-52 \
		./default.svf \
		./work*

	# Remove relatórios e arquivos intermediários antigos de síntese.
	find $(SYNTH_DIR) -type f \( \
		-name "*.ddc" -o \
		-name "*.db" -o \
		-name "*.rpt" \
	\) -delete

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
		*.aux \


# ==========================================
# Limpeza total
# ==========================================
clean: clean_sim clean_synth

.PHONY: syntax lint_rtl compile run wave synth clean clean_sim clean_synth
