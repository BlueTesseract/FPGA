module enc2(output n, v, input i1, i2);
	or o1(v, i1, i2);
	xor xor1(n, i1, v);
endmodule

module enc4(output o1, o2, v, input i1, i2, i3, i4);
	wire e1o, e1v, e2o, e2v, l, r, olr;
	enc2 e1(e1o, e1v, i1, i2);
	enc2 e2(e2o, e2v, i3, i4);
	or or1(v, e1v, e2v);
	not not1(o2, e1v);
	and and1(l, e1v, e1o);
	and and1(r, o2, e2o);
	or or1(o1, l, r);
endmodule

module testbench;
	reg i1, i2, i3, i4;
	wire o1, o2, v;
	enc4 e4(o1, o2, v, i1, i2, i3, i4);
	initial begin
		i1 = 0; i2 = 0; i3 = 0; i4 = 0; #1;
		i1 = 0; i2 = 0; i3 = 0; i4 = 1; #1;
		i1 = 0; i2 = 0; i3 = 1; i4 = 0; #1;
		i1 = 0; i2 = 0; i3 = 1; i4 = 1; #1;
		i1 = 0; i2 = 1; i3 = 0; i4 = 0; #1;
		i1 = 0; i2 = 1; i3 = 0; i4 = 1; #1;
		i1 = 0; i2 = 1; i3 = 1; i4 = 0; #1;
		i1 = 0; i2 = 1; i3 = 1; i4 = 1; #1;
		i1 = 1; i2 = 0; i3 = 0; i4 = 0; #1;
		i1 = 1; i2 = 0; i3 = 0; i4 = 1; #1;
		i1 = 1; i2 = 0; i3 = 1; i4 = 0; #1;
		i1 = 1; i2 = 0; i3 = 1; i4 = 1; #1;
		i1 = 1; i2 = 1; i3 = 0; i4 = 0; #1;
		i1 = 1; i2 = 1; i3 = 0; i4 = 1; #1;
		i1 = 1; i2 = 1; i3 = 1; i4 = 0; #1;
		i1 = 1; i2 = 1; i3 = 1; i4 = 1; #1;
		#1 $finish;
	end
	initial $monitor($time, " %d%d%d%d out=%d%d valid=%d", i4, i3, i2, i1, o2, o1, v);
endmodule
