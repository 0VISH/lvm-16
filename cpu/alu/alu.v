`include "src/alu/add16.v"
`include "src/basic/mux2way16.v"
`include "src/basic/not16.v"
`include "src/basic/and16.v"

module alu(output [15:0] out, input zx, nx, zy, ny, f, no, input wire [15:0] x, input wire [15:0] y);

wire [15:0] ozx;
mux2way16 mzx(ozx, 16'b0, x, zx);

wire [15:0] nxcalc;
not16 nnx(nxcalc, ozx);
wire [15:0] onx;
mux2way16 mnx(onx, nxcalc, ozx, nx);

wire [15:0] ozy;
mux2way16 mzy(ozy, 16'b0, y, zy);

wire [15:0] nycalc;
not16 nny(nycalc, ozy);
wire [15:0] ony;
mux2way16 mny(ony, nycalc, ozy, ny);

wire [15:0] oandxy;
and16 andxy(oandxy, onx, ony);

wire [15:0] oplusxy;
add16 addxy(oplusxy, onx, ony);

wire [15:0] of;
mux2way16 mf(of, oplusxy, oandxy, f);

wire [15:0] nocalc;
not16 nno(nocalc, of);
mux2way16 mno(out, nocalc, of, no);

endmodule;
