library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.all;
entity Buffer_de is 
	generic(n : integer := 4);
port (
write_enable_signal_in : IN std_logic;
write_enable_signal_out : out std_logic;
r_type_signal_in : IN std_logic;
r_type_signal_out : OUT std_logic;
dst_offset_signal_in : IN std_logic;
dst_offset_signal_out : OUT std_logic;
mem_write_signal : IN std_logic;
mem_write_signal_out : OUT std_logic;
dst_src_signal : IN std_logic;
dst_src_signal_out : out std_logic;
load_signal_in : in std_logic;
load_signal_out : out std_logic;
out_port_signal : in std_logic;
out_port_signal_out : out std_logic;
store_signal : in std_logic;
store_signal_out : out std_logic;
ReadData1_in 	 :	in std_logic_vector(31 downto 0);
ReadData2_in	 :	in std_logic_vector(31 downto 0);
opcode_in : in std_logic_vector(5 DOWNTO 0);
opcode_out : out std_logic_vector(5 DOWNTO 0);
dst_in 	 :	in std_logic_vector(2 downto 0);
src_in 	 :	in std_logic_vector(2 downto 0);
offset_in 	 :	in std_logic_vector(15 downto 0);
ReadData1_out 	 :	out std_logic_vector(31 downto 0);
ReadData2_out	 :	out std_logic_vector(31 downto 0);
dst_out 	 :	out std_logic_vector(2 downto 0);
src_out 	 :	out std_logic_vector(2 downto 0);
offset_out 	 :	out std_logic_vector(15 downto 0);
Inport : in std_logic_vector(31 downto 0);
Inport_out : out std_logic_vector(31 downto 0);
clk : IN std_logic                 
);
end Buffer_de;
ARCHITECTURE a_buffer OF Buffer_de IS
BEGIN
PROCESS(clk)
BEGIN
	IF falling_edge(clk) THEN
		ReadData1_out<=ReadData1_in;
		ReadData2_out<=ReadData2_in;
		dst_out<=dst_in;
		src_out<=src_in;
		offset_out<=offset_in;
		opcode_out<=opcode_in;
		write_enable_signal_out<=write_enable_signal_in;
		r_type_signal_out<=r_type_signal_in;
		dst_offset_signal_out<=dst_offset_signal_in;
		mem_write_signal_out<=mem_write_signal;
		dst_src_signal_out<=dst_src_signal;
		load_signal_out<=load_signal_in;
		Inport_out<=Inport;
		out_port_signal_out<=out_port_signal;
		store_signal_out<=store_signal;

	END IF;
END PROCESS;
END a_buffer;
