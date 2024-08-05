module mux2way16(output wire [15:0] out, input wire [15:0] inp1, input wire [15:0] inp2, input wire line);

assign out = (~{16{line}} & inp1) | ({16{line}} & inp2);

endmodule;


module test_mux2way16();

wire [15:0] o;
reg [15:0] inpo;
reg [15:0] inpt;
reg l;

mux2way16 mu(.out(o), .inp1(inpo), .inp2(inpt), .line(l));

initial begin
	$display("Time\t inp1\t inp2\t line\t output");
	$monitor("%0t\t %b\t %b\t %b\t %b", $time, inpo, inpt, l, o);
	inpo = 16'b0;
	inpt = 16'b1111111111111111;
	l = 0;
	#10;
	l = 1;
	#10;
	$finish;
end;

endmodule;
