module tb;

	reg clk=0;
	reg [1:0] KEY=0;
	reg [3:0] SW=0;
	wire [7:0] LED;	  

	de0_nano_soc_baseline M(.CLOCK_50(clk), .KEY(KEY), .LED(LED), .SW(SW));
	
	always #5 clk<=~clk;
	initial begin 
	
	#100; //SW[1]=1; #50; SW[2]=1; #100; KEY[1]=1; #50; KEY[1]=0;
	SW=6; #100; KEY[1]=1; #50; KEY[1]=0; //does nothing as sw is not 0
	SW=0; #100; KEY[1]=1; #50; KEY[1]=0; 
	SW=9; #100; KEY[1]=1; #50; KEY[1]=0;
   SW=1; #100; KEY[1]=1; #50; KEY[1]=0;
	SW=3; #100; KEY[1]=1; #50; KEY[1]=0;
	SW=0; #100; KEY[1]=1; #50; KEY[1]=0;
	SW=1; #100; KEY[1]=1; #50; KEY[1]=0;	
	SW=1; #100; KEY[1]=1; #50; KEY[1]=0; //yay egaa
	#100; KEY[0]=1; #50; KEY[0]=0; //state0 
	
	
	end
	
	endmodule 