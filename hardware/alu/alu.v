`include "hardware/alu/add16.v"
`include "hardware/basic/mux2way16.v"
`include "hardware/basic/not16.v"
`include "hardware/basic/and16.v"

module alu(output [15:0] out, input enable, input zx, nx, zy, ny, f, no, input wire [15:0] x, input wire [15:0] y);

wire [15:0] ozx;
mux2way16 mzx(ozx, x, 16'b0, zx);

wire [15:0] nxcalc;
not16 nnx(nxcalc, ozx);
wire [15:0] onx;
mux2way16 mnx(onx, ozx, nxcalc, nx);

wire [15:0] ozy;
mux2way16 mzy(ozy, y, 16'b0, zy);

wire [15:0] nycalc;
not16 nny(nycalc, ozy);
wire [15:0] ony;
mux2way16 mny(ony, ozy, nycalc, ny);

wire [15:0] oandxy;
and16 andxy(oandxy, onx, ony);

wire [15:0] oplusxy;
add16 addxy(oplusxy, onx, ony);

wire [15:0] of;
mux2way16 mf(of, oandxy, oplusxy, f);

wire [15:0] nocalc;
wire [15:0] tempOut;
not16 nno(nocalc, of);
mux2way16 mno(tempOut, of, nocalc, no);

assign out = {16{enable}} & tempOut;

endmodule;
