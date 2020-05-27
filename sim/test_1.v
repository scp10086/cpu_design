`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/25 18:22:33
// Design Name: 
// Module Name: test_1
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


module test_1(  );
reg clk;
reg rst;
initial begin
clk<=0;
rst<=0;

# 40
rst<=1;
end
always # 10 clk=~clk;
top u_top(
.clk(clk),
.rst(rst)
);
endmodule
