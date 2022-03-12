library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity bit_adder is
port (
  
  SW : IN std_logic_vector(5 DOWNTO 0);
  HEX0 : OUT std_logic_vector(6 DOWNTO 0)
  
  );
  
end bit_adder;

architecture behave of bit_adder is
	SIGNAL count: std_logic_vector(3 downto 0);
BEGIN
	count <= ("0" & SW(2 downto 0))+("0" & SW(5 downto 3));
	


 PROCESS(count) is
 BEGIN
  
   CASE count IS
    WHEN "0000"=>HEX0<="1000000";
    WHEN "0001"=>HEX0<="1111001";
    WHEN "0010"=>HEX0<="0100100";
    WHEN "0011"=>HEX0<="0110000";
    WHEN "0100"=>HEX0<="0011001";
    WHEN "0101"=>HEX0<="0010010";
    WHEN "0110"=>HEX0<="0000010";
    WHEN "0111"=>HEX0<="1111000";
    WHEN "1000"=>HEX0<="0000000";
    WHEN "1001"=>HEX0<="0011000";
    WHEN "1010"=>HEX0<="0001000"; -- A
    WHEN "1011"=>HEX0<="0000011"; -- B
    WHEN "1100"=>HEX0<="0100111"; -- C
    WHEN "1101"=>HEX0<="0100001"; -- d
    WHEN "1110"=>HEX0<="0000110"; -- e
    WHEN OTHERS=>HEX0<="1111111";
   END CASE;
   

 end process;
end behave;
