// ------------------------------------------------------
// ---- Unidade de controle por meio de FSM enumerada ----
// ------------------------------------------------------

module control_unit (
    input  logic       clk,
    input  logic       rst,
    input  logic       cancel,
    input  logic [1:0] coin_in,
    input  logic       confirm,
    input  logic       read_valid,
    input  logic       can_sell,

    output logic       credit_load,
    output logic       clear_credit,
    output logic       mem_read,
    output logic       mem_write,
    output logic       dispense,
    output logic       error,
    output logic       change_capture,
    output logic [2:0] state_out
);

    import vending_pkg::*;

    logic coin_present;

    state_t state_q; // registra os estado definidos em vending_pkg.sv

    assign coin_present = (coin_in != 2'b00);

    // Transição e registrador de estados
    always_ff @(posedge clk) begin : STATE_TRANSITION
        if (rst || cancel) begin
            state_q <= ST_IDLE;
        end
        else begin
            unique case (state_q)

                ST_IDLE: begin
                    if (coin_present)
                        state_q <= ST_COLLECT;
                    else
                        state_q <= ST_IDLE;
                end

                ST_COLLECT: begin
                    if (confirm)
                        state_q <= ST_CHECK;
                    else
                        state_q <= ST_COLLECT;
                end

                ST_CHECK: begin
                    if (read_valid) begin
                        if (can_sell)
                            state_q <= ST_DISPENSE;
                        else
                            state_q <= ST_ERROR;
                    end
                    else begin
                        state_q <= ST_CHECK;
                    end
                end

                ST_DISPENSE: begin
                    state_q <= ST_CHANGE;
                end

                ST_CHANGE: begin
                    state_q <= ST_IDLE;
                end

                ST_ERROR: begin
                    state_q <= ST_ERROR;
                end

                default: begin
                    state_q <= ST_IDLE;
                end

            endcase
        end
    end

    // Saídas de Moore: dependem exclusivamente de state_q
    always_comb begin : OUTPUT_LOGIC
        credit_load = 1'b0;
        clear_credit   = 1'b0;
        mem_read       = 1'b0;
        mem_write      = 1'b0;
        dispense       = 1'b0;
        error          = 1'b0;
        change_capture = 1'b0;

        unique case (state_q)

            ST_COLLECT: begin
                credit_load = 1'b1;
            end

            ST_CHECK: begin
                mem_read = 1'b1;
            end

            ST_DISPENSE: begin
                mem_write      = 1'b1;
                dispense       = 1'b1;
                change_capture = 1'b1;
            end

            ST_CHANGE: begin
                clear_credit = 1'b1;
            end

            ST_ERROR: begin
                error = 1'b1;
            end

            default: begin
            end

        endcase

        state_out = state_q;
    end

endmodule
