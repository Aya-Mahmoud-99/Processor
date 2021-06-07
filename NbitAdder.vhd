Library ieee;
use ieee.std_logic_1164.all;

ENTITY my_nadder IS
GENERIC (n: integer := 8);
PORT(
	A,B: IN std_logic_vector(n-1 DOWNTO 0);
	Cin: IN std_logic;
	Sum: OUT std_logic_vector(n-1 DOWNTO 0);
	Cout: OUT std_logic);
END ENTITY;

ARCHITECTURE a_my_nadder OF my_nadder IS

COMPONENT my_adder IS 
PORT(
	A,B,Cin: IN std_logic;
	S,Cout: OUT std_logic);
END COMPONENT;

SIGNAL temp: std_logic_vector(n-1 DOWNTO 0);

BEGIN
f0: my_adder PORT MAP(A(0),B(0),Cin,Sum(0),temp(0));
loop1: FOR i IN 1 TO n-1 GENERATE
	fx: my_adder PORT MAP (A(i),B(i),temp(i-1),Sum(i),temp(i));
END GENERATE;
Cout <= temp(n-1);
END ARCHITECTURE;
