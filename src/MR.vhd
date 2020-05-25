----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2020/05/25 14:40:28
-- Design Name: 
-- Module Name: MR - Behavioral

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

entity MR is
  Port (
  clk,rst:in std_logic;
  mr_in:in std_logic_vector(15 downto 0);
  mr_out:out std_logic_vector(15 downto 0)
   );
end MR;

architecture Behavioral of MR is

begin

process(clk)
begin
if (clk'event and clk='1') then
if (rst='1') then
mr_out<=mr_in;
else mr_out<="0000000000000000";
end if;
end if;
end process;

end Behavioral;
