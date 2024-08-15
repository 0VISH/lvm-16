module register(output reg [15:0] curState, input [15:0] d, input enable);

always @(*) begin
	if(enable)
		curState <= d;
end

endmodule;
