// ============================================================================
// Copyright (c) 2012 by Terasic Technologies Inc.
// ============================================================================
//
// Permission:
//
//   Terasic grants permission to use and modify this code for use
//   in synthesis for all Terasic Development Boards and Altera Development 
//   Kits made by Terasic.  Other use of this code, including the selling 
//   ,duplication, or modification of any portion is strictly prohibited.
//
// Disclaimer:
//
//   This VHDL/Verilog or C/C++ source code is intended as a design reference
//   which illustrates how these types of functions can be implemented.
//   It is the user's responsibility to verify their design for
//   consistency and functionality through the use of formal
//   verification methods.  Terasic provides no warranty regarding the use 
//   or functionality of this code.
//
// ============================================================================
//           
//  Terasic Technologies Inc
//  9F., No.176, Sec.2, Gongdao 5th Rd, East Dist, Hsinchu City, 30070. Taiwan
//
//
//
//                     web: http://www.terasic.com/
//                     email: support@terasic.com
//
// ============================================================================
//
// Major Functions:	DE2 TOP LEVEL
//
// ============================================================================
//
// Revision History :
// ============================================================================
//   Ver  :| Author            :| Mod. Date :| Changes Made:
//   V1.0 :| Johnny Chen       :| 05/08/19  :|      Initial Revision
//   V1.1 :| Johnny Chen       :| 05/11/16  :|      Added FLASH Address FL_ADDR[21:20]
//   V1.2 :| Johnny Chen       :| 05/11/16  :|		Fixed ISP1362 INT/DREQ Pin Direction.   
//   V1.3 :| Johnny Chen       :| 06/11/16  :|		Added the Dedicated TV Decoder Line-Locked-Clock Input
//													            for DE2 v2.X PCB.
//   V1.5 :| Eko    Yan        :| 12/01/30  :|      Update to version 11.1 sp1.
// ============================================================================

