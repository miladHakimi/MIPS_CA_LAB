module ID_Stage(
		input clk,
		input rst,
		input freeze,
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
		output WB_EN,
		//src output for forwarding unit
		output [4:0] src1,
		output [4:0] src2,
		output is_single_src,
		output is_BNE
	);
	wire [31:0] reg2, sign_output;
	wire is_immediate;

	wire MEM_R_EN2, MEM_W_EN2, WB_EN2;
	wire [1:0] Branch_Type2;
	wire [3:0] EXE_CMD2;
	
	Sign_Extend SE(.sign_input(Instruction[15:0]), .sign_output(sign_output));

	Registers_file Reg_File(.clk(clk), .rst(rst), .src1(Instruction[25:21]), .src2(Instruction[20:16]),
					 		.dest(WB_Dest), .Write_Val(WB_Data), .Write_EN(WB_Write_Enable),
					 		.reg1(Val1), .reg2(reg2));

	assign Val2 = is_immediate? sign_output: reg2;
	controller CU(.opcode(Instruction[31:26]), .is_immediate(is_immediate), .MEM_W_EN(MEM_W_EN2), .MEM_R_EN(MEM_R_EN2),
					.WB_EN(WB_EN2), .EXE_CMD(EXE_CMD2), .br_type(Branch_Type2), .is_single_src(is_single_src), .is_BNE(is_BNE));

	//**************MUX for Hazard Detection
	assign EXE_CMD = freeze ? 4'b0 : EXE_CMD2;
	assign Branch_Type = freeze ? 2'b0 : Branch_Type2;
	assign MEM_R_EN = freeze ? 1'b0 : MEM_R_EN2;
	assign MEM_W_EN = freeze ? 1'b0 : MEM_W_EN2;
	assign WB_EN = freeze ? 1'b0 : WB_EN2;
	//*************End of MUX
	assign Dest = is_immediate ? Instruction[20:16] : Instruction[15:11];
	assign Reg2 = reg2;
	//src1 and src2 for forwarding unit
	assign src1 = Instruction[25:21];
	assign src2 = Instruction[20:16];
	
endmodule
