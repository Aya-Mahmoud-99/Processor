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
mem load -filltype value -filldata 1 -fillradix symbolic /processor/Mem/IM/ram(0)
mem load -filltype value -filldata 1 -fillradix symbolic /processor/Mem/IM/ram(1)
mem load -filltype value -filldata 1 -fillradix symbolic /processor/Mem/IM/ram(2)
mem load -filltype value -filldata 1 -fillradix symbolic /processor/Mem/IM/ram(3)
mem load -filltype value -filldata 1101000001100001 -fillradix symbolic /processor/ftch/IM/ram(0)
mem load -filltype value -filldata 1 -fillradix symbolic /processor/ftch/IM/ram(1)
mem load -filltype value -filldata 0 -fillradix symbolic /processor/ftch/IM/ram(2)
mem load -filltype value -filldata 0 -fillradix symbolic /processor/ftch/IM/ram(3)
mem load -filltype value -filldata 0001000000100010 -fillradix symbolic /processor/ftch/IM/ram(4)
mem load -filltype value -filldata 00 -fillradix symbolic /processor/ftch/IM/ram(5)
mem load -filltype value -filldata 0000110010100011 -fillradix symbolic /processor/ftch/IM/ram(6)
mem load -filltype value -filldata 0 -fillradix symbolic /processor/ftch/IM/ram(7)
mem load -filltype value -filldata 0001010001100100 -fillradix symbolic /processor/ftch/IM/ram(8)
mem load -filltype value -filldata 0 -fillradix symbolic /processor/ftch/IM/ram(9)
mem load -filltype value -filldata 0001000000000001 -fillradix symbolic /processor/ftch/IM/ram(10)
mem load -filltype value -filldata {0 } -fillradix symbolic /processor/ftch/IM/ram(11)
mem load -filltype value -filldata 0000100010100001 -fillradix symbolic /processor/ftch/IM/ram(12)
mem load -filltype value -filldata {0 } -fillradix symbolic /processor/ftch/IM/ram(13)
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
sim:/processor/write_enable_signal_mem
force -freeze sim:/processor/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/processor/RST 1 0
force -freeze sim:/processor/pc_enable 1 0
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
