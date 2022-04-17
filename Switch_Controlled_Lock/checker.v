module checker(
input clk,
input [1:0]KEY,
input [3:0] SW,
output reg [7:0] LED);	

	
	reg [1:0] state=0;
	 
    parameter S0 = 2'b00;
    parameter S1 = 2'b01;
    parameter S2 = 2'b10;
    parameter S3 = 2'b11;
	 
	 //buttons
	 reg [1:0] keyreg, keyregpp; 
	 wire flag1trig,flag0trig;
	 assign flag1trig=~keyreg[1] && keyregpp[1];
	 assign flag0trig=~keyreg[0] && keyregpp[0];
	 

    always @ (posedge clk) begin
	 
	 keyreg<=KEY;
	 keyregpp<=keyreg; 
	 
    case (state)
	 
    S0: 	begin
			LED[7:0]<=0;
			state = S1;
			end
			
    S1:  begin
			LED[0]=1;
			if(SW == 0 && flag1trig) state = S2;
			if(SW != 0 && flag1trig) state = S1;
		   end
			
    S2:  begin
			LED[0]=0; LED[1]=1;
			if(SW == 1 && flag1trig) state = S3;
			if(SW == 0 && flag1trig) state = S2;
			if(SW != 0 && SW != 1 && flag1trig) state = S1;
			end
			
    S3:  begin
			LED[0]=1; LED[1]=1;
			if(SW == 1 && flag1trig) LED <= 8'b11111111;
			if(SW == 0 && flag1trig) state = S2;
			if(SW != 0 && SW != 1 && flag1trig) state = S1;
			if (flag0trig) state =S0;
			end
	
    default: state = S0;
    endcase
	 end
	 

endmodule
