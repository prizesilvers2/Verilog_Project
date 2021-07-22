//	--------------------------------------------------
//	Flexible Numerical Display Decoder
//	--------------------------------------------------
module	fnd_dec(
		o_seg,
		i_num);

output	[6:0]	o_seg		;			// {o_seg_a, o_seg_b, ... , o_seg_g}

input	[3:0]	i_num		;			// i_num(because need 0-9, 4-bit)
reg	[6:0]	o_seg		;
//making
always @(i_num) begin 					// number display
 	case(i_num) 
 		4'd0 : o_seg = 7'b111_1110	; 
 		4'd1 : o_seg = 7'b011_0000	; 
 		4'd2 : o_seg = 7'b110_1101	; 
 		4'd3 : o_seg = 7'b111_1001	; 
 		4'd4 : o_seg = 7'b011_0011	; 
 		4'd5 : o_seg = 7'b101_1011	; 
 		4'd6 : o_seg = 7'b101_1111	; 
 		4'd7 : o_seg = 7'b111_0000	; 
 		4'd8 : o_seg = 7'b111_1111	; 
 		4'd9 : o_seg = 7'b111_0011	; 
		default : o_seg = 7'b000_0000	; 
	endcase 
end

endmodule

module	find_dec_all( 
			clk,
			hour10,
			hour0,
			min10,
			min0,
			sec10,
			sec0,
			o_seg_enb,
			o_seg
			);

input		clk			;

input [6:0]	hour10			;
input [6:0]	hour0			;
input [6:0]	min10			;
input [6:0]	min0			;
input [6:0]	sec10			;
input [6:0]	sec0			;

inout [5:0]	o_seg_enb		;
output[6:0]	o_seg			;		// o_seg = { hour left, hour right, min left, min right, sec left, sec right}

wire		gen_clk			;

nco		u_nco(					
		.o_gen_clk	( gen_clk	),
		.i_nco_num	( 32'd5000	),	// i don't know why 32'd5000 ( display = slow ?)
		.clk		( clk		),
		.rst_n		( rst_n		));

reg	[3:0]	cnt_common_node	;			// common_node  = lighting led 

always @(posedge gen_clk or negedge rst_n) begin
	if(rst_n == 1'b0) begin
		cnt_common_node <= 4'd0;
	end else begin
		if(cnt_common_node >= 4'd5) begin
			cnt_common_node <= 4'd0;
		end else begin
			cnt_common_node <= cnt_common_node + 1'b1;
		end
	end
end

reg [41:0]	i_six_digit_seg		;

always @ (posedge gen_clk) begin

	if((o_seg_enb == 6'b01_11_11) &&(o_seg_enb == 6'b10_11_11)) begin		// hour on
		case(hour10)
		4'd0 : i_six_digit_seg[41:35] <= 7'b111_1110	; 
 		4'd1 : i_six_digit_seg[41:35] <= 7'b011_0000	; 
 		4'd2 : i_six_digit_seg[41:35] <= 7'b110_1101	; 
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
		i_six_digit_seg[41:28] <= 7'b000_0000		;
	end

	if((o_seg_enb == 6'b11_01_11) &&(o_seg_enb == 6'b11_10_11)) begin		// min on
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
		i_six_digit_seg[27:14] <= 7'b000_0000		;
	end

	if((o_seg_enb == 6'b11_11_01)&&(o_seg_enb == 6'b11_11_10)) begin		// sec on
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
		i_six_digit_seg[6:0] <= 7'b000_0000		;
	end
end

reg	[6:0]	o_seg			;

always @(cnt_common_node) begin
	case (cnt_common_node)
		4'd0 : o_seg = i_six_digit_seg[6:0];	// sec-right
		4'd1 : o_seg = i_six_digit_seg[13:7];	// sec-left
		4'd2 : o_seg = i_six_digit_seg[20:14];	// min-right
		4'd3 : o_seg = i_six_digit_seg[27:21];	// min-left
		4'd4 : o_seg = i_six_digit_seg[34:28];	// hour-right
		4'd5 : o_seg = i_six_digit_seg[41:35];	// hour-left
		default:o_seg = 7'b111_1110; 		// 0 display
	endcase
end


endmodule

