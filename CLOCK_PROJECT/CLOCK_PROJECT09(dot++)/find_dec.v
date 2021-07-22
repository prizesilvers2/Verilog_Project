//	--------------------------------------------------
//	Flexible Numerical Display Decoder
//	--------------------------------------------------
module	fnd_dec(
		clk,
		hour10,
		hour0,
		min10,
		min0,
		sec10,
		sec0,
		blink,
		blink_clk,
		dis_hour,
		dis_min,
		dis_sec,
		i_six_digit_seg
		);

output[41:0]	i_six_digit_seg	;		

input		clk		;

input [3:0]	hour10		;
input [3:0]	hour0		;
input [3:0]	min10		;
input [3:0]	min0		;
input [3:0]	sec10		;
input [3:0]	sec0		;

input		dis_hour	;
input		dis_min		;
input		dis_sec		;

input		blink		;
input		blink_clk	;

reg [41:0] 	i_six_digit_seg	;

always @ (posedge blink_clk) begin
	if(dis_hour == 1'b1) begin
		case(hour10)
		4'd0 : i_six_digit_seg[41:35] <= 7'b111_1110	; 
 		4'd1 : i_six_digit_seg[41:35] <= 7'b011_0000	; 
 		4'd2 : i_six_digit_seg[41:35] <= 7'b110_1101	; 
		4'd3 : i_six_digit_seg[41:35] <= 7'b111_1001	; 
 		4'd4 : i_six_digit_seg[41:35] <= 7'b011_0011	; 
 		4'd5 : i_six_digit_seg[41:35] <= 7'b101_1011	; 
 		4'd6 : i_six_digit_seg[41:35] <= 7'b101_1111	; 
 		4'd7 : i_six_digit_seg[41:35] <= 7'b111_0000	; 
 		4'd8 : i_six_digit_seg[41:35] <= 7'b111_1111	; 
 		4'd9 : i_six_digit_seg[41:35] <= 7'b111_0011	; 
		default : ;
		endcase
	
		case(hour0)
		4'd0 : i_six_digit_seg[34:28] <= 7'b111_1110	; 
 		4'd1 : i_six_digit_seg[34:28] <= 7'b011_0000	; 
 		4'd2 : i_six_digit_seg[34:28] <= 7'b110_1101	; 
 		4'd3 : i_six_digit_seg[34:28] <= 7'b111_1001	; 
 		4'd4 : i_six_digit_seg[34:28] <= 7'b011_0011	; 
 		4'd5 : i_six_digit_seg[34:28] <= 7'b101_1011	; 
 		4'd6 : i_six_digit_seg[34:28] <= 7'b101_1111	; 
 		4'd7 : i_six_digit_seg[34:28] <= 7'b111_0000	; 
 		4'd8 : i_six_digit_seg[34:28] <= 7'b111_1111	; 
 		4'd9 : i_six_digit_seg[34:28] <= 7'b111_0011	; 
		default : ;
		endcase
	end else begin
		i_six_digit_seg[41:35] <= 7'b000_0000		;
		i_six_digit_seg[34:28] <= 7'b000_0000		;
		
	end
	
	if(dis_min == 1'b1) begin
		case(min10)
		4'd0 : i_six_digit_seg[27:21] <= 7'b111_1110	; 
 		4'd1 : i_six_digit_seg[27:21] <= 7'b011_0000	; 
 		4'd2 : i_six_digit_seg[27:21] <= 7'b110_1101	; 
 		4'd3 : i_six_digit_seg[27:21] <= 7'b111_1001	; 
 		4'd4 : i_six_digit_seg[27:21] <= 7'b011_0011	; 
 		4'd5 : i_six_digit_seg[27:21] <= 7'b101_1011	; 
 		4'd6 : i_six_digit_seg[27:21] <= 7'b101_1111	; 
 		4'd7 : i_six_digit_seg[27:21] <= 7'b111_0000	; 
 		4'd8 : i_six_digit_seg[27:21] <= 7'b111_1111	; 
 		4'd9 : i_six_digit_seg[27:21] <= 7'b111_0011	; 
		default : ;
		endcase
	
		case(min0)
		4'd0 : i_six_digit_seg[20:14] <= 7'b111_1110	; 
 		4'd1 : i_six_digit_seg[20:14] <= 7'b011_0000	; 
 		4'd2 : i_six_digit_seg[20:14] <= 7'b110_1101	; 
 		4'd3 : i_six_digit_seg[20:14] <= 7'b111_1001	; 
 		4'd4 : i_six_digit_seg[20:14] <= 7'b011_0011	; 
 		4'd5 : i_six_digit_seg[20:14] <= 7'b101_1011	; 
 		4'd6 : i_six_digit_seg[20:14] <= 7'b101_1111	; 
 		4'd7 : i_six_digit_seg[20:14] <= 7'b111_0000	; 
 		4'd8 : i_six_digit_seg[20:14] <= 7'b111_1111	; 
 		4'd9 : i_six_digit_seg[20:14] <= 7'b111_0011	; 
		default : ;
		endcase
	end else begin
		i_six_digit_seg[27:21] <= 7'b000_0000		;
		i_six_digit_seg[20:14] <= 7'b000_0000		;
	end
	
	if(dis_sec == 1'b1) begin
		case(sec10)
		4'd0 : i_six_digit_seg[13:7] <= 7'b111_1110	; 
 		4'd1 : i_six_digit_seg[13:7] <= 7'b011_0000	; 
 		4'd2 : i_six_digit_seg[13:7] <= 7'b110_1101	; 
 		4'd3 : i_six_digit_seg[13:7] <= 7'b111_1001	; 
 		4'd4 : i_six_digit_seg[13:7] <= 7'b011_0011	; 
 		4'd5 : i_six_digit_seg[13:7] <= 7'b101_1011	; 
 		4'd6 : i_six_digit_seg[13:7] <= 7'b101_1111	; 
 		4'd7 : i_six_digit_seg[13:7] <= 7'b111_0000	; 
 		4'd8 : i_six_digit_seg[13:7] <= 7'b111_1111	; 
 		4'd9 : i_six_digit_seg[13:7] <= 7'b111_0011	; 
		default : ;
		endcase

		case(sec0)
		4'd0 : i_six_digit_seg[6:0] <= 7'b111_1110	; 
 		4'd1 : i_six_digit_seg[6:0] <= 7'b011_0000	; 
 		4'd2 : i_six_digit_seg[6:0] <= 7'b110_1101	; 
 		4'd3 : i_six_digit_seg[6:0] <= 7'b111_1001	; 
 		4'd4 : i_six_digit_seg[6:0] <= 7'b011_0011	; 
 		4'd5 : i_six_digit_seg[6:0] <= 7'b101_1011	; 
 		4'd6 : i_six_digit_seg[6:0] <= 7'b101_1111	; 
 		4'd7 : i_six_digit_seg[6:0] <= 7'b111_0000	; 
 		4'd8 : i_six_digit_seg[6:0] <= 7'b111_1111	; 
 		4'd9 : i_six_digit_seg[6:0] <= 7'b111_0011	; 
		default : ;
		endcase
	end else begin
		i_six_digit_seg[13:7] <= 7'b000_0000		;
		i_six_digit_seg[6:0] <= 7'b000_0000		;
	end

end


endmodule

