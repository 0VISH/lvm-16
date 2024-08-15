module selector(input enable, input [1:0] line, output o1, output o2, output o3, output o4);

wire s0 = line[0];
wire s1 = line[1];

assign o1 = (~s0 & ~s1) & enable;
assign o2 = (s0 & ~s1) & enable;
assign o3 = (~s0 & s1) & enable;
assign o4 = (s0 & s1) & enable;

endmodule;
