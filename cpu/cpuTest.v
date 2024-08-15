`include "cpu/cpu.v"

module cpuTest();

wire [15:0] out, pc, addr;
wire write;
reg [15:0] instruction, data;
reg reset;
cpu tcpu(out, pc, addr, write, instruction, data, reset);

initial begin
	$display("-----[CPU]-----");
	$display("out\tpc\taddr\twrite\tinstruction\tdata\treset");
	$monitor("%b(%d)\t%b(%d)\t%b(%d)\t%b\t%b\t%b(%d)\t%b\n%b %b %b %b", out, out, pc, pc, addr, addr, write, instruction, data, data, reset, tcpu.r1Out, tcpu.r1En, tcpu.r2Out, tcpu.r2En);


	reset = 1'b0;
	data = 16'd50;
	instruction = 16'b0101111111111111;
	#1000;
	instruction = 16'b0100000000000000;
	#1000;
	instruction = 16'b0110111111111111;
	data = 16'd5;
	#1000;
	instruction = 16'b0100000000000000;
	#1000;
	instruction = 16'b1100011000001011;
	#1000;

	$finish;
end;

endmodule
