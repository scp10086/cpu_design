`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/27 18:03:10
// Design Name: 
// Module Name: ALU
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


module ALU(
input clk,
input rst,
input [31:0]control_signal,
input signed [15:0]BRtoALU,
input signed [15:0]ACCtoALU,
output reg [15:0]ALUtoACC,
output reg [15:0]ALUtoMR,
output reg[7:0]flag
    );

reg signed[31:0] mpy=0;
//reg [15:0] low=0;  
//reg [15:0] high=0;  
reg signed[15:0] operand1=0;  
reg signed[15:0] operand2=0;  
reg signed[15:0] result=0;
reg [15:0] left_arith=0;  
reg [15:0] right_arith=0;  

always@( clk or posedge rst)begin
   if(rst)begin
   operand1<=ACCtoALU;
   operand2<=BRtoALU;
   //ALUtoACC<=result;
   //ALUtoACC<=mpy[15:0];
   //ALUtoMR<=mpy[31:16];
   end
   else begin
        flag<=0;
        ALUtoMR<=0;
        ALUtoACC<=0;
   end
end

always@( clk or posedge rst)begin
   if(rst)begin
   if(ACCtoALU[15]==0)begin
   flag<=8'h00;
   end
   else begin
   flag<=8'h01;
   end
   end
end
   
always@( clk or posedge rst)begin
   if(rst)begin
   if(control_signal[22]==1)begin
     result<=operand1+operand2;
     ALUtoACC<=result;
   end
   if(control_signal[23]==1)begin
     result<=operand1-operand2;
     ALUtoACC<=result;
   end
   if(control_signal[29]==1)begin
     mpy<=ACCtoALU*BRtoALU;
     ALUtoACC<=mpy[15:0];
   end
   if(control_signal[16]==1)begin
     mpy<=operand1*operand2;
     ALUtoMR<=mpy[31:16];
   end
   if(control_signal[24]==1)begin //Óë
     result<=operand1&operand2;
     ALUtoACC<=result;
   end
   if(control_signal[25]==1)begin //»ò
     result<=operand1|operand2;
     ALUtoACC<=result;
   end
   if(control_signal[26]==1)begin //·Ç  
     result<=~operand1;
     ALUtoACC<=result;
   end
   if(control_signal[27]==1)begin //Âß¼­×óÒÆ
     result<=operand1<<1;
     ALUtoACC<=result;
   end
   if(control_signal[28]==1)begin //Âß¼­ÓÒÒÆ
     result<=operand1>>1;
     ALUtoACC<=result;
   end
   if(control_signal[30]==1)begin //ËãÊõ×óÒÆ
     result<=operand1<<1;
     ALUtoACC<=result;
   end
   if(control_signal[31]==1)begin //ËãÊõÓÒÒÆ
     result<=operand1>>>1;
     ALUtoACC<=result;
   end
   end
end


endmodule
