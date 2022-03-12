library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity prbs is
    Port ( pclock : in  STD_LOGIC;
	        preset : IN std_logic := '0';
			  --prbsout : out  STD_LOGIC;
           LEDR0 : out  STD_LOGIC;
			  LEDR1 : out  STD_LOGIC);
end prbs;

architecture Behavioral of prbs is

COMPONENT d_ff is
	PORT(
		dclock : IN std_logic;
		dreset : IN std_logic;
		din : IN std_logic ;          
		dout : OUT std_logic 
		);
	END COMPONENT;
	

signal dintern : std_logic_vector (9 downto 0):="0001110001"; --Change value of N to change size of shift register
signal feedback : std_logic := '0';
signal prbsout : STD_LOGIC;


begin

instdff : d_ff port map (pclock , preset , feedback , dintern(0));
genreg : for i in 1 to 9 generate --Change Value of N Here to generate that many instance of d flip flop
begin
instdff : d_ff port map ( pclock , preset , dintern(i-1) , dintern(i));
end generate genreg;

main : process(pclock)

begin
	if pclock'event and pclock = '1' then	
			if preset = '0'  then
				if dintern /= "0" then
					
					feedback <= dintern(6) xor dintern(9); 				
			   
				else
				feedback <= '1';
				end if;
			end if;	 			 						
	end if;	
end process main;

prbsout <= dintern(9) ; --Change Value of N Here to take output to top entity 
LEDR0 <=prbsout;
LEDR1 <= (dintern(9) AND dintern(8) AND dintern(7) AND dintern(6) AND dintern(5) AND dintern(4) AND dintern(3) AND dintern(2) AND dintern(1) AND dintern(0));


end Behavioral;

