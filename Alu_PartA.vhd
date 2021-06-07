Library ieee;
use ieee.std_logic_1164.all;

ENTITY partA IS
GENERIC (n: integer := 8);
PORT(
	A,B: IN std_logic_vector(n-1 DOWNTO 0);
	Cin: IN std_logic;
	S: IN std_logic_vector(1 DOWNTO 0);
	Cout: OUT std_logic;
	F: OUT std_logic_vector(n-1 DOWNTO 0));
END ENTITY;

ARCHITECTURE archA OF partA IS

COMPONENT my_nadder IS 
PORT(
	A,B: IN std_logic_vector(n-1 DOWNTO 0);
	Cin: IN std_logic;
	Sum: OUT std_logic_vector(n-1 DOWNTO 0);
	Cout: OUT std_logic);
END COMPONENT;
SIGNAL sigB: std_logic_vector(n-1 DOWNTO 0);
SIGNAL coutA: std_logic;

BEGIN

sigB <= (others => '0') WHEN S="00"
ELSE B WHEN S="01"
ELSE NOT B WHEN S="10"
ELSE (others => '1') WHEN S="11" AND Cin = '0'
ELSE NOT A WHEN S="11" AND Cin = '1';

Cout <= '0' WHEN S="11" AND Cin = '1'
ELSE coutA;

u0: my_nadder GENERIC MAP (n) PORT MAP(A,sigB,Cin,F,coutA);

END ARCHITECTURE;
