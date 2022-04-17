module de0_nano_soc_baseline(
	input CLOCK_50,
	input	[1:0] KEY,
	input	[3:0]	SW, 
	output [35:0] GPIO_0);
	
	sevenseg S(.CLOCK_50(CLOCK_50), .KEY(KEY), .segments(GPIO_0[6:0]), .one_seg(GPIO_0[11:8]));
	
	
	
	//uart_rx res(.CLOCK_50(CLOCK_50), .rx(GPIO_0[1]), .LED(LED));
	
	
endmodule
	

