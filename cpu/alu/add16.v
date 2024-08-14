`include "src/alu/fullAdder.v"

module add16(output [15:0] out, input [15:0] in1, input [15:0] in2);

wire [15:0] carry;

fullAdder fa0(.sum(out[0]), .carry(carry[0]), .a(in1[0]), .b(in2[0]), .c(1'b0));

genvar i;
generate
    for(i=1; i<16; i=i+1) begin
        fullAdder fa(.sum(out[i]), .carry(carry[i]), .a(in1[i]), .b(in2[i]), .c(carry[i-1]));
    end
endgenerate

endmodule
