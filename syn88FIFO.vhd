library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;


ENTITY syn88FIFO IS

PORT (SW : IN STD_LOGIC_VECTOR(9 DOWNTO 0) ;
KEY : IN STD_LOGIC_VECTOR(1 downto 0) ;
HEX0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0) ;
HEX1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0) ;
HEX2 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0) ;
HEX3 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0) ;
HEX4 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0) ;
HEX5 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0) ;
LEDR1 : OUT STD_LOGIC;
LEDR0 : OUT STD_LOGIC;
LEDR8 : OUT STD_LOGIC;
LEDR9 : OUT STD_LOGIC);



END syn88FIFO;

ARCHITECTURE Behavior OF syn88FIFO IS

	SIGNAL data, Data_display, q : STD_LOGIC_VECTOR(7 DOWNTO 0) ;
	SIGNAL wraddress, rdaddress : STD_LOGIC_VECTOR(4 DOWNTO 0):= (others => '0') ;
	SIGNAL wren : STD_LOGIC ;
	SIGNAL rden : STD_LOGIC ;
	SIGNAL clock : STD_LOGIC ;
	SIGNAL clear : STD_LOGIC ;
	SIGNAL full : STD_LOGIC ;
	SIGNAL empty : STD_LOGIC ;


	COMPONENT ramlpm 
	PORT( data : IN STD_LOGIC_VECTOR(7 DOWNTO 0) ;
	wraddress : IN STD_LOGIC_VECTOR(4 DOWNTO 0) ;
	rdaddress : IN STD_LOGIC_VECTOR(4 DOWNTO 0) ;
	wren : IN STD_LOGIC ;
	rden : IN STD_LOGIC ;
	clock : IN STD_LOGIC ;
	q : OUT STD_LOGIC_VECTOR (7 downto 0));
	END COMPONENT ;



	COMPONENT Seg_decoder
	PORT ( SW : IN std_logic_vector(3 downto 0);
	HEX0 : OUT std_logic_vector(6 downto 0)  ) ;
	END COMPONENT ;


BEGIN

	clock<=KEY(0);
	clear<=KEY(1);
	data <= SW (7 downto 0);
	wren <= SW(8);
	rden <= SW(9);


-- ########################################################
-- # Write Functional Section
-- ########################################################
WRITE_POINTER : process (clear, clock) 
begin
if (clear = '0') then
wraddress <= (others => '0');
elsif (clock'event and clock = '1') then
if (wren = '1') then

wraddress <= (others => '0');
else
wraddress <= wraddress + '1';
end if;

end if;
end process;

-- ######################################################## 
-- # Read Functional Section
-- ########################################################
READ_POINTER : process (clear, clock) 
begin
if (clear = '0') then
rdaddress <= (others => '0');
elsif (clock'event and clock = '1') then
if (rden = '1') then

rdaddress <= (others => '0');
else
rdaddress <= rdaddress + '1';
end if;

end if;
end process;

-- ########################################################
-- # Full Flag Functional Section : Active high
-- ########################################################
FFLAG : process (clear, clock)
begin
if (clear = '0') then
full <= '0';
elsif (clock'event and clock = '1') then
if (wren = '1' and rden = '0') then
if ((wraddress = rdaddress-1) or
((wraddress = 7) and (rdaddress = 0))) then
full <= '1';
end if;
else
full <= '0';
end if;
end if;
end process;
-- ########################################################
-- # Empty Flag Functional Section : Active low
-- ########################################################
EFLAG : process (clear, clock)
begin
if (clear = '0') then
empty <= '0';
elsif (clock'event and clock = '1') then
if (rden = '1' and wren = '0') then
if ((wraddress = rdaddress+1) or
((rdaddress = 7) and (wraddress = 0))) then
empty <= '0';
end if;
else
empty <= '1';
end if;
end if;
end process;







FIFO_RAM : ramlpm
Port map( data, wraddress, rdaddress, wren, rden, clock, q );

tens_q_display: Seg_decoder
PORT MAP ( q (7 downto 4), HEX3) ;
ones_q_display: Seg_decoder
PORT MAP ( q (3 downto 0), HEX2) ;

tens_data_display: Seg_decoder
PORT MAP ( data (7 downto 4), HEX1) ;
ones_data_display: Seg_decoder
PORT MAP ( data (3 downto 0), HEX0) ;

wraddress_display: Seg_decoder
PORT MAP ( wraddress (3 downto 0), HEX4) ;
rdaddress_display: Seg_decoder
PORT MAP ( rdaddress (3 downto 0), HEX5) ;

LEDR8 <= wren;
LEDR9 <= rden;
LEDR1 <= full;
LEDR0 <= empty;



end Behavior;
