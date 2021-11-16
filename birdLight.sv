module birdLight(clk, reset, gameOver, up, arrayOut);
// vertical row for the bird location led
//
	input logic clk, reset;
	input logic gameOver, up;
	
	logic [14:0] leds;
	logic [9:0]counter;
	logic move;
	
	output logic [15:0][15:0] arrayOut;
	
		always_ff @(posedge clk) begin
		if (reset) begin
			counter <= 3'd1;
			move <= 1'b0;
		end else if (counter == 150) begin 	// for board
		//end else if (counter == 8) begin		// for sim
			counter <= 'b0;
			move <= 1'b1;
		end else begin
			counter <= counter + 1;
			move <= 1'b0;
		end
	end

		topLight fifteen(.clk, .reset, .gameOver, .enable(move), .up, .above(1'b0), .below(leds[13]), .lightOn(leds[14]));
		normalLight fourteen(.clk, .reset, .gameOver, .enable(move), .up, .above(leds[14]), .below(leds[12]), .lightOn(leds[13]));
		normalLight thirteen(.clk, .reset, .gameOver,.enable(move), .up, .above(leds[13]), .below(leds[11]), .lightOn(leds[12]));
		normalLight twelve(.clk, .reset, .gameOver,.enable(move), .up, .above(leds[12]), .below(leds[10]), .lightOn(leds[11]));
		normalLight eleven(.clk, .reset, .gameOver,.enable(move), .up, .above(leds[11]), .below(leds[9]), .lightOn(leds[10]));
		normalLight ten(.clk, .reset, .gameOver,.enable(move), .up, .above(leds[10]), .below(leds[8]), .lightOn(leds[9]));
		normalLight nine(.clk, .reset, .gameOver, .enable(move), .up, .above(leds[9]), .below(leds[7]), .lightOn(leds[8]));
		
		centerLight center(.clk, .reset, .up, .gameOver, .enable(move), .above(leds[8]), .below(leds[6]), .lightOn(leds[7])); // on when reset
		
		normalLight seven(.clk, .reset, .gameOver, .enable(move), .up, .above(leds[7]), .below(leds[5]), .lightOn(leds[6]));
		normalLight six(.clk, .reset, .gameOver, .enable(move), .up,  .above(leds[6]), .below(leds[4]), .lightOn(leds[5]));
		normalLight five(.clk, .reset, .gameOver, .enable(move), .up, .above(leds[5]), .below(leds[3]), .lightOn(leds[4]));
		normalLight four(.clk, .reset, .gameOver, .enable(move), .up, .above(leds[4]), .below(leds[2]), .lightOn(leds[3]));
		normalLight three(.clk, .reset, .gameOver, .enable(move), .up, .above(leds[3]), .below(leds[1]), .lightOn(leds[2]));
		normalLight two(.clk, .reset, .gameOver, .enable(move), .up, .above(leds[2]), .below(leds[0]), .lightOn(leds[1]));
		bottomLight one(.clk, .reset, .gameOver, .enable(move), .up, .above(leds[1]), .below(1'b0), .lightOn(leds[0]));
		
		assign arrayOut[0] = 16'b0;
		assign arrayOut[1] = 16'b0;
		assign arrayOut[2] = 16'b0;
		assign arrayOut[3] = 16'b0;
		assign arrayOut[4] = 16'b0;
		assign arrayOut[5] = 16'b0;
		assign arrayOut[6] = 16'b0;
		assign arrayOut[7] = 16'b0;
		assign arrayOut[8] = 16'b0;
		assign arrayOut[9] = 16'b0;
		assign arrayOut[10] = 16'b0;
		assign arrayOut[11] = 16'b0;
		assign arrayOut[12] = {1'b0, leds[14:0]};
		assign arrayOut[13] = 16'b0;
		assign arrayOut[14] = 16'b0;
		assign arrayOut[15] = 16'b0;
	
endmodule	


module birdLight_testbench();
	logic clk, reset;
	logic gameOver, up;
	
	logic [14:0] leds;
	logic [15:0][15:0] arrayOut;
	
	birdLight dut(.*);
	 // Set up a simulated clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock
	end
	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin
		reset <= 1; @(posedge clk);							//NEW GAME
		reset <= 0; up<=0;@(posedge clk);
		repeat(1) begin
			up <= 1; @(posedge clk);
		end
		repeat(2) begin
			up <=0; @(posedge clk);
		end
		repeat(3) begin
			up <=1; @(posedge clk);
		end
		repeat(4) begin
			up <=0; @(posedge clk);
		end
		repeat(5) begin
			up<=1; @(posedge clk);
		end
		repeat(6) begin
			up<=0; @(posedge clk);
		end
		repeat(7) begin
			up<=1; @(posedge clk);
		end
		repeat(8) begin
			up<=0; @(posedge clk);
		end
		repeat(9) begin
			up<=1; @(posedge clk);
		end
		@(posedge clk);
		@(posedge clk);
		
		
		
//		
//		L <= 0; R<=1;						//LEDR[4]
//		@(posedge clk);
//		L <= 0; R<=1;						//LEDR[3]
//		@(posedge clk);					
//		L <= 1; R<=0;						//LEDR[4]
//		@(posedge clk);
//		L <= 1; R<=0;						//LEDR[5]
//		@(posedge clk);
//		L <= 1; R<=0;						//LEDR[6]
//		@(posedge clk);
//		L <= 0; R<=1;						//LEDR[5]
//		@(posedge clk);
//		L <= 0; R<=1;						//LEDR[4]
//		@(posedge clk);
//		L <= 0; R<=1;						//LEDR[3]
//		@(posedge clk);
//		L <= 0; R<=1;						//LEDR[2]
//		@(posedge clk);
//		L <= 0; R<=1;						//LEDR[1]
//		@(posedge clk);
//		L <= 0; R<=1;						//LEDR[1]
//		@(posedge clk);			
		$stop;
	end
endmodule
		