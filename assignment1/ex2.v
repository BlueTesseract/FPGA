primitive t_flipflop(out, clk, rst, en);
	output out;
	input clk, rst, en;
	reg out;
	table
		 ?   1  ? : ? : 0;

		(01) 0  0 : ? : -;
		(01) 0  1 : 0 : 1;
		(01) 0  1 : 1 : 0;
		(?0) ?  ? : ? : -;
		 ?  (??) ? : ? : -;
		 ?  ?  (??) : ? : -;
	endtable
endprimitive

module testbench;
	reg clk, rst, en;
	wire o;
	t_flipflop t1(o, clk, rst, en);
	initial begin
		#1 rst = 1; #1 en =0;
		#1 clk = 0; #1 clk = 1;
		#1 rst = 0; #1 en = 1;
		#1 clk = 0; #1 clk = 1;
		#1 clk = 0; #1 clk = 1;
		#1 rst = 0; #1 en = 0;
		#1 clk = 0; #1 clk = 1;
		#1 clk = 0; #1 clk = 1;
		#1 $finish;
	end
	initial $monitor($time, " clk=%d, rst=%d, en=%d, out=%d", clk, rst, en, o);
endmodule
