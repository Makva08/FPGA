module sevenseg (input CLOCK_50,
	input [1:0] KEY,
	output reg [6:0] segments,
	output reg [3:0] one_seg);
	
	slowClk #(.divideBy(50000000/1000)) disp (.refClk(CLOCK_50), .outClk(displayselectorclock));
	slowClk #(.divideBy(50000000/1)) one (.refClk(CLOCK_50), .outClk(onesecondclock));
	
	reg [1:0] keyreg, keyregpp;
	
	reg [3:0] data = 0;
	
	wire displayselectorclock, onesecondclock;
	
	reg [1:0] select = 0;
	
	reg [15:0] counter = 0;
	 
	wire pause,reset;
	assign pause=~keyreg[1] && keyregpp[1];
	assign reset=~keyreg[0] && keyregpp[0];
	
	reg count_enable = 0;

	always @ (posedge CLOCK_50) begin
	
	keyreg<=KEY;
	keyregpp<=keyreg;
	
	if (displayselectorclock) select <= select + 1;
	
	if(onesecondclock && count_enable==0) counter <= counter + 1; 
	if (pause) count_enable <= ~count_enable;
	if (reset) counter <= 0;		
		
	case(select)
		2'b00: begin one_seg <= 4'b0001; data <= counter[3:0]; end
		2'b01: begin one_seg <= 4'b0010; data <= counter[7:4]; end
		2'b10: begin one_seg <= 4'b0100; data <= counter[11:8]; end
		2'b11: begin one_seg <= 4'b1000; data <= counter[15:12]; end
	endcase
		

	case(data)
		0:segments<=7'b1000000;
		1:segments<=7'b1111001;
		2:segments<=7'b0100100; 
		3:segments<=7'b0110000; 
		4:segments<=7'b0011001;
		5:segments<=7'b0010010;
		6:segments<=7'b0000010;
		7:segments<=7'b1111000; 
		8:segments<=7'b0000000; 
		9:segments<=7'b0010000;
		10:segments<=7'b0001000;
		11:segments<=7'b0000011;
		12:segments<=7'b1000110;
		13:segments<=7'b0100001;
		14:segments<=7'b0000110;
		15:segments<=7'b0001110; 
		default:segments<=7'b1111111;
	endcase

			
	end
endmodule

