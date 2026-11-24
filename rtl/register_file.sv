
module Register (
    input  logic        clk,
    input  logic        rst,
    input  logic [31:0] instr,
    input  logic        regwrite,
    input  logic [31:0] write_data,
    output logic [31:0] out1,
    output logic [31:0] out2
);

    logic [31:0] mem [0:31];

    logic [4:0] rs1;
    logic [4:0] rs2;
    logic [4:0] rd;

    assign rs1 = instr[19:15];
    assign rs2 = instr[24:20];
    assign rd  = instr[11:7];

    // Combinational register reads
    assign out1 = (rs1 == 0) ? 32'b0 : mem[rs1];
    assign out2 = (rs2 == 0) ? 32'b0 : mem[rs2];

    // Synchronous register write
    always_ff @(posedge clk) begin

        if (!rst) begin
            for (int i = 0; i < 32; i++)
                mem[i] <= 32'b0;
        end

        else if (regwrite && (rd != 0)) begin
            mem[rd] <= write_data;
        end

    end

endmodule
