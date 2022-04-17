

module de0_nano_soc_baseline(
	input CLOCK_50,
	input	[1:0] KEY,
	output [7:0] LED,
	inout [35:0] GPIO_0,
	input	[3:0]	SW );
	
//	wire tx, rx;
//	
//	assign GPIO_0[0] = tx;
//	assign rx = GPIO_0[1];
//	
	uart_tx trans(.CLOCK_50(CLOCK_50), .KEY(KEY), .SW(SW), .tx(GPIO_0[0]));
	uart_rx res(.CLOCK_50(CLOCK_50), .rx(GPIO_0[1]), .LED(LED));
	
	
endmodule
	

