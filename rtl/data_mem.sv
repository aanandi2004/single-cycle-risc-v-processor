
module data_mem (
    input  logic        clk,
    input  logic        rst,
    input  logic [31:0] add,
    input  logic [31:0] write_data,
    output logic [31:0] read_out,
    input  logic        memwrite,
    input  logic        memread
);

    logic [31:0] mem [0:31];

    // Combinational read
    always_comb begin
        if (memread)
            read_out = mem[add[6:2]];
        else
            read_out = 32'b0;
    end

    // Synchronous write
    always_ff @(posedge clk) begin
        if (rst && memwrite)
            mem[add[6:2]] <= write_data;
    end

endmodule
