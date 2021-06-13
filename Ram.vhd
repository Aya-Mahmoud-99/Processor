
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
USE IEEE.numeric_std.all;


ENTITY ram IS
GENERIC ( n : integer := 32);
PORT (clk : IN std_logic;
 we : IN std_logic;
address : IN std_logic_vector(18 DOWNTO 0);
datain : IN std_logic_vector(n-1 DOWNTO 0);
dataout : OUT std_logic_vector(n-1 DOWNTO 0) );
END ENTITY ram;



ARCHITECTURE sync_ram_a OF ram IS
 TYPE ram_type IS ARRAY(0 TO 524288) of std_logic_vector(15 DOWNTO 0);
 SIGNAL ram : ram_type ;
BEGIN
PROCESS(clk) IS
BEGIN
 IF rising_edge(clk) THEN
 	IF we = '1' THEN
	ram(to_integer(unsigned(address))) <= datain(31 downto 16);
        ram(to_integer(unsigned(address+1))) <= datain(15 downto 0);
 	END IF;
 END IF;
END PROCESS;
 dataout <= ram(to_integer(unsigned(address)))&ram(to_integer(unsigned(address))+1);
END sync_ram_a;
