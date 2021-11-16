// a hex value 0-9 for a single hex display
// increments its hex value by 1 (decimal) when upcount is true
module carCounter(clk, reset, upCount, hex, nextHex);
	input logic clk, reset;
	input logic upCount;
	
	output logic [6:0] hex;
	output logic nextHex;

	
	enum {zero, one, two, three, four, five, six, seven, eight, nine} ps, ns;
	
	always_comb begin
		if (upCount) begin
			case(ps)
				zero: begin
					ns = one;
					hex = ~7'b0111111; // 0
					nextHex =0;
				end one: begin
					ns = two;
					hex = ~7'b0000110; // 1
					nextHex =0;
				end two: begin
					ns = three;
					hex = ~7'b1011011; // 2
					nextHex =0;
				end three: begin
					ns = four;
					hex = ~7'b1001111; // 3
					nextHex =0;
				end four: begin
					ns = five;
					hex = ~7'b1100110; // 4
					nextHex =0;
				end five: begin
					ns = six;
					hex = ~7'b1101101; // 5
					nextHex =0;
				end six: begin
					ns = seven;
					hex = ~7'b1111101; // 6
					nextHex =0;
				end seven: begin
					ns = eight;
					hex = ~7'b0000111; // 7
					nextHex =0;
				end eight: begin		
					ns = nine;
					hex = ~7'b1111111; // 8
					nextHex =0;
				end nine: begin		
					ns = zero;
					hex = ~7'b1101111; // 9
					nextHex = 1; 
				end default: begin
					ns = one;
					hex = ~7'b0111111; // 0
					nextHex =0;
				end
			endcase
		end else begin 
			case(ps) 
					zero: begin
					ns = zero;
					hex = ~7'b0111111; // 0
					nextHex =0;
				end one: begin
					ns = one;
					hex = ~7'b0000110; // 1
					nextHex =0;
				end two: begin
					ns = two;
					hex = ~7'b1011011; // 2
					nextHex =0;
				end three: begin
					ns = three;
					hex = ~7'b1001111; // 3
					nextHex =0;
				end four: begin
					ns = four;
					hex = ~7'b1100110; // 4
					nextHex =0;
				end five: begin
					ns = five;
					hex = ~7'b1101101; // 5
					nextHex =0;
				end six: begin
					ns = six;
					hex = ~7'b1111101; // 6
					nextHex =0;
				end seven: begin
					ns = seven;
					hex = ~7'b0000111; // 7
					nextHex =0;
				end eight: begin		
					ns = eight;
					hex = ~7'b1111111; // 8
					nextHex =0;
				end nine: begin		
					ns = nine;
					hex = ~7'b1101111; // 9
					nextHex = 0; 
				end default: begin
					ns = one;
					hex = ~7'b0111111; // 0
					nextHex =0;
				end
			endcase
		end
	end
	
	always_ff @(posedge clk) begin
		if (reset) begin
			ps <= zero;
		end else begin
			ps <= ns;
		end
		
	end
endmodule	
	

module carCounter_testbench();
	logic clk, reset;
	logic upCount;
	
	logic [6:0] hex;
	logic nextHex;
	
	pointDisplay dut(.*);
	
		parameter CLOCK_PERIOD=100;
	initial begin
	clk <= 0;
	forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock
	end
	
	 // Set up the inputs to the design. Each line is a clock cycle.
	initial begin
		reset <= 1; @(posedge clk);
		reset <= 0; @(posedge clk);
		repeat(12) begin
			upCount <= 1; @(posedge clk);
			upCount <= 0; @(posedge clk);
		end
		$stop;
	end
endmodule
	
			