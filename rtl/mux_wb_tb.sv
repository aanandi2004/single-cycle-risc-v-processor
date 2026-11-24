//Register write-back selection

module mux_wb(
    input  logic [31:0] alu_result,
    input  logic [31:0] mem_read_data,
    input  logic        memtoreg,
    output logic [31:0] write_data
);

assign write_data = memtoreg ? mem_read_data : alu_result;

endmodule