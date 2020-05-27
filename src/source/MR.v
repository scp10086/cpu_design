`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/27 16:33:04
// Design Name: 
// Module Name: ACC
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


module MR(
input clk,
input rst,
input [31:0]control_signal,
input [15:0]mr_in,
output reg[15:0]mr_out
    );
reg [15:0] buffer_mr=0;    
always@(posedge clk or posedge rst)begin
    if(rst)begin
    buffer_mr<=mr_in;
    mr_out<=buffer_mr;
    end
    else begin
        mr_out<=0;
    end
end

always@(posedge clk or posedge rst)begin
    if(rst)begin
    if(control_signal[21]==1)begin
    buffer_mr<=16'h0000;
    mr_out<=16'h0000;
    end
    end
end   
endmodule
