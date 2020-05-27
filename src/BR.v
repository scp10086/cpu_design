`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/27 16:51:03
// Design Name: 
// Module Name: BR
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


module BR(
input clk,
input rst,
input [31:0]control_signal,
input [15:0]MBRtoBR,
output reg[15:0]BRtoALU
    );
reg [15:0] buffer_br=0;    
    always@( clk or posedge rst)begin
        if(!rst)begin
        BRtoALU<=16'h0000;
        end
        else begin
        buffer_br<=MBRtoBR;
        BRtoALU<=buffer_br;
        end
    end    
    
    
endmodule
