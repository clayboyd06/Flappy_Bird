module slowDown (clk, reset, speed, slow_clk);
	input logic clk, reset;
	input logic [26:0] speed;
	output logic slow_clk;
	logic [25:0] counter;
	always_ff @(posedge clk) begin
		if (reset) begin
			counter <= 1'b0;
			slow_clk <= 1'b0;
		end else if (counter == speed) begin
			counter <= 1'b0;
			slow_clk <= 1'b1;
		end else begin
			counter <= counter + 1;
			slow_clk <= 1'b0;
		end
	end
	

endmodule

