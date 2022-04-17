module FreqDiv #(
	parameter divideBy = 1
)(
	input reg refClk,
	output reg outClk = 0
);

int count = 1;

always @(posedge refClk)
begin
	
	if(2 * count == divideBy || 2 * count == divideBy + 1) 
	begin
		count <= 1;
		outClk <= 1;
	end
	else begin count <= count + 1;
		outClk <= 0; end
	
end

endmodule
