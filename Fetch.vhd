Library ieee;
use ieee.std_logic_1164.all;

entity Fetch is 

port(
out_instruction : OUT std_logic_vector(31 DOWNTO 0);
in_instruction : IN std_logic_vector(31 DOWNTO 0);
next_pc : OUT std_logic_vector(18 DOWNTO 0);
curr_pc : IN std_logic_vector(18 DOWNTO 0);
memory_zero : IN std_logic_vector(18 DOWNTO 0);
clk : IN std_logic;
RST: IN std_logic;
pc_enable: IN std_logic
);

end entity;

Architecture myModel of Fetch is

component my_nadder IS
GENERIC (n: integer := 8);
PORT(
	A,B: IN std_logic_vector(n-1 DOWNTO 0);
	Cin: IN std_logic;
	Sum: OUT std_logic_vector(n-1 DOWNTO 0);
	Cout: OUT std_logic);
END component;

COMPONENT my_nDFF IS
GENERIC ( n : integer := 32);
PORT( Clk,Rst,enable : IN std_logic;
d : IN std_logic_vector(n-1 DOWNTO 0);
q : OUT std_logic_vector(n-1 DOWNTO 0));
END COMPONENT;

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
SIGNAL read_from_pc : std_logic_vector(18 DOWNTO 0);
SIGNAL add_to_pc : std_logic_vector(18 DOWNTO 0);
SIGNAL pc_after_added : std_logic_vector(18 DOWNTO 0);
SIGNAL cout_pc : std_logic;
SIGNAL pc_input : std_logic_vector(18 DOWNTO 0);
signal dont_care : std_logic_vector(18 DOWNTO 0);

begin
pc: my_nDFF GENERIC MAP (19) PORT MAP(Clk,'0',pc_enable,pc_input,read_from_pc);
IM :ram GENERIC MAP (32) PORT MAP(Clk,'0',read_from_pc,in_instruction,out_instruction,dont_care,rst);
add: my_nadder GENERIC MAP(19)PORT MAP(read_from_pc,add_to_pc,'0',pc_after_added,cout_pc);
next_pc<=pc_after_added;
add_to_pc<="0000000000000000010";
pc_input<=memory_zero when rst='1'
ELSE curr_pc when rst='0';
end Architecture;
