module Registers_file (
		input clk, 
		input rst,
		input [4:0] src1,
		input [4:0] src2,
		input [4:0] dest,
		input [31:0] Write_Val,
		input Write_EN,
		output [31:0] reg1,
		output [31:0] reg2
);
	reg [31:0] regs [0:31];
	integer i;
	
	assign reg1 = regs[src1];
	assign reg2 = regs[src2];
	always @(negedge clk, posedge rst)begin
		if (rst==1'b1)
			for(i = 0; i< 32; i=i+1)
				regs[i] = i;
		else if (clk==1'b0)
			if (Write_EN==1 && dest != 5'b0)
				regs [dest] = Write_Val; 
	end
endmodule