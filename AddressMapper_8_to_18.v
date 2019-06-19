module AddressMapper_8_to_18(
		input[7:0] addr1,
		output [17:0] addr2);
	assign addr2 = (addr1) << 1 ;
endmodule