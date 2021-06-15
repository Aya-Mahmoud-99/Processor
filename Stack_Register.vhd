LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
ENTITY my_nDFF_Stack IS
GENERIC ( n : integer := 16);
PORT( Clk,Rst,enable : IN std_logic;
d : IN std_logic_vector(n-1 DOWNTO 0);
q : OUT std_logic_vector(n-1 DOWNTO 0));
END my_nDFF_Stack;
ARCHITECTURE b_my_nDFF OF my_nDFF_Stack IS
COMPONENT my_DFF_Stack IS
PORT( d,clk,rst,enable : IN std_logic; q : OUT std_logic; initial_value : IN std_logic);
END COMPONENT;
signal initial_val : std_logic_vector(18 DOWNTO 0);
BEGIN
initial_val <= "1111111111111111110";
loop1: FOR i IN 0 TO n-1 GENERATE
fx: my_DFF_Stack PORT MAP(d(i),Clk,Rst,enable,q(i),initial_val(i));
END GENERATE;
END b_my_nDFF;
