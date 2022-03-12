library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity BBPD is
    Port ( CLK_early, CLK_edge, CLK_late : in  STD_LOGIC;
	        rst : in STD_LOGIC := '0';
           D_in : in STD_LOGIC;
			  UP,DOWN : out STD_LOGIC);
end BBPD;

architecture Behavioral of BBPD is

COMPONENT d_ff is
	PORT(
		dclock : IN std_logic;
		dreset : IN std_logic;
		din : IN std_logic ;          
		dout : OUT std_logic 
		);
	END COMPONENT;
	

signal Q_early,Q_edge,Q_late : std_logic; 
signal D_up,D_down: std_logic;
signal inv_CLK_late : std_logic;


begin

instdff_1 : d_ff port map (CLK_early , rst , D_in , Q_early);
instdff_2 : d_ff port map (CLK_edge , rst , D_in , Q_edge);
instdff_3 : d_ff port map (CLK_late , rst , D_in , Q_late);

D_up <= (Q_early xor Q_edge);
D_down <= (Q_edge xor Q_late);
inv_CLK_late <= not CLK_late;

instdff_4 : d_ff port map (inv_CLK_late , rst , D_up , UP);
instdff_5 : d_ff port map (inv_CLK_late , rst , D_down , DOWN);






end Behavioral;