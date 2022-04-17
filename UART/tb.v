module tb;

	reg clk=0;
	reg [1:0] KEY=3;
	reg [3:0] SW=0;
	wire [7:0] LED;
	wire tx;
	reg rx;
	
	
	uart_tx trans(.CLOCK_50(clk), .KEY(KEY), .SW(SW), .tx(tx));
	uart_rx res(.CLOCK_50(clk), .rx(tx), .LED(LED));
	
	always #1 clk<=~clk;
	initial begin 
	
	#100;
	
	
		//state1
		SW=7;			//0111
		#100; KEY[1]=1; #50; KEY[1]=0; 
		#50; KEY[0]=1; #20; KEY[0]=0; 
	
		//state2
		SW=14;			//1110
		#100; KEY[1]=1; #50; KEY[1]=0; 
		#50; KEY[0]=1; #20; KEY[0]=0; 
		
		//state3
		#50; KEY[0]=1; #20; KEY[0]=0; 
		
		#50000; KEY[0]=1; #20; KEY[0]=0; 
		
		
		//state1
		SW=0;			//0111
		#100; KEY[1]=1; #50; KEY[1]=0; 
		#50; KEY[0]=1; #20; KEY[0]=0; 
	
		//state2
		SW=1;			//1110
		#100; KEY[1]=1; #50; KEY[1]=0; 
		#50; KEY[0]=1; #20; KEY[0]=0; 
		
		//state3
		#50; KEY[0]=1; #20; KEY[0]=0;
		
		
	$stop;
	end
	
	endmodule 