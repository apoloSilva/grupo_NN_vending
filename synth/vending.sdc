# Synopsys Design Constraints para máquina de vendas

# -------------------------------------------------------------------------
# Verificação do período de clock
# -------------------------------------------------------------------------
# A variável deve ter sido definida pelo script synth.tcl.
if {![info exists ::CLK_PERIOD] || $::CLK_PERIOD eq ""} {
    error "CLK_PERIOD não foi definido antes da leitura do arquivo vending.sdc."
}

puts "INFO: vending.sdc - CLK_PERIOD = $::CLK_PERIOD ns"


create_clock -name clk -period $::CLK_PERIOD [get_ports clk]
set_clock_uncertainty 0.5 [get_clocks clk]

# -------------------------------------------------------------------------
# Atrasos de entrada e saída
# -------------------------------------------------------------------------
# Todas as entradas, exceto o próprio clock.
set INPUT_PORTS [get_ports {
    coin_in[*]
    sel_item[*]
    confirm
    cancel
    rst
}]

# Todas as saídas do módulo top-level.
set OUTPUT_PORTS [all_outputs]

set_input_delay 3.0 -clock [get_clocks clk] $INPUT_PORTS
set_output_delay 3.0 -clock [get_clocks clk] $OUTPUT_PORTS

# -------------------------------------------------------------------------
# Driving cell e load
# -------------------------------------------------------------------------
# Célula típica da biblioteca dirigindo as entradas.
set_driving_cell -lib_cell NBUFFX2_RVT $INPUT_PORTS

# Carga capacitiva típica aplicada às saídas.
set_load 0.05 $OUTPUT_PORTS