module MIPS
	(
		////////////////////	Clock Input	 	////////////////////	 
		CLOCK_27,						//	27 MHz
		CLOCK_50,						//	50 MHz
		EXT_CLOCK,						//	External Clock
		////////////////////	Push Button		////////////////////
		KEY,							//	Pushbutton[3:0]
		////////////////////	DPDT Switch		////////////////////
		SW,								//	Toggle Switch[17:0]
		////////////////////	7-SEG Dispaly	////////////////////
		HEX0,							//	Seven Segment Digit 0
		HEX1,							//	Seven Segment Digit 1
		HEX2,							//	Seven Segment Digit 2
		HEX3,							//	Seven Segment Digit 3
		HEX4,							//	Seven Segment Digit 4
		HEX5,							//	Seven Segment Digit 5
		HEX6,							//	Seven Segment Digit 6
		HEX7,							//	Seven Segment Digit 7
		////////////////////////	LED		////////////////////////
		LEDG,							//	LED Green[8:0]
		LEDR,							//	LED Red[17:0]
		////////////////////////	UART	////////////////////////
		//UART_TXD,						//	UART Transmitter
		//UART_RXD,						//	UART Receiver
		////////////////////////	IRDA	////////////////////////
		//IRDA_TXD,						//	IRDA Transmitter
		//IRDA_RXD,						//	IRDA Receiver
		/////////////////////	SDRAM Interface		////////////////
		DRAM_DQ,						//	SDRAM Data bus 16 Bits
		DRAM_ADDR,						//	SDRAM Address bus 12 Bits
		DRAM_LDQM,						//	SDRAM Low-byte Data Mask 
		DRAM_UDQM,						//	SDRAM High-byte Data Mask
		DRAM_WE_N,						//	SDRAM Write Enable
		DRAM_CAS_N,						//	SDRAM Column Address Strobe
		DRAM_RAS_N,						//	SDRAM Row Address Strobe
		DRAM_CS_N,						//	SDRAM Chip Select
		DRAM_BA_0,						//	SDRAM Bank Address 0
		DRAM_BA_1,						//	SDRAM Bank Address 0
		DRAM_CLK,						//	SDRAM Clock
		DRAM_CKE,						//	SDRAM Clock Enable
		////////////////////	Flash Interface		////////////////
		FL_DQ,							//	FLASH Data bus 8 Bits
		FL_ADDR,						//	FLASH Address bus 22 Bits
		FL_WE_N,						//	FLASH Write Enable
		FL_RST_N,						//	FLASH Reset
		FL_OE_N,						//	FLASH Output Enable
		FL_CE_N,						//	FLASH Chip Enable
		////////////////////	SRAM Interface		////////////////
		SRAM_DQ,						//	SRAM Data bus 16 Bits
		SRAM_ADDR,						//	SRAM Address bus 18 Bits
		SRAM_UB_N,						//	SRAM High-byte Data Mask 
		SRAM_LB_N,						//	SRAM Low-byte Data Mask 
		SRAM_WE_N,						//	SRAM Write Enable
		SRAM_CE_N,						//	SRAM Chip Enable
		SRAM_OE_N,						//	SRAM Output Enable
		////////////////////	ISP1362 Interface	////////////////
		OTG_DATA,						//	ISP1362 Data bus 16 Bits
		OTG_ADDR,						//	ISP1362 Address 2 Bits
		OTG_CS_N,						//	ISP1362 Chip Select
		OTG_RD_N,						//	ISP1362 Write
		OTG_WR_N,						//	ISP1362 Read
		OTG_RST_N,						//	ISP1362 Reset
		OTG_FSPEED,						//	USB Full Speed,	0 = Enable, Z = Disable
		OTG_LSPEED,						//	USB Low Speed, 	0 = Enable, Z = Disable
		OTG_INT0,						//	ISP1362 Interrupt 0
		OTG_INT1,						//	ISP1362 Interrupt 1
		OTG_DREQ0,						//	ISP1362 DMA Request 0
		OTG_DREQ1,						//	ISP1362 DMA Request 1
		OTG_DACK0_N,					//	ISP1362 DMA Acknowledge 0
		OTG_DACK1_N,					//	ISP1362 DMA Acknowledge 1
		////////////////////	LCD Module 16X2		////////////////
		LCD_ON,							//	LCD Power ON/OFF
		LCD_BLON,						//	LCD Back Light ON/OFF
		LCD_RW,							//	LCD Read/Write Select, 0 = Write, 1 = Read
		LCD_EN,							//	LCD Enable
		LCD_RS,							//	LCD Command/Data Select, 0 = Command, 1 = Data
		LCD_DATA,						//	LCD Data bus 8 bits
		////////////////////	SD_Card Interface	////////////////
		//SD_DAT,							//	SD Card Data
		//SD_WP_N,						   //	SD Write protect 
		//SD_CMD,							//	SD Card Command Signal
		//SD_CLK,							//	SD Card Clock
		////////////////////	USB JTAG link	////////////////////
		TDI,  							// CPLD -> FPGA (data in)
		TCK,  							// CPLD -> FPGA (clk)
		TCS,  							// CPLD -> FPGA (CS)
	   TDO,  							// FPGA -> CPLD (data out)
		////////////////////	I2C		////////////////////////////
		I2C_SDAT,						//	I2C Data
		I2C_SCLK,						//	I2C Clock
		////////////////////	PS2		////////////////////////////
		PS2_DAT,						//	PS2 Data
		PS2_CLK,						//	PS2 Clock
		////////////////////	VGA		////////////////////////////
		VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK,						//	VGA BLANK
		VGA_SYNC,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B,  						//	VGA Blue[9:0]
		////////////	Ethernet Interface	////////////////////////
		ENET_DATA,						//	DM9000A DATA bus 16Bits
		ENET_CMD,						//	DM9000A Command/Data Select, 0 = Command, 1 = Data
		ENET_CS_N,						//	DM9000A Chip Select
		ENET_WR_N,						//	DM9000A Write
		ENET_RD_N,						//	DM9000A Read
		ENET_RST_N,						//	DM9000A Reset
		ENET_INT,						//	DM9000A Interrupt
		ENET_CLK,						//	DM9000A Clock 25 MHz
		////////////////	Audio CODEC		////////////////////////
		AUD_ADCLRCK,					//	Audio CODEC ADC LR Clock
		AUD_ADCDAT,						//	Audio CODEC ADC Data
		AUD_DACLRCK,					//	Audio CODEC DAC LR Clock
		AUD_DACDAT,						//	Audio CODEC DAC Data
		AUD_BCLK,						//	Audio CODEC Bit-Stream Clock
		AUD_XCK,						//	Audio CODEC Chip Clock
		////////////////	TV Decoder		////////////////////////
		TD_DATA,    					//	TV Decoder Data bus 8 bits
		TD_HS,							//	TV Decoder H_SYNC
		TD_VS,							//	TV Decoder V_SYNC
		TD_RESET,						//	TV Decoder Reset
		TD_CLK27,                  //	TV Decoder 27MHz CLK
		////////////////////	GPIO	////////////////////////////
		GPIO_0,							//	GPIO Connection 0
		GPIO_1							//	GPIO Connection 1
	);

