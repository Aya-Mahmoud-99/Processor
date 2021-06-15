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
memory_zero : OUT std_logic_vector(18 DOWNTO 0);
SP_enable : IN std_logic
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

COMPONENT my_nDFF_Stack IS
GENERIC ( n : integer := 16);
PORT( Clk,Rst,enable : IN std_logic;
d : IN std_logic_vector(n-1 DOWNTO 0);
q : OUT std_logic_vector(n-1 DOWNTO 0));
END COMPONENT;


COMPONENT my_nadder IS 
GENERIC (n: integer := 8);
PORT(
	A,B: IN std_logic_vector(n-1 DOWNTO 0);
	Cin: IN std_logic;
	Sum: OUT std_logic_vector(n-1 DOWNTO 0);
	Cout: OUT std_logic);
END COMPONENT;

signal added : std_logic_vector(31 DOWNTO 0);
signal out_data : std_logic_vector(31 DOWNTO 0);
signal sp_new : std_logic_vector(31 DOWNTO 0);
signal selected_Address : std_logic_vector(18 DOWNTO 0);
signal cout : std_logic;
begin
added <= x"FFFFFFFE" WHEN write_enable = '1'
ELSE x"00000002";
selected_Address <= Address WHEN SP_enable = '0'
ELSE out_data (18 downto 0);
IM :ram GENERIC MAP (32) PORT MAP(Clk,write_enable,selected_Address,write_data,read_data,memory_zero,'0');
u0: my_nadder GENERIC MAP (32) PORT MAP(out_data,added,'0',sp_new,cout);
SP: my_nDFF_Stack GENERIC MAP (32) PORT MAP(Clk,Rst,SP_enable,sp_new,out_data);
end Architecture;
