LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
USE IEEE.numeric_std.all;
entity processor is 

port(
clk : IN std_logic;
RST: IN std_logic;
Iin : IN std_logic_vector(31 DOWNTO 0);
Inport : IN std_logic_vector(31 DOWNTO 0);
Outport : out std_logic_vector(31 DOWNTO 0)
);

end entity;

Architecture myModel of processor is

component Hazard_unit is 

port(
load : IN std_logic;
flush : OUT std_logic;
pc_enable : OUT std_logic;
src_decode : IN std_logic_vector(2 downto 0);
dst_decode : IN std_logic_vector(2 downto 0);
dst_excute : IN std_logic_vector(2 downto 0)
);

end component;


component forwarding_unit is 

port(
wb_address1 : IN std_logic_vector(2 downto 0); -- destination of write back in memory stage
wb_Signal1 : IN std_logic;
wb_address2 : IN std_logic_vector(2 downto 0); -- destination of write back in write back stage
wb_Signal2 : IN std_logic;
src : IN std_logic_vector(2 downto 0);
dst : IN std_logic_vector(2 downto 0);
decision_src : out std_logic_vector(1 downto 0);
decision_dst : out std_logic_vector(1 downto 0)
);

end component;



component Memory is 
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
sp_signal : in std_logic;
sp_signal_out : out std_logic;
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
src_decision : in std_logic_vector(1 DOWNTO 0);
dst_decision : in std_logic_vector(1 DOWNTO 0);
ReadData11 : in std_logic_vector(31 DOWNTO 0);
ReadData22 : in std_logic_vector(31 DOWNTO 0);
forwarded_from_alu : in std_logic_vector(31 DOWNTO 0);
forwarded_from_memo : in std_logic_vector(31 DOWNTO 0);
opcode : in std_logic_vector(5 DOWNTO 0);
F: OUT std_logic_vector(31 DOWNTO 0);
dst_offset_signal : IN std_logic;
offset : in std_logic_vector(15 DOWNTO 0);
Inport_out : in std_logic_vector(31 DOWNTO 0);
out_port_signal : IN std_logic;
store_signal : IN std_logic;
forwarded_data : out std_logic_vector(31 DOWNTO 0)
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
dst_src_signal : IN std_logic;
dst_src_signal_out : out std_logic;
load_signal_in : in std_logic;
load_signal_out : out std_logic;
out_port_signal : in std_logic;
out_port_signal_out : out std_logic;
store_signal : in std_logic;
store_signal_out : out std_logic;
sp_signal : in std_logic;
sp_signal_out : out std_logic;
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
end component;

component deocde_writeBack is 
port(
Rst : IN std_logic;
clk : IN std_logic;
write_enable_signal : out std_logic;
r_type_signal : out std_logic;
dst_offset_signal : out std_logic;
mem_write_signal : out std_logic;
dst_src_signal : out std_logic;
load_signal : out std_logic;
out_port_signal : out std_logic;
store_signal : out std_logic;
SP_enable : OUT std_logic; 
flush : in std_logic;
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
memory_zero : IN std_logic_vector(18 DOWNTO 0);
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
Inport : in std_logic_vector(31 downto 0);
Inport_out : out std_logic_vector(31 downto 0);
clk : IN std_logic             
);
end COMPONENT;
SIGNAL Iout_ftch : std_logic_vector(31 DOWNTO 0);
SIGNAL Iin_decode : std_logic_vector(31 DOWNTO 0);
SIGNAL ALU_output : std_logic_vector(31 DOWNTO 0);
SIGNAL ALU_output_memory : std_logic_vector(31 DOWNTO 0);
SIGNAL nxt_pc : std_logic_vector(18 DOWNTO 0);
SIGNAL curr_pc : std_logic_vector(18 DOWNTO 0);
SIGNAL memory_zero : std_logic_vector(18 DOWNTO 0);
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
signal Inporttemp : std_logic_vector(31 DOWNTO 0);
signal Inport_out : std_logic_vector(31 DOWNTO 0);
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
signal out_port_signal : std_logic;
signal r_type_signal_out : std_logic;
signal r_type_signal_mem : std_logic;
signal r_type_signal_wb : std_logic;
signal dst_offset_signal : std_logic;
signal dst_offset_signal_out : std_logic;
signal mem_Write_signal : std_logic;
signal mem_Write_signal_out : std_logic;
signal dst_src_signal : std_logic;
signal dst_src_signal_out : std_logic;
signal dst_or_src_out : std_logic_vector(2 DOWNTO 0);
signal decision_src : std_logic_vector(1 DOWNTO 0);
signal decision_dst : std_logic_vector(1 DOWNTO 0);
signal load_signal : std_logic;
signal flush : std_logic;
signal pc_enable : std_logic;
signal load_signal_out : std_logic;
signal out_port_signal_out : std_logic;
signal store_signal : std_logic;
signal store_signal_out : std_logic;
signal sp_enable_in : std_logic;
signal sp_enable_out : std_logic;
signal sp_enable_out2 : std_logic;
signal forwarded_data : std_logic_vector(31 DOWNTO 0);
begin

