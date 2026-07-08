module vending_top (
    input  logic       clk,
    input  logic       rst,       // active low reset
    input  logic [1:0] coin_in,
    input  logic [1:0] sel_item,   // seleciona um item entre 4
    input  logic       confirm,    // confirma seção
    input  logic       cancel,     // cancela seleção a qualquer momento

    output logic       dispense,   // ativa a dispesadora, sinalizando que o item está pronto para ser liberado
    output logic [7:0] change_out, // troco
    output logic       error,      // ativado quando algum item está sem estoque, ou quando o credito não é o suficiente
    output logic [7:0] display,    // mostra o credito atual 
    output logic [2:0] state_out   // estado atual para debug
);

    logic [7:0] credit, price, stock, change; // variáveis utilizadas para armazenar os valores nas diferentes operações

    // sinais de controle
    logic can_sell, read_valid, credit_load, clear_credit, mem_read, mem_write, change_capture;

// -------------------------------------------------------
// ------------------- UNIDADE DE CONTROLE ---------------
// -------------------------------------------------------

    control_unit u_control_unit (
        .clk           (clk),
        .rst           (rst),
        .cancel        (cancel),
        .coin_in       (coin_in), 
        .confirm       (confirm),
        .read_valid    (read_valid),
        .can_sell      (can_sell),
        .credit_load   (credit_load),
        .clear_credit  (clear_credit),
        .mem_read      (mem_read),
        .mem_write     (mem_write),
        .dispense      (dispense),
        .error         (error),
        .change_capture(change_capture),
        .state_out     (state_out)
    );
 
// -------------------------------------------------------
// ------------------- CAMINHO DE DADOS ---------------
// -------------------------------------------------------
    credit_reg u_credit_reg (
        .clk          (clk),
        .rst          (rst),
        .cancel       (cancel),
        .credit_load  (credit_load),
        .clear_credit (clear_credit), // final da operação com sucesso, durante troco
        .coin_in      (coin_in),
        .credit       (credit)
    );

    vending_memory u_memory (
        .clk        (clk),
        .rst       (rst),
        .mem_read   (mem_read),
        .mem_write  (mem_write),
        .addr       (sel_item),
        .price      (price),
        .stock      (stock),
        .read_valid (read_valid)
    );

    comparator u_comparator (
        .credit   (credit),
        .price    (price),
        .stock    (stock),
        .can_sell (can_sell)
    );

    subtractor u_subtractor (
        .credit (credit),
        .price  (price),
        .change (change) // atualizada instantaneamente
    );

    // bloco para definir o troco de acordo com os sinais rst, cancel e change_capture
    always_ff @(posedge clk) begin // c
        if (rst) begin
            change_out <= '0;
        end else if (cancel) begin
            change_out <= credit; // 
        end else if (change_capture) begin
            change_out <= change;
        end
    end

    assign display = credit;

endmodule
