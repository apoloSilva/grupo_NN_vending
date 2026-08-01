# ATIVIDADES AVALIATIVAS: Controlador de Vending Machine e Verificação de Equivalência Formal

> Este repositório contém a implementação, a simulação, a síntese e a verificação de equivalência formal do controlador de vending machine.

## Descrição do projeto

O projeto implementa um controlador de máquina de vendas utilizando SystemVerilog. O sistema é composto principalmente por uma unidade de controle baseada em uma máquina de estados de Moore, memória síncrona, registrador de crédito e blocos combinacionais de comparação e subtração.

Além disso, o projeto realiza a verificação de equivalência formal entre a descrição RTL do controlador e a netlist.

O relatório em PDF apresenta mais detalhes sobre a arquitetura, a simulação, a síntese e os resultados da verificação de equivalência formal.

## Estrutura do projeto

```text
grupo_NN_vending/
├── relatorio.pdf
├── Makefile
├── rtl/
│   ├── vending_pkg.sv
│   ├── credit_reg.sv
│   ├── memory.sv
│   ├── comparator.sv
│   ├── subtractor.sv
│   ├── control_unit.sv
│   └── vending_top.sv
├── sim/
│   └── tb_vending.sv
├── synth/
│   ├── synth.tcl
│   ├── vending.sdc
│   ├── vending_top_syn.v
│   └── reports/
│       ├── default.svf
│       └── ...
└── fm/
    ├── formality.tcl
    ├── formality_auto.tcl
    └── reports/
│       └── ...
```

## Verificação de sintaxe

Para analisar os arquivos RTL e o testbench com o comando `vlogan`, execute:

```bash
make syntax
```

## Compilação

Para analisar os arquivos e elaborar o testbench com o VCS, execute:

```bash
make compile
```

## Simulação

Para compilar e executar o testbench, utilize:

```bash
make run
```

Esse alvo executa, em sequência:

- a análise dos arquivos com `vlogan`;
- a elaboração do projeto com `vcs`;
- a execução do simulador `simv`.

Durante a simulação, o testbench gera o seguinte arquivo de formas de onda:

```text
waves.fsdb
```

## Visualização das formas de onda

Depois de executar a simulação, abra o arquivo FSDB no Verdi com:

```bash
make wave
```

## Síntese com Design Compiler

Para executar a síntese e gerar a netlist e o arquivo SVF, utilize:

```bash
make synth
```

Antes da síntese, os arquivos antigos gerados pela simulação e pela síntese são removidos.

Atualmente, o período de clock utilizado é de 6 ns.

Para utilizar outro período de clock, altere o valor de `CLK_PERIOD` no alvo `synth` do `Makefile`.

Os relatórios de síntese são armazenados em:

```text
synth/reports/
```

## Verificação de equivalência formal

Para executar a verificação de equivalência formal, utilize:

```bash
make fm_run
```

Para abrir a interface gráfica do Formality, utilize:

```bash
make rungui
```

Os relatórios da verificação são armazenados em:

```text
fm/reports/
```

## Limpeza

Para remover apenas os arquivos gerados pela simulação, execute:

```bash
make clean_sim
```

Para remover apenas os arquivos gerados pela síntese, execute:

```bash
make clean_synth
```

Para remover apenas os arquivos gerados pelo Formality, execute:

```bash
make clean_fm
```

Para remover todos os arquivos gerados, execute:

```bash
make clean
```

## Alvos disponíveis

| Alvo | Descrição |
|---|---|
| `make syntax` | Analisa a sintaxe do RTL e do testbench com o comando `vlogan` |
| `make compile` | Analisa e elabora o projeto com o VCS |
| `make run` | Compila e executa a simulação |
| `make wave` | Abre o arquivo `waves.fsdb` no Verdi |
| `make synth` | Executa a síntese com período de clock de 6 ns e gera a netlist e o arquivo SVF |
| `make fm_run` | Executa a verificação de equivalência formal |
| `make gen_fm` | Gera setup automático para Formality a partir de `default.svf`
| `make rungui` | Abre a interface gráfica do Formality |
| `make clean_sim` | Remove os arquivos gerados pela simulação |
| `make clean_synth` | Remove os arquivos gerados pela síntese |
| `make clean_fm` | Remove os arquivos gerados pelo Formality |
| `make clean` | Executa a limpeza completa |


