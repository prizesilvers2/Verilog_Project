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
			i_sec_clk,
			i_min_clk,
			i_hour_clk,			// hour-clk
			clk,
			rst_n);

output	[5:0]	o_sec		;
output	[5:0]	o_min		;
output	[5:0]	o_hour		;			// hour(hour : 0-24, but o_hms_cnt is 6-bit, so o_hour need 6-bit)

output		o_max_hit_sec	;
output		o_max_hit_min	;
output		o_max_hit_hour	;			// max_hit_hour

input		i_sec_clk	;
input		i_min_clk	;
input		i_hour_clk	;			// hour_clk

input		clk		;
input		rst_n		;

hms_cnt		u0_hms_cnt(				// u0 : sec
		.o_hms_cnt	( o_sec		),
		.o_max_hit	( o_max_hit_sec	),
		.i_max_cnt	( 6'd59		),	// sec(0-59)
		.clk		( i_sec_clk	),
		.rst_n		( rst_n		));

hms_cnt		u1_hms_cnt(				// u1 : min
		.o_hms_cnt	( o_min		),
		.o_max_hit	( o_max_hit_min	),
		.i_max_cnt	( 6'd59		),	// min(0-59)
		.clk		( i_min_clk	),
		.rst_n		( rst_n		));

hms_cnt		u2_hms_cnt(				// u2 : hour
		.o_hms_cnt	( o_hour	),
		.o_max_hit	( o_max_hit_hour),
		.i_max_cnt	( 6'd23		),	// hour(0-23)
		.clk		( i_hour_clk	),	
		.rst_n		( rst_n		));

endmodule
