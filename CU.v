module controller(input [5:0]opcode, output is_immediate, output [3:0] alu_cmd);
parameter ADD = 000001, SUB = 000011, AND = 000101, OR = 000110, NOR = 000111, XOR = 001000, SLA = 001001,
		 SLL = 001010, SRA = 001011, SRL = 001100, ADDI = 100000, SUBI = 100001, LD = 100100, ST = 100101, 
		 BEQ = 101000, BNE = 101001, JMP = 101010;
		 
always @(opcode) begin : 
	// immediates :
	case (opcode)
		ADD: alu_cmd = 4'b0000;
		SUB: alu_cmd = 4'b0010;
		AND: alu_cmd = 4'b0100;
		OR:  alu_cmd = 4'b0101;
		NOR: alu_cmd = 4'b0110;
		XOR: alu_cmd = 4'b0111;
		SRA: alu_cmd = 4'b1001;
		SRL: alu_cmd = 4'b1010;
		SLA: alu_cmd = 4'b1000;
		SLL: alu_cmd = 4'b1000;
		ADDI: {alu_cmd, is_immediate} = {4'b0000, 1};
		SUBI: {alu_cmd, is_immediate} = {4'b0010, 1};
		LD: {alu_cmd, is_immediate} = {4'b0000, 1};
		ST: {alu_cmd, is_immediate} = {4'b0000, 1};
		BEZ: is_immediate = 0;
		BNE: is_immediate = 0;
		JMP: is_immediate = 0;
		default : {alu_cmd, is_immediate} = 5'b0;;
	endcase
end

