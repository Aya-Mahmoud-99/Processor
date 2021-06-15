Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

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
SIGNAL sigB: std_logic_vector(n-1 DOWNTO 0);
SIGNAL coutA: std_logic;
SIGNAL cin: std_logic;


BEGIN

F <= A and B WHEN s="0110"
ELSE A or B WHEN S="0111"
Else sigadd WHEN S="0100" or s="0101" or s="0001" or s="0010"
ELSE not B WHEN S="0000"
ELSE A WHEN S="0011"
ELSE std_logic_vector(shift_left(unsigned(A), to_integer(unsigned(B)))) WHEN S="1000" 
ELSE std_logic_vector(shift_right(unsigned(A), to_integer(unsigned(B)))) WHEN S="1001"
ELSE B WHEN S="1011";

sigA<=A WHEN S="0100"
ELSE A WHEN S="0101"
ELSE "00000000000000000000000000000001" WHEN s="0001"
ELSE "11111111111111111111111111111111" WHEN s="0010";

sigB<=not B WHEN S="0101"
ELSE B ;

cin<='1' when S="0101"
ELSE '0';
u0: my_nadder GENERIC MAP (32) PORT MAP(sigA,sigB,cin,sigadd,coutA);

END ARCHITECTURE;
