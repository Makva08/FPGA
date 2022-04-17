module de0_nano_soc_baseline(
	input CLOCK_50,
	output ADC_CONVST,
	output ADC_SCLK,
	output ADC_SDI,
	input ADC_SDO,
   inout[35:0]GPIO_0,
	input[1:0]KEY,
	output[7:0]LED,
	input [3:0]SW);

wire[11:0] result;


ADC_Read read( .clk(CLOCK_50), .CONVST(ADC_CONVST), .SCK(ADC_SCLK), .SDI(ADC_SDI), .SDO(ADC_SDO),.ADC_Reading(result));

full_sevenseg full(.clk(CLOCK_50),.value({4'b0000, result}),.display(GPIO_0[21:15]),.select(GPIO_0[9:6]));

endmodule
