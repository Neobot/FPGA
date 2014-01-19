## Generated SDC file "Decoder.out.sdc"

## Copyright (C) 1991-2013 Altera Corporation
## Your use of Altera Corporation's design tools, logic functions 
## and other software and tools, and its AMPP partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Altera Program License 
## Subscription Agreement, Altera MegaCore Function License 
## Agreement, or other applicable license agreement, including, 
## without limitation, that your use is for the sole purpose of 
## programming logic devices manufactured by Altera and sold by 
## Altera or its authorized distributors.  Please refer to the 
## applicable agreement for further details.


## VENDOR  "Altera"
## PROGRAM "Quartus II"
## VERSION "Version 13.0.1 Build 232 06/12/2013 Service Pack 1 SJ Web Edition"

## DATE    "Wed Jan 01 17:54:59 2014"

##
## DEVICE  "EP2C5T144C8"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {clk} -period 20.000 -waveform { 0.000 10.000 } [get_ports {clk}]


#**************************************************************
# Create Generated Clock
#**************************************************************



#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************



#**************************************************************
# Set Input Delay
#**************************************************************

set_input_delay -add_delay  -clock [get_clocks {clk}]  2.000 [get_ports {ch1A}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  2.000 [get_ports {ch1B}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  2.000 [get_ports {ch2A}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  2.000 [get_ports {ch2B}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  2.000 [get_ports {ch3A}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  2.000 [get_ports {ch3B}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  2.000 [get_ports {ch4A}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  2.000 [get_ports {ch4B}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  2.000 [get_ports {sel[0]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  2.000 [get_ports {sel[1]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  2.000 [get_ports {sel[2]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  2.000 [get_ports {sel[3]}]


#**************************************************************
# Set Output Delay
#**************************************************************

set_output_delay -add_delay  -clock [get_clocks {clk}]  1.500 [get_ports {count_out[0]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  1.500 [get_ports {count_out[1]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  1.500 [get_ports {count_out[2]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  1.500 [get_ports {count_out[3]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  1.500 [get_ports {count_out[4]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  1.500 [get_ports {count_out[5]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  1.500 [get_ports {count_out[6]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  1.500 [get_ports {count_out[7]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  1.500 [get_ports {count_out[8]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  1.500 [get_ports {count_out[9]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  1.500 [get_ports {count_out[10]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  1.500 [get_ports {count_out[11]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  1.500 [get_ports {led1}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  1.500 [get_ports {led2}]


#**************************************************************
# Set Clock Groups
#**************************************************************



#**************************************************************
# Set False Path
#**************************************************************



#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************
