module sram(output reg [15:0] out, input [15:0] inp, input [15:0] addr, input load);

reg [15:0] sramRegs [511:0];

always @ (posedge load)
	if(load)
		sramRegs[addr] <= inp;
	else
		out <= sramRegs[addr];

endmodule;
