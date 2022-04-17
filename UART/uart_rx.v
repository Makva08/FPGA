module uart_rx(
	input CLOCK_50,
	input rx,
	output reg [7:0] LED);
	
	reg [10:0] received = 0;   //marto datas amovigo ledze
	
	FreqDiv #(.divideBy( 50000 / 1000)) FD (.refClk(CLOCK_50), .outClk(rxClk));
		 
	reg [1:0] state=0;
   parameter Idle = 2'b00;
   parameter Opa = 2'b01;
	
	reg [3:0] k = 0;
	
	integer i; 
	
	always @ (posedge CLOCK_50) begin

		
		case (state)
		 
			Idle: 	begin
						//araferi
						k <= 0;
						LED <= 0;
						if (rx == 0) state <= Opa;
						end
					
			Opa: 		begin
						received[k] <= rx;	
						if (rxClk) begin
							if (k<11)
								k<=k+1; end								
						if (~(^received[8:1]) == received[1]) LED[7:0] <= received[8:1];
						else LED[7:0] <= 8'b11111111;
						if (k >= 11) state <= Idle;					
						end	
		endcase	
		
	end 
		
endmodule
	