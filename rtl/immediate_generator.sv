
module imm_gen (
    input  logic [31:0] instr,
    output logic [31:0] out
);

    always_comb begin

        case (instr[6:0])

            // I-Type: ADDI, LW
            7'b0010011,
            7'b0000011: begin
                out = {{20{instr[31]}}, instr[31:20]};
            end

            // S-Type: SW
            7'b0100011: begin
                out = {{20{instr[31]}},
                       instr[31:25],
                       instr[11:7]};
            end

            // B-Type: BEQ
            7'b1100011: begin
                out = {{19{instr[31]}},
                       instr[31],
                       instr[7],
                       instr[30:25],
                       instr[11:8],
                       1'b0};
            end

            default: begin
                out = 32'b0;
            end

        endcase

    end

endmodule
