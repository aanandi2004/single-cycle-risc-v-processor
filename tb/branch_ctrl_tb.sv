module tb_branch_control;

    logic branch, zero;
    logic pcsrc;

    branch_control uut (
        .branch(branch),
        .zero(zero),
        .pcsrc(pcsrc)
    );

    initial begin
        $dumpfile("branch_control.vcd");
        $dumpvars(0, tb_branch_control);

        branch = 0; zero = 0; #10;
        $display("Branch=%b Zero=%b PCSrc=%b", branch, zero, pcsrc);

        branch = 1; zero = 0; #10;
        $display("Branch=%b Zero=%b PCSrc=%b", branch, zero, pcsrc);

        branch = 1; zero = 1; #10;
        $display("Branch=%b Zero=%b PCSrc=%b", branch, zero, pcsrc);

        branch = 0; zero = 1; #10;
        $display("Branch=%b Zero=%b PCSrc=%b", branch, zero, pcsrc);

        $finish;
    end

endmodule