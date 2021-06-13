Library ieee;
use ieee.std_logic_1164.all;

entity control_unit is 

port(

opcode : in std_logic_vector(5 DOWNTO 0);
write_enable: out std_logic;
R_type_signal : out std_logic;
dst_offset_signal : out std_logic;
mem_write : out std_logic
);

end entity;

Architecture myModel of control_unit is

begin
write_enable<='1'when opcode="111001" or opcode="110010" or opcode="110100" or opcode(5)='0'
ELSE '0';
R_type_signal<=not opcode(5);
dst_offset_signal<=opcode(4);
mem_write<='1' when opcode="110000" or opcode="110001" or opcode="110101"
ELSE '0';
end Architecture;
