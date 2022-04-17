module de0_nano_soc_baseline(
	input CLOCK_50,
	input	[1:0] KEY,
	output [7:0]LED,
	input	[3:0] SW
	);

	checker indy1 (CLOCK_50, KEY, SW, LED);
	
	endmodule 