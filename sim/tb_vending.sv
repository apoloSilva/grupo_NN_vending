module tb_vending;

    import vending_pkg::*;

    // sinais
    logic clk;
    logic rst;
    logic [1:0] coin_in;
    logic [1:0] sel_item;
    logic confirm;
    logic cancel;

    logic dispense;
    logic [7:0] change_out;
    logic error;
    logic [7:0] display;
    logic [2:0] state_out;

    int unsigned checks;
    int unsigned failures;
    int scenario;

    event start_s1;
    event done_s1;
    event done_s2;
    event done_s3;
    event done_s4;

    // DUT
    vending_top dut (
        .clk        (clk),
        .rst        (rst),
        .coin_in    (coin_in),
        .sel_item   (sel_item),
        .confirm    (confirm),
        .cancel     (cancel),
        .dispense   (dispense),
        .change_out (change_out),
        .error      (error),
        .display    (display),
        .state_out  (state_out)
    );

    // ------------------------------------------------------
    // TESTES DE ACORDO COM SEÇÃO 8
    // ------------------------------------------------------

    // 8.2.1 Geração de clock
    always #5 clk = ~clk;

    initial begin : MAIN_TEST

        // 8.2.6 Geração de waveform
        $fsdbDumpfile("waves.fsdb");
        $fsdbDumpvars(0, tb_vending);

        $timeformat(-9, 3, " ns", 10);

        clk      = 1'b0;
        rst      = 1'b1;
        coin_in  = 2'b00;
        sel_item = 2'b00;
        confirm  = 1'b0;
        cancel   = 1'b0;

        checks   = 0;
        failures = 0;

        // Executa todos os cenários definidos nos blocos "initial begin ... end" até done_s4 é assinalado
        #1ps;
        -> start_s1;

        @done_s4;

        $display("\n============================================================");

        if (failures == 0) begin
            $display("RESULTADO DO TESTBENCH: PASS (%0d checks, %0d failures)",
                     checks, failures);
        end
        else begin
            $display("RESULTADO DO TESTBENCH: FAIL (%0d checks, %0d failures)",
                     checks, failures);
            $fatal(1, "Falhas detectadas no testbench");
        end

        $display("============================================================");

        #10;
        $finish;
    end

    initial begin : TEST_SCENARIO_1

        @start_s1;

        // ----------------------------------------------------------
        // Reset inicial por 2 ciclos de clock
        // ----------------------------------------------------------
        $display("\nReset inicial por 2 ciclos de clock");
        reset_dut();

        check_state(ST_IDLE, state_out, "Reset: FSM inicia em IDLE");
        check(8'd0, display, "Reset: credito inicial igual a zero");
        $display("[TIME] Apos reset inicial: %0t", $time);
        
        // ----------------------------------------------------------
        // Execução do cenário 1
        // ----------------------------------------------------------
        scenario_1_success_with_change();
        $display("[TIME] Apos cenario 1: %0t", $time);

        -> done_s1;
    end

    initial begin : TEST_SCENARIO_2

        @done_s1;

        scenario_2_insufficient_credit();
        $display("[TIME] Apos cenario 2: %0t", $time);

        -> done_s2;
    end

    initial begin : TEST_SCENARIO_3

        @done_s2;

        scenario_3_cancel();
        $display("[TIME] Apos cenario 3: %0t", $time);

        -> done_s3;
    end

    initial begin : TEST_SCENARIO_4

        @done_s3;

        scenario_4_zero_stock();
        $display("[TIME] Apos cenario 4: %0t", $time);

        -> done_s4;
    end

    // Timeout global
    initial begin
        #5000;
        $fatal(1, "Timeout: simulacao excedeu 5000 ns");
    end

    // ======================================================
    // DEFINIÇÃO DAS TAREFAS
    // ======================================================

    task automatic reset_dut;
        begin
            rst      = 1'b1;
            coin_in  = 2'b00;
            sel_item = 2'b00;
            confirm  = 1'b0;
            cancel   = 1'b0;

            repeat (2) @(posedge clk);

            @(negedge clk);
            rst = 1'b0;

            @(posedge clk);
            #1ps;
        end
    endtask

    task automatic apply_coin(
        input logic [1:0] value
    );
        begin
            if (value == 2'b00) begin
                $fatal(1, "apply_coin: moeda invalida 00");
            end

            @(negedge clk);
            coin_in = value;

            @(posedge clk); // mantem a moeda durante um ciclo de clock
            //repeat (2) @(posedge clk);

            @(negedge clk); // reseta
            coin_in = 2'b00;

            @(posedge clk);
            #1ps;
        end
    endtask

    task automatic press_confirm;
        begin
            @(negedge clk);
            confirm = 1'b1;

            @(posedge clk);

            @(negedge clk);
            confirm = 1'b0;

            #1ps;
        end
    endtask

    task automatic press_cancel;
        begin
            @(negedge clk);
            cancel = 1'b1;

            @(posedge clk);

            @(negedge clk);
            cancel = 1'b0;

            #1ps;
        end
    endtask

    task automatic buy_item(
        input logic [1:0] item,
        input logic [1:0] coins[]
    );
        begin
            @(negedge clk);
            sel_item = item;

            foreach (coins[i]) begin
                apply_coin(coins[i]);
            end

            press_confirm();
        end
    endtask

    // ----------------------------------------------------------
    // define tarefa check (expected, actual, label) que reporta PASS/FAIL (8.2.5)
    // ----------------------------------------------------------
    task automatic check(
        input logic [7:0] expected,
        input logic [7:0] actual,
        input string      label
    );
        begin
            checks++;

            if (actual === expected) begin
                $display("[PASS] %s | expected=%0d actual=%0d",
                         label, expected, actual);
            end
            else begin
                failures++;
                $error("[FAIL] %s | expected=%0d actual=%0d",
                       label, expected, actual);
            end
        end
    endtask

    task automatic check_bit(
        input logic  expected,
        input logic  actual,
        input string label
    );
        begin
            check({7'd0, expected}, {7'd0, actual}, label);
        end
    endtask

    task automatic check_state(
        input logic [2:0] expected,
        input logic [2:0] actual,
        input string      label
    );
        begin
            check({5'd0, expected}, {5'd0, actual}, label);
        end
    endtask

    task automatic wait_for_state(
        input state_t expected_state,
        input string  label
    );
        int unsigned timeout_count;
        logic [2:0] expected_code;

        begin
            timeout_count = 0;
            expected_code = expected_state;

            while ((state_out !== expected_code) &&
                   (timeout_count < 20)) begin
                @(posedge clk);
                #1ps;
                timeout_count++;
            end

            check_state(expected_code, state_out, label);
        end
    endtask

    // ======================================================
    // DEFINIÇÃO DE CENÁRIOS
    // ======================================================

    // ======================================================
    // CENÁRIO 1
    // Compra bem-sucedida de café com troco
    // ======================================================
    task automatic scenario_1_success_with_change;
        logic [1:0] coins[];

        begin
            coins = new[1];
            coins[0] = 2'b11; // R$1,00

            $display("\n============================================================");
            $display("CENARIO 1: compra de cafe com troco");
            $display("============================================================");

            buy_item(2'd0, coins); // Café: R$0,25

            wait_for_state(ST_DISPENSE, "S1: FSM entra em DISPENSE");
            check_bit(1'b1, dispense, "S1: dispense ativo em DISPENSE");

            wait_for_state(ST_CHANGE, "S1: FSM entra em CHANGE");
            check_bit(1'b0, dispense, "S1: dispense dura apenas um ciclo");
            check(8'd75, change_out, "S1: troco igual a 75 centavos");

            wait_for_state(ST_IDLE, "S1: FSM retorna para IDLE");
            check(8'd0, display, "S1: credito zerado ao final da venda");
        end
    endtask

    // ======================================================
    // CENÁRIO 2
    // Crédito insuficiente para comprar snack
    // ======================================================
    task automatic scenario_2_insufficient_credit;
        logic [1:0] coins[];

        begin
            coins = new[1];
            coins[0] = 2'b01; // R$0,25

            $display("\n============================================================");
            $display("CENARIO 2: credito insuficiente");
            $display("============================================================");

            buy_item(2'd3, coins); // Snack: R$1,00

            wait_for_state(ST_ERROR,
                           "S2: FSM entra em ERROR");

            check_bit(1'b1, error,
                      "S2: error permanece ativo");

            press_cancel();

            wait_for_state(ST_IDLE,
                           "S2: cancel retorna para IDLE");

            check(8'd25, change_out,
                  "S2: cancel devolve 25 centavos");

            check(8'd0, display,
                  "S2: credito zerado apos cancelamento");
        end
    endtask

    // ======================================================
    // CENÁRIO 3
    // Cancelamento com R$2,00 acumulados
    // ======================================================
    task automatic scenario_3_cancel;
        begin
            $display("\n============================================================");
            $display("CENARIO 3: cancelamento com R$2,00");
            $display("============================================================");

            apply_coin(2'b11); // R$1,00
            apply_coin(2'b11); // R$1,00

            check(8'd200, display,
                  "S3: credito acumulado igual a 200");

            press_cancel();

            wait_for_state(ST_IDLE,
                           "S3: FSM retorna para IDLE");

            check(8'd200, change_out,
                  "S3: cancel devolve 200 centavos");

            check(8'd0, display,
                  "S3: credito zerado apos cancelamento");
        end
    endtask

    // ======================================================
    // CENÁRIO 4
    // Estoque zerado: vende 5 cafes e tenta a sexta compra
    // ======================================================
    task automatic scenario_4_zero_stock;
        logic [1:0] coins[];
        int i;

        begin
            coins = new[1];
            coins[0] = 2'b11; // R$1,00

            $display("\n============================================================");
            $display("CENARIO 4: estoque de cafe zerado");
            $display("============================================================");

            // O cenário 1 já vendeu 1 café.
            // Como o estoque inicial era 5, agora restam 4 cafés.
            // As próximas 4 compras correspondem às vendas 2, 3, 4 e 5.
            for (i = 2; i <= 5; i++) begin
                buy_item(2'd0, coins);

                wait_for_state(
                    ST_DISPENSE,
                    $sformatf("S4: venda %0d entra em DISPENSE", i)
                );

                check_bit(
                    1'b1,
                    dispense,
                    $sformatf("S4: venda %0d gera dispense", i)
                );

                wait_for_state(
                    ST_CHANGE,
                    $sformatf("S4: venda %0d entra em CHANGE", i)
                );

                check(
                    8'd75,
                    change_out,
                    $sformatf("S4: venda %0d devolve 75 centavos", i)
                );

                wait_for_state(
                    ST_IDLE,
                    $sformatf("S4: venda %0d retorna para IDLE", i)
                );
            end

            // Sexta tentativa: estoque já é zero.
            buy_item(2'd0, coins);

            wait_for_state(
                ST_ERROR,
                "S4: sexta tentativa entra em ERROR"
            );

            check_bit(
                1'b1,
                error,
                "S4: error ativo pois o estoque esta zerado"
            );
        end
    endtask

endmodule


