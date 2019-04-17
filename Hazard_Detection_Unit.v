module Hazard_Detection_Unit(
		input [4:0] src1,
		input [4:0] src2,
		input [4:0] Exe_Dest,
		input Exe_WB_EN,
		input [4:0] Mem_Dest,
		input Mem_WB_EN,
		input is_single_src,
		input is_BNE,
		output reg hazard_Detected);
	always @(*) begin
		if((is_BNE|| is_single_src == 1'b0) &&(src1 == Exe_Dest || src2 == Exe_Dest) && Exe_WB_EN == 1'b1)begin
			hazard_Detected = 1'b1;
			$display("exe not immediate!");
		end
		else if((is_BNE || is_single_src == 1'b0) &&(src1 == Mem_Dest || src2 == Mem_Dest) && Mem_WB_EN == 1'b1)begin
			hazard_Detected = 1'b1;
			$display("mem not immediate!");
		end
		else if(is_single_src == 1'b1 && ((src1 == Exe_Dest) && Exe_WB_EN || (src1 == Mem_Dest) && Mem_WB_EN))begin
			hazard_Detected = 1'b1;
			$display("immediate!");
		end
		else begin
			hazard_Detected = 1'b0;
		end
	end
endmodule