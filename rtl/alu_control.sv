module alu_control(
    input  logic [6:0] funct7,
    input  logic [2:0] funct3,
    input  logic [1:0] ALUOp,
    output logic [2:0] alu_ctrl_out
);

always_comb begin

    alu_ctrl_out = 3'b000;

    case (ALUOp)

        // Load / Store: ADD
        2'b00: begin
            alu_ctrl_out = 3'b000;
        end

        // Branch: SUB
        2'b01: begin
            alu_ctrl_out = 3'b001;
        end

        // R-Type: Decode funct3 and funct7
        2'b10: begin
            case ({funct7, funct3})
                {7'b0000000, 3'b000}: alu_ctrl_out = 3'b000; // ADD
                {7'b0100000, 3'b000}: alu_ctrl_out = 3'b001; // SUB
                {7'b0000000, 3'b111}: alu_ctrl_out = 3'b100; // AND
                {7'b0000000, 3'b110}: alu_ctrl_out = 3'b101; // OR
                {7'b0000000, 3'b100}: alu_ctrl_out = 3'b011; // XOR
                default: alu_ctrl_out = 3'b000;
            endcase
        end

        // I-Type: Decode funct3 (ADDI, ANDI, ORI, XORI)
        2'b11: begin
            case (funct3)
                3'b000: alu_ctrl_out = 3'b000; // ADDI
                3'b111: alu_ctrl_out = 3'b100; // ANDI
                3'b110: alu_ctrl_out = 3'b101; // ORI
                3'b100: alu_ctrl_out = 3'b011; // XORI
                default: alu_ctrl_out = 3'b000;
            endcase
        end

        default: alu_ctrl_out = 3'b000;

    endcase
end

endmodule