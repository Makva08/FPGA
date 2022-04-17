module clkDiv (
    input logic refClk,
    input logic enable,
    output logic outClk = 0);

logic clockOn = 0;

always @(posedge refClk)
begin
    if(enable) clockOn <= 1;
    else clockOn <= 0;
    
    if(clockOn) outClk <= ~outClk;
    else outClk <= 0;
end

endmodule


module SR_clken (
	input logic refClk,
	input logic enable,
	output logic SR_clk);

logic[2:0] count = 1;
assign SR_clk = count == 5;

always @(posedge refClk)
begin
    if(count == 5) count <= 1;
    else if(~enable) count <= 1;
    else count <= count + 1;
end

endmodule
