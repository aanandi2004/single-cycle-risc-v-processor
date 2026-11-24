module inst_mem(
    input logic [31:0] addr,
    output logic [31:0] instruction
);

//word addressable
//logic [31:0] mem [0:1023];
// byte addressable
logic [7:0] mem [0:1023];

assign instruction[7:0]   = mem[addr];
assign instruction[15:8]  = mem[addr + 1];
assign instruction[23:16] = mem[addr + 2];
assign instruction[31:24] = mem[addr + 3];


endmodule 