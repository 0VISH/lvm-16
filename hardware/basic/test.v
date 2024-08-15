`include "src/basic/mux4way16.v"
`include "src/basic/mux2way16.v"

module test_mux();

wire [15:0] o4;
wire [15:0] o2;
reg [15:0] inpo;
reg [15:0] inpt;
reg [15:0] inpth;
reg [15:0] inpf;
reg [1:0] l4;
reg l2;

mux4way16 mu4(.out(o4), .inp1(inpo), .inp2(inpt), .inp3(inpth), .inp4(inpf), .line(l4));
mux2way16 mu2(.out(o2), .inp1(inpo), .inp2(inpt), .line(l2));

initial begin
	inpo = 16'b0;
	inpt = 16'b1111111111111111;
	inpth = 16'b0101010101010101;
	inpf = 16'b0000000011111111;
	$display("inp1: %b\ninp2: %b\ninp3: %b\ninp4: %b", inpo, inpt, inpth, inpf);
	$display("-----[MUX4WAY]-----");
	$display("Time\t line\t output");
	$monitor("%0t\t %b\t %b", $time, l4, o4);
	l4 = 2'b00;
	#100;
	l4 = 2'b01;
	#100;
	l4 = 2'b10;
	#100;
	l4 = 2'b11;
	#100;
	$display("-----[MUX2WAY]-----");
	$display("Time\t line\t output");
	$monitor("%0t\t %b\t %b", $time, l2, o2);
	inpo = 16'b0;
	inpt = 16'b1111111111111111;
	l2 = 0;
	#100;
	l2 = 1;
	#100;
	$finish;
end;

endmodule;
