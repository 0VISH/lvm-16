`include "src/basic/mux4way16.v"
`include "src/basic/mux2way16.v"

module mux8way16(
	output wire[15:0] out,
	input wire[15:0] inp1,
	input wire[15:0] inp2,
	input wire[15:0] inp3,
	input wire[15:0] inp4,
	input wire[15:0] inp5,
	input wire[15:0] inp6,
	input wire[15:0] inp7,
	input wire[15:0] inp8,
	input wire[2:0] lines
);

wire [1:0] line1 = lines[2:1];
wire line2 = lines[2];
wire [15:0] out1;
wire [15:0] out2;

mux4way16 mux4o(.out(out1), .inp1(inp1), .inp2(inp2), .inp3(inp3), .inp4(inp4), .line(line1));
mux4way16 mux4t(.out(out2), .inp1(inp5), .inp2(inp6), .inp3(inp7), .inp4(inp8), .line(line1));
mux2way16 mux2(.out(out), .inp1(out1), .inp2(out2), .line(line2));

endmodule;
