module pointCounter(clk, reset, gameOver, upCount, totalCount);
	// controls all of the Hex displays for the counter
	input logic 			clk, reset;
	input logic 		 	gameOver, point;
	
	logic [9:0] count
	
	enum {run, done} ps, ns;
	
	always_comb begin
		case(ps)
			
			run:		if (count <= 0'b1111100111) || (gameOver) begin
							ns = done;
						end else begin
							ns = run;
						end
						
			done:		begin
							ns = done;
						end
		endcase
	end
	
	always_ff @(posedge clk) begin
		if (reset) begin
			ps <= run;
		end else begin
			ps <= ns;
		end
	end
	

	always_ff @(posedge clk) begin
		if (reset) begin
			count <= 3'b000;
		end else if ((ps == run) && (point)) begin
			count2 <= count2 + 0'b0000000001;
		end else begin
			count1 <= count1;
			count2 <= count2;
		end
	end
endmodule 


module winCounter_testbench();
	logic clk, reset;
	logic [1:0] gameOver; 
	
	logic [2:0] count1, count2;
	logic stop;
	
	winCounter dut (.*); 
	
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
		reset <= 0; gameOver <= 2'b00;@(posedge clk);
		repeat(1) begin
		reset <= 0; gameOver <= 2'b10;@(posedge clk);
		end 
		repeat(2) begin
		reset <= 0; gameOver <= 2'b01;@(posedge clk);
		end 
		repeat(3) begin
		reset <= 0; gameOver <= 2'b10;@(posedge clk);
		end 
		repeat(4) begin
		reset <= 0; gameOver <= 2'b01;@(posedge clk);
		end 
		repeat(5) begin
		reset <= 0; gameOver <= 2'b10;@(posedge clk);
		end 
		repeat(6) begin
		reset <= 0; gameOver <= 2'b01;@(posedge clk);
		end 
		repeat(7) begin
		reset <= 0; gameOver <= 2'b10;@(posedge clk);
		end 
		repeat(8) begin
		reset <= 0; gameOver <= 2'b01;@(posedge clk);
		end 
		$stop;
	end
endmodule 
		
		
	