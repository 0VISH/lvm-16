module not16(output wire [15:0] outputs, input wire [15:0] inputs);

genvar i;
generate
	for(i=0; i<16; i=i+1) begin
		assign outputs[i] = ~inputs[i];
	end
endgenerate

endmodule;



module test();

wire [15:0] outs;
reg [15:0] ins;

not16 n16 (.outputs(outs), .inputs(ins));

initial begin
	$display("Time\tin\tout");
	$monitor("%0t\t%b\t%b", $time, ins, outs);
	ins = 16'b0;
	#10;
	ins = 16'b0000000011111111;
	#10;
	$finish;
end

endmodule
