module controller(input [5:0]opcode, output reg is_immediate, MEM_R_EN, MEM_W_EN, WB_EN, output reg [3:0] EXE_CMD, 
	output reg [1:0] br_type);
parameter ADD = 6'b000001, SUB = 6'b000011, AND = 6'b000101, OR = 6'b000110, NOR = 6'b000111, XOR = 6'b001000, SLA = 6'b001001,
		 SLL = 6'b001010, SRA = 6'b001011, SRL = 6'b001100, ADDI = 6'b100000, SUBI = 6'b100001, LD = 6'b100100, ST = 6'b100101, 
		 BEZ = 6'b101000, BNE = 6'b101001, JMP = 6'b101010;
		 
always @(opcode) begin
	{EXE_CMD, is_immediate, br_type, MEM_R_EN, MEM_W_EN, WB_EN} = 10'b0;
	case (opcode)
		ADD: {EXE_CMD, WB_EN} = {4'b0000, 1'b1};
		SUB: {EXE_CMD, WB_EN} = {4'b0010, 1'b1};
		AND: {EXE_CMD, WB_EN} = {4'b0100, 1'b1};
		OR:  {EXE_CMD, WB_EN} = {4'b0101, 1'b1};
		NOR: {EXE_CMD, WB_EN} = {4'b0110, 1'b1};
		XOR: {EXE_CMD, WB_EN} = {4'b0111, 1'b1};
		SRA: {EXE_CMD, WB_EN} = {4'b1001, 1'b1};
		SRL: {EXE_CMD, WB_EN} = {4'b1010, 1'b1};
		SLA: {EXE_CMD, WB_EN} = {4'b1000, 1'b1};
		SLL: {EXE_CMD, WB_EN} = {4'b1000, 1'b1};
		ADDI: {EXE_CMD, WB_EN, is_immediate} = {4'b0000, 1'b1, 1'b1};
		SUBI: {EXE_CMD, WB_EN, is_immediate} = {4'b0010, 1'b1, 1'b1};
		LD: {EXE_CMD, WB_EN, MEM_R_EN, is_immediate} = {4'b0000, 3'b111};
		ST: {MEM_W_EN, is_immediate} = {2'b11};
		BEZ: {is_immediate, br_type} = {1'b1, 2'b01};
		BNE: {is_immediate, br_type} = {1'b1, 2'b10};
		JMP: {is_immediate, br_type} = {1'b1, 2'b11};
	endcase
end

endmodule

