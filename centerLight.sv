module centerLight (clk, reset, gameOver, enable, up, above, below, lightOn);
	input logic clk, reset;
	// up is true when key is pressed
	// above is true when the light on the above is on, and below
	// is true when the light below is on.
	input logic gameOver, enable, up, above, below;
	// when lightOn is true, the center light should be on.
	output logic lightOn;

	enum logic {on, off} ps, ns;
																												//added an enable feature based off counter in birdlight
	always_comb begin
		case (ps)
			on:	if (up) begin
						ns = off;
						lightOn = 1'b1;
					end else	begin
						ns = off;
						lightOn = 1'b1;
					end
					
					
			off:  if ((below && up) || (above && ~up)) begin
						ns = on;
						lightOn = 1'b0;
					end else	begin
						ns = off;
						lightOn = 1'b0;
					end
					
		endcase
	end


	 always_ff @(posedge clk) begin
		if (reset) begin
			ps <= on;
		end else if (enable) begin
			if(gameOver) begin
				ps <= ps;
			end else begin
				ps <= ns;
			end
		end
	 end
endmodule

module centerLight_testbench();
	logic clk, reset;
	logic gameOver, enable, up, above, below, lightOn;
	
	centerLight dut(.*);
	
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
		reset <= 0; up <= 0; above=0; below=0; @(posedge clk);
		@(posedge clk);
		@(posedge clk);
		up <= 1; above = 0; below = 0; @(posedge clk); 
		@(posedge clk);
		up <= 1; above = 0; below = 1; @(posedge clk); 
		 @(posedge clk);
		 @(posedge clk);
		reset<=1; @(posedge clk);
		$stop; // End the simulation.
	end
endmodule
	