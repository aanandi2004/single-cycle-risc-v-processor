module tb_mux_alu;

    logic [31:0] read_data2, imm;
    logic alusrc;
    logic [31:0] alu_input2;

    mux_alu uut (
        .read_data2(read_data2),
        .imm(imm),
        .alusrc(alusrc),
        .alu_input2(alu_input2)
    );

    initial begin
        $dumpfile("mux_alu.vcd");
        $dumpvars(0, tb_mux_alu);

        read_data2 = 32'h0000000A;
        imm = 32'h00000005;

        alusrc = 0; #10;
        $display("ALUSrc=%b Output=%h", alusrc, alu_input2);

        alusrc = 1; #10;
        $display("ALUSrc=%b Output=%h", alusrc, alu_input2);

        $finish;
    end

endmodule