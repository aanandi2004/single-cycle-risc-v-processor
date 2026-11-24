
module single_cycle_processor (
    input logic clk,
    input logic rst
);

    // Internal signals

    logic [31:0] pc_current;
    logic [31:0] pc_next;
    logic [31:0] pc_plus4;
    logic [31:0] branch_target;

    logic [31:0] instruction;

    logic [31:0] read_data1;
    logic [31:0] read_data2;

    logic [31:0] immediate;
    logic [31:0] imm_i;
    logic [31:0] alu_input2;

    logic [63:0] alu_out;
    logic [31:0] alu_result;

    logic [31:0] mem_read_data;
    logic [31:0] write_back_data;

    logic Branch;
    logic MemRead;
    logic MemtoReg;
    logic MemWrite;
    logic ALUSrc;
    logic RegWrite;

    logic [1:0] ALUOp;
    logic [2:0] alu_ctrl_out;
    logic [3:0] alu_sel;

    logic carry;
    logic borrow;
    logic overflow;
    logic zero;
    logic negative;

    logic pcsrc;


    // 1. PC

    pc PC (
        .clk(clk),
        .rst(rst),
        .pc_in(pc_next),
        .pc_out(pc_current)
    );


    // 2. Instruction Memory

    inst_mem IM (
        .addr(pc_current),
        .instruction(instruction)
    );


    // 3. PC + 4

    adder PC_ADDER (
        .a(pc_current),
        .b(32'd4),
        .sum(pc_plus4)
    );


    // 4. Control Unit

    control CTRL (
        .opcode(instruction[6:0]),
        .Branch(Branch),
        .MemRead(MemRead),
        .MemtoReg(MemtoReg),
        .ALUOp(ALUOp),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .RegWrite(RegWrite)
    );


    // 5. Register File

    Register RF (
        .clk(clk),
        .rst(rst),
        .instr(instruction),
        .regwrite(RegWrite),
        .write_data(write_back_data),
        .out1(read_data1),
        .out2(read_data2)
    );


    // 6. Immediate Generator

    imm_gen IMM_GEN (
        .instr(instruction),
        .out(imm_i)
    );

    // I-Type, S-Type and B-Type immediate selection

    always_comb begin

        case(instruction[6:0])

            // I-Type
            7'b0010011,
            7'b0000011: begin
                immediate = imm_i;
            end

            // S-Type
            7'b0100011: begin
                immediate = {{20{instruction[31]}},
                             instruction[31:25],
                             instruction[11:7]};
            end

            default: begin
                immediate = 32'b0;
            end

        endcase

    end


    // 7. ALU Control

    alu_control ALU_CTRL (
        .funct7(instruction[31:25]), // why-
        .funct3(instruction[14:12]),//why 
        .ALUOp(ALUOp),
        .alu_ctrl_out(alu_ctrl_out)
    );


    // 8. ALU Encoding Conversion
    // Original ALU uses 4-bit encoding

    always_comb begin

        case(alu_ctrl_out)

            3'b000: alu_sel = 4'b0000; // ADD
            3'b001: alu_sel = 4'b0001; // SUB
            3'b011: alu_sel = 4'b0110; // XOR
            3'b100: alu_sel = 4'b0100; // AND
            3'b101: alu_sel = 4'b0101; // OR

            default: alu_sel = 4'b0000;

        endcase

    end


    // 9. ALU Input MUX

    mux_alu ALU_MUX (
        .read_data2(read_data2),
        .imm(immediate),
        .alusrc(ALUSrc),
        .alu_input2(alu_input2)
    );


    // 10. ALU

    alu ALU (
        .a(read_data1),
        .b(alu_input2),
        .sel(alu_sel),
        .alu_out(alu_out),
        .carry(carry),
        .borrow(borrow),
        .overflow(overflow),
        .zero(zero),
        .negative(negative)
    );

    assign alu_result = alu_out[31:0];


    // 11. Data Memory

    data_mem DM (
        .clk(clk),
        .rst(~rst),
        .add(alu_result),
        .write_data(read_data2),
        .read_out(mem_read_data),
        .memwrite(MemWrite),
        .memread(MemRead)
    );


    // 12. Write Back MUX

    mux_wb WB_MUX (
        .alu_result(alu_result),
        .mem_read_data(mem_read_data),
        .memtoreg(MemtoReg),
        .write_data(write_back_data)
    );


    // 13. Branch Target Address

    adder BRANCH_ADDER (
        .a(pc_current),
        .b(immediate),
        .sum(branch_target)
    );


    // 14. Branch Control

    branch_control BRANCH_CTRL (
        .branch(Branch),
        .zero(zero),
        .pcsrc(pcsrc)
    );


    // 15. PC MUX

    mux_pc PC_MUX (
        .pc_plus4(pc_plus4),
        .branch_target(branch_target),
        .pcsrc(pcsrc),
        .pc_next(pc_next)
    );


endmodule
