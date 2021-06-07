Library ieee;
use ieee.std_logic_1164.all;

ENTITY partB IS
GENERIC (n: integer := 8);
PORT(
	A: IN std_logic_vector(n-1 DOWNTO 0);
	B: IN std_logic_vector(n-1 DOWNTO 0);
	S: IN std_logic_vector(1 DOWNTO 0);
	Cin: IN std_logic;
	F: OUT std_logic_vector(n-1 DOWNTO 0));
END ENTITY;


ARCHITECTURE archB OF partB IS
BEGIN

F <= A and B WHEN S="00"
ELSE A or B WHEN S="01"
ELSE A nor B WHEN S="10"
ELSE not A WHEN S="11";

END ARCHITECTURE;