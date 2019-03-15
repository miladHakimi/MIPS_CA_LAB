module IF_Stage(
		input clk,
		input rst,
		input br_taken,
		input [31:0] br_addr,
		output [31:0] PC,
		output [31:0] instruction
);
	reg [31:0] PC_out;
	wire [31:0] PC_in;
	
	Instruction_MEM imem(PC_out, instruction);
	
	assign PC_in = br_taken? br_addr: PC;
	assign PC = PC_out + 32'd4;

	always @(posedge clk or posedge rst) begin
		if(rst) 
			PC_out <= 32'd0;
		else 
			PC_out <= PC_in;
	end

endmodule
