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
input [7:0]flags,
output reg [31:0] control_signal
    );
reg [7:0]buffer_cu;
reg [7:0]car_addr;
reg [31:0]buffer_control_signal;

parameter store = 8'b0000_0001;
parameter load = 8'b0000_0010;
parameter add = 8'b0000_0011;
parameter sub = 8'b0000_0100;
parameter jmpgez = 8'b0000_0101;
parameter jmp = 8'b0000_0110;
parameter halt = 8'b0000_0111;
parameter mpy = 8'b0000_1000;
parameter div = 8'b0000_1001;
parameter and_and = 8'b0000_1010;
parameter or_or = 8'b0000_1011;
parameter not_not = 8'b0000_1100;
parameter logical_shift_right = 8'b0000_1101;
parameter logical_shift_left = 8'b0000_1110;
parameter arithmetic_shift_right = 8'b0000_1111;
parameter arithmetic_shift_left = 8'b0001_0000;

parameter mar2memory = 32'b1<<0;
parameter pc2mbr = 32'b1<<1;
parameter pc2mar = 32'b1<<2;
parameter mbr2pc = 32'b1<<3;
parameter mbr2ir = 32'b1<<4;
parameter memory2mbr = 32'b1<<5;
parameter mbr2br = 32'b1<<6;
parameter acc2alu = 32'b1<<7;
parameter mbr2mar = 32'b1<<8;
//parameter alu2acc = 32'b1<<9;
parameter mbr2acc = 32'b1<<10;
parameter acc2mbr = 32'b1<<11;
parameter mbr2memory = 32'b1<<12;
parameter ir2cu = 32'b1<<13;
parameter br2alu = 32'b1<<14;
parameter mr2mbr = 32'b1<<15;
parameter alu2mbr = 32'b1<<16;
parameter car_plus1 = 32'b1<<17;
parameter car_jump = 32'b1<<18;
parameter car_clear = 32'b1<<19;
parameter pc_plus1 = 32'b1<<20;
parameter acc_clear = 32'b1<<21;
parameter addition = 32'b1<<22;
parameter subtraction = 32'b1<<23;
parameter and_operation = 32'b1<<24;
parameter or_operation = 32'b1<<25;
parameter not_operation = 32'b1<<26;
parameter logical_shift_left_operation = 32'b1<<27;
parameter logical_shift_right_operation = 32'b1<<28;
parameter mpy_operation = 32'b1<<29;
parameter arithmetic_shift_left_operation =  32'b1<<30;
parameter arithmetic_shift_right_operation =  32'b1<<31;
always@(posedge clk or negedge rst)begin
    if(rst == 0)begin
        control_signal<=0;
        buffer_cu<=5;
        car_addr<=0;
        buffer_control_signal<=0;
    end
    else begin
    buffer_cu<=1;
    if(buffer_control_signal&car_plus1)begin
    buffer_cu<=2;
        car_addr = car_addr + 1;
    end
    if(buffer_control_signal&car_clear)begin
    buffer_cu<=3;
        car_addr = 0;
    end
    if(buffer_control_signal&car_jump)
        begin
        buffer_cu<=4;
        case (data_from_ir)
        store:car_addr<=8'b0000_1000;
        load:car_addr<=8'b0001_0000;
        add:car_addr<=8'b0001_1000;
        sub:car_addr<=8'b0010_0000;
        jmpgez:car_addr<=8'b0010_1000;
        jmp:car_addr<=8'b0011_0000;
        halt:car_addr<=8'b0011_1000;
        mpy:car_addr<=8'b0100_0000;
        div:car_addr<=8'b0100_1000;
        and_and:car_addr<=8'b0101_0000;
        or_or:car_addr<=8'b0101_1000;
        not_not:car_addr<=8'b0110_0000;
        logical_shift_right:car_addr<=8'b0110_1000;
        logical_shift_left:car_addr<=8'b0111_0000;
        arithmetic_shift_right:car_addr<=8'b0111_1000;
        arithmetic_shift_left:car_addr<=8'b1000_0000;
        default:car_addr<=0;
        endcase
        end
    end
