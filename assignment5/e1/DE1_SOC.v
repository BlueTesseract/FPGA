module ram_single(
	output reg [7:0] out_data,
	input [9:0]	address,
	input [7:0] in_data,
	input in_mode, clk
);
	reg [7:0] mem[1023:0];
	always @(posedge clk) begin
		if (in_mode)
			mem[address] <= in_data;
		out_data <= mem[address];
	end
endmodule

module display_byte(output [6:0] d1, d2, input [3:0] hb1, hb2);
	reg [6:0] digit[15:0];
	initial begin
		digit[0] = 'h3F; digit[1] = 'h6; digit[2] = 'h5B;
		digit[3] = 'h4F; digit[4] = 'h66; digit[5] = 'h6D;
		digit[6] = 'h7D; digit[7] = 'h7; digit[8] = 'h7F;
		digit[9] = 'h6F; digit[10] = 'h77; digit[11] = 'h7E;
		digit[12] = 'h39; digit[13] = 'h3E; digit[14] = 'h79;
		digit[15] = 'h71;
	end
	assign d1 = ~digit[hb1];
	assign d2 = ~digit[hb2];
endmodule

module DE1_SOC(

	//////////// CLOCK //////////
	input 		          		CLOCK2_50,
	input 		          		CLOCK3_50,
	input 		          		CLOCK4_50,
	input 		          		CLOCK_50,

	//////////// SDRAM //////////
	output		    [12:0]		DRAM_ADDR,
	output		     [1:0]		DRAM_BA,
	output		          		DRAM_CAS_N,
	output		          		DRAM_CKE,
	output		          		DRAM_CLK,
	output		          		DRAM_CS_N,
	inout 		    [15:0]		DRAM_DQ,
	output		          		DRAM_LDQM,
	output		          		DRAM_RAS_N,
	output		          		DRAM_UDQM,
	output		          		DRAM_WE_N,


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
	reg [9:0] address;
	wire plus = KEY[0];
	wire minus = KEY[1];
	wire store_address = KEY[2];
	wire store_sw = KEY[3];
	wire [7:0] mem_out;
	reg [7:0] mem_in;
	reg in_mode;

	

	initial begin
		address = 5;
		in_mode = 0;
	end
	display_byte address_display(HEX0, HEX1, address[3:0], address[7:4]);
	assign LEDR[9:8] = address[9:8];
	display_byte sw_display(HEX4, HEX5, SW[3:0], SW[7:4]);
	ram_single ram_mem(mem_out, address, mem_in, in_mode, CLOCK_50);
	display_byte data_display(HEX2, HEX3, mem_out[3:0], mem_out[7:4]);
	
	always @(negedge plus or negedge minus or negedge store_address) begin
			if (~plus)
				address <= address + 1;
			else if (~minus)
				address <= address - 1;
			else if (~store_address)
				address <= SW;
	end

	always @(posedge CLOCK_50) begin
		in_mode <= ~store_sw;
	end
	always @(negedge store_sw) begin
		mem_in <= SW[7:0];
	end
	
	
endmodule
