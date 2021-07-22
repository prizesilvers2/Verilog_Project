module	top_total_clock(
		o_seg_enb,
		o_seg_dp,
		o_seg,
		i_sw0,
		i_sw1,
		i_sw2,
		clk,
		rst_n);

output	[5:0]	o_seg_enb	;
output		o_seg_dp	;
output	[6:0]	o_seg		;

input		i_sw0		;
input		i_sw1		;
input		i_sw2		;
input		clk		;
input		rst_n	;

wire		max_hit_hour	;			// max_hit_hour
wire		max_hit_min	;
wire		max_hit_sec	;

wire		out_max_hit_hour;			// out_max_hit_hour
wire 		out_max_hit_min	;
wire		out_max_hit_sec	;

wire		out_hour_clk	;			// out_hour_clk
wire		out_min_clk	;
wire		out_sec_clk	;


controller	controller_ctrl(
		.o_mode(),
		.o_position(),
		.o_sec_clk(out_sec_clk),
		.o_min_clk(out_min_clk),
		.o_hour_clk(out_hour_clk),
		.i_max_hit_sec(out_max_hit_sec),
		.i_max_hit_min(out_max_hit_min),
		.i_max_hit_hour(out_max_hit_hour),
		.i_sw0(i_sw0),
		.i_sw1(i_sw1),
		.i_sw2(i_sw2),
		.clk(clk),
		.rst_n(rst_n));

wire [5:0]	out_hour	;
wire [5:0]	out_min		;
wire [5:0]	out_sec		;


hourminsec	hourminsec_hourminsec(
		.o_sec(out_sec),
		.o_min(out_min),
		.o_hour(out_hour),
		.o_max_hit_sec(out_max_hit_sec),
		.o_max_hit_min(out_max_hit_min),
		.o_max_hit_hour(out_max_hit_hour),
		.i_sec_clk(out_sec_clk),
		.i_min_clk(out_min_clk),
		.i_hour_clk(out_hour_clk),
		.clk(clk),
		.rst_n(rst_n));

wire [3:0]	out_left_hour	;
wire [3:0]	out_right_hour	;

wire [3:0]	out_left_min	;
wire [3:0]	out_rihgt_min	;

wire [3:0]	out_left_sec	;	
wire [3:0]	out_right_sec	;

double_fig_sep	double_fig_sep_u0_dfs(			// u0 : hour
		.o_left(out_left_hour),
		.o_right(out_rihgt_hour),
		.i_double_fig(out_hour));

double_fig_sep	double_fig_sep_u1_dfs(			// u1 : min
		.o_left(out_left_min),
		.o_right(out_rihgt_min),
		.i_double_fig(out_min));

double_fig_sep	double_fig_sep_u2_dfs(			// u2 : sec
		.o_left(out_left_sec),
		.o_right(out_right_sec),
		.i_double_fig(out_sec));

wire [6:0]	out_seg_left_hour	;
wire [6:0]	out_seg_right_hour	;

wire [6:0]	out_seg_left_min	;
wire [6:0]	out_seg_right_min	;

wire [6:0]	out_seg_left_sec	;
wire [6:0]	out_seg_right_sec	;


fnd_dec		find_dec_u0_find_dec(
		.o_seg(out_seg_left_hour),
		.i_num(out_left_hour));

fnd_dec		find_dec_u1_find_dec(
		.o_seg(out_seg_right_hour),
		.i_num(out_rihgt_hour));

fnd_dec		find_dec_u2_find_dec(
		.o_seg(out_seg_left_min),
		.i_num(out_left_min));

fnd_dec		find_dec_u3_find_dec(
		.o_seg(out_seg_right_min),
		.i_num(out_rihgt_min));

fnd_dec		find_dec_u4_find_dec(
		.o_seg(out_seg_left_sec),
		.i_num(out_left_sec));

fnd_dec		find_dec_u5_find_dec(
		.o_seg(out_seg_right_sec),
		.i_num(out_right_sec));

wire [41:0]	in_six_digit_seg	;
assign		in_six_digit_seg ={ out_seg_left_hour , out_seg_right_hour , out_seg_left_min , out_seg_right_min , out_seg_left_sec , out_seg_right_sec} ;   		


led_disp	led_disp_u0_led_disp(
		.o_seg(o_seg),
		.o_seg_dp(o_seg_dp),
		.o_seg_enb(o_seg_enb),
		.i_six_digit_seg(in_six_digit_seg),
		.i_six_dp(6'h0),
		.clk(clk),
		.rst_n(rst_n));


endmodule

