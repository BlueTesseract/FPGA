module enc2(output [0:0] n, v, input [1:0] i);
	assign v = |i;
	assign n = i[0] ^ v;
endmodule

module encX(output [2**(i_len-1)-1:0] o, output [0:0] v, input [2**(i_len)-1:0] in);
	parameter i_len = 3;
	wire [2**(i_len-1)-1:0] eo, ev, av;
	genvar i;
	genvar j;
	generate
		for (i = 0; i < 2**(i_len-1); i = i + 1) begin : gen_enc
			enc2 e(eo[i], ev[i], in[i*2+1:i*2]);
			if (i == 0)
				or or1(av[i], ev[i], ev[i]);
			else
				and and1(av[i], ev[i], ev[i-1]);
		end
	endgenerate

	assign o = 6;

	assign v = |ev;
endmodule

module testbench;
	parameter word_len = 3;
	wire [2**(word_len-1)-1:0] out;
	wire [0:0] v;
	reg [2**(word_len)-1:0] in;
	encX #(.i_len(word_len)) e(out, v, in);
	initial begin
		in = 0;
		repeat(2**(word_len)) begin
			#1;
			$display("in=%b v=%b, o=%d", in, v, out);
			in = in + 1;
		end
			in = 0;
			#1;
			$display("in=%b v=%b, o=%d", in, v, out);
		$finish;
	end
endmodule
