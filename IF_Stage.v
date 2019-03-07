module IF_Stage(
		input clk,
		input rst,
		output [31:0] PC,
		output [31:0] instruction
);
	reg [31:0] my_pc;
	Instruction_MEM imem(my_pc, instruction);
	initial begin
		my_pc = 32'b0;
	end
	always @(posedge clk, posedge rst) begin
		if(rst) 
			{my_pc} <= 32'b0;
		else begin
			my_pc <= my_pc + 32'd4;
		end
	end
	assign PC = my_pc;
endmodule
