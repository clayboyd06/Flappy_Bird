  module newPipe (clk, reset, gameOver, slow_clk, pattern);
 // generates a psuedo - random pattern for the pipes 
	input logic clk, reset;
	input logic gameOver, slow_clk;
	
	output logic [14: 0] pattern; // Pattern corresponds to the columns of the LEDs that are on
	
	logic [2:0] numbr, numUse;
	logic [2:0] counter;
	logic [4:0] counter2;
	logic next_pipe;
	
	
	lfsr3 rand1(.clk, .reset, .out(numUse));
	
	always_ff @(posedge clk) begin
		if (reset) begin
			counter <= 1'b0;
		end else begin
			counter <= counter + 1;
		end
	end
	
	assign numbr = numUse + counter + counter;
	
	
	
	always_ff @(posedge clk) begin
		if (reset) begin
			counter2 <= 2'b11;
			next_pipe <= 1'b0;
		end else if (counter2 == 4) begin
			counter2 <= 'b0;
			next_pipe <= 1'b1;
		end else begin
			counter2 <= counter2 + 1;
			next_pipe <= 1'b0;
		end
	end
			
	
	
	always_comb begin
		if (next_pipe && ~gameOver) begin
		//if (ps == lit && ~gameOver) begin
			if (numbr == 3'b000) begin
				//ns = a;
				pattern = 15'b110000011111111;
			end else if (numbr == 3'b001) begin
				//ns = b;
				pattern = 15'b111000001111111;
			end else if (numbr == 3'b010) begin
				//ns = c;
				pattern = 15'b111100000111111;
			end else if (numbr == 3'b011) begin
				//ns = d;
				pattern = 15'b111110000011111; 
			end else if (numbr == 3'b100) begin
				//ns = e;
				pattern = 15'b111111000001111;
			end else if (numbr == 3'b101) begin
				//ns = f;
				pattern = 15'b111111100000111; 
			end else if (numbr == 3'b110) begin
				//ns = g;
				pattern = 15'b111111110000011;
			end else if (numbr == 3'b111) begin
				//ns = h;
				pattern = 15'b111111111000001;
			end else begin
				//ns = none;
				pattern = 15'b000000000000000;
			end
		end else begin
			pattern = 15'b000000000000000;
		end
	end
	/*
	always_ff @(posedge clk) begin
		if (reset) begin
			ps <= unlit;
		end else if (gameOver) begin
			ps <= ps;
		end else begin
			ps <= ns;
		end
	end
	*/
	
endmodule

module newPipe_testbench();
	logic clk, reset;
	logic gameOver, slow_clk;
	logic [14:0] pattern;
	
	newPipe dut(.*);
	
		 // Set up a simulated clock.
	parameter CLOCK_PERIOD=100;
	initial begin
	clk <= 0;
	forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock
	end
	
	 // Set up the inputs to the design. Each line is a clock cycle.
	initial begin
		@(posedge clk);
		reset <= 1; @(posedge clk);
		reset <= 0; gameOver <= 0;  @(posedge clk);
		repeat(10) begin
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		slow_clk <= 1; @(posedge clk);
		slow_clk <= 0; @(posedge clk);
		end
		gameOver <= 1;  @(posedge clk); 
		@(posedge clk);
		reset <= 1; @(posedge clk);
		reset <= 0; gameOver <= 0;  @(posedge clk);
		@(posedge clk);
		$stop; // End the simulation.
	end
endmodule
	
