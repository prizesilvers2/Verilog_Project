module 		blink( 
		clk,
		rst_n,
 		setting_mode,
		setting_position,
		i_max_hit_sec,
		i_max_hit_min,
		i_max_hit_hour, 
		sw0,
		sw1, 
		sw2, 
		sw3, 
		rst_n, 
		blink, 
		blink_clk);

input		clk			;	
input		rst_n			;
input   [1:0]	setting_mode		;
input   [1:0]	setting_position	;

input		i_max_hit_sec		;
input		i_max_hit_min		;
input		i_max_hit_hour		;  	// hit hour nessary o (max:24)

input		sw0			;
input 		sw1			;
input 		sw2			; 
input		sw3			;  	// alarm button , when 0, no alarm, when 1, alarm ring

input		clk			;
input		rst_n			;


output		blink			;		// blink=1  ON, blink=0 OFF
output		blink_clk		;

controller	blink_mode_get(
		.o_mode(setting_mode),		// o_mode=>setting_mode
		.o_position(setting_position),
		.o_sec_clk(),
		.o_min_clk(),
		.o_hour_clk(),		
		.i_max_hit_sec(i_max_hit_sec),
		.i_max_hit_min(i_max_hit_min),
		.i_max_hit_hour(i_max_hit_hour),		
		.o_alarm_sec_clk(),
		.o_alarm_min_clk(),
		.o_alarm_hour_clk(),	
		.o_alarm_en(),
		.i_sw0(sw0),
		.i_sw1(sw1),
		.i_sw2(sw2),
		.i_sw3(sw3),
		.clk(clk),
		.rst_n(rst_n));

nco		blink_clk_gen(			
		.o_gen_clk	( blink_clk	),
		.i_nco_num	( 32'd5000	),
		.clk		( clk		),
		.rst_n		( rst_n		));

reg	blink	;

always @ (*) begin
	if(setting_mode == 2'd1) begin
		blink <= 1'b1 ;
	end else begin
		blink <= 1'b0 ;
	end
end

endmodule
