module IF_Stage_reg(
		input clk,
		input rst,
		input flush,
		
		input [31:0] PC_in,
		input [31:0] instruction_in,
		output reg [31:0] PC,
		output reg [31:0] instruction
		);
		always @(posedge clk, posedge rst) begin
			if(rst || (clk && flush))
				{PC, instruction} <= 64'b0;
			else 
				PC <= PC_in;
				instruction <= instruction_in;
		end
endmodule
