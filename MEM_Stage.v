module MEM_Stage(
	input clk,

	input MEM_R_EN_in,
	input MEM_W_EN_in,

	input [31:0] ALU_result_in,
	input [31:0] ST_val,

	output[31:0] Mem_read_value 
);
wire [7:0] read_addr;

AddressMapper AM(.ALU_Result(ALU_result_in), .addr(read_addr));
DataMemory DM(.clk(clk), .ST_value(ST_val), .r_addr(read_addr), .MEM_W_EN(MEM_W_EN_in), .MEM_R_EN(MEM_R_EN_in), .r_data(Mem_read_value));
	
endmodule