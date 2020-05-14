`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/12 11:47:50
// Design Name: 
// Module Name: IR
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


module IR(
input clk,
input rst,
input [31:0]control_signal,
input [7:0]data_from_mbr,
output reg [7:0]data_to_cu
    );
reg [7:0] buffer_ir;
always@(posedge clk or negedge rst)begin
    if(!rst)begin
        buffer_ir<=0;
        data_to_cu<=0;
    end
    else begin
        if(control_signal[4]==1)begin
            buffer_ir<=data_from_mbr;
        end
        if(control_signal[13]==1)begin
            data_to_cu<=buffer_ir;
        end
    end
end
endmodule
