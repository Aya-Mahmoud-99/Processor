Library ieee;
use ieee.std_logic_1164.all;

ENTITY partD IS
GENERIC (n: integer := 8);
PORT(
	A: IN std_logic_vector(n-1 DOWNTO 0);
	S: IN std_logic_vector(1 DOWNTO 0);
	Cin: IN std_logic;
	Cout: OUT std_logic;
	F: OUT std_logic_vector(n-1 DOWNTO 0));
END ENTITY;


ARCHITECTURE archD OF partD IS
BEGIN

F <= A(6 DOWNTO 0) & '0' WHEN S="00"
ELSE A(6 DOWNTO 0) & A(0) WHEN S="01"
ELSE A(6 DOWNTO 0) & Cin WHEN S="10"
ELSE "00000000" WHEN S="11";

Cout <= A(7) WHEN S="00"
ELSE A(7) WHEN S="01"
ELSE A(7) WHEN S="10"
ELSE '0' WHEN S="11";
 
END ARCHITECTURE;
