onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /decoder/clk
add wave -noupdate /decoder/ch1A
add wave -noupdate /decoder/ch1B
add wave -noupdate /decoder/sel
add wave -noupdate /decoder/count_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {0 ps} {732 ps}
