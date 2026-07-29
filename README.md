# ATIVIDADE AVALIATIVA: Verificação de Equivalência Formal

> Este branch contém os arquivos utilizados na verificação de equivalência formal do controlador de vending machine.
>
> A implementação, a simulação e a síntese originais do controlador estão disponíveis no branch [`main`](https://github.com/apoloSilva/grupo_NN_vending).

## Descrição do projeto

O projeto realiza a verificação de equivalência formal entre a descrição RTL do controlador de vending machine, desenvolvida em SystemVerilog, e a netlist gerada pelo Synopsys Design Compiler.

A descrição RTL é utilizada como design de referência (*golden*), enquanto a netlist sintetizada é utilizada como design revisado (*revision*). A verificação é realizada com o Synopsys Formality, utilizando o arquivo SVF gerado durante a síntese como orientação para o casamento dos pontos de comparação.

O relatório em PDF apresenta os procedimentos adotados e os resultados obtidos.

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
```

## Execução

Para executar a síntese com período de *clock* de 6 ns e gerar a netlist e o arquivo SVF:

```bash
make synth
```

Para gerar o script automático do Formality a partir do SVF:

```bash
make gen_fm
```

O arquivo automático é utilizado apenas para conferir o script `formality.tcl`, desenvolvido manualmente.

Para executar a verificação de equivalência formal:

```bash
make fm_run
```

Os relatórios são gerados no diretório `fm/reports/`.

Para abrir a interface gráfica do Formality:

```bash
make rungui
```

## Limpeza

Para remover os arquivos gerados pela síntese:

```bash
make clean_synth
```

Para remover os arquivos gerados pelo Formality:

```bash
make clean_fm
```



