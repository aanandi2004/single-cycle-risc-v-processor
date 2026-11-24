module tb_adder;

    logic [31:0] a, b;
    logic [31:0] sum;

    adder uut (
        .a(a),
        .b(b),
        .sum(sum)
    );

    initial begin
        $dumpfile("adder.vcd");
        $dumpvars(0, tb_adder);

        a = 32'd10; b = 32'd20;
        #10;
        $display("a=%d b=%d sum=%d", a, b, sum);

        a = 32'hFFFFFFFF; b = 32'd1;
        #10;
        $display("a=%h b=%h sum=%h", a, b, sum);

        $finish;
    end

endmodule