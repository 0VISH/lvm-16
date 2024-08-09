module xor16(output [15:0] out, input [15:0] in1, input [15:0] in2);

genvar i;
generate
	for(i=0; i<16; i=i+1) begin
		assign out[i] = (in1[i] & ~in2[i]) | (~in1[i] & in2[i]);
	end
endgenerate

endmodule;
