library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity mux8to1 is
port (
  
  mux_in : IN std_logic_vector(7 DOWNTO 0);
  mux_sel: IN std_logic_vector(2 DOWNTO 0);
  mux_out : OUT std_logic);
  
end mux8to1;

architecture behave of mux8to1 is
	SIGNAL count: std_logic_vector(2 downto 0);
BEGIN
	count <= mux_sel;
	


 PROCESS(count) is
 BEGIN
  
   CASE count IS
    WHEN "000"=>mux_out<=mux_in(0);
    WHEN "001"=>mux_out<=mux_in(1);
    WHEN "010"=>mux_out<=mux_in(2);
    WHEN "011"=>mux_out<=mux_in(3);
    WHEN "100"=>mux_out<=mux_in(4);
    WHEN "101"=>mux_out<=mux_in(5);
    WHEN "110"=>mux_out<=mux_in(6);
    WHEN "111"=>mux_out<=mux_in(7);
    
   END CASE;
   

 end process;
end behave;