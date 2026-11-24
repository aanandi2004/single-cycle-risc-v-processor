module tb_imm_gen;

    logic[31:0] instr;
    logic [31:0] out;

    imm_gen uut (
        .instr(instr),
        .out(out)
    );

    initial begin
        $dumpfile("waveform/imm_gen.vcd");
        $dumpvars(0, tb_imm_gen);
                $monitor("instr = %b, out = %b", instr, out);
        instr = 32'b0;
        #10;
       // $display("instr = %b, out = %b", instr, out);
        #20;
        instr = 32'b11111111111111111111111111111111;


       #10 $finish;
    end

endmodule