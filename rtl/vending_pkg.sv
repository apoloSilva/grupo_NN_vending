package vending_pkg;

    typedef enum logic [2:0] {
        ST_IDLE     = 3'b000,
        ST_COLLECT  = 3'b001,
        ST_CHECK    = 3'b010,
        ST_DISPENSE = 3'b011,
        ST_CHANGE   = 3'b100,
        ST_ERROR    = 3'b101
    } state_t;

    localparam logic [7:0] COIN_NONE = 8'd0;
    localparam logic [7:0] COIN_25   = 8'd25;
    localparam logic [7:0] COIN_50   = 8'd50;
    localparam logic [7:0] COIN_100  = 8'd100;

    function automatic logic [7:0] coin_to_value(input logic [1:0] coin_in);
        unique case (coin_in) // suportes três valores de moedas
            2'b00:   coin_to_value = COIN_NONE;
            2'b01:   coin_to_value = COIN_25;
            2'b10:   coin_to_value = COIN_50;
            2'b11:   coin_to_value = COIN_100;
            default:  coin_to_value = COIN_NONE;
        endcase
    endfunction

endpackage
