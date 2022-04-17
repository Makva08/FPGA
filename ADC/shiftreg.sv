module shiftreg(
    input logic clk,
    input logic[7:0] data,
    output logic RCLK,
    output logic SRCLK,
    output logic SER        
);
    
typedef enum{idle, busy} SR_STAGE;
SR_STAGE stage = idle;

logic SR_clk_en = 0; 
SR_clken myCE(.refClk(clk),.SR_clk(SRCLK),.enable(SR_clk_en));
    
    
logic [3:0] count = 0;
logic [7:0] data_to_shift = 0;
    
always @(posedge clk)
begin

case(stage)
    idle:
    begin
        stage <= busy;
        SR_clk_en <= 1;
        data_to_shift <= data;
        SER <= data[7];
        RCLK <= 0;    
    end
    
    
    busy:
    begin
        
        if(SRCLK)
        begin
            count <= count + 1;
            if(count != 7) SER <= data_to_shift[6 - count];
            if(count == 7)
            begin
                stage <= idle;
                SR_clk_en <= 0;
                RCLK <= 1;
                count <= 0;
                SER <= 0;
            end     
        end
    end
    
endcase
end
    
    
endmodule
