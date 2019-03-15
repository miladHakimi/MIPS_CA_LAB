module ID_Stage_reg (
		input clk,
		input rst,
		input Flush,
		input[4:0] Dest_in,
		input[31:0] Reg2_in,
		input[31:0] Val2_in,
		input[31:0] Val1_in,
		input[31:0] PC_in,
		input[1:0] br_type_in,
		input[3:0] EXE_CMD_in,
		input MEM_R_EN_in,
		input MEM_W_EN_in,
		input WB_EN_in,
		//to stage registers
		output reg[4:0] Dest,
		output reg[31:0] Reg2,
		output reg[31:0] Val2,
		output reg[31:0] Val1,
		output reg[31:0] PC_out,
		output reg [1:0] br_type_out,
		output reg[3:0] EXE_CMD,
		output reg MEM_R_EN,
		output reg MEM_W_EN,
		output reg WB_EN
	);
	always@(posedge clk, posedge rst) begin
		if(rst || (clk && Flush)) begin
			Dest = 5'b0;
			Reg2 = 32'b0;
			Val2 = 32'b0;
			PC_out = 32'b0;
			br_type_out = 2'b0;
			EXE_CMD = 32'b0;
			MEM_R_EN = 1'b0;
			MEM_W_EN = 1'b0;
			WB_EN = 1'b0;
		end
		else if(clk) begin
			Dest = Dest_in;
			Reg2 = Reg2_in;
			Val2 = Val2_in;
			PC_out = PC_in;
			Val1 = Val1_in;
			br_type_out = br_type_in;
			EXE_CMD = EXE_CMD_in;
			MEM_R_EN = MEM_R_EN_in;
			MEM_W_EN = MEM_W_EN_in;
			WB_EN =	WB_EN_in;
		end
	end
endmodule