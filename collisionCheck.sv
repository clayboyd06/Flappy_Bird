module collisionCheck(clk, reset, birdloc, column3, point, loser);
	input logic clk, reset;
	input logic [14:0] birdloc, column3; 
	
	output logic point, loser;
	logic [14:0] crash;
	logic [9:0] counter2;
	logic move;

	
	//If pipe is in column 13
	//AND pipe opening include bird location
	//THEN increment point
	//ELSE gameover
	always_ff @(posedge clk) begin
		if (reset) begin
			counter2 <= 3'd7;
			move <= 1'b0;
		end else if (counter2 == 175) begin		// for board 
		//end else if (counter2 == 8) begin // for simulation
			counter2 <= 'b0;
			move <= 1'b1;
		end else begin
			counter2 <= counter2 + 1;
			move <= 1'b0;
		end
	end
	
	
	
	
	always_ff @(posedge clk) begin
		if (reset) begin
			loser <= 0;
			point <= 0;
		end else if ((column3 != 0)) begin
			if ((birdloc & column3) == 0) begin
				loser <= 0;
				if (move) begin
					point <= 1;
				end else begin
					point <=0;
				end
			end else begin
				loser <= 1;
				point <= 0;
			end
		end else begin
			loser <= loser;
			point <= 0;
		end
	end
		
	/*
	always_comb begin
		if (birdloc[0] && column3[0] || birdloc[1] && column3[1] ||
						 birdloc[2] && column3[2] || birdloc[3] && column3[3] ||
						 birdloc[4] && column3[4] || birdloc[5] && column3[5] ||
						 birdloc[6] && column3[6] || birdloc[7] && column3[7] ||
						 birdloc[8] && column3[8] || birdloc[9] && column3[9] ||
						 birdloc[10] && column3[10] || birdloc[11] && column3[11] ||
						 birdloc[12] && column3[12] || birdloc[13] && column3[13] ||
						 birdloc[14] && column3[14]) begin
			loser = 1;
			point = 0;
		end else if (~(column3 == 15'b0) ) begin
			loser = 0;
			point = 1; 
		end else begin
			loser = 0;
			point = 0;
		end
	end
	*/
endmodule

module collisionCheck_testbench();
   logic [14:0] birdloc, column3;
	logic clk, reset;
	logic [4:0] counter2;
	logic move;
	
	logic point, loser;
	
	collisionCheck dut(.*);
	
	initial begin
		birdloc = 15'b00000100000000; column3 = 15'b111111100001111; #10;
		birdloc = 15'b00000100000000; column3 = 15'b111000011111111; #10;
		birdloc = 15'b00000000000100; column3 = 15'b110000111111111; #10;
		birdloc = 15'b00010000000000; column3 = 15'b111000011111111; #10;
		birdloc = 15'b00010000000000; column3 = 15'b0; #10;
		birdloc = 15'b00001000000000; column3 = 15'b111000011111111; #10;
	end
endmodule 