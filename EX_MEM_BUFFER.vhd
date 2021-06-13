library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.all;
entity Buffer_em is 
	generic(n : integer := 4);
port (
write_enable_signal_in : IN std_logic;
write_enable_signal_out : out std_logic;
r_type_signal_in : IN std_logic;
r_type_signal_out : OUT std_logic;
mem_write_signal : IN std_logic;
mem_write_signal_out : OUT std_logic;
ReadData2_in	 :	in std_logic_vector(31 downto 0);
ReadData2_out	 :	out std_logic_vector(31 downto 0);
write_back_reg_in 	 :	in std_logic_vector(2 downto 0);
write_back_reg_out 	 :	out std_logic_vector(2 downto 0);
ALU_output_in	 :	in std_logic_vector(31 downto 0);
ALU_output_out	 :	out std_logic_vector(31 downto 0);
clk : IN std_logic                 
);
end Buffer_em;
ARCHITECTURE a_buffer OF Buffer_em IS
BEGIN
PROCESS(clk)
BEGIN
	IF falling_edge(clk) THEN
		ReadData2_out<=ReadData2_in;
		write_back_reg_out<=write_back_reg_in;
   		ALU_output_out<=ALU_output_in;
		write_enable_signal_out<=write_enable_signal_in;
		r_type_signal_out<=r_type_signal_in;
		mem_write_signal_out<=mem_write_signal;
	END IF;
END PROCESS;
END a_buffer;
