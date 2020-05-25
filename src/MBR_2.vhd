----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2020/05/24 23:45:21
-- Design Name: 
-- Module Name: MBR - Behavioral
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

entity MBR is
  Port (
  clk,rst:in std_logic;
  pc2mbr:in std_logic_vector(7 downto 0);
  ram2mbr,acc2mbr:in std_logic_vector(15 downto 0);
  ctrl_sig:in std_logic_vector(31 downto 0);
  --mbr2pc,mbr2mar:out std_logic_vector(7 downto 0);
  --mbr2ram,mbr2acc:out std_logic_vector(15 downto 0)
  mbr_out:out std_logic_vector(15 downto 0)
   );
end MBR;

architecture Behavioral of MBR is

begin

process(clk)
begin
if (clk'event and clk='1') then
if (rst='1') then
if (ctrl_sig(5)='1') then -- MBR<=Memory
mbr_out<=ram2mbr;
elsif (ctrl_sig(11)='1') then -- MBR<=ACC
mbr_out<=ram2mbr;
end if;
else mbr_out<="0000000000000000";
end if;
end if;
end process;

end Behavioral;
