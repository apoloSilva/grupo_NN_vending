// ------------------------------------------------------
// ---- Acumulador de crédito (registrador síncrono) ----
// ------------------------------------------------------

module credit_reg (
    input  logic       clk,
    input  logic       nrst,
    input  logic       cancel,
    input  logic       credit_load,
    input  logic       clear_credit,
    input  logic [1:0] coin_in,
    
    output logic [7:0] credit
);

    import vending_pkg::*;

    logic [7:0] coin_value;
    logic [1:0] coin_in_q;
    logic       coin_inserted;

    assign coin_value    = coin_to_value(coin_in);
    // o assign abaixo evita que "credit <= credit + coin_value;" ocorra no proximo ciclo de clock
    // quando nenhuma nova moeda for inserida. Do contrário, o valor de credit seria 
    // adiconado junto a repetidos valores de coin_value para a mesma moeda inserida
    assign coin_inserted = (coin_in_q == 2'b00) && (coin_in   != 2'b00);
 
    always_ff @(posedge clk or negedge nrst) begin
        if (!nrst) begin
            credit    <= '0;
            coin_in_q <= 2'b00;

        end else begin
            // Guarda a moeda amostrada no ciclo atual.
            coin_in_q <= coin_in;

            if (cancel || clear_credit) begin
                credit <= '0;

            end else if (credit_load && coin_inserted) begin
                credit <= credit + coin_value;
            end
        end
    end

endmodule