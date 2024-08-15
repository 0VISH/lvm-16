module mux2way16(output wire [15:0] out, input wire [15:0] inp1, input wire [15:0] inp2, input wire line);

assign out = (~{16{line}} & inp1) | ({16{line}} & inp2);

endmodule;
