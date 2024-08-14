module fullAdder(output sum, output carry, input a, input b, input c);

assign sum = a ^ b ^ c;
assign carry = (a&b) | (c&(a^b));

endmodule;
