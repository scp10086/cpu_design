----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2020/05/01 19:42:56 
-- Module Name: ALU - Behavioral
-- Description: 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.numeric_std.all;

entity ALU is
  Port (
  clk,rst:in std_logic;
  BRtoALU:in std_logic_vector(15 downto 0);
  ctrl_sig:in std_logic_vector(31 downto 0); --32位控制信号
  flag:out std_logic_vector(7 downto 0); --8位flag
  ACCtoALU:in std_logic_vector(15 downto 0);
  ALUtoACC, ALUtoMR:out std_logic_vector(15 downto 0) --MR放乘法结果的高16位
   );
end ALU;

architecture Behavioral of ALU is

signal low,high:std_logic_vector(15 downto 0);
signal operand1,operand2:std_logic_vector(15 downto 0); --operand1是ACCtoALU operand2是BRtoALU
signal left_arith,right_arith:std_logic_vector(15 downto 0);

begin

process(clk)
begin
if (clk'event and clk='1') then
 if (rst='1') then
 operand1<=ACCtoALU;
 operand2<=BRtoALU;
 end if;
end if;

end process;

process(clk)
begin
if (clk'event and clk='1') then
if (rst='1') then
if (ACCtoALU(15)=0) then --ACC>=0
flag<="00000000";
else 
flag<="00000001";
end if;
end if;
end if;
end process;


process(clk)
variable temp:std_logic_vector(31 downto 0):=x"00000000"; --乘积
begin
if (clk'event and clk='1') then
 if (rst='1') then
  if (ctrl_sig=x"00420000") then  --ACC<=ACC+BR
  ALUtoACC<=operand1 + operand2;
  elsif (ctrl_sig=x"00820000") then --ACC<=ACC-BR
  ALUtoACC<=operand1 - operand2;
  elsif (ctrl_sig=x"40020000") then --ACC<=ACC*BR(L)
  temp:=std_logic_vector (signed(operand1) * signed(operand2));
  ALUtoACC<=temp(15 downto 0);
  elsif (ctrl_sig=x"00030000") then  --ACC<=ACC*BR(H)
  temp:=std_logic_vector (signed(operand1) * signed(operand2));
  ALUtoMR<=temp(31 downto 16);
  elsif (ctrl_sig=x"01020000") then --ACC<=ACC&&BR
  ALUtoACC<=operand1 and operand2;
  elsif (ctrl_sig=x"02020000") then --ACC<=ACC||BR
  ALUtoACC<=operand1 or operand2;
  elsif (ctrl_sig=x"04020000") then --ACC<=!ACC
  ALUtoACC<=not operand1;
  elsif (ctrl_sig=x"08120000") then --SLL
  ALUtoACC<=operand1(14 downto 0)&'0';
  elsif (ctrl_sig=x"10120000") then --SRL
  ALUtoACC<='0'& operand1(15 downto 1);
  elsif (ctrl_sig=x"40120000") then --SLA
  left_arith(15 downto 1)<=operand1(14 downto 0);
  left_arith(0)<=operand1(15);
  ALUtoACC<=left_arith;
  elsif (ctrl_sig=x"80120000") then --SRA
  right_arith(14 downto 0)<=operand1(15 downto 1);
  right_arith(15)<=operand1(0);
  ALUtoACC<=right_arith;
  end if;
 end if;
end if;
end process;

end Behavioral;
