module not16(output wire [15:0] outputs, input wire [15:0] inputs);

genvar i;
generate
	for(i=0; i<16; i=i+1) begin
		assign outputs[i] = ~inputs[i];
	end
endgenerate

endmodule;
