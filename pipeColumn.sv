module pipeColumn(clk, reset, gameOver, slow_clk, oldPipe, currentPipe);
	input logic clk, reset;
	input logic gameOver, slow_clk;
	input logic [14:0] oldPipe;
	
	output logic [14:0] currentPipe; 
	
	logic [14:0] ps, ns;
	logic holdClk;
	
	logic [9:0] counter2;
	logic move;
	
	
	always_ff @(posedge clk) begin
		if (reset) begin
			counter2 <= 3'd7;
			move <= 1'b0;
		end else if (counter2 == 175) begin 		// for board
		//end else if (counter2 == 8) begin			// for sim
			counter2 <= 'b0;
			move <= 1'b1;
		end else begin
			counter2 <= counter2 + 1'b1;
			move <= 1'b0;
		end
	end
	
	always_comb begin
		if (gameOver) begin
			ns = ps;	
		end else begin
			ns = oldPipe;
		end 
	end
	
	assign currentPipe = ps;
	
	always_ff@(posedge clk) begin
		if (reset) begin
			ps <= 15'b0000000000000000;
		end else if (move) begin
			if (gameOver) begin
				ps <= ps;
			end else begin
				ps <= ns;
			end
		end
	end
endmodule

module pipeColumn_testbench();
	logic clk, reset;
	logic gameOver, slow_clk;
	logic [14:0] oldPipe;
	logic [14:0] currentPipe; 
	
	pipeColumn dut(.*);
	
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
		oldPipe = 15'b111111111000011; @(posedge clk);
		oldPipe = 15'b000000000000000; @(posedge clk);
		oldPipe = 15'b111110000111111; @(posedge clk);
		oldPipe = 15'b000000000000000; @(posedge clk);
		oldPipe = 15'b111000011111111; @(posedge clk);
		gameOver <= 1;  @(posedge clk); 
		@(posedge clk);
		reset <= 1; @(posedge clk);
		reset <= 0; gameOver <= 0;  @(posedge clk);
		@(posedge clk);
		$stop; // End the simulation.
	end
endmodule