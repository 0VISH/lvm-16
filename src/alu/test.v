`include "src/alu/add16.v"

module test();

wire [15:0] out;
reg [15:0] in1;
reg [15:0] in2;

wire su;
wire carr;
reg aa;
reg bb;
reg cc;

fullAdder fa(.sum(su), .carry(carr), .a(aa), .b(bb), .c(cc));
add16 add(.out(out), .in1(in1), .in2(in2));

initial begin
	$display("-----[ADD]-----");
	$display("Time\t inp1\t inp2\t out\t");
	$monitor("%0t\t %b(%d)\t %b(%d)\t %b(%d)\t", $time, in1, in1, in2, in2, out, out);
	in1 = 16'd2;
	in2 = 16'd2; 
	#100;
	in1 = 16'd10;
	in2 = 16'd5;
	#100;
	in1 = 16'd100;
	in2 = 16'd69;
	#100;
	$display("-----[FULL_ADDER]-----");
	$display("Time\t a\t b\t c\t sum\t carry");
	$monitor("%0t\t %b\t %b\t %b\t %b\t %b", $time, aa, bb, cc, su, carr);
	aa = 1'b0;
	bb = 1'b0;
	cc = 1'b0;
	#100;
	aa = 1'b0;
	bb = 1'b0;
	cc = 1'b1;
	#100;
	aa = 1'b0;
	bb = 1'b1;
	cc = 1'b0;
	#100;
	aa = 1'b0;
	bb = 1'b1;
	cc = 1'b1;
	#100;
	aa = 1'b1;
	bb = 1'b0;
	cc = 1'b0;
	#100;
	aa = 1'b1;
	bb = 1'b0;
	cc = 1'b1;
	#10;
	aa = 1'b1;
	bb = 1'b1;
	cc = 1'b0;
	#10;
	aa = 1'b1;
	bb = 1'b1;
	cc = 1'b1;
	#10;

	$finish;
end

endmodule;
