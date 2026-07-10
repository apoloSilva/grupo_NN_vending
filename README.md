# Controlador de Vending Machine em SystemVerilog

O projeto implementa um controlador de máquina de vendas utilizando SystemVerilog. O sistema é composto por uma unidade de controle baseada em uma máquina de estados de Moore, memória síncrona, registrador de crédito e blocos combinacionais de comparação e subtração.

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
├── sim/
│   └── tb_vending.sv
└── synth/
    ├── synth.tcl
    ├── vending.sdc
    └── reports/
```

## Verificação de sintaxe

Para analisar os arquivos RTL e o testbench com o Vlogan:

```bash
make syntax
```

## Compilação

Para verificar a sintaxe e elaborar o testbench com o VCS:

```bash
make compile`
```
## Simulação

Para compilar e executar o testbench:

```bash
make run
```

Esse alvo executa, em sequência:

- análise dos arquivos com `vlogan`;
- elaboração com `vcs`;
- execução do simulador `simv`.

Durante a simulação, o testbench gera o arquivo de formas de onda:

```text
waves.fsdb
```

## Visualização das formas de onda

Depois de executar a simulação, abra o arquivo FSDB no Verdi com:

```bash
make wave
```

## Síntese com Design Compiler

Para executar a síntese:

```bash
make synth
```

Antes da síntese, os arquivos antigos de simulação e síntese são removidos. Atualmente, o período de clock utilizado é 6 ns.

Para utilizar outro período de clock, altere o valor de `CLK_PERIOD` no alvo `synth` do `Makefile`.

Os relatórios de síntese são armazenados em:

```text
synth/reports/
```

## Limpeza

Para remover apenas os arquivos gerados pela simulação:

```bash
make clean_sim
```

Para remover apenas os arquivos gerados pela síntese:

```bash
make clean_synth
```

Para remover todos os arquivos gerados:

```bash
make clean
```

## Todos os alvos disponíveis

| Alvo | Descrição |
|---|---|
| `make syntax` | Analisa a sintaxe do RTL e do testbench com o Vlogan |
| `make compile` | Analisa e elabora o projeto com o VCS |
| `make run` | Compila e executa a simulação |
| `make wave` | Abre o arquivo `waves.fsdb` no Verdi |
| `make synth` | Executa a síntese com período de clock de 6 ns |
| `make clean_sim` | Remove os arquivos gerados pela simulação |
| `make clean_synth` | Remove os arquivos gerados pela síntese |
| `make clean` | Executa a limpeza completa |
