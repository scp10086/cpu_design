`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/14 14:41:06
// Design Name: 
// Module Name: cu
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


module cu(
input clk,
input rst,
input [7:0]data_from_ir,
output reg [31:0] control_signal
    );
reg [7:0]buffer_cu;
reg [7:0]car_addr;
always@(posedge clk or negedge rst)begin
    if(!rst)begin
        control_signal<=0;
        buffer_cu<=0;
        car_addr<=0;
    end
    else begin
        
    end
end
endmodule
