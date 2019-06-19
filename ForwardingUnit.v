module ForwardingUnit(
    input [4:0] src1,
    input [4:0] src2,
    input [4:0] id_reg_dest,
    input [4:0] mem_reg_dest,
    input [4:0] exe_reg_dest,
    input exe_reg_wb,
    input mem_reg_wb,
    input is_bne,
    input is_store,
    input enable_forward_unit,
    output reg [1:0] val1_sel,
    output reg [1:0] val2_sel,
    output reg [1:0] src2_val_sel
);

always @(*) begin
    if (enable_forward_unit == 1'b1) begin
        if(src1 == exe_reg_dest && exe_reg_wb == 1'b1)
            val1_sel = 2'b01;
        else if (src1 == mem_reg_dest && mem_reg_wb == 1'b1)
            val1_sel = 2'b10;
        else
            val1_sel = 2'b00;

        if (is_store)
            val2_sel = 2'b00;
        else if (id_reg_dest == exe_reg_dest && exe_reg_wb == 1'b1 && is_bne)
            val2_sel = 2'b01;
        else if (id_reg_dest == mem_reg_dest && mem_reg_wb == 1'b1 && is_bne)
            val2_sel = 2'b10;
        else if (src2 == exe_reg_dest && exe_reg_wb == 1'b1)
            val2_sel = 2'b01;
        else if (src2 == mem_reg_dest && mem_reg_wb == 1'b1)
            val2_sel = 2'b10;
        else
            val2_sel = 2'b00;

        if (id_reg_dest == mem_reg_dest && mem_reg_wb == 1'b1)
            src2_val_sel = 2'b10;
        else if(id_reg_dest == exe_reg_dest && exe_reg_wb == 1'b1)
            src2_val_sel = 2'b01;
        else
            src2_val_sel = 2'b00;
    end
    else begin
        val1_sel = 2'b00;
        val2_sel = 2'b00;
        src2_val_sel = 2'b00;
    end
    

end
endmodule