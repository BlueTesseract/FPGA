module pwm(output reg [0:0] out, input [7:0] p, input clk);
	reg [31:0] counter;
	initial counter = 0;
	
	always @ (posedge clk) begin
		counter <= counter + 1;
		if (counter >= 255) begin
			counter <= 0;
		end
		else begin
			if (counter >= p)
				out <= 0;
			else
				out <= 1;
		end
	end
endmodule


module DE1_SOC(

	//////////// CLOCK //////////
	input 		          		CLOCK2_50,
	input 		          		CLOCK3_50,
	input 		          		CLOCK4_50,
	input 		          		CLOCK_50,

	//////////// SEG7 //////////
	output		     [6:0]		HEX0,
	output		     [6:0]		HEX1,
	output		     [6:0]		HEX2,
	output		     [6:0]		HEX3,
	output		     [6:0]		HEX4,
	output		     [6:0]		HEX5,

	//////////// KEY //////////
	input 		     [3:0]		KEY,

	//////////// LED //////////
	output		     [9:0]		LEDR,

	//////////// SW //////////
	input 		     [9:0]		SW
);
	wire o;
	pwm p(o, SW[7:0], CLOCK_50);
	assign LEDR[7:0] = SW[7:0];
	assign LEDR[9] = o;

endmodule
