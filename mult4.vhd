LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE ieee.std_logic_unsigned.all;

-- Top-level entity
ENTITY mult4 IS

PORT (SW : IN STD_LOGIC_VECTOR(7 DOWNTO 0) ;
KEY : IN STD_LOGIC_VECTOR(1 downto 0) ;
HEX0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0) ;
HEX1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0) ;
HEX4 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0) ;
HEX5 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0) );


END mult4 ;
ARCHITECTURE Behavior OF mult4 IS

SIGNAL Areg, Breg : STD_LOGIC_VECTOR(3 DOWNTO 0) ;
SIGNAL multreg : STD_LOGIC_VECTOR(7 DOWNTO 0) ;
SIGNAL multout : STD_LOGIC_VECTOR(7 DOWNTO 0) ;
SIGNAL Clock : STD_LOGIC ;
SIGNAL Reset : STD_LOGIC;


COMPONENT Seg_decoder

PORT ( SW : IN std_logic_vector(3 downto 0);
HEX0 : OUT std_logic_vector(6 downto 0)  ) ;
END COMPONENT ;


COMPONENT megmult
PORT (dataa, datab : IN STD_LOGIC_VECTOR(3 DOWNTO 0) ;
result : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)  ) ;
END COMPONENT ;


BEGIN

Clock<=KEY(0);
Reset<=KEY(1);



process(Clock,Reset)
BEGIN

IF Reset = '0' THEN
Areg <= (OTHERS => '0'); Breg <= (OTHERS => '0');
multreg <= (OTHERS => '0');

ELSIF Clock'EVENT AND Clock = '0' THEN


Areg <= SW (7 downto 4); Breg <= SW (3 downto 0) ;

multreg <= multout;

END IF ;
END PROCESS ;

multiplexerL: megmult
PORT MAP ( Areg, Breg, multout) ;

A_decoder: Seg_decoder
PORT MAP ( Areg, HEX5) ;



B_decoder: Seg_decoder
PORT MAP ( Breg, HEX4) ;


tens_decoder: Seg_decoder
PORT MAP ( multreg (7 downto 4), HEX1) ;
ones_decoder: Seg_decoder
PORT MAP ( multreg (3 downto 0), HEX0) ;



END Behavior;