# Synopsys Design Compiler script para máquina de vendas

# -------------------------------------------------------------------------
# Caminhos para arquivos do projeto e bibliotecas
# -------------------------------------------------------------------------
set ROOT_DIR  [pwd]; # diretório onde o dc_shell é executado
set RTL_DIR   $ROOT_DIR/rtl
set LIBS_DIR  $ROOT_DIR/libs
set SYNTH_DIR $ROOT_DIR/synth

file mkdir $ROOT_DIR/work
file mkdir $SYNTH_DIR/reports

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
# Período do clock
# -------------------------------------------------------------------------

# Deve ser informado na execução, por exemplo:
# CLK_PERIOD=18 dc_shell -f synth/synth.tcl
if {![info exists ::env(CLK_PERIOD)] || $::env(CLK_PERIOD) eq ""} {
    error "A variável de ambiente CLK_PERIOD não foi definida. Execute, por exemplo: CLK_PERIOD=18 dc_shell -f synth/synth.tcl"
}

# Variável Tcl global, visível pelo arquivo vending.sdc.
set ::CLK_PERIOD $::env(CLK_PERIOD)



puts "INFO: synth.tcl - CLK_PERIOD = $::CLK_PERIOD ns"



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
set hdlin_check_no_latch true;     # Força DC a emitir aviso quando uma inferência de latch ocorre
set compile_autonogate true;       # Desabilita clock gating

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
    $RTL_DIR/vending_top.sv \
]

elaborate $TOP
current_design $TOP
link

# Carrega o SDC no mesmo contexto Tcl, permitindo o uso de ::CLK_PERIOD.
source $SYNTH_DIR/vending.sdc

set_fix_hold [get_clocks clk] # não observei mudanças com ou sem

redirect $SYNTH_DIR/reports/check_design.rpt {
    check_design
}

compile_ultra -no_autoungroup
#compile_ultra

redirect $SYNTH_DIR/reports/report_area.rpt {
    report_area
}

redirect $SYNTH_DIR/reports/report_timing.rpt {
    report_timing -max_paths 10
}


redirect $SYNTH_DIR/reports/report_power.rpt {
    report_power
}

redirect $SYNTH_DIR/reports/report_constraints.rpt {
    report_constraint -all_violators
}

# Gera arquivo sintetizado em Verilog.
write -format verilog \
      -hierarchy \
      -output $SYNTH_DIR/${TOP}_syn.v

# Gera banco de dados sintetizado do Design Compiler.
write -format ddc \
      -hierarchy \
      -output $SYNTH_DIR/${TOP}_syn.ddc

quit