////////////////////////	Clock Input	 	////////////////////////
input		   	CLOCK_27;				//	27 MHz
input		   	CLOCK_50;				//	50 MHz
input			   EXT_CLOCK;				//	External Clock
////////////////////////	Push Button		////////////////////////
input	   [3:0]	KEY;					//	Pushbutton[3:0]
////////////////////////	DPDT Switch		////////////////////////
input	  [17:0]	SW;						//	Toggle Switch[17:0]
////////////////////////	7-SEG Dispaly	////////////////////////
output	[6:0]	HEX0;					//	Seven Segment Digit 0
output	[6:0]	HEX1;					//	Seven Segment Digit 1
output	[6:0]	HEX2;					//	Seven Segment Digit 2
output	[6:0]	HEX3;					//	Seven Segment Digit 3
output	[6:0]	HEX4;					//	Seven Segment Digit 4
output	[6:0]	HEX5;					//	Seven Segment Digit 5
output	[6:0]	HEX6;					//	Seven Segment Digit 6
output	[6:0]	HEX7;					//	Seven Segment Digit 7
////////////////////////////	LED		////////////////////////////
output	[8:0]	LEDG;					//	LED Green[8:0]
output  [17:0]	LEDR;					//	LED Red[17:0]
////////////////////////////	UART	////////////////////////////
//output			UART_TXD;				//	UART Transmitter
//input			   UART_RXD;				//	UART Receiver
////////////////////////////	IRDA	////////////////////////////
//output			IRDA_TXD;				//	IRDA Transmitter
//input			   IRDA_RXD;				//	IRDA Receiver
///////////////////////		SDRAM Interface	////////////////////////
inout	  [15:0]	DRAM_DQ;				//	SDRAM Data bus 16 Bits
output  [11:0]	DRAM_ADDR;				//	SDRAM Address bus 12 Bits
output			DRAM_LDQM;				//	SDRAM Low-byte Data Mask 
output			DRAM_UDQM;				//	SDRAM High-byte Data Mask
output			DRAM_WE_N;				//	SDRAM Write Enable
output			DRAM_CAS_N;				//	SDRAM Column Address Strobe
output			DRAM_RAS_N;				//	SDRAM Row Address Strobe
output			DRAM_CS_N;				//	SDRAM Chip Select
output			DRAM_BA_0;				//	SDRAM Bank Address 0
output			DRAM_BA_1;				//	SDRAM Bank Address 0
output			DRAM_CLK;				//	SDRAM Clock
output			DRAM_CKE;				//	SDRAM Clock Enable
////////////////////////	Flash Interface	////////////////////////
inout	  [7:0]	FL_DQ;					//	FLASH Data bus 8 Bits
output [21:0]	FL_ADDR;				//	FLASH Address bus 22 Bits
output			FL_WE_N;				//	FLASH Write Enable
output			FL_RST_N;				//	FLASH Reset
output			FL_OE_N;				//	FLASH Output Enable
output			FL_CE_N;				//	FLASH Chip Enable
////////////////////////	SRAM Interface	////////////////////////
inout	 [15:0]	SRAM_DQ;				//	SRAM Data bus 16 Bits
output [17:0]	SRAM_ADDR;				//	SRAM Address bus 18 Bits
output			SRAM_UB_N;				//	SRAM High-byte Data Mask 
output			SRAM_LB_N;				//	SRAM Low-byte Data Mask 
output			SRAM_WE_N;				//	SRAM Write Enable
output			SRAM_CE_N;				//	SRAM Chip Enable
output			SRAM_OE_N;				//	SRAM Output Enable
////////////////////	ISP1362 Interface	////////////////////////
inout	 [15:0]	OTG_DATA;				//	ISP1362 Data bus 16 Bits
output  [1:0]	OTG_ADDR;				//	ISP1362 Address 2 Bits
output			OTG_CS_N;				//	ISP1362 Chip Select
output			OTG_RD_N;				//	ISP1362 Write
output			OTG_WR_N;				//	ISP1362 Read
output			OTG_RST_N;				//	ISP1362 Reset
output			OTG_FSPEED;				//	USB Full Speed,	0 = Enable, Z = Disable
output			OTG_LSPEED;				//	USB Low Speed, 	0 = Enable, Z = Disable
input			   OTG_INT0;				//	ISP1362 Interrupt 0
input			   OTG_INT1;				//	ISP1362 Interrupt 1
input			   OTG_DREQ0;				//	ISP1362 DMA Request 0
input			   OTG_DREQ1;				//	ISP1362 DMA Request 1
output			OTG_DACK0_N;			//	ISP1362 DMA Acknowledge 0
output			OTG_DACK1_N;			//	ISP1362 DMA Acknowledge 1
////////////////////	LCD Module 16X2	////////////////////////////
inout	  [7:0]	LCD_DATA;				//	LCD Data bus 8 bits
output			LCD_ON;					//	LCD Power ON/OFF
output			LCD_BLON;				//	LCD Back Light ON/OFF
output			LCD_RW;					//	LCD Read/Write Select, 0 = Write, 1 = Read
output			LCD_EN;					//	LCD Enable
output			LCD_RS;					//	LCD Command/Data Select, 0 = Command, 1 = Data
////////////////////	SD Card Interface	////////////////////////
//inout	 [3:0]	SD_DAT;					//	SD Card Data
//input			   SD_WP_N;				   //	SD write protect
//inout			   SD_CMD;					//	SD Card Command Signal
//output			SD_CLK;					//	SD Card Clock
////////////////////////	I2C		////////////////////////////////
inout			   I2C_SDAT;				//	I2C Data
output			I2C_SCLK;				//	I2C Clock
////////////////////////	PS2		////////////////////////////////
input		 	   PS2_DAT;				//	PS2 Data
input			   PS2_CLK;				//	PS2 Clock
////////////////////	USB JTAG link	////////////////////////////
input  			TDI;					// CPLD -> FPGA (data in)
input  			TCK;					// CPLD -> FPGA (clk)
input  			TCS;					// CPLD -> FPGA (CS)
output 			TDO;					// FPGA -> CPLD (data out)
////////////////////////	VGA			////////////////////////////
output			VGA_CLK;   				//	VGA Clock
output			VGA_HS;					//	VGA H_SYNC
output			VGA_VS;					//	VGA V_SYNC
output			VGA_BLANK;				//	VGA BLANK
output			VGA_SYNC;				//	VGA SYNC
output	[9:0]	VGA_R;   				//	VGA Red[9:0]
output	[9:0]	VGA_G;	 				//	VGA Green[9:0]
output	[9:0]	VGA_B;   				//	VGA Blue[9:0]
////////////////	Ethernet Interface	////////////////////////////
inout	[15:0]	ENET_DATA;				//	DM9000A DATA bus 16Bits
output			ENET_CMD;				//	DM9000A Command/Data Select, 0 = Command, 1 = Data
output			ENET_CS_N;				//	DM9000A Chip Select
output			ENET_WR_N;				//	DM9000A Write
output			ENET_RD_N;				//	DM9000A Read
output			ENET_RST_N;				//	DM9000A Reset
input			   ENET_INT;				//	DM9000A Interrupt
output			ENET_CLK;				//	DM9000A Clock 25 MHz
////////////////////	Audio CODEC		////////////////////////////
inout			   AUD_ADCLRCK;			//	Audio CODEC ADC LR Clock
input			   AUD_ADCDAT;				//	Audio CODEC ADC Data
inout			   AUD_DACLRCK;			//	Audio CODEC DAC LR Clock
output			AUD_DACDAT;				//	Audio CODEC DAC Data
inout			   AUD_BCLK;				//	Audio CODEC Bit-Stream Clock
output			AUD_XCK;				//	Audio CODEC Chip Clock
////////////////////	TV Devoder		////////////////////////////
input	 [7:0]	TD_DATA;    			//	TV Decoder Data bus 8 bits
input			   TD_HS;					//	TV Decoder H_SYNC
input			   TD_VS;					//	TV Decoder V_SYNC
output			TD_RESET;				//	TV Decoder Reset
input          TD_CLK27;            //	TV Decoder 27MHz CLK
////////////////////////	GPIO	////////////////////////////////
inout	[35:0]	GPIO_0;					//	GPIO Connection 0
inout	[35:0]	GPIO_1;					//	GPIO Connection 1

