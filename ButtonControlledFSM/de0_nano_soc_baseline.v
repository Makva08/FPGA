module de0_nano_soc_baseline(
	input CLOCK_50,
	input [1:0]	KEY,
	output reg [7:0] LED,
	input	[3:0]	SW );
	
		 
    reg [3:0] state=0;
	 
    parameter S0 = 4'b0000;
    parameter S1 = 4'b0001;
    parameter S2 = 4'b0010;
    parameter S3 = 4'b0011;
	 parameter S4 = 4'b0100;
	 parameter S5 = 4'b0101;
	 parameter S6 = 4'b0110;
	 parameter S7 = 4'b0111;
	 
	 //buttons
	 reg [1:0] keyreg, keyregpp; 
	 wire flag1trig,flag0trig;
	 assign flag1trig=~keyreg[1] && keyregpp[1];
	 assign flag0trig=~keyreg[0] && keyregpp[0];
	 
	 reg [3:0] a,b,c,d;
	 reg [7:0] num1, num2;
	 
	 reg [7:0] answer=0;

    always @ (posedge CLOCK_50) begin
	 
	 keyreg<=KEY;
	 keyregpp<=keyreg; 
	 
	 case (state)
	 
    S0: 	begin
			LED[7:0]<=0;
			state = S1;
			end
			
    S1:  begin
			LED=1;
			if (flag1trig) a<=SW; 
			if (flag0trig) state = S2;
		   end
			
    S2:  begin
			LED=2;
			if (flag1trig) b<=SW;
			num1 <= {SW,a};
			if (flag0trig) state = S3;
			end
			
    S3:  begin
			LED=3;
			if (num1[7]==1) num1 <= -num1;
			if (flag0trig) state = S4;
			end
			
    S4:  begin
			LED=4;
			if (flag1trig) c<=SW; 
			if (flag0trig) state = S5;
		   end
			
    S5:  begin
			LED=5;
			if (flag1trig) d<=SW;
			num2 <= {SW,c};
			if (flag0trig) state = S6;
			end
			
    S6:  begin
			LED=6;
			if (num2[7]==1) num2 <= ~(num2-1);
			if (flag0trig) state = S7;
			end
			
	 S7: begin
		  LED = 7;
		  if (num2 ==0) answer <= num1;
		  else if (num1 == 0) answer <= num2;
		  else if (num1==num2) answer <=num1;
		  else if (num1 > num2) num1 <= num1-num2;
		  else num2 <= num2 - num1;
		  LED <= answer;
		  if (flag0trig) state = S0;
		  end
		  
    default: state = S0;
    endcase
	 end
	
	
	
endmodule 