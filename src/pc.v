`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/12 10:33:27
// Design Name: 
// Module Name: pc
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


module pc(
input clk,
input rst,
input [31:0]control_signal,
input [7:0]data_from_mbr,
output reg [7:0]data_to_mbr,
output reg [7:0]data_to_mar
    );
reg [7:0]buffer_pc;
always@(posedge clk or negedge rst)begin
    if(!rst)begin
        buffer_pc<=0;
        data_to_mar<=0;
        data_to_mbr<=0;
    end
    else begin
        if(control_signal[20] == 1)begin
            buffer_pc <= buffer_pc + 1;
        end
        if(control_signal[1] == 1)begin
            data_to_mbr <= buffer_pc ;
        end  
        if(control_signal[2] == 1)begin
            data_to_mar <= buffer_pc ;
        end
        if(control_signal[3] == 1)begin
           buffer_pc <= data_from_mbr ;
        end                     
    end
end
endmodule
