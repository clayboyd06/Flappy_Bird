module comparator10(A, B, out);
	// compares two 10-bit numbers A, B, and outputs 1 if A > B
	//  and false otherwise
	input logic [9:0] A, B;
	output logic out;
	/*
	always_comb begin
		if (A[9] > B[9]) begin
			out = 1'b1;
		end else if (A[9] > B[9]) begin
			out = 1'b1;
		end else if (A[8] > B[8]) begin
			out = 1'b1;
		end else if (A[7] > B[7]) begin
			out = 1'b1;
		end else if (A[6] > B[6]) begin
			out = 1'b1;
		end else if (A[5] > B[5]) begin
			out = 1'b1;
		end else if (A[4] > B[4]) begin
			out = 1'b1;
		end else if (A[3] > B[3]) begin
			out = 1'b1;
		end else if (A[2] > B[2]) begin
			out = 1'b1;
		end else if (A[1] > B[1]) begin
			out = 1'b1;
		end else if (A[0] > B[0]) begin
			out = 1'b1;
		end else begin
			out = 1'b0;
		end
	end*/
	
	assign out = A > B;
endmodule


module comparator10_testbench();
	logic [9:0] A, B;
	logic out;
	
	comparator10 dut(.*);
	
	initial begin
		A = 10'b0001010011; B = 10'b0010000000; #10;
		A = 10'b0011010011; B = 10'b0010000000; #10;
		A = 10'b1000010011; B = 10'b0010000000; #10;
		A = 10'b0000000001; B = 10'b0000000001; #10;
		A = 10'b0000000001; B = 10'b0000000011; #10;
		A = 10'b0000000101; B = 10'b0000000001; #10;
	end
endmodule
			
	