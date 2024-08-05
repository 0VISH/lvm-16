module mux4way16(
	output wire [15:0] out,
	input wire [15:0] inp1,
	input wire [15:0] inp2,
	input wire [15:0] inp3, 
	input wire [15:0] inp4,
	input wire [1:0] line);

wire [15:0] line1 = {16{line[0]}};
wire [15:0] line2 = {16{line[1]}};

assign out = (~line1 & ~line2 & inp1) + (line1 & ~line2 & inp2) + 
	     (~line1 & line2 & inp3) + (line1 & line2 & inp4);

endmodule;


module test_mux4way16();

wire [15:0] o;
reg [15:0] inpo;
reg [15:0] inpt;
reg [15:0] inpth;
reg [15:0] inpf;
reg [1:0] l;

mux4way16 mu(.out(o), .inp1(inpo), .inp2(inpt), .inp3(inpth), .inp4(inpf), .line(l));

initial begin
	inpo = 16'b0;
	inpt = 16'b1111111111111111;
	inpth = 16'b0101010101010101;
	inpf = 16'b0000000011111111;
	$display("inp1: %b\ninp2: %b\ninp3: %b\ninp4: %b", inpo, inpt, inpth, inpf);
	$display("Time\t line\t output");
	$monitor("%0t\t %b\t %b", $time, l, o);
	l = 2'b00;
	#10;
	l = 2'b01;
	#10;
	l = 2'b10;
	#10;
	l = 2'b11;
	#10;
	$finish;
end;

endmodule;
