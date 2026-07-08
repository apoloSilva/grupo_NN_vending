module vending_memory (
    input  logic       clk,
    input  logic       rst,
    input  logic       mem_read,
    input  logic       mem_write,
    input  logic [1:0] addr,

    output logic [7:0] price,
    output logic [7:0] stock,
    output logic       read_valid // indica que price e stock foram atualizados
);

    // Memória com quatro itens de 16 bits:
    // mem[i] = {price[7:0], stock[7:0]} = {preço, quantidade}
    logic [15:0] mem [0:3];

    always_ff @(posedge clk) begin
        if (rst) begin
            // Inicializa o estoque.
            // Temos apenas quatro itens na máquina de vendas.
            mem[0] <= {8'd25,  8'd5};  // cafe
            mem[1] <= {8'd50,  8'd5};  // agua
            mem[2] <= {8'd75,  8'd3};  // suco
            mem[3] <= {8'd100, 8'd2};  // snack

            // Limpa a interface de leitura do estoque.
            price      <= '0;
            stock      <= '0;
            read_valid <= 1'b0;

        end else begin
            // read_valid permanece ativo por um ciclo após uma leitura.
            read_valid <= mem_read;

            // Leitura síncrona do preço e da quantidade em estoque.
            if (mem_read) begin
                price <= mem[addr][15:8];
                stock <= mem[addr][7:0];
            end

            // Após uma venda, decrementa uma unidade,
            // desde que ainda exista item no estoque.
            if (mem_write && (mem[addr][7:0] != 8'd0)) begin
                mem[addr][7:0] <= mem[addr][7:0] - 8'd1;
            end
        end
    end

endmodule

