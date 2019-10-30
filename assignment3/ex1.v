module seconds(output reg [7:0] out, output reg min, input clk);
	reg [7:0]t;
	initial out = 0;
	initial t = 0;
	always @(posedge clk) begin
		t = (t + 1);
		if (t == 60)
			begin
				min = 1;
				t = 0;
			end
		else
			min <= 0;
		out[3:0] <= t%10;
		out[7:4] <= t/10;
	end
endmodule

module minutes(output reg [4*(D)-1:0] min, input inc);
	parameter D = 2;
	reg [4*D-1:0] t;
	initial min = 0;
	initial t = 0;
	always @(posedge inc) begin
		t = t + 1;
		min[3:0] = t%10;
		min[7:4] = (t/10)%10;
	end
endmodule

module testbench;
	wire [7:0] s;
	wire m;
	wire [7:0] m0;
	reg clk;
	always begin
		#1 clk = 0;
		#1 clk = 1;
	end
	seconds sec(s, m, clk);
	minutes min(m0, m);
	initial $monitor("%b %b:%b %b", m0[7:4], m0[3:0], s[7:4], s[3:0]);
endmodule
