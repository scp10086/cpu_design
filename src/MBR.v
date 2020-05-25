`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/07 14:56:45
// Design Name: 
// Module Name: MBR
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


module MBR(
input clk,
input rst,
input [31:0]control_signal,
input [15:0]data_from_memory,
input [7:0]data_from_pc,
input [15:0]data_from_mr,
input [15:0]data_from_acc,
output reg [15:0]data_to_memory,
output reg [7:0]data_to_pc,
output reg [7:0]data_to_mar,
output reg [7:0]data_to_ir,
output reg [15:0]data_to_br
    );
reg [15:0]buffer_mbr;
always@(posedge clk or negedge rst)begin
    if(!rst)begin
        data_to_memory<=0;
        data_to_pc<=0;
        data_to_mar<=0;
        buffer_mbr <=0;
        data_to_ir<=0;
        data_to_br<=0;
    end
    else begin
        if(control_signal[5] == 1)begin
            buffer_mbr<=data_from_memory;
        end
        if(control_signal[12] == 1)begin
            data_to_memory<=buffer_mbr;
        end
        if(control_signal[8] == 1)begin
            data_to_mar<=buffer_mbr[7:0];
        end
        if(control_signal[3] == 1)begin
            data_to_pc<=buffer_mbr[7:0];
        end
        if(control_signal[1] == 1)begin
            buffer_mbr[7:0]<=data_from_pc;
        end      
        if(control_signal[4] == 1)begin
            data_to_ir<=buffer_mbr[15:8];
        end 
        if(control_signal[6] == 1)begin
            data_to_br<=buffer_mbr;
        end 
        if(control_signal[15] == 1)begin
            buffer_mbr<=data_from_mr;
        end
        if(control_signal[11] == 1)begin
            buffer_mbr<=data_from_acc;
        end                                        
    end
end
endmodule
