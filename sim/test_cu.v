`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/25 21:52:22
// Design Name: 
// Module Name: test_cu
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


module test_cu(    );
reg clk;
reg rst;
reg [7:0]ir2cu;
reg [7:0]flags;
wire[31:0]control_signal;
initial begin
clk<=0;
rst<=0;
flags<=0;
ir2cu<=8'b0000_0010;

# 60
rst<=1;
end
always # 10 clk=~clk;
cu u_cu(
.clk(clk),
.rst(rst),
.data_from_ir(ir2cu),
.flags(flags),
.control_signal(control_signal)
);
endmodule
