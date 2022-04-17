module de0_nano_soc_baseline(
	input CLOCK_50,
	input	[1:0]	KEY,
	output reg [7:0] LED);
	 
    parameter S0 = 2'b0000;
    parameter S1 = 2'b0001;
    parameter S2 = 2'b0010;
    parameter S3 = 2'b0011;
	 
	 reg [1:0] state=0;
	 reg [3:0] press_counter_A=0;
	 reg [3:0] press_counter_B=0;
	 reg [7:0] product=0;
	 reg [1:0] keyreg, keyregpp;
	 
	 wire flag1trig,flag0trig;
	 assign flag1trig=~keyreg[1] && keyregpp[1];
	 assign flag0trig=~keyreg[0] && keyregpp[0];
	 
    always @ (posedge CLOCK_50) begin
	 
	 keyreg<=KEY;  //butt became reg
	 keyregpp<=keyreg; 
	 
    case (state)
	 
    S0: 	begin
			LED[7:0]<=0;
			press_counter_A=0;
			press_counter_B=0;
			state = S1;
			end
			
    S1:  begin
			LED[0]<=1; LED[1]<=0;
			if (flag1trig) press_counter_A=press_counter_A+1; 
			if (flag0trig) state = S2;
		   end
			
    S2:  begin
			LED[0]<=1; LED[1]<=1;
			if (flag1trig) press_counter_B=press_counter_B+1;
			if (flag0trig) state = S3;
			end
			
    S3:  begin
			product <= press_counter_A * press_counter_B;
			LED[7:0]	<= product;
			if (flag0trig) state = S0;
			end
			
    default: state = S0;
    endcase
	 end
	 
    endmodule
	 