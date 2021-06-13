Library ieee;
use ieee.std_logic_1164.all;

entity deocde_writeBack is 

port(
Rst : IN std_logic;
clk : IN std_logic;
write_enable_signal : out std_logic;
r_type_signal : out std_logic;
dst_offset_signal : out std_logic;
mem_write_signal : out std_logic;
enable_Write : in std_logic;
instruction : IN std_logic_vector(31 DOWNTO 0);
WriteData : IN std_logic_vector(31 DOWNTO 0);
ReadData1 : out std_logic_vector(31 DOWNTO 0);
ReadData2 : out std_logic_vector(31 DOWNTO 0);
WriteReg : in std_logic_vector(2 downto 0);
opcode : out std_logic_vector(5 DOWNTO 0);
dst : out std_logic_vector(2 DOWNTO 0);
src : out std_logic_vector(2 DOWNTO 0);
offset : out std_logic_vector(15 DOWNTO 0)
);

end entity;

Architecture myModel of deocde_writeBack is

component control_unit is 

port(

opcode : in std_logic_vector(5 DOWNTO 0);
write_enable: out std_logic;
R_type_signal : out std_logic;
dst_offset_signal : out std_logic;
mem_write : out std_logic
);

end component;


component regist is 
GENERIC ( n : integer := 32);
port(
Rst : in std_logic;
clk : in std_logic;
WriteData : in std_logic_vector(31 downto 0);
ReadData1 : out std_logic_vector(31 downto 0);
ReadData2 : out std_logic_vector(31 downto 0);
ReadReg1 : in std_logic_vector(2 downto 0);
ReadReg2 : in std_logic_vector(2 downto 0);
WriteReg : in std_logic_vector(2 downto 0);
enable_write : in std_logic);
end component;

signal destination : std_logic_vector(2 downto 0);
signal source : std_logic_vector(2 downto 0);
signal write_enable_signal_out : std_logic;
signal r_type_signal_out : std_logic;
signal dst_offset_signal_out : std_logic;
signal mem_write_signal_out : std_logic;

begin
opcode<=instruction(31 downto 26);
dst<=instruction(23 downto 21);
destination<= instruction(23 downto 21);
src<=instruction(18 downto 16);
source<=instruction(18 downto 16);
offset<=instruction(15 downto 0);
rgFile: regist GENERIC MAP (32) PORT MAP(Rst,clk,WriteData,ReadData1,ReadData2,source,destination,WriteReg,enable_write);
cu : control_unit PORT MAP (instruction(31 downto 26),write_enable_signal_out,r_type_signal_out,dst_offset_signal_out,mem_write_signal_out);
write_enable_signal<=write_enable_signal_out;
r_type_signal<=r_type_signal_out;
dst_offset_signal<=dst_offset_signal_out;
mem_write_signal<=mem_write_signal_out;

end Architecture;
