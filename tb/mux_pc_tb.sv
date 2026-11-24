module tb_mux_pc;

    logic [31:0] pc_plus4, branch_target;
    logic pcsrc;
    logic [31:0] pc_next;

    mux_pc uut (
        .pc_plus4(pc_plus4),
        .branch_target(branch_target),
        .pcsrc(pcsrc),
        .pc_next(pc_next)
    );

    initial begin
        $dumpfile("mux_pc.vcd");
        $dumpvars(0, tb_mux_pc);

        pc_plus4 = 32'h00000004;
        branch_target = 32'h00000020;

        pcsrc = 0; #10;
        $display("PCSrc=%b PC_Next=%h", pcsrc, pc_next);

        pcsrc = 1; #10;
        $display("PCSrc=%b PC_Next=%h", pcsrc, pc_next);

        $finish;
    end

endmodule