/////////////////////////////////START////////////////////////////////////////**************////////////**//
//******************************FETCH*********************************
wire HD_Hazard_Detection;
wire [31:0] PC, Instruction;
wire BR_TAKEN, clk, rst, inst, flush;
assign rst = SW[0];
assign clk = CLOCK_50;
wire [31:0] IF_reg_PC_out, EXE_STAGE_BR_ADDR, IF_reg_Inst_out;

assign flush = BR_TAKEN;
IF_Stage ifs(.clk(clk), .rst(rst), .freeze(general_freeze), .br_taken(BR_TAKEN), .br_addr(EXE_STAGE_BR_ADDR), .PC(PC), .instruction(Instruction));
IF_Stage_reg ifsr(.clk(clk), .rst(rst), .freeze(general_freeze), .flush(flush), .PC_in(PC), .instruction_in(Instruction), .PC(IF_reg_PC_out), .instruction(IF_reg_Inst_out));
Bin_to_7Seg ifseg(PC[3:0], HEX0);
assign LEDG[0] = clk;

Bin_to_7Seg ifseg2(Instruction[24:21], HEX5);
//assign HEX5 = Instruction[24:21];
assign LEDR[4:1] = Instruction[24:21];
assign LEDR[8:5] = SW[4:1];
assign LEDR[9] = inst;
//***********************DECODE*******************
wire ID_WB_WR_EN, ID_MEM_R_EN, ID_MEM_W_EN, ID_WB_EN, ID_reg_MEM_R_EN, ID_reg_MEM_W_EN, ID_reg_WB_EN, MEM_WB_EN, ID_stage_MEM_W_EN;
wire [31:0] ID_reg_PC_out, ID_REG2, ID_Val1, ID_val2, ID_WB_DATA, ID_REG2_out, ID_Val2_out, ID_val1_out, WB_stage_W_value;
wire [4:0] ID_WB_DST, ID_Dest, ID_DST_OUT;
wire [3:0] ID_EXE_CMD, exe_cmd ;
wire [1:0] ID_Branch_type, ID_BR_out;
wire [4:0] MEM_Reg_dest;
wire ID_is_single_src, ID_is_BNE, MEM_stage_ready;
//src1 and src2
wire [4:0] ID_SRC1,ID_SRC2,ID_REG_SRC1,ID_REG_SRC2;