end
always@(posedge clk)begin
    if(!rst)begin
        car_addr<=0;
    end
    else begin
    case(car_addr)
    //autofetch
    8'b0000_0000:buffer_control_signal<=memory2mbr|car_plus1;
    8'b0000_0001:buffer_control_signal<=mbr2ir|car_plus1;
    8'b0000_0010:buffer_control_signal<=ir2cu|car_plus1;
    8'b0000_0011:buffer_control_signal<=car_jump;
    //STORE
    8'b0000_1000:buffer_control_signal<=mbr2mar|pc_plus1|car_plus1;
    8'b0000_1001:buffer_control_signal<=acc2mbr|car_plus1;
    8'b0000_1010:buffer_control_signal<=mbr2memory|car_plus1;
    8'b0000_1011:buffer_control_signal<=pc2mar|car_clear;
    //LOAD
    8'b0001_0000:buffer_control_signal<=mbr2mar|pc_plus1|car_plus1;
    8'b0001_0001:buffer_control_signal<=memory2mbr|car_plus1;
    8'b0001_0010:buffer_control_signal<=mbr2br|acc_clear|car_plus1;
    8'b0001_0011:buffer_control_signal<=addition|car_plus1;
    8'b0001_0100:buffer_control_signal<=pc2mar|car_clear;
    //ADD
    8'b0001_1000:buffer_control_signal<=mbr2mar|pc_plus1|car_plus1;
    8'b0001_1001:buffer_control_signal<=memory2mbr|car_plus1;
    8'b0001_1010:buffer_control_signal<=mbr2br|car_plus1;
    8'b0001_1011:buffer_control_signal<=addition|car_plus1;
    8'b0001_1100:buffer_control_signal<=pc2mar|car_clear;
    //SUB
    8'b0010_0000:buffer_control_signal<=mbr2mar|pc_plus1|car_plus1;
    8'b0010_0001:buffer_control_signal<=memory2mbr|car_plus1;
    8'b0010_0010:buffer_control_signal<=mbr2br|car_plus1;
    8'b0010_0011:buffer_control_signal<=subtraction|car_plus1;
    8'b0010_0100:buffer_control_signal<=pc2mar|car_clear;
    //JMPGEZ
    8'b0010_1000:begin
                    if(flags[0] == 0)begin
                        buffer_control_signal<= mbr2pc|car_plus1;
                    end
                    else begin
                        buffer_control_signal<=pc_plus1|car_plus1;
                    end
        
        end
     8'b0010_1001:buffer_control_signal<=pc2mar|car_clear;   
    //JMP
    8'b0011_0000:buffer_control_signal<= mbr2pc|car_plus1;
    8'b0011_0001:buffer_control_signal<=pc2mar|car_clear;
    //HALT
    8'b0011_1000:buffer_control_signal<=car_clear;
    //MPY
    8'b0100_0000:buffer_control_signal<=mbr2mar|pc_plus1|car_plus1;
    8'b0100_0001:buffer_control_signal<=memory2mbr|car_plus1;
    8'b0100_0010:buffer_control_signal<=mbr2br|car_plus1;
    8'b0100_0011:buffer_control_signal<=mpy_operation|car_plus1;
    8'b0100_0100:buffer_control_signal<=alu2mbr|car_plus1;
    8'b0100_0101:buffer_control_signal<=pc2mar|car_clear;
    //DIV
    
    //AND
    8'b0101_0000:buffer_control_signal<=mbr2mar|pc_plus1|car_plus1;
    8'b0101_0001:buffer_control_signal<=memory2mbr|car_plus1;
    8'b0101_0010:buffer_control_signal<=mbr2br|car_plus1;
    8'b0101_0011:buffer_control_signal<=and_operation|car_plus1;
    8'b0101_0100:buffer_control_signal<=pc2mar|car_clear;
    //OR
    8'b0101_1000:buffer_control_signal<=mbr2mar|pc_plus1|car_plus1;
    8'b0101_1001:buffer_control_signal<=memory2mbr|car_plus1;
    8'b0101_1010:buffer_control_signal<=mbr2br|car_plus1;
    8'b0101_1011:buffer_control_signal<=or_operation|car_plus1;
    8'b0101_1100:buffer_control_signal<=pc2mar|car_clear;
    //NOT
    8'b0110_0000:buffer_control_signal<=mbr2mar|pc_plus1|car_plus1;
    8'b0110_0001:buffer_control_signal<=memory2mbr|car_plus1;
    8'b0110_0010:buffer_control_signal<=mbr2br|car_plus1;
    8'b0110_0011:buffer_control_signal<=not_operation|car_plus1;
    8'b0110_0100:buffer_control_signal<=pc2mar|car_clear;
    //logical_shift_right
    8'b0110_1000:buffer_control_signal<=logical_shift_right_operation|pc_plus1|car_plus1;
    8'b0110_1001:buffer_control_signal<=pc2mar|car_clear;
    //logical_shift_left
    8'b0111_0000:buffer_control_signal<=logical_shift_left_operation|pc_plus1|car_plus1;
    8'b0111_0001:buffer_control_signal<=pc2mar|car_clear;
    //arithmetic_shift_right
    8'b0111_1000:buffer_control_signal<=arithmetic_shift_right|pc_plus1|car_plus1;
    8'b0111_0001:buffer_control_signal<=pc2mar|car_clear;
    //arithmetic_shift_left:car_addr<=8'b1000_0000;
    8'b1000_0000:buffer_control_signal<=arithmetic_shift_left|pc_plus1|car_plus1;
    8'b1000_0001:buffer_control_signal<=pc2mar|car_clear;
    default:buffer_control_signal<=0;
    endcase
    end
end
always@(posedge clk)begin
    control_signal<=buffer_control_signal;
end
endmodule
