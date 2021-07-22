//	--------------------------------------------------
//	HMS(Hour:Min:Sec) Counter
//	--------------------------------------------------
module	hms_cnt(
		o_hms_cnt,
		o_max_hit,
		i_max_cnt,
		clk,
		rst_n);

output	[5:0]	o_hms_cnt		;
output		o_max_hit		;

input	[5:0]	i_max_cnt		;		// max_count value , hour(0-23), min(0-59), sec(0-59)
input		clk			;
input		rst_n			;

reg	[5:0]	o_hms_cnt		;
reg		o_max_hit		;

always @(posedge clk or negedge rst_n) begin
	if(rst_n == 1'b0) begin
		o_hms_cnt <= 6'd0;
		o_max_hit <= 1'b0;
	end else begin
		if(o_hms_cnt >= i_max_cnt) begin	// large than i_max_cnt => o_max_hit +1
			o_hms_cnt <= 6'd0;
			o_max_hit <= 1'b1;
		end else begin
			o_hms_cnt <= o_hms_cnt + 1'b1;	// less than i_max_cnt => o_hms_cnt + 1
			o_max_hit <= 1'b0;
		end
	end
end

endmodule


//	--------------------------------------------------
//	HMS(Hour:Min:Sec) Counter
//	--------------------------------------------------

module	hourminsec(	o_sec,
			o_min,
			o_hour,				// output-hour
			o_max_hit_sec,
			o_max_hit_min,
			o_max_hit_hour,			// max-hit-hour
			o_alarm,
			i_mode,
			i_position,
			i_sec_clk,
			i_min_clk,
			i_hour_clk,			// hour-clk
			i_alarm_en,
			i_alarm_sec_clk,
			i_alarm_min_clk,
			i_alarm_hour_clk,
			clk,
			rst_n);

output	[5:0]	o_sec		;
output	[5:0]	o_min		;
output	[5:0]	o_hour		;			// hour(hour : 0-24, but o_hms_cnt is 6-bit, so o_hour need 6-bit)

output		o_alarm		;

input	[1:0]	i_mode		;
input		i_position	;


output		o_max_hit_sec	;
output		o_max_hit_min	;
output		o_max_hit_hour	;			// max_hit_hour

input		i_sec_clk	;
input		i_min_clk	;
input		i_hour_clk	;			// hour_clk

input		i_alarm_sec_clk	;
input		i_alarm_min_clk	;
input		i_alarm_hour_clk;			// i_alarm_hour_clk

input		i_alarm_en	;

input		clk		;
input		rst_n		;

parameter	MODE_CLOCK	= 2'd0	;
parameter	MODE_SETUP	= 2'd1	;
parameter	MODE_ALARM	= 2'd2	;

parameter	POS_SEC		= 2'd0	;
parameter	POS_MIN		= 2'd1	;
parameter	POS_HOUR	= 2'd2	;


//	MODE_CLOCK

wire	[5:0]	sec		;
wire		max_hit_sec	;

hms_cnt		u0_hms_cnt(				// u0 : sec
		.o_hms_cnt	( sec		),
		.o_max_hit	( o_max_hit_sec	),
		.i_max_cnt	( 6'd59		),	// sec(0-59)
		.clk		( i_sec_clk	),
		.rst_n		( rst_n		));

wire	[5:0]	min		;
wire		max_hit_min	;

hms_cnt		u1_hms_cnt(				// u1 : min
		.o_hms_cnt	( min		),
		.o_max_hit	( o_max_hit_min	),
		.i_max_cnt	( 6'd59		),	// min(0-59)
		.clk		( i_min_clk	),
		.rst_n		( rst_n		));

wire	[5:0]	hour		;
wire		max_hit_hour	; 		

hms_cnt		u2_hms_cnt(				// u2 : hour
		.o_hms_cnt	( hour	),
		.o_max_hit	( o_max_hit_hour),
		.i_max_cnt	( 6'd23		),	// hour(0-23)
		.clk		( i_hour_clk	),	
		.rst_n		( rst_n		));


//	MODE_ALARM

wire	[5:0]	alarm_sec	;

hms_cnt		u_hms_cnt_alarm_sec(
		.o_hms_cnt	( alarm_sec		),
		.o_max_hit	( 			),
		.i_max_cnt	( 6'd59			),
		.clk		( i_alarm_sec_clk	),
		.rst_n		( rst_n			));

wire	[5:0]	alarm_min	;

hms_cnt		u_hms_cnt_alarm_min(
		.o_hms_cnt	( alarm_min		),
		.o_max_hit	( 			),
		.i_max_cnt	( 6'd59			),
		.clk		( i_alarm_min_clk	),
		.rst_n		( rst_n			));

wire	[5:0]	alarm_hour	;

hms_cnt		u_hms_cnt_alarm_hour(				// hour alarm
		.o_hms_cnt	( alarm_hour		),
		.o_max_hit	( 			),
		.i_max_cnt	( 6'd23			),
		.clk		( i_alarm_hour_clk	),
		.rst_n		( rst_n			));

reg	[5:0]	o_sec		;
reg	[5:0]	o_min		;
reg	[5:0]	o_hour		;

always @ (*) begin
	case(i_mode)
		MODE_CLOCK: 	begin
			o_sec	= sec;
			o_min	= min;
			o_hour	= hour;
		end
		MODE_SETUP:	begin
			o_sec	= sec;
			o_min	= min;
			o_hour	= hour;
		end
		MODE_ALARM:	begin
			o_sec	= alarm_sec;
			o_min	= alarm_min;
			o_hour	= alarm_hour;
		end
	endcase
end

reg		o_alarm		;
always @ (posedge clk or negedge rst_n) begin
	if (rst_n == 1'b0) begin
		o_alarm <= 1'b0;
	end else begin
		if( (sec == alarm_sec) && (min == alarm_min) && (hour == alarm_hour)) begin
			o_alarm <= 1'b1 & i_alarm_en;
		end else begin
			o_alarm <= o_alarm & i_alarm_en;
		end
	end
end

endmodule

//	BUZZ

module	buzz(
		o_buzz,
		i_buzz_en,
		clk,
		rst_n);

output		o_buzz		;

input		i_buzz_en	;
input		clk		;
input		rst_n		;

parameter	C = 191113	;
parameter	D = 170262	;
parameter	E = 151686	;
parameter	F = 143173	;
parameter	G = 63776	;
parameter	A = 56818	;
parameter	B = 50619	;

wire		clk_bit		;
nco	u_nco_bit(	
		.o_gen_clk	( clk_bit	),
		.i_nco_num	( 25000000	),
		.clk		( clk		),
		.rst_n		( rst_n		));

reg	[4:0]	cnt		;
always @ (posedge clk_bit or negedge rst_n) begin
	if(rst_n == 1'b0) begin
		cnt <= 5'd0;
	end else begin
		if(cnt >= 5'd24) begin
			cnt <= 5'd0;
		end else begin
			cnt <=i_buzz_en	;
			cnt <= cnt + 1'd1;

		end
	end
end

reg	[31:0]	nco_num		;
always @ (*) begin
	case(cnt)
		5'd00: nco_num = E	;
		5'd01: nco_num = D	;
		5'd02: nco_num = C	;
		5'd03: nco_num = D	;
		5'd04: nco_num = E	;
		5'd05: nco_num = E	;
		5'd06: nco_num = E	;
		5'd07: nco_num = D	;
		5'd08: nco_num = D	;
		5'd09: nco_num = D	;
		5'd10: nco_num = E	;
		5'd11: nco_num = E	;
		5'd12: nco_num = E	;
		5'd13: nco_num = E	;
		5'd14: nco_num = D	;
		5'd15: nco_num = C	;
		5'd16: nco_num = D	;
		5'd17: nco_num = E	;
		5'd18: nco_num = E	;
		5'd19: nco_num = E	;
		5'd20: nco_num = D	;
		5'd21: nco_num = D	;
		5'd22: nco_num = E	;
		5'd23: nco_num = D	;
		5'd24: nco_num = C	;
	endcase
end

wire		buzz		;
nco	u_nco_buzz(	
		.o_gen_clk	( buzz		),
		.i_nco_num	( nco_num	),
		.clk		( clk		),
		.rst_n		( rst_n		));

assign		o_buzz = buzz & i_buzz_en;

endmodule


