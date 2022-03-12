library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity phase_rot is
    Port ( clk,rst,INC,DEC : in  STD_LOGIC;
			  P: in STD_LOGIC_VECTOR (7 downto 0);
           CLK_early,CLK_edge,CLK_late : out  STD_LOGIC);
end phase_rot;




architecture Behavioral of phase_rot is

component updown_count_3b is
    Port ( clk,rst,INC,DEC : in  STD_LOGIC;
           count : out  STD_LOGIC_VECTOR (2 downto 0));
end component;

component mux8to1 is
port (
  
  mux_in : IN std_logic_vector(7 DOWNTO 0);
  mux_sel: IN std_logic_vector(2 DOWNTO 0);
  mux_out : OUT std_logic);
  
end component;

--component Clock_Divider is
--port ( clk,reset: in std_logic;
--clock_out: out std_logic);
--end component;




--signal clk_d2: std_logic;
--signal clk_d4: std_logic;
signal mux_sel: std_logic_vector(2 downto 0);
signal mux_in_earlyclk: std_logic_vector(7 downto 0);
signal mux_in_edgeclk: std_logic_vector(7 downto 0);
signal mux_in_lateclk: std_logic_vector(7 downto 0);



begin


--clkd2: Clock_Divider port map(clk,rst,clk_d2);

--clkd4: Clock_Divider port map(clk_d2,rst,clk_d4);

couter_3b: updown_count_3b port map (clk,rst,INC,DEC,mux_sel);



mux_in_earlyclk <= P;
mux_in_edgeclk <= (P(1 downto 0) & P(7 downto 2));
mux_in_lateclk <= (P(3 downto 0) & P(7 downto 4));



earlyclock: mux8to1 port map (mux_in_earlyclk,mux_sel,CLK_early);
edgeclock: mux8to1 port map (mux_in_edgeclk,mux_sel,CLK_edge);
lateclock: mux8to1 port map (mux_in_lateclk,mux_sel,CLK_late);






end Behavioral;