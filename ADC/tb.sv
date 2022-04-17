module tb(input a);

logic clk = 0;
always #10 clk <= ~clk;

logic SDO;
logic[11:0] data = 12'b111110011111;

ADC_Read readtb(.clk(clk),.SDO(SDO));


logic[7:0] data_shift = 8'b10011001;
shiftreg shift(.clk(clk), .data(data_shift));

initial begin
//#2000; $stop; end

always @(posedge clk)
begin
    data <= {data[0],data[11:1]};
    SDO <= data[0];    
end

    
endmodule
