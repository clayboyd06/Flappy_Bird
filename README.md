# Flappy_Bird
Final project for Digital Circuits and Systems 

Implements Flappy Bird Game on Altera DE1_SoC FPGA with 16x16 LED Matrix in System Verilog

Simulation amd output files excluded from the Repository for cleanliness

# System Schematic 

![image](https://user-images.githubusercontent.com/71368259/163904589-f68cef0b-ad19-4a37-bcc9-31fe7dad1c74.png)

# User guide:
The top-level DE1_SoC should operate based on the two user inputs KEY[0] (jump) and KEY[3] (reset). The red LED is controlled by the input jump, and moves up on the led board if jump is true (or the key is pressed) and moves down whenever the key is unpressed. The active little birdy never sits still, although it does not move horizontally. Instead, the screen is translated to the left by a series of pipeColumn modules that duplicate the data of the column to the right into their data based on an enable signal within the module. The position of the pipes in column 12 are checked with the position of the bird. If the pipes are present (column data != 0) and the bird LED is not at the same position as a pipe LED,  then checker will output a point signal, if the bird is in the same position as any of the pipes, the checker will output a loser signal, which will be displayed on the HEX0 display. The point signal goes to a hex-display counter that is outputted to HEX3, HEX4, and HEX0. The position of all of the pipes and the bird are ran through the LED driver and displayed on the LED board.

# Installation
## With quartus software
Download all of the .sv files and the .qpf file to open the file in quartus. Set DE1_SoC as Top Level Module and synthesize. DE1_SoC.sv will instantiate all other modules. 

