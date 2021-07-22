module	top_total_clock(
		o_seg_enb,
		o_seg_dp,
		o_seg,
		o_alarm,
		i_sw0,
		i_sw1,
		i_sw2,
		i_sw3,
		i_sw4,
		clk,
		rst_n);

output	[5:0]	o_seg_enb	;
output		o_seg_dp	;
output	[6:0]	o_seg		;
output		o_alarm		;

input		i_sw0		;
input		i_sw1		;
input		i_sw2		;
input		i_sw3		;
input		i_sw4		;

input		clk		;
input		rst_n		;

wire		max_hit_hour	;			// max_hit_hour
wire		max_hit_min	;
wire		max_hit_sec	;

wire		out_max_hit_hour;			// out_max_hit_hour
wire 		out_max_hit_min	;
wire		out_max_hit_sec	;

wire		out_sw_max_hit_ssec;
wire		out_sw_max_hit_sec;
wire		out_sw_max_hit_min;			// out_sw_hit

wire		out_hour_clk	;			// out_hour_clk
wire		out_min_clk	;
wire		out_sec_clk	;

wire		out_alarm_en	;
wire		out_alarm	;

wire		out_alarm_hour_clk;
wire		out_alarm_min_clk;
wire		out_alarm_sec_clk;

wire [1:0]	out_position	;
wire [1:0]	out_mode	;

wire [6:0]	out_hour	;			// out_hour add
wire [6:0]	out_min		;
wire [6:0]	out_sec		;

wire		stop_en		;

wire 		ssec_clk	;
wire 		sec_clk		;
wire 		min_clk		;

wire		dis_hour_clk	;
wire		dis_min_clk	;
wire		dis_sec_clk	;

wire		blink			;
wire		blink_clk		;

wire		dis_hour		;
wire		dis_min			;
wire		dis_sec			;

controller	controller_ctrl(
		.o_mode(out_mode),
		.o_position(out_position),

		.o_alarm_en(out_alarm_en),
		.o_stopwatch_en(stop_en),

		.o_sec_clk(out_sec_clk),
		.o_min_clk(out_min_clk),
		.o_hour_clk(out_hour_clk),

		.o_alarm_sec_clk(out_alarm_sec_clk),
		.o_alarm_min_clk(out_alarm_min_clk),
		.o_alarm_hour_clk(out_alarm_hour_clk),	//alarm_hour_clk add

		.o_sw_ssec_clk(ssec_clk),         // stop watch clk
      		.o_sw_sec_clk(sec_clk),      
      		.o_sw_min_clk(min_clk),      
		
		.i_max_hit_sec(out_max_hit_sec),
		.i_max_hit_min(out_max_hit_min),
		.i_max_hit_hour(out_max_hit_hour),

		.i_sw_hit_ssec(out_sw_max_hit_ssec),
		.i_sw_hit_sec(out_sw_max_hit_sec),         // sw hit
      		.i_sw_hit_min(out_sw_max_hit_min),         

		.i_sw0(i_sw0),
		.i_sw1(i_sw1),
		.i_sw2(i_sw2),
		.i_sw3(i_sw3),				// sw3 add
		.i_sw4(i_sw4),				// sw4 add
	
		.clk(clk),
		.rst_n(rst_n),

		.dis_hour(dis_hour_clk),
		.dis_min(dis_min_clk),
		.dis_sec(dis_sec_clk)
		);

blink		blink_blink( 
		.clk(clk),
		.rst_n(rst_n),
		.blink(blink), 
		.blink_clk(blink_clk),
		.setting_mode(out_mode),
		.setting_position(out_position),
		.i_dis_hour(dis_hour_clk),
		.i_dis_min(dis_min_clk),
		.i_dis_sec(dis_sec_clk),
		.o_dis_hour(dis_hour),
		.o_dis_min(dis_min),
		.o_dis_sec(dis_sec)
		);


hourminsec	hourminsec_hourminsec(
		.o_sec(out_sec),
		.o_min(out_min),
		.o_hour(out_hour),

		.o_max_hit_sec(out_max_hit_sec),
		.o_max_hit_min(out_max_hit_min),
		.o_max_hit_hour(out_max_hit_hour),

		.o_alarm(out_alarm),

		.i_mode(out_mode),
		.i_position(out_position),

		.i_sec_clk(out_sec_clk),
		.i_min_clk(out_min_clk),
		.i_hour_clk(out_hour_clk),

		.o_sw_hit_ssec(out_sw_max_hit_ssec),			
		.o_sw_hit_sec(out_sw_max_hit_sec),	
		.o_sw_hit_min(out_sw_max_hit_min),	// sw- hit	

		.i_alarm_sec_clk(out_alarm_sec_clk),
		.i_alarm_min_clk(out_alarm_min_clk),
		.i_alarm_hour_clk(out_alarm_hour_clk),

		.i_sw_ssec_clk(ssec_clk),			// sw clk	<= controller
		.i_sw_sec_clk(sec_clk),
		.i_sw_min_clk(min_clk),

		.i_alarm_en(out_alarm_en),
		.i_stopwatch_en(stop_en),

		.clk(clk),
		.rst_n(rst_n)
		);

wire [3:0]	out_left_hour	;
wire [3:0]	out_right_hour	;

wire [3:0]	out_left_min	;
wire [3:0]	out_right_min	;

wire [3:0]	out_left_sec	;	
wire [3:0]	out_right_sec	;

double_fig_sep	double_fig_sep_u0_dfs(			// u0 : hour
		.o_left(out_left_hour),
		.o_right(out_right_hour),
		.i_double_fig(out_hour));

double_fig_sep	double_fig_sep_u1_dfs(			// u1 : min
		.o_left(out_left_min),
		.o_right(out_right_min),
		.i_double_fig(out_min));

double_fig_sep	double_fig_sep_u2_dfs(			// u2 : sec
		.o_left(out_left_sec),
		.o_right(out_right_sec),
		.i_double_fig(out_sec));

wire [41:0]	i_six_digit_seg	;

fnd_dec		find_dec_find_dec(
		.clk(clk),
		.hour10(out_left_hour),
		.hour0(out_right_hour),
		.min10(out_left_min),
		.min0(out_right_min),
		.sec10(out_left_sec),
		.sec0(out_right_sec),
		.blink(blink),
		.blink_clk(blink_clk),
		.dis_hour(dis_hour),
		.dis_min(dis_min),
		.dis_sec(dis_sec),
		.i_six_digit_seg(i_six_digit_seg)
		);

wire [5:0]	o_six_dp	;

dot		dot_dot(
		.mode(out_mode),
		.position(out_position),
		.o_six_dp(o_six_dp),
		.blink_clk(blink_clk),
		.rst_n(rst_n)
		);

led_disp	led_disp_u0_led_disp(
		.o_seg_dp(o_seg_dp),
		.o_seg(o_seg),
		.o_seg_enb(o_seg_enb),
		.i_six_digit_seg(i_six_digit_seg),
		.i_six_dp(o_six_dp),
		.clk(clk),
		.rst_n(rst_n)
		);


buzz		buzz_u0(
		.o_buzz(o_alarm),
		.i_buzz_en(out_alarm),
		.clk(clk),
		.rst_n(rst_n));



endmodule

