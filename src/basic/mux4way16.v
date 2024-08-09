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
