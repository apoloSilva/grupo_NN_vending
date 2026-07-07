# Synopsys Design Compiler script para máquina de vendas

# -------------------------------------------------------------------------
# Caminhos para arquivos do projeto e bibliotecas
# -------------------------------------------------------------------------
set ROOT_DIR  [pwd]; # diretório onde o dc_shell é executado
set RTL_DIR   $ROOT_DIR/rtl
set LIBS_DIR  $ROOT_DIR/libs
set SYNTH_DIR $ROOT_DIR/synth

set_app_var search_path [list \
    $ROOT_DIR \
    $RTL_DIR \
    $LIBS_DIR \
]

# -------------------------------------------------------------------------
# Top do design a sintetizar
# -------------------------------------------------------------------------
set TOP vending_top

# -------------------------------------------------------------------------
# Bibliotecas alvo e link
# -------------------------------------------------------------------------
set_app_var target_library [list \
    saed32rvt_tt1p05v25c.db \
]

set_app_var link_library [concat \
    "*" \
    $target_library \
    [list dw_foundation.sldb] \
]

# Biblioteca DesignWare
set_app_var synthetic_library [list \
    dw_foundation.sldb \
]

define_design_lib WORK -path ./work

# -------------------------------------------------------------------------
# Configurações SystemVerilog
# -------------------------------------------------------------------------
set hdlin_enable_rtldrc_info true; # Habilita mensagens mais detalhadas durante DRC
set hdlin_check_no_latch true; # força DC a emitir aviso quando uma inferência de latch ocorre
set compile_autonogate true; # desabilita clock gating

# -------------------------------------------------------------------------
# Análise, síntese RTL e geração de relatórios para synth/reports
# -------------------------------------------------------------------------

analyze -format sverilog [list \
    $RTL_DIR/vending_pkg.sv \
    $RTL_DIR/credit_reg.sv \
    $RTL_DIR/memory.sv \
    $RTL_DIR/comparator.sv \
    $RTL_DIR/subtractor.sv \
    $RTL_DIR/control_unit.sv \
    $RTL_DIR/vending_top.sv]

elaborate $TOP
current_design $TOP
link

read_sdc $SYNTH_DIR/vending.sdc; # carrega arquivo sdc
redirect $SYNTH_DIR/reports/check_design.rpt {check_design}
compile_ultra -no_autoungroup

redirect $SYNTH_DIR/reports/report_area.rpt {report_area}
redirect $SYNTH_DIR/reports/report_timing.rpt {report_timing -max_paths 10}
redirect $SYNTH_DIR/reports/report_power.rpt {report_power}
redirect $SYNTH_DIR/reports/report_constraints.rpt {report_constraint -all_violators}

write -format verilog -hierarchy -output $SYNTH_DIR/${TOP}_syn.v; # gera arquivo sintetizado em .v
write -format ddc -hierarchy -output $SYNTH_DIR/${TOP}_syn.ddc; # gera arquivo sintetizado em .ddc

quit
