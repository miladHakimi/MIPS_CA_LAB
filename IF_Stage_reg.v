module IF_Stage_reg(
		input clk,
		input rst,
		input freeze,
		input flush,
		input [31:0] PC_in,
		input [31:0] instruction_in,
		

		output reg [31:0] PC,
		output reg [31:0] instruction
		);
		always @(posedge clk, posedge rst) begin
			if(rst)
				{PC, instruction} <= 64'b0;
			else begin  
				if (freeze == 1'b0) begin 
					PC <= PC_in;
					instruction <= instruction_in;
				end
				if (flush)
					{PC, instruction} <= 64'b0;
			end
			
		end
endmodule
