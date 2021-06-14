Library ieee;
use ieee.std_logic_1164.all;

entity forwarding_unit is 

port(
wb_address1 : IN std_logic_vector(2 downto 0); -- destination of write back in memory stage
wb_Signal1 : IN std_logic;
wb_address2 : IN std_logic_vector(2 downto 0); -- destination of write back in write back stage
wb_Signal2 : IN std_logic;
src : IN std_logic_vector(2 downto 0);
dst : IN std_logic_vector(2 downto 0);
decision_src : out std_logic_vector(1 downto 0);
decision_dst : out std_logic_vector(1 downto 0)
);

end entity;

Architecture myModel of forwarding_unit is

BEGIN
decision_src<= "01" WHEN wb_address1=src and wb_Signal1='1'
ELSE "10" WHEN wb_address2=src and wb_Signal2='1'
ELSE "00";

decision_dst<= "01" WHEN wb_address1=dst  and wb_Signal1='1'
ELSE "10" WHEN wb_address2=dst and wb_Signal2='1'
ELSE "00";

end Architecture;
