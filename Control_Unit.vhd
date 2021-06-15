Library ieee;
use ieee.std_logic_1164.all;

entity control_unit is 

port(

opcode : in std_logic_vector(5 DOWNTO 0);
write_enable: out std_logic;
R_type_signal : out std_logic;
dst_offset_signal : out std_logic;
mem_write : out std_logic;
src_dst_signal : out std_logic;
load_signal : out std_logic;
flush : in std_logic
);

end entity;

Architecture myModel of control_unit is

begin

write_enable<='0' when flush = '1'
ELSE '1' when opcode="111010" or opcode="110010" or opcode="110100" or opcode(5)='0'
ELSE '0';

R_type_signal<=not opcode(5);

load_signal<= '1' WHEN opcode = "110100" else '0';

dst_offset_signal<=opcode(4);

mem_Write<='0' when FLUSH = '1'
ELSE '1' when opcode="110000" or opcode="110001" or opcode="110101"
ELSE '0';

src_dst_signal<= not opcode(5) and opcode(4);

end Architecture;
