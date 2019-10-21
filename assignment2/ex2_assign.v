module enc2(output [0:0] n, v, input [1:0] i);
	assign v = |i;
	assign n = i[0] ^ v;
endmodule

module enc4(output [1:0] o, output [0:0] v, input [3:0] i);
	wire e1o, e1v, e2o, e2v, l, r, olr;
	enc2 e1(e1o, e1v, i[1:0]);
	enc2 e2(e2o, e2v, i[3:2]);
	assign v = e1v || e2v;
	assign o[1] = ~e1v;
	assign o[0] = (e1v && e1o) || (o[1] && e2o);
endmodule

module testbench;
	reg [3:0] i;
	wire [1:0] o;
	wire [0:0] v;
	enc4 e4(o, v, i);
	initial begin
		i = 0;
		repeat(16) begin
			#1;
			$display("%d. in=%b, v=%b, o=%d", i, i, v, o);
			i = i + 1;
		end
	end
endmodule
