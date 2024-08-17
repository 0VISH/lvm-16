module jc(output jmp, output incr, input [15:0] instruction, input [15:0] val, input [1:0] jmpInstr);

wire shouldJmp = ~instruction[15] & ~instruction[14];
wire lessZ = val[15] & jmpInstr[0] & ~jmpInstr[1];
wire grtZ = |val & ~instruction[15] & jmpInstr[0] & jmpInstr[1];

wire equZ = ~lessZ & ~grtZ & jmpInstr[0] & jmpInstr[0];
wire justJmp = ~instruction[1] & instruction[0];

assign jmp = shouldJmp & (lessZ | grtZ | equZ | justJmp);
assign incr = ~jmp;

endmodule;
