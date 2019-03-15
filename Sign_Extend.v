module Sign_Extend (
		input [15:0] sign_input,
		output [31:0] sign_output);
		
		assign sign_output = (sign_input[15] == 1)? {16'b1, sign_input}:{16'b0, sign_input};
endmodule