module ADC_Disp(
    input[11:0] ADC_Reading,
    output[7:0] LED
);

assign LED = ADC_Reading[11:4];

endmodule
    
	 
	 
module ADC_Read(
    input logic clk,
    input logic SDO,
    output logic SCK,
    output logic SDI = 0,
    output logic CONVST = 0,
    output logic[11:0] ADC_Reading = 0
);

localparam SDI_data = 6'b100010;

typedef enum {idle, conv_st, conv_wait, send_sdi, rec_sdo} ADC_STAGE;
ADC_STAGE stage = idle;

logic SCK_en = 0;
clkDiv S_CLK(.refClk(clk),.enable(SCK_en),.outClk(SCK));

logic SCK_prevState = 0;
logic SCK_posedge, SCK_negedge;
assign SCK_posedge = ~SCK_prevState & SCK;
assign SCK_negedge = SCK_prevState & ~SCK;

logic[7:0] count = 0;

logic [11:0] reading_local = 0;

always @(posedge clk) begin
    
    SCK_prevState <= SCK;

    case(stage)
    idle:begin
        count <= count + 1;
        if(count == 15)
        begin
            stage <= conv_st;
            CONVST <= 1;
            count <= 0;
        end   end
		  
    conv_st:begin
			  count <= count + 1;
			  if(count == 1)
			  begin
					stage <= conv_wait;
					CONVST <= 0;
					count <= 0;
			  end   end
			  
    conv_wait:begin
				  count <= count + 1;
				  if(count == 80) begin
						stage <= send_sdi;
						SCK_en <= 1;
						SDI <= SDI_data[5];
						reading_local[11] <= SDO;
						count <= 0;
				  end
			 end
    
    send_sdi: begin
				  if(SCK_posedge & count != 5) SDI <= SDI_data[4 - count];
				  if(SCK_negedge) begin
						count <= count + 1;
						reading_local[10-count] <= SDO; end
				  if(count == 4) begin
						stage <= rec_sdo;end   end
    
    rec_sdo:begin
			  if(SCK_negedge)
			  begin
					count <= count + 1;
					reading_local[10-count] <= SDO;
			  end
			  if(count == 10) SCK_en <= 0;
			  if(count == 11)
			  begin
					count <= 0;
					stage <= conv_st;
					CONVST <= 1;
					ADC_Reading <= reading_local;    
			  end   end    
		 
    default: stage <= idle; 
    
    endcase

end

    
endmodule
