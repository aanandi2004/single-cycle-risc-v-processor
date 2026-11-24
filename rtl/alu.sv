
module alu (
    input  logic [31:0] a,
    input  logic [31:0] b,
    input  logic [2:0]  sel,

    output logic [31:0] alu_out,
    output logic carry,
    output logic borrow,
    output logic overflow,
    output logic zero,
    output logic negative
);

    logic [32:0] temp;
    logic [31:0] sub_result;

    always_comb begin

        alu_out    = 32'b0;
        carry      = 1'b0;
        borrow     = 1'b0;
        overflow   = 1'b0;
        zero       = 1'b0;
        negative   = 1'b0;
        temp       = 33'b0;
        sub_result = 32'b0;

        case (sel)

            // ADD
            3'b000: begin
                temp = {1'b0, a} + {1'b0, b};
                alu_out = temp[31:0];
                carry = temp[32];

                overflow = (~(a[31] ^ b[31])) &
                           (alu_out[31] ^ a[31]);
            end

            // SUB
            3'b001: begin
                sub_result = a - b;
                alu_out = sub_result;
                borrow = (a < b);

                overflow = (a[31] ^ b[31]) &
                           (alu_out[31] ^ a[31]);
            end

            // XOR
            3'b011: begin
                alu_out = a ^ b;
            end

            // AND
            3'b100: begin
                alu_out = a & b;
            end

            // OR
            3'b101: begin
                alu_out = a | b;
            end

            default: begin
                alu_out = 32'b0;
            end

        endcase

        zero = (alu_out == 32'b0);
        negative = alu_out[31];

    end

endmodule
