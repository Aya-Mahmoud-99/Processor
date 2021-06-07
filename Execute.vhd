Library ieee;
use ieee.std_logic_1164.all;

entity Execute is 

port(
Rst : IN std_logic;
clk : IN std_logic;
ReadData1 : in std_logic_vector(31 DOWNTO 0);
ReadData2 : in std_logic_vector(31 DOWNTO 0);
opcode : in std_logic_vector(5 DOWNTO 0);
F: OUT std_logic_vector(31 DOWNTO 0)
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

begin
AL: ALU GENERIC MAP (32) PORT MAP(ReadData1,ReadData2,opcode(3 downto 0),F);
end Architecture;
