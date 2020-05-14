`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/01 21:03:49
// Design Name: 
// Module Name: RAM
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


module RAM(
input clk,
input rst,
input [15:0] data_in,
output [15:0] data_out,
input [7:0] addr
    );
reg flag_wea = 0;
blk_mem_gen_0 u_blk_mem_gen_0 (
.addra(addr),
.clka(clk),
.dina(data_in),
.douta(data_out),
.ena(rst), 
.wea(flag_wea) //ram 读写使能信号,高电平写入,低电平读出  
);
endmodule

/*module RAM(
input clk,
input rst,
input [15:0] data_in,
output [15:0] data_out,
input [7:0] addr,
input [31:0] control_signal
    );
reg flag_wea = 1'b0;
always@(posedge clk)begin
    if(control_signal[12] == 1'b1)
    begin
        flag_wea <= 1'b1;
    end
    else 
    begin
        if(control_signal[5] == 1'b1)
        begin
            flag_wea <= 1'b0;
        end
        else flag_wea <= 1'b0;
    end 
    
    
end
blk_mem_gen_0 u_blk_mem_gen_0 (
.addra(addr),
.clka(clk),
.dina(data_in),
.douta(data_out),
.ena(rst), 
.wea(flag_wea) //ram 读写使能信号,高电平写入,低电平读出  
);
endmodule*/