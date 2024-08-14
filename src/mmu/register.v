module register(output reg [15:0] curState, input [15:0] d, input enable);

always @ (posedge enable)
	if(enable)
		curState <= d;

endmodule;
