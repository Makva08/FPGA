module slowClk #(
	parameter divideBy = 1
)(
	input refClk,
	output reg outClk = 0
);

integer count = 1;

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
