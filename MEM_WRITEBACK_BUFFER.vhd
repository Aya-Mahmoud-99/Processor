library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.all;
entity Buffer_mw is 
	generic(n : integer := 4);
port (
write_enable_signal_in : IN std_logic;
write_enable_signal_out : out std_logic;
r_type_signal_in : IN std_logic;
r_type_signal_out : OUT std_logic;
ALU_OUTPUT_IN	 :	in std_logic_vector(31 downto 0);
ALU_OUTPUT_OUT	 :	out std_logic_vector(31 downto 0);
MEM_OUTPUT_IN	 :	in std_logic_vector(31 downto 0);
MEM_OUTPUT_OUT	 :	out std_logic_vector(31 downto 0);
write_back_reg_in 	 :	in std_logic_vector(2 downto 0);
write_back_reg_out 	 :	out std_logic_vector(2 downto 0);
clk : IN std_logic                 
);
end Buffer_mw;
ARCHITECTURE a_buffer OF Buffer_mw IS
BEGIN
PROCESS(clk)
BEGIN
	IF falling_edge(clk) THEN
		write_back_reg_out<=write_back_reg_in;
   		ALU_output_out<=ALU_output_in;
		MEM_OUTPUT_OUT<=MEM_OUTPUT_IN;
		write_enable_signal_out<=write_enable_signal_in;
		r_type_signal_out<=r_type_signal_in;
	END IF;
END PROCESS;
END a_buffer;
