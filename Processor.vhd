
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
USE IEEE.numeric_std.all;
entity processor is 

port(
clk : IN std_logic;
RST: IN std_logic;
Iin : IN std_logic_vector(31 DOWNTO 0);
pc_enable :IN std_logic);

end entity;

Architecture myModel of processor is

component Buffer_de is 
	generic(n : integer := 4);
port (
ReadData1_in 	 :	in std_logic_vector(31 downto 0);
ReadData2_in	 :	in std_logic_vector(31 downto 0);
dst_in 	 :	in std_logic_vector(2 downto 0);
src_in 	 :	in std_logic_vector(2 downto 0);
offset_in 	 :	in std_logic_vector(15 downto 0);
ReadData1_out 	 :	out std_logic_vector(31 downto 0);
ReadData2_out	 :	out std_logic_vector(31 downto 0);
dst_out 	 :	out std_logic_vector(2 downto 0);
src_out 	 :	out std_logic_vector(2 downto 0);
offset_out 	 :	out std_logic_vector(15 downto 0);
clk : IN std_logic                 
);
end component;

component deocde_writeBack is 
port(
Rst : IN std_logic;
clk : IN std_logic;
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
end component;

COMPONENT Fetch is 
port(
out_instruction : OUT std_logic_vector(31 DOWNTO 0);
in_instruction : IN std_logic_vector(31 DOWNTO 0);
next_pc : OUT std_logic_vector(15 DOWNTO 0);
curr_pc : IN std_logic_vector(15 DOWNTO 0);
clk : IN std_logic;
RST: IN std_logic;
pc_enable: IN std_logic
);

end COMPONENT;
Component Buffer_fd is 
generic(n : integer := 4);
port (Iin 	 :	in std_logic_vector(31 downto 0);
Iout 	 :	out std_logic_vector(31 downto 0);
Pcin 	 :	in std_logic_vector(15 downto 0);
Pcout 	 :	out std_logic_vector(15 downto 0);
clk : IN std_logic             
);
end COMPONENT;
SIGNAL Iout_ftch : std_logic_vector(31 DOWNTO 0);
SIGNAL Iin_decode : std_logic_vector(31 DOWNTO 0);
SIGNAL nxt_pc : std_logic_vector(15 DOWNTO 0);
SIGNAL curr_pc : std_logic_vector(15 DOWNTO 0);
signal ReadData1 : std_logic_vector(31 DOWNTO 0);
signal ReadData2 : std_logic_vector(31 DOWNTO 0);
signal WriteData : std_logic_vector(31 DOWNTO 0); 
signal WriteReg : std_logic_vector(2 downto 0);
signal opcode : std_logic_vector(5 DOWNTO 0);
signal dst : std_logic_vector(2 DOWNTO 0);
signal src : std_logic_vector(2 DOWNTO 0);
signal offset : std_logic_vector(15 DOWNTO 0);
signal ReadData1_out : std_logic_vector(31 DOWNTO 0);
signal ReadData2_out : std_logic_vector(31 DOWNTO 0);
signal opcode_out : std_logic_vector(5 DOWNTO 0);
signal dst_out : std_logic_vector(2 DOWNTO 0);
signal src_out : std_logic_vector(2 DOWNTO 0);
signal offset_out : std_logic_vector(15 DOWNTO 0);

begin
ftch: Fetch PORT MAP(Iout_ftch,Iin,nxt_pc,curr_pc,clk,rst,pc_enable);
bf_ftch_decode: Buffer_fd PORT MAP(Iout_ftch,Iin_Decode,nxt_pc,curr_pc,clk);
decode : deocde_writeBack PORT MAP(Rst,clk,'0',Iin_Decode,WriteData,ReadData1,ReadData2,WriteReg,opcode,dst,src,offset);
df_dec : Buffer_de PORT MAP(ReadData1,ReadData2,dst,src,offset,ReadData1_out,ReadData2_out,dst_out,src_out,offset_out,clk);

end Architecture;
