Library ieee;
use ieee.std_logic_1164.all;

entity Memory is 

port(
Address : IN std_logic_vector(18 DOWNTO 0);
write_data : IN std_logic_vector(31 DOWNTO 0);
read_data : OUT std_logic_vector(31 DOWNTO 0);
clk : IN std_logic;
RST: IN std_logic;
write_enable : IN std_logic;
memory_zero : OUT std_logic_vector(18 DOWNTO 0)
);

end entity;

Architecture myModel of Memory is

COMPONENT ram IS
GENERIC ( n : integer := 32);
PORT (clk : IN std_logic;
 we : IN std_logic;
address : IN std_logic_vector(18 DOWNTO 0);
datain : IN std_logic_vector(n-1 DOWNTO 0);
dataout : OUT std_logic_vector(n-1 DOWNTO 0);
memory_zero : OUT std_logic_vector(18 DOWNTO 0);
rst : IN std_logic
);
END COMPONENT ram;

begin
IM :ram GENERIC MAP (32) PORT MAP(Clk,write_enable,Address,write_data,read_data,memory_zero,'0');
end Architecture;
