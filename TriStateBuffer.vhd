Library ieee;
use ieee.std_logic_1164.all;

entity tristate is 
GENERIC ( n : integer := 32);
port(
enable : in std_logic;
A : in std_logic_vector(n-1 downto 0);
F : out std_logic_vector(n-1 downto 0));


end entity;

Architecture tri of tristate is
begin
F <= A WHEN enable='1'
ELSE (others => 'Z') WHEN enable='0' ;
end Architecture;
