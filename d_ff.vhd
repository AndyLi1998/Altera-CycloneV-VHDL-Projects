library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity d_ff is
    Port ( dclock : in  STD_LOGIC ;
           dreset : in  STD_LOGIC ;
           din : in  STD_LOGIC;
           dout : out  STD_LOGIC);
end d_ff;

architecture Behavioral of d_ff is

begin
process(dclock)

begin
	if dclock'event and dclock = '1' then
		if dreset = '0' then
			dout <= din;
      else
			dout <= '1';
		end if;
	end if;
end process;


end Behavioral;