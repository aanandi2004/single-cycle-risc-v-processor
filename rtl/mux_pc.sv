//pc mux 
module branch_control(
    input  logic branch,
    input  logic zero,
    output logic pcsrc
);

assign pcsrc = branch & zero;

endmodule

module mux_pc(
    input  logic [31:0] pc_plus4,
    input  logic [31:0] branch_target,
    input  logic        pcsrc,
    output logic [31:0] pc_next
);

assign pc_next = pcsrc ? branch_target : pc_plus4;

endmodule