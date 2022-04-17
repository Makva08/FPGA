module uart_tx(
	input CLOCK_50,
	input [1:0]KEY,
	input [3:0] SW,
	output reg tx
	);	

	 reg [1:0] state=0;
    parameter S0 = 2'b00;
    parameter S1 = 2'b01;
    parameter S2 = 2'b10;
    parameter S3 = 2'b11;
	 
	 //uart data
	 reg [7:0] DATA;
	 parameter START_BIT=0;
	 reg PARITY_BIT=0;
	 reg STOP_BIT =1;
	 parameter BAUD_RATE=1000;
	 FreqDiv #(.divideBy( 50000 / BAUD_RATE)) FD (.refClk(CLOCK_50), .outClk(txClk));
	 
	 //tx == 1;
	 reg [3:0] i = 0;
	 reg [10:0] pack;
	 
	 //buttons
	 reg [1:0] keyreg, keyregpp; 
	 wire flag1trig,flag0trig;
	 assign flag1trig=~keyreg[1] && keyregpp[1];
	 assign flag0trig=~keyreg[0] && keyregpp[0];
	 

    always @ (posedge CLOCK_50) begin
		 
		 keyreg<=KEY;
		 keyregpp<=keyreg; 
		 
		 case (state)
		 
			 S0: 	begin
					i=0;
					if (flag1trig) DATA[3:0]<=SW; 
					if (flag0trig) state <= S1;
					end
					
			 S1:  begin
					if (flag1trig) DATA[7:4]<=SW;
					PARITY_BIT <= ~(^ DATA);
					if (flag0trig) state <= S2;
					end
					
			 S2:  begin
					pack[0] <=START_BIT;
					pack[8:1] <=DATA;
					pack[9] <=PARITY_BIT;
					pack[10] <=STOP_BIT;
					if (flag0trig) state <= S3;
					end
					
			S3:	begin
					if (txClk==1)
						if (i<10) begin i<=i+1;
							tx<=pack[i]; end
							
					if (flag0trig) state <= S0;
					end

			 default: state = S0;
		 
		endcase
	 end
	 

endmodule

