onerror {resume}
quietly virtual signal -install /DE1_SoC_testbench/dut {/DE1_SoC_testbench/dut/SW[4]  } U
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group top /DE1_SoC_testbench/dut/SYSTEM_CLOCK
add wave -noupdate -expand -group top /DE1_SoC_testbench/dut/RESET
add wave -noupdate -expand -group top {/DE1_SoC_testbench/dut/KEY[3]}
add wave -noupdate -expand -group top {/DE1_SoC_testbench/dut/KEY[0]}
add wave -noupdate -expand -group top -expand /DE1_SoC_testbench/dut/RedPixels
add wave -noupdate -expand -group top -expand {/DE1_SoC_testbench/dut/GrnPixels[12]}
add wave -noupdate -expand -group top /DE1_SoC_testbench/dut/GrnPixels
add wave -noupdate -expand -group top /DE1_SoC_testbench/dut/HEX0
add wave -noupdate -expand -group top /DE1_SoC_testbench/dut/HEX3
add wave -noupdate -expand -group top /DE1_SoC_testbench/dut/HEX4
add wave -noupdate -expand -group top /DE1_SoC_testbench/dut/HEX5
add wave -noupdate -group {NEW PIPE} /DE1_SoC_testbench/dut/offScreen/clk
add wave -noupdate -group {NEW PIPE} /DE1_SoC_testbench/dut/offScreen/reset
add wave -noupdate -group {NEW PIPE} /DE1_SoC_testbench/dut/offScreen/gameOver
add wave -noupdate -group {NEW PIPE} /DE1_SoC_testbench/dut/offScreen/slow_clk
add wave -noupdate -group {NEW PIPE} /DE1_SoC_testbench/dut/offScreen/pattern
add wave -noupdate -group {NEW PIPE} /DE1_SoC_testbench/dut/offScreen/numbr
add wave -noupdate -group {NEW PIPE} /DE1_SoC_testbench/dut/offScreen/numUse
add wave -noupdate -group {NEW PIPE} /DE1_SoC_testbench/dut/offScreen/counter
add wave -noupdate -group {NEW PIPE} /DE1_SoC_testbench/dut/offScreen/counter2
add wave -noupdate -group {NEW PIPE} /DE1_SoC_testbench/dut/offScreen/next_pipe
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 2} {10650 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 97
configure wave -valuecolwidth 119
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {11935 ps}
