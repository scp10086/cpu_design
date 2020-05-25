----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2020/05/05 10:50:34
-- Design Name: 
-- Module Name: ACC - Behavioral

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

entity ACC is
  Port (
  clk,rst:in std_logic;
  acc_in:in std_logic_vector(15 downto 0);
  acc_out:out std_logic_vector(15 downto 0)
  --ctrl_sig:in std_logic_vector(31 downto 0)
   );
end ACC;

architecture Behavioral of ACC is

begin
process(clk)
begin
if (clk'event and clk='1') then
if (rst='1') then
acc_out<=acc_in;
else acc_out<="0000000000000000";
end if;
end if;
end process;
end Behavioral;