ID_Stage ids(.clk(clk), .rst(rst), .freeze(general_freeze), .Instruction(IF_reg_Inst_out), .WB_Write_Enable(MEM_WB_EN), .WB_Dest(MEM_Reg_dest), .WB_Data(WB_stage_W_value),
				.Dest(ID_Dest), .Reg2(ID_REG2), .Val1(ID_Val1), .Val2(ID_val2), .EXE_CMD(ID_EXE_CMD), 
				.Branch_Type(ID_Branch_type), .MEM_R_EN(ID_MEM_R_EN), .MEM_W_EN(ID_stage_MEM_W_EN), 
				.WB_EN(ID_WB_EN),.src1(ID_SRC1),.src2(ID_SRC2), .is_single_src(ID_is_single_src), .is_BNE(ID_is_BNE));

ID_Stage_reg idsr(.clk(clk), .rst(rst), .Flush(flush), .freeze(~MEM_stage_ready), .Dest_in(ID_Dest), .Reg2_in(ID_REG2), .Val1_in(ID_Val1), .Val2_in(ID_val2),
					.PC_in(IF_reg_PC_out), .br_type_in(ID_Branch_type), .EXE_CMD_in(ID_EXE_CMD), .MEM_R_EN_in(ID_MEM_R_EN),
					.MEM_W_EN_in(ID_stage_MEM_W_EN), .WB_EN_in(ID_WB_EN),.src1_in(ID_SRC1),.src2_in(ID_SRC2),
					.Dest(ID_DST_OUT), .Reg2(ID_REG2_out), .Val2(ID_Val2_out),
					.Val1(ID_val1_out), .PC_out(ID_reg_PC_out), .br_type_out(ID_BR_out), .EXE_CMD(exe_cmd), 
					.MEM_R_EN(ID_reg_MEM_R_EN),.MEM_W_EN(ID_MEM_W_EN), .WB_EN(ID_reg_WB_EN),.src1(ID_REG_SRC1), .src2(ID_REG_SRC2));

