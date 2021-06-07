Library ieee;
use ieee.std_logic_1164.all;

ENTITY partC IS
GENERIC (n: integer := 8);
PORT(
	A: IN std_logic_vector(n-1 DOWNTO 0);
	S: IN std_logic_vector(1 DOWNTO 0);
	Cin: IN std_logic;
	Cout: OUT std_logic;
	F: OUT std_logic_vector(n-1 DOWNTO 0));
END ENTITY;


ARCHITECTURE archC OF partC IS
BEGIN

F <= '0' & A(7 DOWNTO 1) WHEN S="00"
ELSE A(0) & A(7 DOWNTO 1) WHEN S="01"
ELSE Cin & A(7 DOWNTO 1) WHEN S="10"
ELSE A(7) & A(7 DOWNTO 1) WHEN S="11";

Cout <= A(0) WHEN S="00"
ELSE A(0) WHEN S="01"
ELSE A(0) WHEN S="10"
ELSE A(0) WHEN S="11";
 
END ARCHITECTURE;
