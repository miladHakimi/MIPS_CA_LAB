module Hazard_Detection_Unit(
		input [4:0] src1,
		input [4:0] src2,
		input [4:0] Exe_Dest,
		input Exe_WB_EN,
		input Exe_Mem_R_En,
		input [4:0] Mem_Dest,
		input Mem_WB_EN,
		input is_single_src,
		input is_BNE,
		input mode,
		output reg hazard_Detected);
	always @(*) begin
		if (mode == 1'b0) begin
			if((is_BNE|| is_single_src == 1'b0) &&(src1 == Exe_Dest || src2 == Exe_Dest) && Exe_WB_EN == 1'b1)begin
				hazard_Detected = 1'b1;
			end
			else if((is_BNE || is_single_src == 1'b0) &&(src1 == Mem_Dest || src2 == Mem_Dest) && Mem_WB_EN == 1'b1)begin
				hazard_Detected = 1'b1;
			end
			else if(is_single_src == 1'b1 && ((src1 == Exe_Dest) && Exe_WB_EN || (src1 == Mem_Dest) && Mem_WB_EN))begin
				hazard_Detected = 1'b1;
			end
			else
				hazard_Detected = 1'b0;
		end

		else begin
			
			if((src1 == Exe_Dest || src2 == Exe_Dest) && Exe_Mem_R_En == 1'b1)
				hazard_Detected = 1'b1;
			else
				hazard_Detected = 1'b0;
		end
	end
endmodule