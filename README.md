# Controlador de Vending Machine em SystemVerilog

Estrutura principal:

```text
grupo_NN_vending/
├── rtl/
├── sim/
├── synth/
├── relatorio/
└── results/
```

## Simulação com VCS

No diretório raiz:

```bash
make sim
```

O `Makefile` executa `vlogan`, elabora com `vcs`, roda `simv` e salva a saída em `results/vcs_simulation.log`.

## Verdi

Depois de executar a simulação, abra a forma de onda gerada pelo ambiente configurado no laboratório. Caso o fluxo gere FSDB, use:

```bash
make verdi
```

## Síntese com Design Compiler

Defina a biblioteca disponível no laboratório. Exemplo:

```bash
export STD_CELL_LIB=/caminho/para/biblioteca.db
export DRIVING_CELL=BUFX2
make synth
```

Os nomes exatos de biblioteca e célula de drive devem ser ajustados para o ambiente do laboratório. Os relatórios serão salvos em `synth/reports/`.

## Observações de projeto

- O estado `CHECK` pode durar dois ciclos para acomodar a leitura síncrona da memória. O sinal `read_valid` evita que a FSM tome a decisão usando valores antigos de `price` e `stock`.
- O primeiro crédito recebido em `IDLE` é registrado na mesma borda que transfere a FSM para `COLLECT`, evitando a perda da primeira moeda.
- Em cancelamento, `change_out` registra o crédito acumulado, conforme o cenário obrigatório que espera R$2,00 devolvidos após duas moedas de R$1,00.
