module tb_register;

    logic clk, rst, regwrite;
    logic [31:0] instr, write_data;
    logic [31:0] out1, out2;

    Register uut (
        .clk(clk),
        .rst(rst),
        .instr(instr),
        .regwrite(regwrite),
        .write_data(write_data),
        .out1(out1),
        .out2(out2)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("waveform/reg_file.vcd");
        $dumpvars(0, tb_register);

        clk = 0;
        rst = 0;

        // Write 25 into x5
        instr = 32'd640;
        write_data = 32'd25;
        regwrite = 1;

        #10;

        // Read x5 and x0
        instr = 32'h00028013;
        regwrite = 0;

        #5;
        $display("x5 = %d, x0 = %d", out1, out2);

        #5;
        $finish;
    end

endmodule