library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CDR is
    Port ( D_in, clk : in  STD_LOGIC;
	        rst : IN std_logic := '0';
           clk_rec, D_out : out  STD_LOGIC);
end CDR;

architecture Behavioral of CDR is

COMPONENT d_ff is
	PORT(
		dclock : IN std_logic;
		dreset : IN std_logic;
		din : IN std_logic ;          
		dout : OUT std_logic 
		);
	END COMPONENT;

COMPONENT BBPD is
    Port ( CLK_early, CLK_edge, CLK_late : in  STD_LOGIC;
	        rst : in STD_LOGIC := '0';
           D_in : in STD_LOGIC;
			  UP,DOWN : out STD_LOGIC);
end COMPONENT;

COMPONENT Clock_Divider is
		port ( clk,reset: in std_logic;
				clock_out: out std_logic);
end COMPONENT;

COMPONENT digital_filter is
    Port ( In_P,In_N,clk : in  STD_LOGIC;
	        rst : IN std_logic := '0';
           Out_P : out  STD_LOGIC;
			  Out_N : out  STD_LOGIC);
end COMPONENT;

COMPONENT phase_gen is
    Port ( clk : in  STD_LOGIC;
	        rst : in STD_LOGIC := '0';
           P : out  STD_LOGIC_VECTOR (7 downto 0));
end COMPONENT;


COMPONENT phase_rot is
    Port ( clk,rst,INC,DEC : in  STD_LOGIC;
			  P: in STD_LOGIC_VECTOR (7 downto 0);
           CLK_early,CLK_edge,CLK_late : out  STD_LOGIC);
end COMPONENT;


	

signal P : std_logic_vector (7 downto 0);
signal INC,DEC, CLK_early,CLK_edge,CLK_late,UP, DOWN : std_logic;
signal clk_rec_D: std_logic;
signal clk_phase_rot:std_logic;
signal inv_clk_rec_D: std_logic := (not clk_rec_D);
signal clk_d2,clk_d4:std_logic;
signal clk_rec_reg:std_logic;

begin


int_phase_gen: phase_gen port map(clk,rst,P);

int_dff_1: d_ff port map(clk,rst,CLK_late,clk_rec_D);
int_dff_2: d_ff port map(clk,rst,clk_rec_D,clk_rec_reg);

clk_rec<=clk_rec_reg;

clkd2: Clock_Divider port map(inv_clk_rec_D,rst,clk_d2);
clkd4: Clock_Divider port map(clk_d2,rst,clk_d4);

int_dff_3: d_ff port map(clk,rst,clk_d4,clk_phase_rot);

int_phase_rot: phase_rot port map(clk_phase_rot,rst,INC,DEC,P,CLK_early,CLK_edge,CLK_late);

int_BBPD: BBPD port map(CLK_early,CLK_edge,CLK_late, rst, D_in, UP, DOWN);

int_digfil: digital_filter port map(UP, DOWN, clk_rec_D, INC,DEC);

int_dff_4: d_ff port map(clk_rec_reg, rst, D_in, D_out);












end Behavioral;