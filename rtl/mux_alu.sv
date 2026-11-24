//ALU input selection
module mux_alu(
    input  logic [31:0] read_data2,
    input  logic [31:0] imm,
    input  logic        alusrc,
    output logic [31:0] alu_input2
);

assign alu_input2 = alusrc ? imm : read_data2;

endmodule