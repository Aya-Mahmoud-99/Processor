LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
ENTITY my_nDFF IS
GENERIC ( n : integer := 16);
PORT( Clk,Rst,enable : IN std_logic;
d : IN std_logic_vector(n-1 DOWNTO 0);
q : OUT std_logic_vector(n-1 DOWNTO 0));
END my_nDFF;
ARCHITECTURE b_my_nDFF OF my_nDFF IS
COMPONENT my_DFF IS
PORT( d,Clk,Rst,enable : IN std_logic;
q : OUT std_logic);
END COMPONENT;
BEGIN
loop1: FOR i IN 0 TO n-1 GENERATE
fx: my_DFF PORT MAP(d(i),Clk,Rst,enable,q(i));
END GENERATE;
END b_my_nDFF;
