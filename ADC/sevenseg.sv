module sevenseg(
	input logic[3:0] one_seg,
	output logic[6:0] sevenseg);

logic[7:0] disp [15:0];

initial begin
    disp[0]  <= 7'b0111111;
    disp[1]  <= 7'b0000110;
    disp[2]  <= 7'b1011011;
    disp[3]  <= 7'b1001111;
    disp[4]  <= 7'b1100110;
    disp[5]  <= 7'b1101101;
    disp[6]  <= 7'b1111101;
    disp[7]  <= 7'b0000111;
    disp[8]  <= 7'b1111111;
    disp[9]  <= 7'b1101111;
    disp[10] <= 7'b1110111;
    disp[11] <= 7'b1111100;
    disp[12] <= 7'b0111001;
    disp[13] <= 7'b1011110;
    disp[14] <= 7'b1111001;
    disp[15] <= 7'b1110001;
end

assign sevenseg = ~disp[one_seg]; 

endmodule


module full_sevenseg(
   input logic clk,
	input logic[15:0] value,
	output logic[6:0] display,
	output logic[3:0] select
);

logic[7:0] inner_display[3:0];
 
localparam clock_div = 50000;
int clock_count = 0;

always @(posedge clk)
begin
    clock_count <= clock_count + 1;
    if(clock_count == clock_div)
    begin
        clock_count <= 0;
        case(select)
            4'b0001: select <= 4'b0010;
            4'b0010: select <= 4'b0100;
            4'b0100: select <= 4'b1000;
            4'b1000: select <= 4'b0001;
            default: select <= 4'b0001;
        endcase
    end    
end

genvar i;
generate
    for(i=0; i<4; i=i+1)  
    begin : gen_sev_seg_instances
        sevenseg segmz(.one_seg(value[4*i+3 : 4*i]),.sevenseg(inner_display[i]));
    end
endgenerate

assign display = select == 4'b0001 ? inner_display[0] : select == 4'b0010 ? inner_display[1] : select == 4'b0100 ? inner_display[2] : select == 4'b1000 ? inner_display[3] : 0;

endmodule
