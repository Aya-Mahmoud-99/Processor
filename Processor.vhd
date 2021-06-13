
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

component Memory is 
port(
Address : IN std_logic_vector(18 DOWNTO 0);
write_data : IN std_logic_vector(31 DOWNTO 0);
read_data : OUT std_logic_vector(31 DOWNTO 0);
clk : IN std_logic;
RST: IN std_logic;
write_enable : IN std_logic
);
end component;

component Buffer_mw is 
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
end component;

component Buffer_em is 
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
end component;

component Execute is 

port(
Rst : IN std_logic;
clk : IN std_logic;
ReadData1 : in std_logic_vector(31 DOWNTO 0);
ReadData2 : in std_logic_vector(31 DOWNTO 0);
opcode : in std_logic_vector(5 DOWNTO 0);
F: OUT std_logic_vector(31 DOWNTO 0);
dst_offset_signal : IN std_logic;
offset : in std_logic_vector(15 DOWNTO 0)
);

end component;

component Buffer_de is 
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
clk : IN std_logic                 
);
end component;

component deocde_writeBack is 
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
end component;

COMPONENT Fetch is 
port(
out_instruction : OUT std_logic_vector(31 DOWNTO 0);
in_instruction : IN std_logic_vector(31 DOWNTO 0);
next_pc : OUT std_logic_vector(18 DOWNTO 0);
curr_pc : IN std_logic_vector(18 DOWNTO 0);
clk : IN std_logic;
RST: IN std_logic;
pc_enable: IN std_logic
);

end COMPONENT;
Component Buffer_fd is 
generic(n : integer := 4);
port (Iin 	 :	in std_logic_vector(31 downto 0);
Iout 	 :	out std_logic_vector(31 downto 0);
Pcin 	 :	in std_logic_vector(18 downto 0);
Pcout 	 :	out std_logic_vector(18 downto 0);
clk : IN std_logic             
);
end COMPONENT;
SIGNAL Iout_ftch : std_logic_vector(31 DOWNTO 0);
SIGNAL Iin_decode : std_logic_vector(31 DOWNTO 0);
SIGNAL ALU_output : std_logic_vector(31 DOWNTO 0);
SIGNAL ALU_output_memory : std_logic_vector(31 DOWNTO 0);
SIGNAL nxt_pc : std_logic_vector(18 DOWNTO 0);
SIGNAL curr_pc : std_logic_vector(18 DOWNTO 0);
signal ReadData1 : std_logic_vector(31 DOWNTO 0);
signal ReadData2 : std_logic_vector(31 DOWNTO 0);
signal Write_Data : std_logic_vector(31 DOWNTO 0); 
signal Write_Data_alu : std_logic_vector(31 DOWNTO 0); 
signal WriteReg : std_logic_vector(2 downto 0);
signal opcode : std_logic_vector(5 DOWNTO 0);
signal opcode_out : std_logic_vector(5 DOWNTO 0);
signal dst : std_logic_vector(2 DOWNTO 0);
signal src : std_logic_vector(2 DOWNTO 0);
signal offset : std_logic_vector(15 DOWNTO 0);
signal ReadData1_out : std_logic_vector(31 DOWNTO 0);
signal ReadData2_out : std_logic_vector(31 DOWNTO 0);
signal ReadData2_out_mem : std_logic_vector(31 DOWNTO 0);
signal read_data_from_memo : std_logic_vector(31 DOWNTO 0);
signal MEM_OUTPUT_OUT : std_logic_vector(31 DOWNTO 0);
signal dst_out : std_logic_vector(2 DOWNTO 0);
signal write_back_reg_out : std_logic_vector(2 DOWNTO 0);
signal src_out : std_logic_vector(2 DOWNTO 0);
signal offset_out : std_logic_vector(15 DOWNTO 0);
signal write_in_memo_enable : std_logic;
signal write_enable_signal : std_logic;
signal write_enable_signal_exe : std_logic;
signal write_enable_signal_in : std_logic;
signal write_enable_signal_out : std_logic;
signal write_enable_signal_mem : std_logic;
signal r_type_signal : std_logic;
signal r_type_signal_out : std_logic;
signal r_type_signal_mem : std_logic;
signal r_type_signal_wb : std_logic;
signal dst_offset_signal : std_logic;
signal dst_offset_signal_out : std_logic;
signal mem_Write_signal : std_logic;
signal mem_Write_signal_out : std_logic;

begin
ftch: Fetch PORT MAP(Iout_ftch,Iin,nxt_pc,curr_pc,clk,rst,pc_enable);
bf_ftch_decode: Buffer_fd PORT MAP(Iout_ftch,Iin_Decode,nxt_pc,curr_pc,clk);
decode : deocde_writeBack PORT MAP(Rst,clk,write_enable_signal,r_type_signal,dst_offset_signal,mem_write_signal,write_enable_signal_exe,Iin_Decode,Write_Data,ReadData1,ReadData2,WriteReg,opcode,dst,src,offset);
df_dec : Buffer_de PORT MAP(write_enable_signal,write_enable_signal_out,r_type_signal,r_type_signal_out,dst_offset_signal,dst_offset_signal_out,mem_write_signal,mem_write_signal_out,ReadData1,ReadData2,opcode,opcode_out,dst,src,offset,ReadData1_out,ReadData2_out,dst_out,src_out,offset_out,clk);
ex : Execute PORT MAP(Rst,clk,ReadData1_out,ReadData2_out,opcode_out,ALU_output,dst_offset_signal_out,offset_out);
ex_mem : Buffer_em PORT MAP (write_enable_signal_out,write_enable_signal_mem,r_type_signal_out,r_type_signal_mem,mem_write_signal_out,write_in_memo_enable,ReadData2_out,ReadData2_out_mem,dst_out,write_back_reg_out,Alu_output,ALU_OUTPUT_MEMORY,clk); -- writeback register should come out of multiplexer choosing between src and destination let it destination only for nowend component;
Mem : Memory PORT MAP (ALU_OUTPUT_MEMORY(18 downto 0),ReadData2_out_mem,read_data_from_memo,clk,RST,write_in_memo_enable );
BF_EM : Buffer_mw PORT MAP (write_enable_signal_mem,write_enable_signal_exe,r_type_signal_mem,r_type_signal_wb,ALU_OUTPUT_MEMORY,Write_Data_alu,read_data_from_memo,MEM_OUTPUT_OUT,write_back_reg_out,WriteReg,clk);  --write back data should be choosen by a multipllexer choosing between output of memory and output of alu let it be output of alu only for now

write_data<=Write_Data_alu when r_type_signal_wb='1'
ELSE MEM_OUTPUT_OUT when r_type_signal_wb='0';


end Architecture;
