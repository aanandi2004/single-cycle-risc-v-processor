module tb_mux_wb;

    logic [31:0] alu_result, mem_read_data;
    logic memtoreg;
    logic [31:0] write_data;

    mux_wb uut (
        .alu_result(alu_result),
        .mem_read_data(mem_read_data),
        .memtoreg(memtoreg),
        .write_data(write_data)
    );

    initial begin
        $dumpfile("mux_wb.vcd");
        $dumpvars(0, tb_mux_wb);

        alu_result = 32'h0000000A;
        mem_read_data = 32'h00000020;

        memtoreg = 0; #10;
        $display("MemToReg=%b WriteData=%h", memtoreg, write_data);

        memtoreg = 1; #10;
        $display("MemToReg=%b WriteData=%h", memtoreg, write_data);

        $finish;
    end

endmodule