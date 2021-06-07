LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
USE IEEE.numeric_std.all;
ENTITY my_nadder IS
GENERIC ( n : integer := 16);
PORT(
IN1 : IN std_logic_vector(n-1 DOWNTO 0);
IN2 : IN std_logic_vector(n-1 DOWNTO 0);
out1 : OUT std_logic_vector(n-1 DOWNTO 0)
);
END my_nadder;
ARCHITECTURE adder OF my_nadder IS
BEGIN
out1<=std_logic_vector(to_unsigned(to_integer(unsigned(IN1))+to_integer(unsigned(IN2)), n));
END adder;
