// ------------------------------------------------------
// ---- Acumulador de crédito (registrador síncrono) ----
// ------------------------------------------------------

module credit_reg (
    input  logic       clk,
    input  logic       rst,
    input  logic       cancel,
    input  logic       credit_load,
    input  logic       clear_credit,
    input  logic [1:0] coin_in,
    
    output logic [7:0] credit
);

    import vending_pkg::*;

    logic [7:0] coin_value;
    logic [7:0] pending_coin_value;

    logic [1:0] coin_in_q;
    logic       coin_inserted;
    logic       coin_pending;

    assign coin_value = coin_to_value(coin_in);

    // Detecta nova moeda: antes era 00, agora é diferente de 00
    assign coin_inserted = (coin_in_q == 2'b00) && (coin_in != 2'b00);

    always_ff @(posedge clk) begin
        if (rst) begin
            credit             <= '0;
            coin_in_q          <= 2'b00;
            coin_pending       <= 1'b0;
            pending_coin_value <= '0;
        end
        else begin
            if (cancel || clear_credit) begin
                credit             <= '0;
                coin_in_q          <= 2'b00;
                coin_pending       <= 1'b0;
                pending_coin_value <= '0;
            end
            else begin
                // Guarda o valor anterior de coin_in para detectar borda
                coin_in_q <= coin_in;

                if (credit_load) begin

                    // Caso 1: havia uma moeda capturada antes do credit_load
                    if (coin_pending) begin
                        credit       <= credit + pending_coin_value;
                        coin_pending <= 1'b0;
                    end

                    // Caso 2: já estamos em ST_COLLECT e uma nova moeda entrou
                    else if (coin_inserted) begin
                        credit <= credit + coin_value;
                    end

                end
                else begin

                    // Caso 3: moeda apareceu antes do credit_load ficar ativo
                    // Isso acontece na transição IDLE -> COLLECT da FSM Moore
                    if (coin_inserted) begin
                        pending_coin_value <= coin_value;
                        coin_pending       <= 1'b1;
                    end

                end
            end
        end
    end

endmodule



