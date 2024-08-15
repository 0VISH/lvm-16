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
wire A = (~x&y) | (x&y);
wire B = x & y;
wire [15:0] selectData;
wire [15:0] r1Out, r2Out, r3Out;
wire [15:0] regRBus1;
wire [15:0] regRBus2;

mux2way16 dataSelector(.out(selectData), .inp1(data), .inp2(out), .line(B));
register r1(.curState(r1Out), .d(selectData), .enable(r1En));
register r2(.curState(r2Out), .d(selectData), .enable(r2En));
register r3(.curState(r3Out), .d(selectData), .enable(r3En));
selector regWSelctor(.enable(A), .line(F), .o2(r1En), .o3(r2En), .o4(r3En));
mux4way16 regRSelctor1(.out(regRBus1), .inp2(r1Out), .inp3(r2Out), .inp4(r3Out), .line(D));
mux4way16 regRSelctor2(.out(regRBus2), .inp2(r1Out), .inp3(r2Out), .inp4(r3Out), .line(E));
alu aluChip(.out(out), .enable(B), .zx(zx), .nx(nx), .zy(zy), .ny(ny), .f(f), .no(no), .x(regRBus1), .y(regRBus2));

endmodule
