library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity digital_filter is
    Port ( In_P,In_N,clk : in  STD_LOGIC;
	        rst : IN std_logic := '0';
           Out_P : out  STD_LOGIC;
			  Out_N : out  STD_LOGIC);
end digital_filter;

architecture Behavioral of digital_filter is

COMPONENT d_ff is
	PORT(
		dclock : IN std_logic;
		dreset : IN std_logic;
		din : IN std_logic ;          
		dout : OUT std_logic 
		);
	END COMPONENT;
	

signal P_dintern : std_logic_vector (3 downto 0);
signal N_dintern : std_logic_vector (3 downto 0);
signal P_or_out: std_logic;
signal N_or_out: std_logic;



begin

instdff_P : d_ff port map (clk , rst , In_P , P_dintern(0));
instdff_N : d_ff port map (clk , rst , In_N , N_dintern(0));


genreg : for i in 1 to 3 generate --Change Value of N Here to generate that many instance of d flip flop
begin
instdff_P : d_ff port map ( clk , rst , P_dintern(i-1) , P_dintern(i));
instdff_N : d_ff port map ( clk , rst , N_dintern(i-1) , N_dintern(i));
end generate genreg;

P_or_out <= (P_dintern(3) or P_dintern(2) or P_dintern(1) or P_dintern(1));
N_or_out <= (N_dintern(3) or N_dintern(2) or N_dintern(1) or N_dintern(1));

Out_P <= (P_or_out AND (not N_or_out));
Out_N <= (N_or_out AND (not P_or_out));





end Behavioral;