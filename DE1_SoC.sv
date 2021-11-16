// Top-level module that defines the I/Os for the DE-1 SoC board
module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, SW, LEDR, GPIO_1, CLOCK_50);
    output logic [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	 output logic [9:0]  LEDR;
    input  logic [3:0]  KEY;
    input  logic [9:0]  SW;
    output logic [35:0] GPIO_1;
    input logic CLOCK_50;

	 // Turn off unused HEX displays
    //assign HEX0 = '1;
    assign HEX1 = '1;
    assign HEX2 = '1;
    //assign HEX3 = '1;
    //assign HEX4 = '1;
    //assign HEX5 = '1;
	 
	 
	 /* Set up system base clock to 1526 Hz (50 MHz / 2**(14+1))
	    ===========================================================*/
	 logic [31:0] clk;
	 logic SYSTEM_CLOCK;
	 
	 clock_divider divider (.clock(CLOCK_50), .divided_clocks(clk));
	 
	 assign SYSTEM_CLOCK = clk[14]; // 1526 Hz clock signal
	 //assign SYSTEM_CLOCK = CLOCK_50;
	 
	 /* If you notice flickering, set SYSTEM_CLOCK faster.
	    However, this may reduce the brightness of the LED board. */
		 
	
	 
//	 /* Set up LED board driver
//	    ================================================================== */
	 logic [15:0][15:0]RedPixels; // 16 x 16 array representing red LEDs
	 logic [15:0][15:0]GrnPixels; // 16 x 16 array representing green LEDs
    logic RESET;                    // reset - toggle this on startup
	 
		/* Standard LED Driver instantiation - set once and 'forget it'. 
	    See LEDDriver.sv for more info. Do not modify unless you know what you are doing! */
	 LEDDriver Driver (.CLK(SYSTEM_CLOCK), .RST(RESET), .EnableCount(1'b1), .RedPixels(GrnPixels), .GrnPixels(RedPixels), .GPIO_1); //oopsy


 //############################   Lab 8 Code ############################ 
	 
//	  Controls the Flappy Bird Game
//
//		 Controls:
//	 	 KEY0      : Reset
//		 KEY3 	  : Jump/Play 
//		 =================================================================== */

	
	logic jump;
	logic birdUp;
	logic midReset;
	logic genCycle, shiftCycle;
	logic loser;
	logic upCount;
	logic gotTen, gotHund, tooBig;	
	logic gameOver;
   logic [14:0] holdFirst, holdBirdCol;
 
	// Filters metastability from user inputs 
   metaFilter rst (.clk(SYSTEM_CLOCK), .key(~KEY[3]), .out(RESET));
	metaFilter keyPress (.clk(SYSTEM_CLOCK), .key(~KEY[0]), .out(jump));

	// control bird vertical location
	birdLight aFlappyBord(.clk(SYSTEM_CLOCK), .reset(RESET), .gameOver(gameOver), .up(jump), .arrayOut(GrnPixels)); // located at third column
	
	// Slows down the creation of new pipes and the translation of pipes respectively
	slowDown createPipe(.clk(SYSTEM_CLOCK), .reset(RESET), .speed(4'b1111), .slow_clk(genCycle));
	slowDown movePipe(.clk(SYSTEM_CLOCK), .reset(RESET), .speed(4'b0011), .slow_clk(shiftCycle));
	// generates a new pipe/offscreen
	newPipe offScreen(.clk(SYSTEM_CLOCK), .reset(RESET), .gameOver(gameOver), .slow_clk(genCycle), .pattern(holdFirst[14:0])); 
	// Duplicates the pipe to the right's data to the current columns data - shifts the pipe
	pipeColumn column1(.clk(SYSTEM_CLOCK), .reset(RESET), .gameOver(gameOver), .slow_clk(shiftCycle), .oldPipe(holdFirst[14:0]), .currentPipe(RedPixels[1][14:0]));
	pipeColumn column2(.clk(SYSTEM_CLOCK), .reset(RESET), .gameOver(gameOver), .slow_clk(shiftCycle), .oldPipe(RedPixels[1][14:0]), .currentPipe(RedPixels[2][14:0]));
	pipeColumn column3(.clk(SYSTEM_CLOCK), .reset(RESET), .gameOver(gameOver), .slow_clk(shiftCycle), .oldPipe(RedPixels[2][14:0]), .currentPipe(RedPixels[3][14:0]));
	pipeColumn column4(.clk(SYSTEM_CLOCK), .reset(RESET), .gameOver(gameOver), .slow_clk(shiftCycle), .oldPipe(RedPixels[3][14:0]), .currentPipe(RedPixels[4][14:0]));
	pipeColumn column5(.clk(SYSTEM_CLOCK), .reset(RESET), .gameOver(gameOver), .slow_clk(shiftCycle), .oldPipe(RedPixels[4][14:0]), .currentPipe(RedPixels[5][14:0]));
	pipeColumn column6(.clk(SYSTEM_CLOCK), .reset(RESET), .gameOver(gameOver), .slow_clk(shiftCycle), .oldPipe(RedPixels[5][14:0]), .currentPipe(RedPixels[6][14:0]));
	pipeColumn column7(.clk(SYSTEM_CLOCK), .reset(RESET), .gameOver(gameOver), .slow_clk(shiftCycle), .oldPipe(RedPixels[6][14:0]), .currentPipe(RedPixels[7][14:0]));
	pipeColumn column8(.clk(SYSTEM_CLOCK), .reset(RESET), .gameOver(gameOver), .slow_clk(shiftCycle), .oldPipe(RedPixels[7][14:0]), .currentPipe(RedPixels[8][14:0]));
	pipeColumn column9(.clk(SYSTEM_CLOCK), .reset(RESET), .gameOver(gameOver), .slow_clk(shiftCycle), .oldPipe(RedPixels[8][14:0]), .currentPipe(RedPixels[9][14:0]));
	pipeColumn column10(.clk(SYSTEM_CLOCK), .reset(RESET), .gameOver(gameOver), .slow_clk(shiftCycle), .oldPipe(RedPixels[9][14:0]), .currentPipe(RedPixels[10][14:0]));
	pipeColumn column11(.clk(SYSTEM_CLOCK), .reset(RESET), .gameOver(gameOver), .slow_clk(shiftCycle), .oldPipe(RedPixels[10][14:0]), .currentPipe(RedPixels[11][14:0]));
	pipeColumn column12(.clk(SYSTEM_CLOCK), .reset(RESET), .gameOver(gameOver), .slow_clk(shiftCycle), .oldPipe(RedPixels[11][14:0]), .currentPipe(RedPixels[12][14:0]));
	pipeColumn column13(.clk(SYSTEM_CLOCK), .reset(RESET), .gameOver(gameOver), .slow_clk(shiftCycle), .oldPipe(RedPixels[12][14:0]), .currentPipe(RedPixels[13][14:0]));
	pipeColumn column14(.clk(SYSTEM_CLOCK), .reset(RESET), .gameOver(gameOver), .slow_clk(shiftCycle), .oldPipe(RedPixels[13][14:0]), .currentPipe(RedPixels[14][14:0]));
	pipeColumn column15(.clk(SYSTEM_CLOCK), .reset(RESET), .gameOver(gameOver), .slow_clk(shiftCycle), .oldPipe(RedPixels[14][14:0]), .currentPipe(RedPixels[15][14:0]));
	
	// Checks if the bird clears the pipes or crashes into them. Outputs point- incrementer or lose signal
	collisionCheck bump(.clk(SYSTEM_CLOCK), .reset(RESET), .birdloc(GrnPixels[12][14:0]), .column3(RedPixels[12][14:0]), .point(upCount), .loser(loser));	
		//output point or loser
		
	// Displays an L on Hex0 if you lose!	
	seg7loser urBad (.lose(loser), .leds(HEX0));
	
	// Displays the score of the game. 
	pointDisplay ones (.clk(SYSTEM_CLOCK), .reset(RESET), .upCount(upCount), .hex(HEX3), .nextHex(gotTen));
	pointDisplay tens (.clk(SYSTEM_CLOCK), .reset(RESET), .upCount(gotTen), .hex(HEX4), .nextHex(gotHund));
	pointDisplay hundz (.clk(SYSTEM_CLOCK), .reset(RESET), .upCount(gotHund), .hex(HEX5), .nextHex(tooBig));

	assign gameOver = loser || tooBig;
	
	
	
	// turn off the unused LEDS
	//======================================== 
	
	assign RedPixels[15][15] = 1'b0;
	assign RedPixels[14][15] = 1'b0;
	assign RedPixels[13][15] = 1'b0;
	assign RedPixels[12][15] = 1'b0;
	assign RedPixels[11][15] = 1'b0;
	assign RedPixels[10][15] = 1'b0;
	assign RedPixels[9][15] = 1'b0;
	assign RedPixels[8][15] = 1'b0;
	assign RedPixels[7][15] = 1'b0;
	assign RedPixels[6][15] = 1'b0;
	assign RedPixels[5][15] = 1'b0;
	assign RedPixels[4][15] = 1'b0;
	assign RedPixels[3][15] = 1'b0;
	assign RedPixels[2][15] = 1'b0;
	assign RedPixels[1][15] = 1'b0;
	assign RedPixels[0][15] = 1'b0;
	assign RedPixels[0][14] = 1'b0;
	assign RedPixels[0][13] = 1'b0;
	assign RedPixels[0][12] = 1'b0;
	assign RedPixels[0][11] = 1'b0;
	assign RedPixels[0][10] = 1'b0;
	assign RedPixels[0][9] = 1'b0;
	assign RedPixels[0][8] = 1'b0;
	assign RedPixels[0][7] = 1'b0;
	assign RedPixels[0][6] = 1'b0;
	assign RedPixels[0][5] = 1'b0;
	assign RedPixels[0][4] = 1'b0;
	assign RedPixels[0][3] = 1'b0;
	assign RedPixels[0][2] = 1'b0;
	assign RedPixels[0][1] = 1'b0;
	assign RedPixels[0][0] = 1'b0;
endmodule

module DE1_SoC_testbench();
    logic [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	 logic [9:0]  LEDR;
    logic [3:0]  KEY;
    logic [9:0]  SW;
    logic [35:0] GPIO_1;
    logic CLOCK_50;
	 
	 DE1_SoC dut (.HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .SW, .LEDR, .GPIO_1, .CLOCK_50(CLOCK_50));
	 
	  // Set up a simulated clock.
	 parameter CLOCK_PERIOD=100;
	 initial begin
		 CLOCK_50 <= 0;
		 forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50; // Forever toggle the clock
	 end
	 
	 initial begin 
		@(posedge CLOCK_50);
		KEY[3] = 0; @(posedge CLOCK_50);
		KEY[3] = 1; @(posedge CLOCK_50);
		repeat(100) begin
			KEY[0] = 0; @(posedge CLOCK_50);
			KEY[0] = 1; @(posedge CLOCK_50);
		end
		$stop;
	 end
endmodule		