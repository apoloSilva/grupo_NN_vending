# ATIVIDADE AVALIATIVA: Verificação de Equivalência Formal


> Este branch contém os arquivos utilizados na verificação de equivalência formal do controlador de vending machine.
>
> A implementação, a simulação e a síntese originais do controlador estão disponíveis no branch `main`.


## Descrição do projeto


O projeto realiza a verificação de equivalência formal entre a descrição RTL do controlador de vending machine, desenvolvida em SystemVerilog, e a netlist gerada pelo Synopsys Design Compiler.


A descrição RTL é utilizada como projeto de referência (*golden*), enquanto a netlist sintetizada é utilizada como implementação (*revision*). A verificação é realizada com o Synopsys Formality, utilizando o arquivo SVF gerado durante a síntese como orientação para o casamento dos pontos de comparação.


## Estrutura do projeto


```text
grupo_NN_vending/
├── Makefile
├── rtl/
│   ├── vending_pkg.sv
│   ├── credit_reg.sv
│   ├── memory.sv
│   ├── comparator.sv
│   ├── subtractor.sv
│   ├── control_unit.sv
│   └── vending_top.sv
├── synth/
│   ├── synth.tcl
│   ├── vending.sdc
│   ├── vending_top_netlist.v
│   └── reports/
│       ├── default.svf
│       ├── dwsvf_default/
│       └── ...
├── fm/
│   ├── formality.tcl
│   ├── formality_submodules.tcl
│   └── reports/
│       ├── formality_status.rpt
│       ├── formality_passing.rpt
│       ├── formality_failing.rpt
│       ├── formality_unmatched.rpt
│       ├── formality_svf_accepted.rpt
│       └── formality_svf_rejected.rpt
└── relatorio_equivalencia.pdf




