onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /dual_port_memory_latency_test_bench/dut/WIDTH
add wave -noupdate /dual_port_memory_latency_test_bench/dut/ADDR
add wave -noupdate /dual_port_memory_latency_test_bench/dut/DEPTH
add wave -noupdate -expand -group Port_A /dual_port_memory_latency_test_bench/dut/WRITE_LATENCY_A
add wave -noupdate -expand -group Port_A /dual_port_memory_latency_test_bench/dut/READ_LATENCY_A
add wave -noupdate -expand -group Port_A /dual_port_memory_latency_test_bench/dut/i_clk_a
add wave -noupdate -expand -group Port_A /dual_port_memory_latency_test_bench/dut/i_we_a
add wave -noupdate -expand -group Port_A /dual_port_memory_latency_test_bench/dut/i_en_a
add wave -noupdate -expand -group Port_A /dual_port_memory_latency_test_bench/dut/i_din_a
add wave -noupdate -expand -group Port_A /dual_port_memory_latency_test_bench/dut/i_addr_a
add wave -noupdate -expand -group Port_A /dual_port_memory_latency_test_bench/dut/o_dout_a
add wave -noupdate -expand -group Port_B /dual_port_memory_latency_test_bench/dut/WRITE_LATENCY_B
add wave -noupdate -expand -group Port_B /dual_port_memory_latency_test_bench/dut/READ_LATENCY_B
add wave -noupdate -expand -group Port_B /dual_port_memory_latency_test_bench/dut/i_clk_b
add wave -noupdate -expand -group Port_B /dual_port_memory_latency_test_bench/dut/i_we_b
add wave -noupdate -expand -group Port_B /dual_port_memory_latency_test_bench/dut/i_en_b
add wave -noupdate -expand -group Port_B /dual_port_memory_latency_test_bench/dut/i_din_b
add wave -noupdate -expand -group Port_B /dual_port_memory_latency_test_bench/dut/i_addr_b
add wave -noupdate -expand -group Port_B /dual_port_memory_latency_test_bench/dut/o_dout_b
add wave -noupdate /dual_port_memory_latency_test_bench/dut/mem
add wave -noupdate /dual_port_memory_latency_test_bench/dut/shreg1
add wave -noupdate /dual_port_memory_latency_test_bench/dut/shreg2
add wave -noupdate /dual_port_memory_latency_test_bench/dut/shreg3
add wave -noupdate /dual_port_memory_latency_test_bench/dut/shreg4
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1379 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 192
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
WaveRestoreZoom {1379 ns} {1875 ns}
