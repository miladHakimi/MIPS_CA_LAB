module Sram_Controller(
	input clk,
	input rst,
	//From Memory Stage
	input wr_en,
	input rd_en,
	input [31:0] address,
	input [31:0] writeData,
	//To Next Stage
	output reg [63:0] readData,
	//For freeze other Stage
	output ready,

	inout  [15:0] SRAM_DQ,
	output [17:0] SRAM_ADDR,
	output SRAM_UB_N,
	output SRAM_LB_N,
	output reg SRAM_WE_N,
	output SRAM_CE_N,
	output SRAM_OE_N
	);
	parameter [3:0] A=0, B=1, C=2, D=3, E=4, F=5, G=6, H=7, I=8;

	assign SRAM_UB_N = 1'b0;
	assign SRAM_LB_N = 1'b0;
	assign SRAM_CE_N = 1'b0;
	assign SRAM_OE_N = 1'b0;
	reg [15:0] SRAM_DQ_1;
	assign  SRAM_DQ = wr_en ? SRAM_DQ_1 : 16'bzzzz_zzzz_zzzz_zzzz;
	wire cmp_out;
	wire [7:0] addr1;
	wire [17:0] addr2;
	reg [17:0] SRAM_WR_ADDR;
	reg [3:0] ns, ps;

	assign SRAM_ADDR = (wr_en) ? SRAM_WR_ADDR :
							 (rd_en) ?
								 (ps == E) ? {addr2[17:2], 2'b00} :
								 (ps == F) ? {addr2[17:2], 2'b01} :
								 (ps == G) ? {addr2[17:2], 2'b10} :
								 (ps == H) ? {addr2[17:2], 2'b11} : 18'b0
							 : 18'b0;
	reg rst_cnt, encnt;
	reg [2:0] cnt_out;

	assign cmp_out = (cnt_out == 3'd4) ? 1'b1 : 1'b0;
	assign ready = (cmp_out | rst_cnt) & (wr_en | rd_en);
	//Counter Implementation
	always @(posedge clk or posedge rst ) begin
		if (rst) begin
			// reset
			cnt_out = 3'b0;			
		end
		else begin
			if(rst_cnt) begin
				cnt_out = 3'b0;
			end
			else if (encnt) begin
				cnt_out = cnt_out + 1;		
			end
			
		end
	end

	//SRAM Controller Implementation
	AddressMapper AM(.ALU_Result(address), .addr(addr1));
	AddressMapper_8_to_18 AM2(.addr1(addr1), .addr2(addr2));
	always @(ps) begin
		{encnt, SRAM_WE_N, rst_cnt} = 3'b010;
		case(ps)
			A: begin
				if(wr_en)
					ns = B;	
				else if(rd_en)
					ns = E;
				else 
					ns = A;
			end
			B: begin
				SRAM_WR_ADDR = addr2;
				SRAM_DQ_1 = writeData[15:0];
				encnt = 1'b1;			
				ns = C;
				SRAM_WE_N = 0;
			end
			C: begin
				SRAM_WR_ADDR = addr2+1;
				SRAM_DQ_1 = writeData[31:16];				
				encnt = 1'b1;
				ns = D;
				SRAM_WE_N = 0;
			end
			D: begin
				encnt = 1'b1;
				if(~ready)
					ns = D;
				else 
					ns = I;
			end
			E: begin
				// SRAM_ADDR = addr2;
				readData[15:0] = SRAM_DQ;
				encnt = 1'b1;
				ns = F;
			end
			F: begin
				// SRAM_ADDR = addr2 + 1;
				readData[31:16] = SRAM_DQ;				
				encnt = 1'b1;
				ns = G;
			end
			G: begin
				// SRAM_ADDR = addr2 + 2;
				readData[47:32] = SRAM_DQ;
				encnt = 1'b1; 
				ns = H;
			end
			H: begin
				// SRAM_ADDR = addr2 + 3;
				readData[63:48] = SRAM_DQ;
				encnt = 1'b1;
				if(~ready)
					ns = H;
				else 
					ns = I;				
			end
			I: begin
				rst_cnt = 1'b1;
				if(wr_en)
					ns = B;
				else if (rd_en)
					ns = E;
				else if(rd_en == 0 && wr_en == 0)
					ns = A;
			end
			default: ns = A;
		endcase
	end
	always @(posedge clk or posedge rst) begin
	 	if (rst) begin
	 		// reset
	 		ps <= A;
	 		
	 	end
	 	else
	 		ps <= ns;
	 end 

endmodule