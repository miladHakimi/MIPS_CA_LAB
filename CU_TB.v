module CU_TB();
reg [5:0] opcode;
wire [3:0] alu_cmd;
wire [1:0] br_type;
wire im;

controller CU(opcode, im, alu_cmd, br_type);

initial begin
	opcode = 6'b000001;
	#50
	opcode = 6'b001001;
	#50
	opcode = 6'b100000;
	#50
	opcode = 6'b101010;
end

endmodule
