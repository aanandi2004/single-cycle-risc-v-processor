module tb_inst_mem;

    logic [31:0] addr;
    logic [31:0] instruction;

    inst_mem uut (
        .addr(addr),
        .instruction(instruction)
    );

    initial begin
        $dumpfile("inst_mem.vcd");
        $dumpvars(0, tb_inst_mem);

        // Store one instruction in four consecutive bytes
        uut.mem[0] = 8'h93;
        uut.mem[1] = 8'h00;
        uut.mem[2] = 8'h50;
        uut.mem[3] = 8'h00;

        addr = 32'd0;
        #10;
        $display("Address=%h Instruction=%h", addr, instruction);

        addr = 32'd4;
        #10;
        $display("Address=%h Instruction=%h", addr, instruction);

        $finish;
    end

endmodule