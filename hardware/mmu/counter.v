module counter(output reg [15:0] curState, input [15:0] d, input reset, input increment, input enable, input clk);

always @ (enable or increment or reset or clk) begin
	if(enable)
		curState <= d;
	else if(increment)
		curState <= curState + 1;
	if(reset)
		curState <= 16'd0;
end

endmodule;
