module tb_alu;

    logic [31:0] a, b;
    logic [2:0] sel;
    logic zero;
    logic [63:0] alu_out;

    alu uut (
        .a(a),
        .b(b),
        .sel(sel),
        .zero(zero),
        .alu_out(alu_out)
    );

    initial begin
        $dumpfile("alu.vcd");
        $dumpvars(0, tb_alu);

        a = 32'd10; b = 32'd5;

        sel = 3'b000; #10;
        $monitor("ADD: %h Zero=%b", alu_out, zero);

        sel = 3'b001; #10;
        //$display("SUB: %h Zero=%b", alu_out, zero);

        sel = 3'b010; #10;
      //  $display("MUL: %h Zero=%b", alu_out, zero);

        sel = 3'b011; #10;
      //  $display("DIV: %h Zero=%b", alu_out, zero);

        sel = 3'b100; #10;
      //  $display("OR:  %h Zero=%b", alu_out, zero);

        sel = 3'b101; #10;
      //  $display("XOR: %h Zero=%b", alu_out, zero);

        sel = 3'b110; #10;
      //  $display("NOR: %h Zero=%b", alu_out, zero);

        // Test zero flag using subtraction
        a = 32'd10; b = 32'd10;
        sel = 3'b001; #10;
        $display("SUB ZERO TEST: %h Zero=%b", alu_out, zero);

        $finish;
    end

endmodule