ftch: Fetch PORT MAP(Iout_ftch,Iin,nxt_pc,curr_pc,memory_zero,clk,rst,pc_enable);
bf_ftch_decode: Buffer_fd PORT MAP(Iout_ftch,Iin_Decode,nxt_pc,curr_pc,InPort,Inporttemp,clk);

decode : deocde_writeBack PORT MAP(Rst,clk,write_enable_signal,r_type_signal,dst_offset_signal,mem_write_signal,dst_src_signal,load_signal,out_port_signal,store_signal,sp_enable_in,flush,write_enable_signal_exe,Iin_Decode,Write_Data,ReadData1,ReadData2,WriteReg,opcode,dst,src,offset);
df_dec : Buffer_de PORT MAP(write_enable_signal,write_enable_signal_out,r_type_signal,r_type_signal_out,dst_offset_signal,dst_offset_signal_out,mem_write_signal,mem_write_signal_out,dst_src_signal,dst_src_signal_out,load_signal,load_signal_out,store_signal,store_signal_out,out_port_signal,out_port_signal_out,sp_enable_in,sp_enable_out,ReadData1,ReadData2,opcode,opcode_out,dst,src,offset,ReadData1_out,ReadData2_out,dst_out,src_out,offset_out,Inporttemp,InPort_out,clk);

ex : Execute PORT MAP(Rst,clk,decision_src,decision_dst,ReadData1_out,ReadData2_out,ALU_OUTPUT_MEMORY,write_data,opcode_out,ALU_output,dst_offset_signal_out,offset_out,Inport_out,out_port_signal_out,store_signal_out,forwarded_data);
ex_mem : Buffer_em PORT MAP (write_enable_signal_out,write_enable_signal_mem,r_type_signal_out,r_type_signal_mem,mem_write_signal_out,write_in_memo_enable,sp_enable_out,sp_enable_out2,forwarded_data,ReadData2_out_mem,dst_or_src_out,write_back_reg_out,Alu_output,ALU_OUTPUT_MEMORY,clk); -- writeback register should come out of multiplexer choosing between src and destination let it destination only for nowend component;

Mem : Memory PORT MAP (ALU_OUTPUT_MEMORY(18 downto 0),ReadData2_out_mem,read_data_from_memo,clk,RST,write_in_memo_enable ,memory_zero,sp_enable_out2);
BF_EM : Buffer_mw PORT MAP (write_enable_signal_mem,write_enable_signal_exe,r_type_signal_mem,r_type_signal_wb,ALU_OUTPUT_MEMORY,Write_Data_alu,read_data_from_memo,MEM_OUTPUT_OUT,write_back_reg_out,WriteReg,clk);  --write back data should be choosen by a multipllexer choosing between output of memory and output of alu let it be output of alu only for now

fru : forwarding_unit PORT MAP (write_back_reg_out,write_enable_signal_mem,WriteReg,write_enable_signal_exe,src_out,dst_out,decision_src,decision_dst);

hazard: Hazard_unit PORT MAP (load_signal_out,flush,pc_enable,src,dst,dst_out);

write_data<=Write_Data_alu when r_type_signal_wb='1'
ELSE MEM_OUTPUT_OUT when r_type_signal_wb='0';

dst_or_src_out<=src_out when dst_src_signal_out='1'
ELSE dst_out when dst_src_signal_out='0'; 

Outport<=ALU_output WHEN out_port_signal_out='1';

end Architecture;
