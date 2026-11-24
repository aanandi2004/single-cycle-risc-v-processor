
module top_tb;

    logic clk;
    logic rst;

    // DUT
    single_cycle_processor dut (
        .clk(clk),
        .rst(rst)
    );

    // Clock generation
    always #5 clk = ~clk;


    initial begin

        clk = 0;
        rst = 0;

        // Initialize Instruction Memory
        for (int i = 0; i < 1024; i++)
            dut.IM.mem[i] = 8'h00;

        // Initialize Register File
        for (int i = 0; i < 32; i++)
            dut.RF.mem[i] = 32'b0;

        // Initialize Data Memory
        for (int i = 0; i < 32; i++)
            dut.DM.mem[i] = 32'b0;


        // =================================
        // INSTRUCTION 1: ADDI x1, x0, 5
        // =================================

        dut.IM.mem[0] = 8'h93;
        dut.IM.mem[1] = 8'h00;
        dut.IM.mem[2] = 8'h50;
        dut.IM.mem[3] = 8'h00;


        // =================================
        // INSTRUCTION 2: ADDI x2, x0, 7
        // =================================

        dut.IM.mem[4] = 8'h13;
        dut.IM.mem[5] = 8'h01;
        dut.IM.mem[6] = 8'h70;
        dut.IM.mem[7] = 8'h00;


        // =================================
        // INSTRUCTION 3: ADD x3, x1, x2
        // =================================

        dut.IM.mem[8]  = 8'hB3;
        dut.IM.mem[9]  = 8'h81;
        dut.IM.mem[10] = 8'h20;
        dut.IM.mem[11] = 8'h00;


        // =================================
        // INSTRUCTION 4: NOP
        // =================================

        dut.IM.mem[12] = 8'h00;
        dut.IM.mem[13] = 8'h00;
        dut.IM.mem[14] = 8'h00;
        dut.IM.mem[15] = 8'h00;


        // =================================
        // INSTRUCTION 5: SW x3, 8(x0)
        // =================================

        dut.IM.mem[16] = 8'h23;
        dut.IM.mem[17] = 8'h24;
        dut.IM.mem[18] = 8'h30;
        dut.IM.mem[19] = 8'h00;

        // =================================
        // INSTRUCTION 6: LW x4, 8(x0)
        // =================================

        dut.IM.mem[20] = 8'h03;
        dut.IM.mem[21] = 8'h22;
        dut.IM.mem[22] = 8'h80;
        dut.IM.mem[23] = 8'h00;


        // =================================
        // INSTRUCTION 7: BEQ x3, x3, 8
        // =================================

        dut.IM.mem[24] = 8'h63;
        dut.IM.mem[25] = 8'h84;
        dut.IM.mem[26] = 8'h31;
        dut.IM.mem[27] = 8'h00;


        // =================================
        // INSTRUCTION 8: ADDI x5, x0, 99
        // This instruction should be skipped
        // =================================

        dut.IM.mem[28] = 8'h93;
        dut.IM.mem[29] = 8'h02;
        dut.IM.mem[30] = 8'h30;
        dut.IM.mem[31] = 8'h06;


        // =================================
        // INSTRUCTION 9: ADDI x6, x0, 11
        // =================================

        dut.IM.mem[32] = 8'h13;
        dut.IM.mem[33] = 8'h03;
        dut.IM.mem[34] = 8'hB0;
        dut.IM.mem[35] = 8'h00;


        // =================================
        // MONITOR
        // =================================

        $monitor(
    "TIME=%0t | PC=%0d | INSTR=%h | ALU=%0d | REGWRITE=%b | MEMWRITE=%b | MEMREAD=%b | x1=%0d | x2=%0d | x3=%0d | x4=%0d | x5=%0d | x6=%0d | MEM[8]=%0d | READ_OUT=%0d",
    $time,
    dut.pc_current,
    dut.instruction,
    dut.alu_result,
    dut.RegWrite,
    dut.MemWrite,
    dut.MemRead,
    dut.RF.mem[1],
    dut.RF.mem[2],
    dut.RF.mem[3],
    dut.RF.mem[4],
    dut.RF.mem[5],
    dut.RF.mem[6],
    dut.DM.mem[8],
    dut.DM.read_out
);


        // =================================
        // RELEASE RESET
        // =================================

        #12;
        rst = 1;


        // =================================
        // TEST 1: ADDI x1, x0, 5
        // =================================

        @(posedge clk);
        #1;

        if (dut.RF.mem[1] == 5)
            $display("PASS: ADDI x1 = 5");
        else
            $error("FAIL: ADDI x1 expected 5, got %0d",
                   dut.RF.mem[1]);


        // =================================
        // TEST 2: ADDI x2, x0, 7
        // =================================

        @(posedge clk);
        #1;

        if (dut.RF.mem[2] == 7)
            $display("PASS: ADDI x2 = 7");
        else
            $error("FAIL: ADDI x2 expected 7, got %0d",
                   dut.RF.mem[2]);


        // =================================
        // TEST 3: ADD x3, x1, x2
        // =================================

        @(posedge clk);
        #1;

        if (dut.RF.mem[3] == 12)
            $display("PASS: ADD x3 = 12");
        else
            $error("FAIL: ADD x3 expected 12, got %0d",
                   dut.RF.mem[3]);


        // =================================
        // NOP CYCLE
        // =================================

        @(posedge clk);
        #1;

        $display("PASS: NOP executed");


        // =================================
        // TEST 4: SW x3, 8(x0)
        // =================================

        @(posedge clk);
        #1;

        if (dut.DM.mem[8] == 12)
            $display("PASS: SW memory[8] = 12");
        else
            $error("FAIL: SW memory[8] expected 12, got %0d",
                   dut.DM.mem[8]);

        // =================================
        // TEST 5: LW x4, 8(x0)
        // =================================

        @(posedge clk);
        #1;

        if (dut.RF.mem[4] == 12)
            $display("PASS: LW memory[4] = 12");
        else
            $error("FAIL: LW memory[4] expected 12, got %0d",
                   dut.RF.mem[4]);

        // =================================
        // TEST 6: BEQ x3, x3, 8
        // =================================

        @(posedge clk);
        #1;

        if (dut.pc_current == 32'd32)
            $display("PASS: BEQ branch taken, PC = 32");
        else
            $error("FAIL: BEQ expected PC=32, got %0d",
                dut.pc_current);


        // =================================
        // TEST 7: ADDI x6, x0, 11
        // =================================

        @(posedge clk);
        #1;

        if (dut.RF.mem[6] == 11)
            $display("PASS: ADDI x6 = 11");
        else
            $error("FAIL: ADDI x6 expected 11, got %0d",
                   dut.RF.mem[6]);


        // =================================
        // FINAL CHECK: BRANCH SKIP
        // =================================

        if (dut.RF.mem[5] == 0)
            $display("PASS: ADDI x5 successfully skipped");
        else
            $error("FAIL: ADDI x5 was executed");


        // =================================
        // FINAL RESULT
        // =================================

        $display("");
        $display("================================");
        $display("PROCESSOR TESTING COMPLETED");
        $display("================================");

        $finish;

    end

endmodule
