module tb_data_mem;

      logic        clk,
      logic        rst,
      logic [31:0] add,
      logic [31:0] write_data,
      logic [31:0] read_out,
      logic        memwrite,
      logic        memread

    inst_mem uut (
        .clk(clk),
        .rst(rst),
        .add(add),
        .write_data(write_data),
        .read_out(read_out),
        .memwrite(memwrite),
        .memread(memread)
    );

    initial begin
    clk = 0;
    forever
    #5; clk = ~clk;
    end

    initial begin
        $dumpfile("data_mem.vcd");
        $dumpvars(0, tb_data_mem);
        $finish;
    end

endmodule