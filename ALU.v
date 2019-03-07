module ALU(
    input [31:0] in1,
    input [31:0] in2,
    input [3:0] cmd,
    output [31:0] result
);
reg [31:0] temp;
always @(in1,in2,cmd) begin
    temp <= 32'b0;
    if(cmd == 4'b0000)
        temp <= in1 + in2;
    if(cmd == 4'b0010)
        temp <= in1 - in2;
    if(cmd == 4'b0100)
        temp <= in1 & in2;
    if(cmd == 4'b0101)
        temp <= in1 | in2;
    if(cmd == 4'b0110)
        temp <= ~(in1 | in2);
    if(cmd == 4'b0111)
        temp <= in1 ^ in2;
    if(cmd == 4'b1000)
        temp <= in1 << in2;
    if(cmd == 4'b1001)
        temp <= $signed(in1) >>> in2;
    if(cmd == 4'b1010)
        temp <= in1 >> in2;
end
assign result = temp;
endmodule