`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/25 21:52:22
// Design Name: 
// Module Name: test_cu
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


module test_cu(    );
reg clk;
reg rst;
reg [7:0]ir2cu;
reg [7:0]flags;
wire [15:0]mbr2ram;
reg [7:0]addr;
wire [15:0]ram2mbr;
reg [7:0]pc2mbr;
wire[31:0]control_signal;
reg [15:0]mr2mbr;
reg [15:0]acc2mbr;
wire [7:0]mbr2pc;
wire [7:0]mbr2mar;
wire [7:0]mbr2ir;
wire [7:0]mbr2br;
initial begin
clk<=0;
rst<=0;
flags<=0;
ir2cu<=8'b0000_0010;
pc2mbr<=1;
addr<=0;
mr2mbr<=2;
acc2mbr<=3;
# 60
rst<=1;
# 100
addr<=8'ha1;
end
always # 10 clk=~clk;
cu u_cu(
.clk(clk),
.rst(rst),
.data_from_ir(ir2cu),
.flags(flags),
.control_signal(control_signal)
);
RAM u_RAM(
.clk(clk),
.rst(rst),
.control_signal(control_signal),
.data_in(mbr2ram),
.data_out(ram2mbr),
.addr(addr)
);
MBR u_MBR(
.clk(clk),
.rst(rst),
.control_signal(control_signal),
.data_from_memory(ram2mbr),
.data_from_pc(pc2mbr),
.data_from_mr(mr2mbr),
.data_from_acc(acc2mbr),
.data_to_memory(mbr2ram),
.data_to_pc(mbr2pc),
.data_to_mar(mbr2mar),
.data_to_ir(mbr2ir),
.data_to_br(mbr2br)
);
endmodule
