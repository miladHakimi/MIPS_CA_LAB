module WB_Stage(
	input clk,
	input MEM_R_EN,
	input [31:0] ALU_result,
	input [31:0] Mem_read_value,
	output reg [31:0] Write_value
);

always @(*) begin
	if(MEM_R_EN == 1'b0)
		Write_value <= ALU_result;
	if(MEM_R_EN == 1'b1)
		Write_value <= Mem_read_value;
end
endmodule // WB_Stage