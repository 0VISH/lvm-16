`include "cpu/basic/selector.v"
`include "cpu/mmu/register.v"
`include "cpu/basic/mux4way16.v"
`include "cpu/alu/alu.v"

module cpu(output [15:0] out, output [15:0] pc, output [15:0] addr, output write, input [15:0] instruction, input [15:0] data, input reset);

wire x = instruction[15];
wire y = instruction[14];
wire zx = instruction[7];
wire nx = instruction[6];
wire zy = instruction[5];
wire ny = instruction[4];
wire f = instruction[3];
wire no = instruction[2];
wire [1:0] E = instruction[9:8];
wire [1:0] D = instruction[11:10];
wire [1:0] F = instruction[13:12];
wire A = (~x&y) | (x&~y);
wire B = x & y;
wire H = ~x & y;
wire [15:0] selectData;
wire [15:0] r0Out, r1Out, r2Out;
wire [15:0] regRBus1;
wire [15:0] regRBus2;

assign selectData = data;
register r0(.curState(r0Out), .d(selectData), .enable(r0En));
register r1(.curState(r1Out), .d(selectData), .enable(r1En));
register r2(.curState(r2Out), .d(selectData), .enable(r2En));
selector regWSelctor(.enable(A), .line(F), .o2(r0En), .o3(r1En), .o4(r2En));
mux4way16 regRSelctor1(.out(regRBus1), .inp2(r0Out), .inp3(r1Out), .inp4(r2Out), .line(D));
mux4way16 regRSelctor2(.out(regRBus2), .inp2(r0Out), .inp3(r1Out), .inp4(r2Out), .line(E));
alu aluChip(.out(out), .enable(B), .zx(zx), .nx(nx), .zy(zy), .ny(ny), .f(f), .no(no), .x(regRBus1), .y(regRBus2));

endmodule
