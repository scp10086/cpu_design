----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2020/05/04 16:01:00
-- Design Name: 
-- Module Name: BR - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity BR is
  Port (
  clk,rst:in std_logic;
  MBRtoBR:in std_logic_vector(15 downto 0);
  BRtoALU:out std_logic_vector(15 downto 0);
  ctrl_sig:in std_logic_vector(31 downto 0) --32位控制信号
  );
end BR;

architecture Behavioral of BR is

signal temp:std_logic_vector(15 downto 0); --一开始命名buffer报错

begin

process(clk)
begin
if (clk'event and clk='1') then
 if (rst='1') then
  if (ctrl_sig(6)='1') then --对应控制信号C6
   temp<=MBRtoBR;
   BRtoALU<=temp;
  else BRtoALU<="0000000000000000";  --没有控制信号进来则给全0
  end if;
 end if;
end if;
end process;

end Behavioral;
