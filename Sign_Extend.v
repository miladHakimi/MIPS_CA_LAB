module Sign_Extend (
		input [11:0] sign_input,
		output [31:0] sign_output);
		
		assign sign_output = (sign_input[11] == 1)? {20'b11111_11111_11111_11111,sign_input}:{20'b0,sign_input};
endmodule