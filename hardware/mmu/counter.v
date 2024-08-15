module counter(output reg [15:0] curState, input [15:0] d, input reset, input increment, input enable);

always @ (enable or increment or reset) begin
	if(enable)
		curState <= d;
	else if(increment)
		curState <= curState + 16;
	if(reset)
		curState <= 16'd0;
end

endmodule;
