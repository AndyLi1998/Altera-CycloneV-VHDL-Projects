library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity updown_count_3b is
    Port ( clk,rst,INC, DEC : in  STD_LOGIC;
           count : out  STD_LOGIC_VECTOR (2 downto 0));
end updown_count_3b;

architecture Behavioral of updown_count_3b is

signal temp:std_logic_vector(2 downto 0):="000";

begin
process(clk,rst)
begin

if(rst='1')then
temp<="000";
elsif(rising_edge(clk))then
	if(INC='1' AND DEC='0')then
	temp<=temp+1;
	elsif(INC='0' AND DEC='1')then
	temp<=temp-1;
	else
	temp <= temp;
	end if;
end if;
end process;

count<=temp;
end Behavioral;