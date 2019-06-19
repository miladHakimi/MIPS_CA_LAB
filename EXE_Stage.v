module EXE_Stage(
	input clk,
	input [3:0] EXE_CMD,
	input [31:0] val1,
	input [31:0] val2,
	input [31:0] val_src2,
	input [31:0] PC,
	input [1:0] Br_type,
	//forwarding unit result
	input [1:0] val1_sel,
	input [1:0] val2_sel,
	input [1:0] src2_val_sel,
	input [31:0] EXE_Reg_ALU_result,
	input [31:0] WB_Write_val,
	output [31:0] src2_val,
	//----------------------
	output [31:0] ALU_result,
	output [31:0] Br_Addr,
	output Br_taken
	);

	//Mux
	wire [31:0] ALU_val1,ALU_val2;
	assign ALU_val1 = (val1_sel == 2'b01) ? EXE_Reg_ALU_result :
						(val1_sel == 2'b10) ? WB_Write_val : val1;
	assign ALU_val2 = (val2_sel == 2'b01) ? EXE_Reg_ALU_result :
						(val2_sel == 2'b10) ? WB_Write_val : val2;
	assign src2_val = (src2_val_sel == 2'b01) ? EXE_Reg_ALU_result :
						(src2_val_sel == 2'b10) ? WB_Write_val : val_src2;

	ALU EXE_ALU(ALU_val1, ALU_val2, EXE_CMD, ALU_result);
	EXE_Condition_Check EXE_Cond_Check (Br_type, ALU_val1, ALU_val2, Br_taken);
	assign Br_Addr = PC + val2*4;

endmodule