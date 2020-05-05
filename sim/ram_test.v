`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/05 18:57:40
// Design Name: 
// Module Name: ram_test
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ram_test();
reg clk;
reg rst;
reg wea;
reg [7:0]addr;
reg [15:0]data_in;
wire [15:0]data_out;
reg flag_pos;
initial begin
clk = 1'b0;
rst = 1'b1;
addr = 8'b0000_0000;
data_in = 16'h0000;
flag_pos = 1'b0;
end
always #10 clk = ~clk;
always @(posedge clk or posedge rst)begin
    flag_pos = ~flag_pos;
    if(flag_pos == 1'b1)begin
        addr = addr + 1'b1;
    end
end
RAM u_ram(
.clk(clk),
.rst(rst),
.data_in(data_in),
.data_out(data_out),
.addr(addr)
);
endmodule
