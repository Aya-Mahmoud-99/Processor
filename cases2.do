vsim work.processor
# vsim work.processor 
# Start time: 01:09:47 on Jun 08,2021
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.std_logic_arith(body)
# Loading ieee.std_logic_unsigned(body)
# Loading ieee.numeric_std(body)
# Loading work.processor(mymodel)
# Loading work.fetch(mymodel)
# Loading work.my_ndff(b_my_ndff)
# Loading work.my_dff(a_my_dff)
# Loading work.ram(sync_ram_a)
# Loading work.my_nadder(a_my_nadder)
# Loading work.my_adder(a_my_adder)
# Loading work.buffer_fd(a_buffer)
# Loading work.deocde_writeback(mymodel)
# Loading work.regist(regista)
# Loading work.my_decoder(decodea)
# Loading work.tristate(tri)
# Loading work.control_unit(mymodel)
# Loading work.buffer_de(a_buffer)
# Loading work.execute(mymodel)
# Loading work.alu(struct1)
# Loading work.buffer_em(a_buffer)
# Loading work.memory(mymodel)
# Loading work.buffer_mw(a_buffer)

mem load -i ./testcases/MachineCode.mem /processor/ftch/IM/ram
mem load -i ./testcases/Ram.mem /processor/Mem/IM/ram







add wave -position insertpoint  \
sim:/processor/MEM_OUTPUT_OUT
add wave -position insertpoint  \
sim:/processor/dst_offset_signal
add wave -position insertpoint  \
sim:/processor/dst_offset_signal_out
add wave -position insertpoint  \
sim:/processor/clk \
sim:/processor/RST \
sim:/processor/Iin \
sim:/processor/pc_enable \
sim:/processor/Iout_ftch \
sim:/processor/Iin_decode \
sim:/processor/ALU_output \
sim:/processor/ALU_output_memory \
sim:/processor/nxt_pc \
sim:/processor/curr_pc \
sim:/processor/ReadData1 \
sim:/processor/ReadData2 \
sim:/processor/Write_Data \
sim:/processor/WriteReg \
sim:/processor/opcode \
sim:/processor/opcode_out \
sim:/processor/dst \
sim:/processor/src \
sim:/processor/offset \
sim:/processor/ReadData1_out \
sim:/processor/ReadData2_out \
sim:/processor/ReadData2_out_mem \
sim:/processor/read_data_from_memo \
sim:/processor/MEM_OUTPUT_OUT \
sim:/processor/dst_out \
sim:/processor/write_back_reg_out \
sim:/processor/src_out \
sim:/processor/offset_out \
sim:/processor/write_in_memo_enable \
sim:/processor/write_enable_signal \
sim:/processor/write_enable_signal_exe \
sim:/processor/write_enable_signal_in \
sim:/processor/write_enable_signal_out \
sim:/processor/write_enable_signal_mem \
sim:/processor/decision_src \
sim:/processor/decision_dst \
sim:/processor/flush \
sim:/processor/Inport \
sim:/processor/load_signal \
sim:/processor/dst_or_src_out \
sim:/processor/Outport
force -freeze sim:/processor/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/processor/RST 1 0




run
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Instance: /processor/Mem/IM
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Instance: /processor/Mem/IM
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Instance: /processor/ftch/IM
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Instance: /processor/ftch/IM
force -freeze sim:/processor/RST 0 0
run
run

force -freeze sim:/processor/Inport 32'hFFFFFFF 0
run

force -freeze sim:/processor/Inport 32'hFFFFF320 0
run

run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
