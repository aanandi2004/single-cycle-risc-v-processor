module tb_pc;

    logic clk, rst;
    logic [31:0] pc_in;
    logic [31:0] pc_out;

    pc uut (
        .clk(clk),
        .rst(rst),
        .pc_in(pc_in),
        .pc_out(pc_out)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("pc.vcd");
        $dumpvars(0, tb_pc);

        clk = 0;
        rst = 0;
        pc_in = 32'h00000000;

        #10;
        $display("Reset: PC=%h", pc_out);

        rst = 1;
        pc_in = 32'h00000004;
        #10;
        $display("PC=%h", pc_out);

        pc_in = 32'h00000008;
        #10;
        $display("PC=%h", pc_out);

        pc_in = 32'h0000000C;
        #10;
        $display("PC=%h", pc_out);

        $finish;
    end

endmodule