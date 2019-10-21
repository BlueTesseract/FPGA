module parity_bit (output parity_bit, input [0:word_len] w);
	parameter word_len = 8;
	assign parity_bit =^ w;
endmodule


module testbench;
	reg [0:8] w, n;
	wire o;
	parity_bit pb(o, w);
	initial begin
		n = 0;
		w = 0;
		repeat(64) begin
			$display("%d. in=%b, pb=%b", n, w, o);
			n = n + 1;
			w = n ^ (n >> 1);
		end
	end
endmodule
