primitive d_flipflop(out, clk, d);
	output out;
	input clk, d;
	reg out;
	table
		(01) 0   : ? : 0;
		(01) 1   : ? : 1;
		(1?) ?   : ? : -;
		(?0) ?   : ? : -;
		 ?  (??) : ? : -;
	endtable
endprimitive

module mux(output o, input a1, a2, a, b, c, d);
	assign o =	(a1 == 0 && a2 == 0) ? a :
			(a1 == 1 && a2 == 0) ? b :
			(a1 == 0 && a2 == 1) ? c :
			(a1 == 1 && a2 == 1) ? d : 0;
endmodule

module jk(output o, input clk, j, k);
	wire od1, od2, nod1;
	d_flipflop d1(od1, clk, o);
	not not1(nod1, od1);
	d_flipflop d2(od2,  clk, j);
	mux m1(o, k, j, od1, od2, od2, nod1);
endmodule

module testbench;
	reg clk, j, k;
	wire o;
	jk jk1(o, clk, j, k);
	initial begin
		j = 0;
		k = 0;
		clk = 0;
		#1 clk = 1;
		#1 clk = 0;
		j = 1;
		k = 0;
		#1 clk = 1;
		#1 clk = 0;
		j = 0;
		k = 1;
		#1 clk = 1;
		#1 clk = 0;
		j = 1;
		k = 1;
		#1 clk = 1;
		#1 clk = 0;
		#1 clk = 1;
		#1 clk = 0;
		#1 $finish;
	end
	initial $monitor($time, " clk=%d, j=%d, k=%d, out=%d", clk, j, k, o);
endmodule
