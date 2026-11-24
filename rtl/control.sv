module control(
    input logic [6:0] opcode,

    output logic Branch,
    output logic MemRead,
    output logic MemtoReg,
    output logic [1:0] ALUOp,
    output logic MemWrite,
    output logic ALUSrc,
    output logic RegWrite
);

always_comb begin

    case(opcode)

        // R-Type
        7'b0110011: begin
            Branch   = 1'b0;
            MemRead  = 1'b0;
            MemtoReg = 1'b0;
            ALUOp    = 2'b10;
            MemWrite = 1'b0;
            ALUSrc   = 1'b0;
            RegWrite = 1'b1;
        end

        // I-Type (ADDI)
        7'b0010011: begin
            Branch   = 1'b0;
            MemRead  = 1'b0;
            MemtoReg = 1'b0;
            ALUOp    = 2'b11;
            MemWrite = 1'b0;
            ALUSrc   = 1'b1;
            RegWrite = 1'b1;
        end

        // Load (LW)
        7'b0000011: begin
            Branch   = 1'b0;
            MemRead  = 1'b1;
            MemtoReg = 1'b1;
            ALUOp    = 2'b00;
            MemWrite = 1'b0;
            ALUSrc   = 1'b1;
            RegWrite = 1'b1;
        end

        // Store (SW)
        7'b0100011: begin
            Branch   = 1'b0;
            MemRead  = 1'b0;
            MemtoReg = 1'b0;
            ALUOp    = 2'b00;
            MemWrite = 1'b1;
            ALUSrc   = 1'b1;
            RegWrite = 1'b0;
        end

        // Branch (BEQ)
        7'b1100011: begin
            Branch   = 1'b1;
            MemRead  = 1'b0;
            MemtoReg = 1'b0;
            ALUOp    = 2'b01;
            MemWrite = 1'b0;
            ALUSrc   = 1'b0;
            RegWrite = 1'b0;
        end

        // Default
        default: begin
            Branch   = 1'b0;
            MemRead  = 1'b0;
            MemtoReg = 1'b0;
            ALUOp    = 2'b00;
            MemWrite = 1'b0;
            ALUSrc   = 1'b0;
            RegWrite = 1'b0;
        end

    endcase

end

endmodule