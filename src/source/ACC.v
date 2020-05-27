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


module ACC(
input clk,
input rst,
input [31:0]control_signal,
input [15:0]acc_in,
output reg[15:0]acc_out
    );
reg [15:0] buffer_acc=0;    
always@(posedge clk or posedge rst)begin
    if(rst)begin
    buffer_acc<=acc_in;
    acc_out<=buffer_acc;
    end
    else begin
        acc_out<=0;
    end
end

always@(posedge clk or posedge rst)begin
    if(rst)begin
    if(control_signal[21]==1)begin
    buffer_acc<=16'h0000;
    acc_out<=16'h0000;
    end
    end
end   
endmodule
