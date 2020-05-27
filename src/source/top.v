`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/25 20:53:14
// Design Name: 
// Module Name: top
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


module top(
input clk,
input rst
);
wire [15:0] ram2mbr,mbr2ram,mbr2br,br2alu,acc_out,alu2acc,mr_out,alu2mr;
wire [31:0] control_signal;
wire [7:0] pc2mbr,mbr2pc,mbr2mar,mbr2ir,ir2cu,pc2mar,addr;
wire [7:0] flags;
cu u_cu(
.clk(clk),
.rst(rst),
.data_from_ir(ir2cu),
.flags(flags),
.control_signal(control_signal)
);
pc u_pc(
.clk(clk),
.rst(rst),
.control_signal(control_signal),
.data_from_mbr(mbr2pc),
.data_to_mbr(pc2mbr),
.data_to_mar(pc2mar)
);
MAR u_MAR(
.clk(clk),
.rst(rst),
.control_signal(control_signal),
.data_from_mbr(mbr2mar),
.data_from_pc(pc2mar),
.addr(addr)
);
MBR u_MBR(
.clk(clk),
.rst(rst),
.control_signal(control_signal),
.data_from_memory(ram2mbr),
.data_from_pc(pc2mbr),
.data_from_mr(mr_out),
.data_from_acc(acc_out),
.data_to_memory(mbr2ram),
.data_to_pc(mbr2pc),
.data_to_mar(mbr2mar),
.data_to_ir(mbr2ir),
.data_to_br(mbr2br)
);
IR u_IR(
.clk(clk),
.rst(rst),
.control_signal(control_signal),
.data_from_mbr(mbr2ir),
.data_to_cu(ir2cu)
);
BR u_BR(
.clk(clk),
.rst(rst),
.control_signal(control_signal),
.MBRtoBR(mbr2br),
.BRtoALU(br2alu)
);
ALU u_ALU(
.clk(clk),
.rst(rst),
.control_signal(control_signal),
.BRtoALU(br2alu),
.ACCtoALU(acc_out),
.ALUtoACC(alu2acc),
.ALUtoMR(alu2mr),
.flag(flags)
);
RAM u_RAM(
.clk(clk),
.rst(rst),
.control_signal(control_signal),
.data_in(mbr2ram),
.data_out(ram2mbr),
.addr(addr)
);
ACC u_ACC(
.clk(clk),
.rst(rst),
.control_signal(control_signal),
.acc_in(alu2acc),
.acc_out(acc_out)

);
MR u_MR(
.clk(clk),
.rst(rst),
.mr_in(alu2mr),
.mr_out(mr_out)
);
endmodule
