Library ieee;
use ieee.std_logic_1164.all;

ENTITY ALU IS
GENERIC (n: integer := 8);
PORT(
	A: IN std_logic_vector(n-1 DOWNTO 0);
	B: IN std_logic_vector(n-1 DOWNTO 0);
	S: IN std_logic_vector(3 DOWNTO 0);
	F: OUT std_logic_vector(n-1 DOWNTO 0));
END ENTITY;

ARCHITECTURE struct1 OF ALU IS

COMPONENT my_nadder IS 
GENERIC (n: integer := 8);
PORT(
	A,B: IN std_logic_vector(n-1 DOWNTO 0);
	Cin: IN std_logic;
	Sum: OUT std_logic_vector(n-1 DOWNTO 0);
	Cout: OUT std_logic);
END COMPONENT;
SIGNAL sigadd: std_logic_vector(n-1 DOWNTO 0);
SIGNAL sigA: std_logic_vector(n-1 DOWNTO 0);
SIGNAL coutA: std_logic;
SIGNAL cin: std_logic;


BEGIN

F <= A and B WHEN s="0110"
ELSE A or B WHEN S="0111"
Else sigadd WHEN S="0100"
ELSE sigadd WHEN S="0101"
ELSE not B WHEN S="0000";

sigA<=A WHEN S="0100"
ELSE not A WHEN S="0101";

cin<='1' when S="0101"
ELSE '0';
u0: my_nadder GENERIC MAP (32) PORT MAP(sigA,B,cin,sigadd,coutA);

END ARCHITECTURE;

