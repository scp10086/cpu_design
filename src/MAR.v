`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/07 14:56:16
// Design Name: 
// Module Name: MAR
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


module MAR(
input clk,
input rst,
input [31:0]control_signal,
input [7:0]data_from_mbr,
input [7:0]data_from_pc,
output reg [7:0]addr
    );
reg [7:0] buffer_mar=0;
always@(posedge clk or posedge rst)begin
    if(!rst)begin
        addr <= 8'h00;
        buffer_mar<=8'h00;
    end
    else begin
        if(control_signal[8] == 1)
        begin
            buffer_mar <= data_from_mbr;
        end
        if(control_signal[2] == 1 )
        begin
            buffer_mar <= data_from_pc;
        end
        if(control_signal[0] == 1 )
        begin
            addr <= buffer_mar;
        end
    end
end
endmodule
