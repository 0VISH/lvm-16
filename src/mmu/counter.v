module counter(output reg [15:0] curState, input [15:0] d, input reset, input increment, input enable);

always @ (posedge enable or posedge reset or posedge increment)
	if(enable)
		curState <= d;
	else if(reset)
		curState <= 16'd0;
	else if(increment)
		curState <= curState + 1;

endmodule;
