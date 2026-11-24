module data_mem(
    input  logic        clk,
    input  logic        rst,
    input  logic [31:0] add,
    input  logic [31:0] write_data,
    output logic [31:0] read_out,
    input  logic        memwrite,
    input  logic        memread
);

    logic [31:0] mem [0:31];

    always @(posedge clk) begin

        if (rst)
            read_out <= 32'h00000000;

        else if (memwrite)
            mem[add] <= write_data;
    end

        // Combinational read
    always_comb begin
        if (rst)
            read_out = 32'h00000000;
        else if (memread)
            read_out = mem[add];
        else
            read_out = 32'h00000000;
    end

endmodule