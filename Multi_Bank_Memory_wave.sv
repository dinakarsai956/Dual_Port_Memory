onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /dual_port_multi_bank_memory_testbench/dut/WIDTH
add wave -noupdate /dual_port_multi_bank_memory_testbench/dut/ADDR_TOTAL
add wave -noupdate /dual_port_multi_bank_memory_testbench/dut/NUM_BANK
add wave -noupdate /dual_port_multi_bank_memory_testbench/dut/BANK_BITS
add wave -noupdate /dual_port_multi_bank_memory_testbench/dut/ADDR_PER_BANK
add wave -noupdate -expand -group Port_A /dual_port_multi_bank_memory_testbench/dut/i_clk_a
add wave -noupdate -expand -group Port_A /dual_port_multi_bank_memory_testbench/dut/i_en_a
add wave -noupdate -expand -group Port_A /dual_port_multi_bank_memory_testbench/dut/i_we_a
add wave -noupdate -expand -group Port_A /dual_port_multi_bank_memory_testbench/dut/i_din_a
add wave -noupdate -expand -group Port_A /dual_port_multi_bank_memory_testbench/dut/i_addr_a
add wave -noupdate -expand -group Port_A /dual_port_multi_bank_memory_testbench/dut/o_dout_a
add wave -noupdate -expand -group Port_A /dual_port_multi_bank_memory_testbench/dut/bank_sel_a
add wave -noupdate -expand -group Port_A /dual_port_multi_bank_memory_testbench/dut/bank_addr_a
add wave -noupdate -expand -group Port_A /dual_port_multi_bank_memory_testbench/dut/out_a
add wave -noupdate -expand -group Port_A /dual_port_multi_bank_memory_testbench/dut/bank_dout_a
add wave -noupdate -expand -group Port_B /dual_port_multi_bank_memory_testbench/dut/i_clk_b
add wave -noupdate -expand -group Port_B /dual_port_multi_bank_memory_testbench/dut/i_en_b
add wave -noupdate -expand -group Port_B /dual_port_multi_bank_memory_testbench/dut/i_we_b
add wave -noupdate -expand -group Port_B /dual_port_multi_bank_memory_testbench/dut/i_din_b
add wave -noupdate -expand -group Port_B /dual_port_multi_bank_memory_testbench/dut/i_addr_b
add wave -noupdate -expand -group Port_B /dual_port_multi_bank_memory_testbench/dut/o_dout_b
add wave -noupdate -expand -group Port_B /dual_port_multi_bank_memory_testbench/dut/bank_sel_b
add wave -noupdate -expand -group Port_B /dual_port_multi_bank_memory_testbench/dut/bank_addr_b
add wave -noupdate -expand -group Port_B /dual_port_multi_bank_memory_testbench/dut/out_b
add wave -noupdate -expand -group Port_B /dual_port_multi_bank_memory_testbench/dut/bank_dout_b
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {240 ns}
