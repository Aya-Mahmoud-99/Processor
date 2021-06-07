Library ieee;
use ieee.std_logic_1164.all;

entity my_decoder is 

port(
enable : in std_logic;
inADDR : in std_logic_vector(2 downto 0);
S : out std_logic_vector(7 downto 0));


end entity;

Architecture DecodeA of my_decoder is
begin
S <= "00000000" WHEN enable='0'
ELSE "00000001" WHEN inADDR="000" and enable='1'
ELSE "00000010" WHEN inADDR="001" and enable='1'
ELSE "00000100" WHEN inADDR="010" and enable='1'
ELSE "00001000" WHEN inADDR="011" and enable='1'
ELSE "00010000" WHEN inADDR="100" and enable='1'
ELSE "00100000" WHEN inADDR="101" and enable='1'
ELSE "01000000" WHEN inADDR="110" and enable='1'
ELSE "10000000" WHEN inADDR="111" and enable='1';
end Architecture;
