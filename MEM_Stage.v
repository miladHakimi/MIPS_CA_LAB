module MEM_Stage(
	input clk,
	input rst,

	input MEM_R_EN_in,
	input MEM_W_EN_in,

	input [31:0] ALU_result_in,
	input [31:0] ST_val,

	output[31:0] Mem_read_value,
	
	output ready,
	inout  [15:0] SRAM_DQ,
	output [17:0] SRAM_ADDR,
	output SRAM_UB_N,
	output SRAM_LB_N,
	output SRAM_WE_N,
	output SRAM_CE_N,
	output SRAM_OE_N
);
wire [7:0] read_addr;
wire sram_ready, write, read;
wire [63:0]sram_mem_read_val;
wire [31:0] sram_address, sram_wdata;
// AddressMapper AM(.ALU_Result(ALU_result_in), .addr(read_addr));
// DataMemory DM(.clk(clk), .ST_value(ST_val), .r_addr(read_addr), .MEM_W_EN(MEM_W_EN_in), .MEM_R_EN(MEM_R_EN_in), .r_data(Mem_read_value));
	Cache_Controller cache_controller(
		// IN
		.clk(clk),
		.rst(rst),
		.MEM_R_EN(MEM_R_EN_in),
		.MEM_W_EN(MEM_W_EN_in),
		.address(ALU_result_in),
		.wdata(ST_val),
		.sram_ready(sram_ready),
		.sram_rdata(sram_mem_read_val),
		// OUT
		.ready(ready),
		.rdata(Mem_read_value),
		.sram_address(sram_address),
		.sram_wdata(sram_wdata),
		.write(write),
		.read(read)
	);
Sram_Controller SC(.clk(clk), .rst(rst), .wr_en(write), .rd_en(read),
				   .address(sram_address), .writeData(sram_wdata), .readData(sram_mem_read_val),
				   .ready(sram_ready), .SRAM_DQ(SRAM_DQ), .SRAM_ADDR(SRAM_ADDR),
				   .SRAM_UB_N(SRAM_UB_N), .SRAM_LB_N(SRAM_LB_N),
				   .SRAM_WE_N(SRAM_WE_N), .SRAM_CE_N(SRAM_CE_N), .SRAM_OE_N(SRAM_OE_N));				 	
endmodule