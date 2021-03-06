library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.all;
entity Buffer_fd is 
	generic(n : integer := 4);
	port (Iin 	 :	in std_logic_vector(31 downto 0);
Iout 	 :	out std_logic_vector(31 downto 0);
Pcin 	 :	in std_logic_vector(18 downto 0);
Pcout 	 :	out std_logic_vector(18 downto 0);
Inport : in std_logic_vector(31 downto 0);
Inport_out : out std_logic_vector(31 downto 0);
clk : IN std_logic
                  
);
end Buffer_fd;
ARCHITECTURE a_buffer OF Buffer_fd IS
BEGIN
PROCESS(clk)
BEGIN
	IF falling_edge(clk) THEN
		Iout<=Iin;
		Pcout<=Pcin;
		Inport_out<=Inport;

	END IF;
END PROCESS;
END a_buffer;
