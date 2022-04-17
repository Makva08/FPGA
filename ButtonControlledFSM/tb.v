module tb;

	reg clk=0;
	reg [1:0] KEY=3;
	reg [3:0] SW=0;
	wire [7:0] LED;	  

	de0_nano_soc_baseline M(.CLOCK_50(clk), .KEY(KEY), .LED(LED), .SW(SW));
	
	always #5 clk<=~clk;
	initial begin 
	
	#100;
	
	SW=4'b1111; 
		#100; KEY[1]=1; #50; KEY[1]=0; 
		#50;  KEY[0]=1; #50; KEY[0]=0;// a
	
	SW=4'b1110; 
		#100; KEY[1]=1; #50; KEY[1]=0; 
		#50;  KEY[0]=1; #50; KEY[0]=0;// b
	#50;  KEY[0]=1; #50; KEY[0]=0; 
	
	SW=4'b0011; 
		#100; KEY[1]=1; #50; KEY[1]=0; 
		#50;  KEY[0]=1; #50; KEY[0]=0;// c
	
	SW=4'b0011; 
		#100; KEY[1]=1; #50; KEY[1]=0; 
		#50;  KEY[0]=1; #50; KEY[0]=0;// d
		#50;  KEY[0]=1; #50; KEY[0]=0;

		
	#100; KEY[0]=1; #50; KEY[0]=0;
	$stop;
	end
	
	endmodule 