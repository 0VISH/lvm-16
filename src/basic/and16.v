module and16(output wire [15:0] out, input [15:0] in1, input [15:0] in2);

genvar i;
generate
	for(i=0; i<16; i=i+1) begin
		assign out[i] = in1[i] & in2[i];
	end
endgenerate

endmodule;


module test();

reg [15:0] ino;
reg [15:0] intw;
wire [15:0] o;

and16 an(.out(o), .in1(ino), .in2(intw));

initial begin
	$display("Time\t in1\t in2\t out");
	$monitor("%0t\t %b\t %b\t %b\t", $time, ino, intw, o);
	ino = 16'b0;
	intw = 16'b1111111111111111;
	#10;
	ino =  16'b1111111111111111;
	intw = 16'b0000000011111111;
	#10;
	$finish;
end;

endmodule;
