library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity phase_gen is
    Port ( clk : in  STD_LOGIC;
	        rst : in STD_LOGIC := '0';
           P : out  STD_LOGIC_VECTOR (7 downto 0));
end phase_gen;

architecture Behavioral of phase_gen is

COMPONENT d_ff is
	PORT(
		dclock : IN std_logic;
		dreset : IN std_logic;
		din : IN std_logic ;          
		dout : OUT std_logic 
		);
	END COMPONENT;
	

signal dintern : std_logic_vector (7 downto 0); --Change value of N to change size of shift register
signal feedback : std_logic := '0';



begin

instdff : d_ff port map (clk , rst , feedback , dintern(0));
genreg : for i in 1 to 7 generate --Change Value of N Here to generate that many instance of d flip flop
begin
instdff : d_ff port map ( clk , rst , dintern(i-1) , dintern(i));
end generate genreg;

main : process(clk)

begin
	if clk'event and clk = '1' then	
			if rst = '0'  then
				if dintern /= "0" then
					
					feedback <= dintern(7); 				
			   
				else
				feedback <= '1';
				end if;
			end if;	 			 						
	end if;	
end process main;

P <= dintern; --Change Value of N Here to take output to top entity 



end Behavioral;