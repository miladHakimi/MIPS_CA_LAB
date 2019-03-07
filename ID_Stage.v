module ID_Stage(
		input clk,
		input rst,
		input[31:0] Instruction,
		input WB_Write_Enable,
		input[4:0] WB_Dest,
		input[31:0] WB_Data,
		// output IF_flush,
		output[4:0] Dest,
		output[31:0] Reg2,
		output[31:0] Val2,
		output[31:0] Val1,
		output[3:0] EXE_CMD,
		output[1:0] Branch_Type,
		output MEM_R_EN,
		output MEM_W_EN,
		output WB_EN
	);
	wire [31:0] reg2, sign_output;
	wire is_immediate;

	Sign_Extend SE(.sign_input(Instruction[11:0]), .sign_output(sign_output));

	Registers_file Reg_File(.clk(clk), .rst(rst), .src1(Instruction[25:21]), .src2(Instruction[20:16]),
					 		.dest(WB_Dest), .Write_Val(WB_Data), .Write_EN(WB_Write_Enable),
					 		.reg1(Val1), .reg2(reg2));

	assign Val2 = is_immediate? sign_output: reg2;
	controller CU(.opcode(Instruction[31:26]), .is_immediate(is_immediate), .MEM_W_EN(MEM_W_EN), .MEM_R_EN(MEM_R_EN),
					.WB_EN(WB_EN), .EXE_CMD(EXE_CMD), .br_type(Branch_Type));
	assign Dest = is_immediate ? Instruction[20:16] : Instruction[15:11];
	assign Reg2 = reg2;

	
endmodule
