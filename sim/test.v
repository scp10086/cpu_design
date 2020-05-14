`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/07 15:14:33
// Design Name: 
// Module Name: test
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


module test(    );
reg [15:0]data;
reg flag;
reg [3:0]register;
reg clk;
initial begin
    data = 16'h3333;
    clk = 1'b0;
end
always #10 clk = ~clk;
always@(posedge clk)begin
    flag = data[2:2];
    register = data[3:0];
end
endmodule
