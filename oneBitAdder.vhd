Library ieee;
use ieee.std_logic_1164.all;

ENTITY my_adder IS
PORT(
	A,B,Cin: IN std_logic;
	S,Cout: OUT std_logic);
END ENTITY;

ARCHITECTURE a_my_adder OF my_adder IS
BEGIN
S <= A XOR B XOR Cin;
Cout <= (A AND B) OR (Cin AND (A XOR B));
END ARCHITECTURE;
