module tb;

	reg clk=0;
	reg [1:0] KEY=0;
	wire [7:0] LED;	  

	de0_nano_soc_baseline M(.CLOCK_50(clk), .KEY(KEY), .LED(LED));
	
	always #5 clk<=~clk;
	initial begin 
	
	#100;  //KEY[0]=1; #50; KEY[0]=0; //state 1shi wavida
	KEY[1]=1; #50; KEY[1]=0; #50; KEY[1]=1; #50; KEY[1]=0; #50; KEY[1]=1; #50; KEY[1]=0; #50; //3 dachera state 1shi
	#105;  KEY[0]=1; #50; KEY[0]=0; //wavedit state 2shi
	KEY[1]=1; #50; KEY[1]=0; #50; KEY[1]=1; #50; KEY[1]=0; #50; KEY[1]=1; #50; KEY[1]=0; #50;  //3 dachera state 2shi
	#105;  KEY[0]=1; #50; KEY[0]=0; //enter state3
	#105;  KEY[0]=1; #50; KEY[0]=0; //end

	
	end
	
	endmodule 