module AddressMapper(
		input[31:0] ALU_Result,
		output [7:0] addr);
	assign addr = (ALU_Result - 11'd1024) >> 2 ;
endmodule