module seg7loser (lose, leds);
// displays an L on the hex Display
	input logic  lose;
	output logic [6:0] leds;

	always_comb begin
		if (lose) 	leds = ~7'b0111000; // L
		else			leds = ~7'b0000000;
	end
endmodule