Bin_to_7Seg idseg(ID_reg_PC_out[3:0], HEX1);
//*********************EXECUTION***********************
wire EXE_reg_WB_EN, EXE_reg_MEM_R_EN, EXE_reg_MEM_W_EN;
wire [31:0] EXE_reg_PC_out, EXE_STAGE_ALU_RES, EXE_PC_out, EXE_reg_ALU_result, EXE_reg_ST_val, EXE_st_Src2_val;
wire [4:0] EXE_reg_Dest;



//forwarding unit
wire [1:0] EXE_Val1_sel,EXE_Val2_sel,EXE_Src2_Val_sel;


EXE_Stage es(.clk(clk), .EXE_CMD(exe_cmd), .val1(ID_val1_out), .val2(ID_Val2_out), .val_src2(ID_REG2_out), .PC(ID_reg_PC_out),
				.Br_type(ID_BR_out),.val1_sel(EXE_Val1_sel),.val2_sel(EXE_Val2_sel), .src2_val_sel(EXE_Src2_Val_sel),
				.EXE_Reg_ALU_result(EXE_reg_ALU_result), .src2_val(EXE_st_Src2_val), .WB_Write_val(WB_stage_W_value),
				.ALU_result(EXE_STAGE_ALU_RES), .Br_Addr(EXE_STAGE_BR_ADDR), .Br_taken(BR_TAKEN));


EXE_Stage_reg esr(.clk(clk), .rst(rst), .freeze(~MEM_stage_ready), .WB_en_in(ID_reg_WB_EN), .MEM_R_EN_in(ID_reg_MEM_R_EN), .MEM_W_EN_in(ID_MEM_W_EN),
 					.ALU_result_in(EXE_STAGE_ALU_RES), .ST_val_in(EXE_st_Src2_val), .Dest_in(ID_DST_OUT),
 					.WB_en(EXE_reg_WB_EN), .MEM_R_EN(EXE_reg_MEM_R_EN),.MEM_W_EN(EXE_reg_MEM_W_EN), .ALU_result(EXE_reg_ALU_result),
 					.ST_val(EXE_reg_ST_val), .Dest(EXE_reg_Dest));
