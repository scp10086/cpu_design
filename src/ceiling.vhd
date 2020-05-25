----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2020/05/25 00:17:45
-- Design Name: 
-- Module Name: ceiling - Behavioral

----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity ceiling is
  Port (
  clk,rst:in std_logic;
  acc_out:out std_logic_vector(15 downto 0);
  mr_out:out std_logic_vector(15 downto 0)
   );
end ceiling;

architecture Behavioral of ceiling is

component cu is
port(
clk:in std_logic;
rst:in std_logic;
data_from_ir:in std_logic_vector(7 downto 0);
flags:in std_logic_vector(7 downto 0);
control_signal:out std_logic_vector(31 downto 0)
);
end component;

component pc is
port(
clk:in std_logic;
rst:in std_logic;
control_signal:in std_logic_vector(31 downto 0);
data_from_mbr:in std_logic_vector(7 downto 0);
data_to_mbr:out std_logic_vector(7 downto 0);
data_to_mar:out std_logic_vector(7 downto 0)
);
end component;

component MAR is
port(
clk:in std_logic;
rst:in std_logic;
control_signal:in std_logic_vector(31 downto 0);
data_from_mbr:in std_logic_vector(7 downto 0);
data_from_pc:in std_logic_vector(7 downto 0);
addr:out std_logic_vector(7 downto 0)
);
end component;

component MBR is
port(
clk:in std_logic;
rst:in std_logic;
pc2mbr:in std_logic_vector(7 downto 0);
ram2mbr,acc2mbr:in std_logic_vector(15 downto 0);
ctrl_sig:in std_logic_vector(31 downto 0);
mbr_out:out std_logic_vector(15 downto 0)
);
end component;

component IR is
port(
clk:in std_logic;
rst:in std_logic;
control_signal:in std_logic_vector(31 downto 0);
data_from_mbr:in std_logic_vector(7 downto 0);
data_to_cu:out std_logic_vector(7 downto 0)
);
end component;

component BR is
port(
clk:in std_logic;
rst:in std_logic;
MBRtoBR:in std_logic_vector(15 downto 0);
BRtoALU:out std_logic_vector(15 downto 0);
ctrl_sig:in std_logic_vector(31 downto 0) 
);
end component;

component ALU is
port(
clk:in std_logic;
rst:in std_logic;
BRtoALU:in std_logic_vector(15 downto 0);
ctrl_sig:in std_logic_vector(31 downto 0); --32位控制信号
flag:out std_logic_vector(7 downto 0); --8位flag
ACCtoALU:in std_logic_vector(15 downto 0);
ALUtoACC, ALUtoMR:out std_logic_vector(15 downto 0)
);
end component;

component RAM is
port(
clk:in std_logic;
rst:in std_logic;
data_in:in std_logic_vector(15 downto 0);
addr:in std_logic_vector(7 downto 0); --32位控制信号
data_out:out std_logic_vector(15 downto 0)
);
end component;

component ACC is
port(
clk,rst:in std_logic;
acc_in:in std_logic_vector(15 downto 0);
acc_out:out std_logic_vector(15 downto 0)
);
end component;

component MR is
port(
clk,rst:in std_logic;
mr_in:in std_logic_vector(15 downto 0);
mr_out:out std_logic_vector(15 downto 0)
);
end component;

signal ir2cu,pc2mbr,pc2mar,addr:std_logic_vector(7 downto 0);
signal flags:std_logic_vector(7 downto 0);
signal mbr_out,ram2mbr,acc2mbr,br2alu,acc2alu,alu2acc,alu2mr:std_logic_vector(15 downto 0);
signal ctrl_sig:std_logic_vector(31 downto 0);



begin

mux1:cu
port map(
clk=>clk,
rst=>rst,
data_from_ir=>ir2cu,
flags=>flags,
control_signal=>ctrl_sig
);

mux2:pc
port map(
clk=>clk,
rst=>rst,
control_signal=>ctrl_sig,
data_from_mbr=>mbr_out(7 downto 0),
data_to_mbr=>pc2mbr,
data_to_mar=>pc2mar
);

mux3:MAR
port map(
clk=>clk,
rst=>rst,
control_signal=>ctrl_sig,
data_from_mbr=>mbr_out(7 downto 0),
data_from_pc=>pc2mar,
addr=>addr
);

mux4:MBR
port map(
clk=>clk,
rst=>rst,
pc2mbr=>pc2mbr,
ram2mbr=>ram2mbr,
acc2mbr=>acc2mbr,
ctrl_sig=>ctrl_sig,
mbr_out=>mbr_out
);

mux5:IR
port map(
clk=>clk,
rst=>rst,
control_signal=>ctrl_sig,
data_from_mbr=>mbr_out(15 downto 8),
data_to_cu=>ir2cu
);

mux6:BR
port map(
clk=>clk,
rst=>rst,
MBRtoBR=>mbr_out, --16位
BRtoALU=>br2alu,
ctrl_sig=>ctrl_sig
);

mux7:ALU
port map(
clk=>clk,
rst=>rst,
BRtoALU=>br2alu,
ctrl_sig=>ctrl_sig,
flag=>flags,
ACCtoALU=>acc2alu,
ALUtoACC=>alu2acc,
ALUtoMR=>alu2mr
);

mux8:RAM
port map(
clk=>clk,
rst=>rst,
data_in=>mbr_out,
addr=>addr,
data_out=>ram2mbr
);

mux9:ACC
port map(
clk=>clk,
rst=>rst,
acc_in=>alu2acc,
acc_out=>acc_out
);

mux10:MR
port map(
clk=>clk,
rst=>rst,
mr_in=>alu2mr,
mr_out=>mr_out
);

end Behavioral;
