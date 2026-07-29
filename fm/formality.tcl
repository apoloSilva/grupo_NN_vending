# Synopsys Formality script  para máquina de vendas - MANUAL

# 1. Caminhos para arquivos do projeto e bibliotecas

set ROOT_DIR  [pwd]; # diretório onde o fm_shell é executado
set RTL_DIR   $ROOT_DIR/rtl
set LIBS_DIR  $ROOT_DIR/libs
set SYNTH_DIR $ROOT_DIR/synth
set FORMAL_DIR $ROOT_DIR/fm

set rtl_files [list \
	$RTL_DIR/vending_pkg.sv \
	$RTL_DIR/credit_reg.sv \
	$RTL_DIR/memory.sv \
	$RTL_DIR/comparator.sv \
	$RTL_DIR/subtractor.sv \
	$RTL_DIR/control_unit.sv \
	$RTL_DIR/vending_top.sv \
]

set TOP vending_top; #top do design a verificar

# 2. habilita o modo de setup automático baseado no SVF
set synopsys_auto_setup true

# 3. Guidance 
set_svf $FORMAL_DIR/reports/default.svf; # gerado a partir da síntese em dc

# 4. Design de referência (golden) — RTL pré-síntese
read_sverilog -r $rtl_files
set_top r:/WORK/$TOP

# 5. Design revisado — netlist gerada pelo Design Compiler
read_db $LIBS_DIR/saed32rvt_tt1p05v25c.db
read_verilog -i $SYNTH_DIR/${TOP}_syn.v
set_top i:/WORK/$TOP

# 6. Casamento de pontos entre golden e revised, usando o guidance do SVF
match

# Salvando operações do SVF que foram usadas com sucesso como guidance e que foram rejetidas
report_svf_operation -status accepted > $FORMAL_DIR/reports/formality_svf_accepted.rpt
report_svf_operation -status rejected > $FORMAL_DIR/reports/formality_svf_rejected.rpt

# Resultados do casamento (matching)
report_matched_points > $FORMAL_DIR/reports/formality_matched.rpt
report_unmatched_points > $FORMAL_DIR/reports/formality_unmatched.rpt

# 7. Prova de equivalência ponto a ponto
verify

# 8. Relatórios de sign-off
report_status > $FORMAL_DIR/reports/formality_status.rpt
report_passing_points > $FORMAL_DIR/reports/formality_passing.rpt
report_failing_points > $FORMAL_DIR/reports/formality_failing.rpt
report_unmatched_points > $FORMAL_DIR/reports/formality_unmatched.rpt

exit







