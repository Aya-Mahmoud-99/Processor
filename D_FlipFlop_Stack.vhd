LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
ENTITY my_DFF_Stack IS
PORT( d,clk,rst,enable : IN std_logic; q : OUT std_logic; initial_value : IN std_logic);
END my_DFF_Stack;
ARCHITECTURE a_my_DFF OF my_DFF_Stack IS
BEGIN
PROCESS(clk,rst)
BEGIN
IF(rst = '1') THEN
q <= initial_value;
ELSIF rising_edge(clk) and enable='1' THEN
q <= d;
END IF;
END PROCESS;
END a_my_DFF;
