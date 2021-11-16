module metaFilter(clk, key, out); 
	input logic clk ;
	input logic key;
	output logic out;
	
	logic temp1;
	
	always_ff @(posedge clk) begin
		temp1 <= key;
		out <= temp1;
	end
endmodule 