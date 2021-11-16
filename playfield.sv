module birdLight(clk, reset, up, leds);
// vertical row for the bird location led
//
	input logic clk, reset;
	input logic up; 
	
	output logic [14:0] leds;
	
	normalLight fifteen(.clk, .reset, .up, .above(1'b0), .below(leds[13]), .lightOn(leds[14]));
	normalLight fourteen(.clk, .reset, .up, .above(leds[14]), .below(leds[12]), .lightOn(leds[13]));
	normalLight thirteen(.clk, .reset, .up, .above(leds[13]), .below(leds[11]), .lightOn(leds[12]));
	normalLight twelve(.clk, .reset, .up, .above(leds[12]), .below(leds[10]), .lightOn(leds[11]));
	normalLight eleven(.clk, .reset, .up, .above(leds[11]), .below(leds[9]), .lightOn(leds[10]));
	normalLight ten(.clk, .reset, .up, .above(leds[10]), .below(leds[8]), .lightOn(leds[9]));
	normalLight nine(.clk, .reset, .up, .above(leds[9]), .below(leds[7]), .lightOn(leds[8]));
	
	centerLight center(.clk, .reset, .up, .above(leds[8]), .below(leds[6]), .lightOn(leds[7])); // on when reset
	
	normalLight seven(.clk, .reset, .up, .above(leds[7]), .below(leds[5]), .lightOn(leds[6]));
	normalLight six(.clk, .reset, .up, .above(leds[6]), .below(leds[4]), .lightOn(leds[5]));
	normalLight five(.clk, .reset, .up, .above(leds[5]), .below(leds[3]), .lightOn(leds[4]));
	normalLight four(.clk, .reset, .up, .above(leds[4]), .below(leds[2]), .lightOn(leds[3]));
	normalLight three(.clk, .reset, .up, .above(leds[3]), .below(leds[1]), .lightOn(leds[2]));
	normalLight two(.clk, .reset, .up, .above(leds[2]), .below(leds[0]), .lightOn(leds[1]));
	normalLight one(.clk, .reset, .up, .above(leds[1]), .below(1'b0), .lightOn(leds[0]));

	
	
	
	

endmodule	


module playfield_testbench();
	logic clk, reset;
	logic up;
	
	logic [14:1] leds;
	
	playfield dut(.*);
	 // Set up a simulated clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock
	end
	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin
		reset <= 1; @(posedge clk);							//NEW GAME
		reset <= 0; L <= 0; R<=0;		// CENTER LED[5]
		@(posedge clk);
		repeat(1) begin
			L <= 0; R<=1; @(posedge clk);
		end
		repeat(2) begin
			L <= 1; R<=0; @(posedge clk);
		end
		repeat(3) begin
			L <= 0; R<=1; @(posedge clk);
		end
		repeat(4) begin
			L <= 1; R<=0; @(posedge clk);
		end
		repeat(5) begin
			L <= 0; R<=1; @(posedge clk);
		end
		repeat(6) begin
			L <= 1; R<=0; @(posedge clk);
		end
		repeat(7) begin
			L <= 0; R<=1; @(posedge clk);
		end
		repeat(8) begin
			L <= 1; R<=0; @(posedge clk);
		end
		repeat(9) begin
			L <= 0; R<=1; @(posedge clk);
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
		