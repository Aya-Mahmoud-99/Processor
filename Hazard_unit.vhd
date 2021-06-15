Library ieee;
use ieee.std_logic_1164.all;

entity Hazard_unit is 

port(
load : IN std_logic;
flush : OUT std_logic;
pc_enable : OUT std_logic;
src_decode : IN std_logic_vector(2 downto 0);
dst_decode : IN std_logic_vector(2 downto 0);
dst_excute : IN std_logic_vector(2 downto 0)
);

end entity;

Architecture myModel of Hazard_unit is

BEGIN
pc_enable <= '0' WHEN load = '1' AND src_decode = dst_excute
ELSE '0' WHEN load = '1' AND dst_decode = dst_excute
ELSE '1';

flush <= '1' WHEN load = '1' AND src_decode = dst_excute
ELSE '1' WHEN load = '1' AND dst_decode = dst_excute
ELSE '0';

end Architecture;