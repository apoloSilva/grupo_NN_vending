module vending_memory (
    input  logic       clk,
    input  logic       nrst,
    input  logic       mem_read,
    input  logic       mem_write,
    input  logic [1:0] addr,
    output logic [7:0] price,
    output logic [7:0] stock,
    output logic       read_valid // retorna read
);

    logic [15:0] mem [0:3]; // inicializa uma memória com espaço para 16 itens de tamanho 4 bits

    initial begin // inicializa o estoque: // {price[7:0], stock[7:0]} = {preço, quantidade}
        // temos apenas quatro itens na máquina de vendas
        mem[0] = {8'd25,  8'd5};  // cafe
        mem[1] = {8'd50,  8'd5};  // agua
        mem[2] = {8'd75,  8'd3};  // suco
        mem[3] = {8'd100, 8'd2};  // snack

        price      = '0;
        stock      = '0;
        read_valid = 1'b0;
    end

    always_ff @(posedge clk or negedge nrst) begin
        if (!nrst) begin
            // limpa a interface de leitura do estoque.
            price      <= '0;
            stock      <= '0;
            read_valid <= 1'b0;
        end else begin
            read_valid <= mem_read;

            if (mem_read) begin
                price <= mem[addr][15:8];
                stock <= mem[addr][7:0];
            end

            if (mem_write && (mem[addr][7:0] != 8'd0)) begin
                mem[addr][7:0] <= mem[addr][7:0] - 8'd1; // decrementa uma unidade
            end
        end
    end

endmodule
