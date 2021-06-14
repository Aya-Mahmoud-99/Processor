Library ieee;
use ieee.std_logic_1164.all;

entity Execute is 

port(
Rst : IN std_logic;
clk : IN std_logic;
src_decision : in std_logic_vector(1 DOWNTO 0);
dst_decision : in std_logic_vector(1 DOWNTO 0);
ReadData1 : in std_logic_vector(31 DOWNTO 0);
ReadData2 : in std_logic_vector(31 DOWNTO 0);
forwarded_from_alu : in std_logic_vector(31 DOWNTO 0);
forwarded_from_memo : in std_logic_vector(31 DOWNTO 0);
opcode : in std_logic_vector(5 DOWNTO 0);
F: OUT std_logic_vector(31 DOWNTO 0);
dst_offset_signal : IN std_logic;
offset : in std_logic_vector(15 DOWNTO 0)
);

end entity;

Architecture myModel of Execute is

COMPONENT ALU IS
GENERIC (n: integer := 8);
PORT(
	A: IN std_logic_vector(n-1 DOWNTO 0);
	B: IN std_logic_vector(n-1 DOWNTO 0);
	S: IN std_logic_vector(3 DOWNTO 0);
	F: OUT std_logic_vector(n-1 DOWNTO 0));
END COMPONENT;

signal to_be_added : std_logic_vector(31 DOWNTO 0);
signal temp_src : std_logic_vector(31 DOWNTO 0);
signal temp_dst : std_logic_vector(31 DOWNTO 0);

begin
temp_src<=ReadData1 when src_decision="00"
ELSE forwarded_from_alu when src_decision="01"
ELSE forwarded_from_memo when src_decision="10" ;

temp_dst<=ReadData2 when dst_decision="00"
ELSE forwarded_from_alu when dst_decision="01"
ELSE forwarded_from_memo when dst_decision="10" ;

to_be_added<= temp_dst when dst_offset_signal='0'
ELSE "0000000000000000"&offset when dst_offset_signal='1';
AL: ALU GENERIC MAP (32) PORT MAP(temp_src,to_be_added,opcode(3 downto 0),F);
end Architecture;