Bin_to_7Seg eseg(EXE_reg_PC_out[3:0], HEX2);

//*********************MEMORY**************************
wire [31:0] MEM_reg_PC_out, Mem_stage_read_value, MEM_Reg_ALU_res, MEM_Reg_Mem_read_val, MEM_PC_out;
wire MEM_Reg_Mem_R_en;

MEM_Stage ms(.clk(clk), .rst(rst), .MEM_R_EN_in(EXE_reg_MEM_R_EN), .MEM_W_EN_in(EXE_reg_MEM_W_EN), .ALU_result_in(EXE_reg_ALU_result),
				.ST_val(EXE_reg_ST_val), .Mem_read_value(Mem_stage_read_value), .ready(MEM_stage_ready), .SRAM_DQ(SRAM_DQ)
				, .SRAM_ADDR(SRAM_ADDR), .SRAM_UB_N(SRAM_UB_N), .SRAM_LB_N(SRAM_LB_N), .SRAM_WE_N(SRAM_WE_N), .SRAM_CE_N(SRAM_CE_N)
				, .SRAM_OE_N(SRAM_OE_N));

MEM_Stage_reg msr(.clk(clk), .rst(rst), .freeze(~MEM_stage_ready), .WB_en_in(EXE_reg_WB_EN), .MEM_R_EN_in(EXE_reg_MEM_R_EN), .ALU_result_in(EXE_reg_ALU_result), 
				.MEM_read_value_in(Mem_stage_read_value), .Dest_in(EXE_reg_Dest), .WB_en(MEM_WB_EN), .MEM_R_en(MEM_Reg_Mem_R_en),
				.ALU_result(MEM_Reg_ALU_res), .MEM_read_value(MEM_Reg_Mem_read_val), .Dest(MEM_Reg_dest));

Bin_to_7Seg mseg(MEM_reg_PC_out[3:0], HEX3);
//*******************WRITEBACK****************************
wire [31:0] WB_PC_out;
wire [31:0] WB_reg_PC_out;

WB_Stage ws(.clk(clk), .MEM_R_EN(MEM_Reg_Mem_R_en), .ALU_result(MEM_Reg_ALU_res), .Mem_read_value(MEM_Reg_Mem_read_val), 
			.Write_value(WB_stage_W_value));

Bin_to_7Seg wbseg(WB_reg_PC_out[3:0], HEX4);
//******************HAZARD DETECTION**********************
Hazard_Detection_Unit hdu(.src1(IF_reg_Inst_out[25:21]), .src2(IF_reg_Inst_out[20:16]), 
						  .Exe_Dest(ID_DST_OUT), .Exe_WB_EN(ID_reg_WB_EN), .Exe_Mem_R_En(ID_reg_MEM_R_EN), 
						  .Mem_Dest(EXE_reg_Dest), .Mem_WB_EN(EXE_reg_WB_EN), 
						  .is_single_src(ID_is_single_src), .is_BNE(ID_is_BNE), .mode(SW[2]), .hazard_Detected(HD_Hazard_Detection));

//******************FORWARDING UNIT**********************
wire enable_forward_unit;
assign enable_forward_unit = SW[2];
//355
ForwardingUnit fu(.src1(ID_REG_SRC1),.src2(ID_REG_SRC2),.id_reg_dest(ID_DST_OUT),
				.mem_reg_dest(MEM_Reg_dest),.is_bne(ID_is_BNE), .is_store(ID_MEM_W_EN), .exe_reg_dest(EXE_reg_Dest),
				.exe_reg_wb(EXE_reg_WB_EN),.mem_reg_wb(MEM_WB_EN),.enable_forward_unit(enable_forward_unit),
				.val1_sel(EXE_Val1_sel),.val2_sel(EXE_Val2_sel),.src2_val_sel(EXE_Src2_Val_sel));

assign general_freeze = HD_Hazard_Detection | ~MEM_stage_ready;

endmodule

