Library ieee;
use ieee.std_logic_1164.all;

entity Fetch is 

port(
out_instruction : OUT std_logic_vector(31 DOWNTO 0);
in_instruction : IN std_logic_vector(31 DOWNTO 0);
next_pc : OUT std_logic_vector(15 DOWNTO 0);
curr_pc : IN std_logic_vector(15 DOWNTO 0);
clk : IN std_logic;
RST: IN std_logic;
pc_enable: IN std_logic
);

end entity;

Architecture myModel of Fetch is

COMPONENT my_nadder IS
GENERIC ( n : integer := 16);
PORT(
IN1 : IN std_logic_vector(n-1 DOWNTO 0);
IN2 : IN std_logic_vector(n-1 DOWNTO 0);
out1 : 	OUT std_logic_vector(n-1 DOWNTO 0));
END COMPONENT;

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
address : IN std_logic_vector(15 DOWNTO 0);
datain : IN std_logic_vector(n-1 DOWNTO 0);
dataout : OUT std_logic_vector(n-1 DOWNTO 0) );
END COMPONENT ram;
SIGNAL read_from_pc : std_logic_vector(15 DOWNTO 0);
SIGNAL add_to_pc : std_logic_vector(15 DOWNTO 0);
SIGNAL pc_after_added : std_logic_vector(15 DOWNTO 0);
begin
pc: my_nDFF GENERIC MAP (16) PORT MAP(Clk,Rst,pc_enable,curr_pc,read_from_pc);
IM :ram GENERIC MAP (32) PORT MAP(Clk,'0',read_from_pc,in_instruction,out_instruction);
add: my_nadder GENERIC MAP(16)PORT MAP(read_from_pc,add_to_pc,pc_after_added);
next_pc<=pc_after_added;
add_to_pc<="0000000000000010";
end Architecture;
