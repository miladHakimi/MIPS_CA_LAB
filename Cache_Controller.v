module Cache_Controller(
	input clk,
	input rst,
	input MEM_R_EN,
	input MEM_W_EN,
	input[31:0] address,
	input[31:0] wdata,
	input sram_ready,
	input[63:0] sram_rdata,
	output ready,
	output[31:0] rdata,
	output reg[31:0] sram_address,
	output reg[31:0] sram_wdata,
	output reg write,
	output reg read
);
	// tag1(9bit) data1(64bit) valid1(1bit) + tag2(9bit) data2(64bit) valid2(1bit) + LRU(1bit)
	reg [148:0]cache_mem[0:63];
	wire hit1, hit2, hit;
	wire [8:0] tag;
	wire [5:0] index;
	wire [2:0] offset;

	assign tag = address[17:9];
	assign index = address[8:3];
	assign offset = address[2:0];


	assign hit1 = (cache_mem[index][75] && cache_mem[index][148:140] == tag);
	assign hit2 = (cache_mem[index][1]) && (cache_mem[index][74:66] == tag);
	assign hit = hit1 | hit2;

	assign ready = MEM_W_EN ? sram_ready : ((MEM_R_EN == 0 & MEM_W_EN == 0) | sram_ready | hit ) ? 1 : 0;

	
	integer i;
	always@(posedge clk, posedge rst) begin
		if (rst==1'b1) begin
			write <= 0;
			read <= 0;
			sram_address <= 0;

			for (i=0; i<64; i=i+1) 
				cache_mem[i] <= 149'd0;
		end
		else begin
			write <= 0;
			read <= 0;
			sram_address <= 0;
			if (MEM_W_EN) begin
				if(hit1)
					cache_mem[index][75] <= 0;
				if(hit2) 
					cache_mem[index][1] <= 0;

				if (sram_ready==1'b0) begin
					sram_wdata <= wdata;
					sram_address <= address;
					write <= 1;
				end	
			end
			else if (MEM_R_EN) begin
				if (sram_ready==1'b0 && hit==1'b0) begin
					sram_address <= address;
					read <= 1;
				end
				else if(sram_ready==1'b1) begin
					if (cache_mem[index][0]==1'b0) begin
						cache_mem[index][75] <= 1;
						cache_mem[index][139:76] <= sram_rdata;
						cache_mem[index][148:140] <= tag;
						cache_mem[index][0] <= 1;
					end
					else if(cache_mem[index][0] == 1'b1) begin
						cache_mem[index][1] <= 1;
						cache_mem[index][65:2] <= sram_rdata;
						cache_mem[index][74:66] <= tag;
						cache_mem[index][0] <= 0;
					end
				end
			end
		end
	end

	assign rdata = sram_ready ? (address[2] ? sram_rdata[63:0] : sram_rdata[31:0]) :
					hit1 ? (address[2] ? cache_mem[index][139:108] : cache_mem[index][107:76]) :
				   	hit2 ? (address[2] ? cache_mem[index][65:34] : cache_mem[index][33:2]) : 32'b0;
endmodule // Cache_Controller