`include "hardware/cpu/cpu.v"

module cpuTest();

wire [15:0] out, pc, addr;
wire write;
reg [15:0] instruction, data;
reg reset, clk;
cpu tcpu(out, pc, addr, write, clk, instruction, data, reset);

wire jmp, incr;
reg [15:0] val;
reg [1:0] jmpInstr;
jc tjc(jmp, incr, instruction, val, jmpInstr);

initial begin
	$display("-----[JC]-----");
	$monitor("%b\t%b\t%b\t%b\t%b", jmp, incr, instruction, val, jmpInstr);
	instruction = 16'd0;
	val = 16'd69;
	jmpInstr = 2'b11;
	#100;
	jmpInstr = 2'b00;
	#100;
	$display("\n-----[CPU]-----");
	$display("out\tpc\taddr\twrite\tinstruction\tdata\treset");
	$monitor("%b(%d)\t%b(%d)\t%b(%d)\t%b\t%b\t%b(%d)\t%b", out, out, pc, pc, addr, addr, write, instruction, data, data, reset);

	clk = 0;
	reset = 1'd1;
	instruction = 16'b0100000000000000;
	#100;
	clk = 1;
	reset = 1'd0;
	#100;
	clk = 0;
	data = 16'd50;
	instruction = 16'b0101111111111111;
	#1000;
	clk = 1;
	instruction = 16'b0100000000000000;
	#1000;
	clk = 0;
	instruction = 16'b0110111111111111;
	data = 16'd5;
	#1000;
	clk = 1;
	instruction = 16'b0100000000000000;
	#1000;
	clk = 0;
	instruction = 16'b1111011000001011;
	#1000;
	clk = 1;
	instruction = 16'b0100000000000000;
	#1000;
	clk = 0;
	instruction = 16'b10xxxxxxxxxxxx11;
	#1000;
	clk = 1;
	instruction = 16'b0010110100000000;
	#1000;
	$finish;
end;

endmodule
