module Instruction_MEM(
			input [31:0] r_addr,
			output [31:0] r_data);
			reg [31:0]inst[200:0];
			wire [2:0] shift_addr;
			initial begin

				inst[0] = 32'b100000_00000_00001_00000_11000001010;//-- Addi r1 ,r0 ,1546 //r1=1546
				
				inst[2] = 32'b0;
				inst[3] = 32'b0;
				inst[5] = 32'b0;
				inst[5] = 32'b0;
				
				inst[6] = 32'b000001_00000_00001_00010_00000000000;//-- Add r2 ,r0 ,r1//r2=1546
				inst[7] = 32'b000011_00000_00001_00011_00000000000;//-- sub r3 ,r0 ,r1//r3=-1546
				
				inst[8] = 32'b0;
				inst[9] = 32'b0;
				inst[10] = 32'b0;
				inst[11] = 32'b0;
				
				inst[12] = 32'b000101_00010_00011_0010000000000000; //--and r4,r2,r3 //r4=2
				inst[13] = 32'b100001_00011_00101_0001101000110100; //--subi r5,r3,//r5=-8254
				
				inst[14] = 32'b0;
				inst[15] = 32'b0;
				inst[16] = 32'b0;
				inst[17] = 32'b0;
				
				inst[18] = 32'b000110_00011_00100_0010100000000000; //--or r5,r3,r4 //r5=-1546
				
				inst[19] = 32'b0;
				inst[20] = 32'b0;
				inst[21] = 32'b0;
				inst[22] = 32'b0;

				inst[23] = 32'b000111_00101_00000_0011000000000000; //--nor r6,r5,r0//r6=1545

				inst[24] = 32'b000111_00100_00000_0101100000000000; //--nor r11,r4,r0//r11=-3
				inst[25] = 32'b000011_00101_00101_0010100000000000; //--sub r5,r5,r5//r5=0
				inst[26] = 32'b100000_00000_00001_0000010000000000; //--addi r1,r0,1024 //r1=1024

				inst[27] = 32'b0;
				inst[28] = 32'b0;
				inst[29] = 32'b0;
				inst[30] = 32'b0;

				inst[31] = 32'b100101_00001_00010_0000000000000000;//-- st r2 ,r1 ,0 //
				
				inst[32] = 32'b0;
				inst[33] = 32'b0;
				inst[34] = 32'b0;
				inst[35] = 32'b0;

				inst[36] = 32'b100100_00001_00101_00000_00000000000;//-- ld r5 ,r1 ,0 //r5=1546

				inst[37] = 32'b0;
				inst[38] = 32'b0;
				inst[39] = 32'b0;
				inst[40] = 32'b0;

				inst[41] = 32'b101000_00101_00000_00000_00000000001;//-- Bez r5 ,1//not taken

				inst[42] = 32'b001000_00101_00001_00111_00000000000;//-- xor r7 ,r5 ,r1 //r7=522
				inst[41] = 32'b001000_00101_00001_00000_00000000000;//-- xor r0 ,r5 ,r1 //r0=0

				inst[43] = 32'b0;
				inst[44] = 32'b0;
				inst[45] = 32'b0;
				inst[46] = 32'b0;

				inst[47] = 32'b001001_00011_00100_00111_00000000000;//-- sla r7 ,r3 ,r4//r7=-6184

				inst[48] = 32'b0;
				inst[49] = 32'b0;
				inst[50] = 32'b0;
				inst[51] = 32'b0;
				
				inst[52] = 32'b100101_00001_00111_00000_00000010100;//-- st r7 ,r1 ,20
				inst[53] = 32'b001010_00011_00100_01000_00000000000;//-- sll r8 ,r3 ,r4 //r8=-6184
				inst[54] = 32'b001011_00011_00100_01001_00000000000;//-- sra r9 ,r3 ,r4 //r9=1073741437
				inst[55] = 32'b001100_00011_00100_01010_00000000000;//-- srl r10 ,r3 ,r4//r10=-384
				inst[56] = 32'b100101_00001_00011_00000_00000000100;//-- st r3 ,r1 ,4
				inst[57] = 32'b100101_00001_00100_00000_00000001000;//-- st r4 ,r1 ,8
				inst[58] = 32'b100101_00001_00101_00000_00000001100;//-- st r5 ,r1 ,12
				inst[59] = 32'b100101_00001_00110_00000_00000010000;//-- st r6 ,r1 ,16
				inst[60] = 32'b100100_00001_01011_00000_00000000100;//-- ld r11 ,r1 ,4//r11=-1456

				inst[61] = 32'b0;
				inst[62] = 32'b0;
				inst[63] = 32'b0;
				inst[64] = 32'b0;

				inst[65] = 32'b100101_00001_01011_00000_00000011000;//-- st r11 ,r1 ,24
				inst[66] = 32'b100101_00001_01001_00000_00000011100;//-- st r9 ,r1 ,28
				inst[67] = 32'b100101_00001_01010_00000_00000100000;//-- st r10 ,r1 ,32
				inst[68] = 32'b100101_00001_01000_00000_00000100100;//-- st r8 ,r1 ,36

				inst[69] = 32'b100000_00000_00001_00000_00000000011;//-- Addi r1 ,r0 ,3 //r1=3
				inst[70] = 32'b100000_00000_00100_00000_10000000000;//-- Addi r4 ,r0 ,1024 //r4=1024
				inst[71] = 32'b100000_00000_00010_00000_00000000000;//-- Addi r2 ,r0 ,0 //r2=0
				inst[72] = 32'b100000_00000_00011_00000_00000000001;//-- Addi r3 ,r0 ,1 //r3=1
				inst[73] = 32'b100000_00000_01001_00000_00000000010;//-- Addi r9 ,r0 ,2 //r9=2

				inst[74] = 32'b0;
				inst[75] = 32'b0;
				inst[76] = 32'b0;
				inst[77] = 32'b0;

				inst[78] = 32'b001010_00011_01001_01000_00000000000;//-- sll r8 ,r3 ,r9 //r8=r3*4

				inst[79] = 32'b0;
				inst[80] = 32'b0;
				inst[81] = 32'b0;
				inst[82] = 32'b0;

				inst[83] = 32'b000001_00100_01000_01000_00000000000;//-- Add r8 ,r4 ,r8 //r8=1024+r3*4

				inst[84] = 32'b0;
				inst[85] = 32'b0;
				inst[86] = 32'b0;
				inst[87] = 32'b0;

				inst[88] = 32'b100100_01000_00101_00000_00000000000;//-- ld r5 ,r8 ,0 //

				inst[89] = 32'b0;
				inst[90] = 32'b0;
				inst[91] = 32'b0;
				inst[92] = 32'b0;

				inst[93] = 32'b100100_01000_00110_11111_11111111100;//-- ld r6 ,r8 ,-4 //

				inst[94] = 32'b0;
				inst[95] = 32'b0;
				inst[96] = 32'b0;
				inst[97] = 32'b0;

				inst[98] = 32'b000011_00101_00110_01001_00000000000;//-- sub r9 ,r5 ,r6

				inst[99] =   32'b100000_00000_01010_10000_00000000000;//-- Addi r10 ,r0 ,0x8000
				inst[100] =  32'b100000_00000_01011_00000_00000010000;//-- Addi r11 ,r0 ,16 //2

				inst[101] = 32'b0;
				inst[102] = 32'b0;

				inst[103] =  32'b001010_01010_01011_01010_00000000000;//-- sll r10 ,r1 ,r11 //2

				inst[104] = 32'b0;
				inst[105] = 32'b0;

				inst[106] =  32'b000101_01001_01010_01001_00000000000;//-- And r9 ,r9 ,r10 // if(r5>r6) r9=0 else r9=-2147483648

				inst[107] = 32'b0;
				inst[108] = 32'b0;

				inst[109] =  32'b101000_01001_00000_00000_00000000010;//-- Bez r9 ,2
				inst[110] =  32'b100101_01000_00101_11111_11111111100;//-- st r5 ,r8 ,-4
				inst[111] =  32'b100101_01000_00110_00000_00000000000;//-- st r6 ,r8 ,0
				inst[112] =  32'b100000_00011_00011_00000_00000000001;//-- Addi r3 ,r3 ,1 //2
				
				inst[113] = 32'b0;
				inst[114] = 32'b0;
				
				inst[115] =  32'b101001_00001_00011_11111_11111110001;//-- BNE r1 ,r3 ,-15

				inst[116] = 32'b0;
				inst[117] = 32'b0;	
				inst[118] = 32'b0;
				inst[119] = 32'b0;
			
				inst[120] =  32'b100000_00010_00010_00000_00000000001;//-- Addi r2 ,r2 ,1 //2
				inst[121] =  32'b101001_00001_00010_11111_11111101110;//-- BNE r1 ,r2 ,-18
				inst[122] = 32'b100000_00000_00001_00000_10000000000;//-- Addi r1 ,r0 ,1024 //r1=1024

				inst[123] = 32'b0;
				inst[124] = 32'b0;
				
				inst[125] = 32'b100100_00001_00010_00000_00000000000;//-- ld ,r2 ,r1 ,0 //r2=-1546
				inst[126] = 32'b100100_00001_00011_00000_00000000100;//-- ld ,r3 ,r1 ,4 //r3=2
				inst[127] = 32'b100100_00001_00100_00000_00000001000;//-- ld ,r4 ,r1 ,8 //r4=1546
				inst[128] = 32'b100100_00001_00100_00000_01000001000;//-- ld ,r4 ,r1 ,520 // after SRAM r4=random number
				inst[129] = 32'b100100_00001_00100_00000_10000001000;//-- ld ,r4 ,r1 ,1023 // after SRAM r4=random number
				inst[130] = 32'b100100_00001_00101_00000_00000001100;//-- ld ,r5 ,r1 ,12 // r5=1546
				inst[131] = 32'b100100_00001_00110_00000_00000010000;//-- ld ,r6 ,r1 ,16 //r6=1545
				inst[132] = 32'b100100_00001_00111_00000_00000010100;//-- ld ,r7 ,r1 ,20 //r7=-6184
				inst[133] = 32'b100100_00001_01000_00000_00000011000;//-- ld ,r8 ,r1 ,24 //r8=-1546
				inst[134] = 32'b100100_00001_01001_00000_00000011100;//-- ld ,r9 ,r1 ,28 //r9=1073741437
				inst[135] = 32'b100100_00001_01010_00000_00000100000;//-- ld ,r10,r1 ,32 //r10=-387
				inst[136] = 32'b100100_00001_01011_00000_00000100100;//-- ld ,r11,r1 ,36 //r11=-6184
				inst[137] = 32'b101010_00000_00000_11111_11111111111;//-- JMP -1*/
			end
			
			assign r_data = inst[r_addr >> 2];
			
endmodule