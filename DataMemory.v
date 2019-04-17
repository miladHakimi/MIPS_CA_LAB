module DataMemory(
		input clk,
		input [31:0] ST_value,
		input [7:0] r_addr,
		input MEM_W_EN,
		input MEM_R_EN,
		output [31:0] r_data);
	reg [31:0] data_mem [255:0] ;
	assign  r_data = (MEM_R_EN ? data_mem[r_addr] : r_data );
	always @(posedge clk)begin
		if(MEM_W_EN)
			data_mem[r_addr] = ST_value;
	end
endmodule