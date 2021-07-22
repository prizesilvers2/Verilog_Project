//	--------------------------------------------------
//	Clock Controller (nco, debounce, controller)
//	--------------------------------------------------
module	nco(	
		o_gen_clk,
		i_nco_num,
		clk,
		rst_n);

output		o_gen_clk	;				// generate 1Hz CLK

input	[31:0]	i_nco_num	;				// (like cnt) 1~50M switching
input		clk		;				// 50Mhz CLK
input		rst_n		;

reg	[31:0]	cnt		;				// (like i_nco_num) 1~25M twice switching
reg		o_gen_clk	;

always @(posedge clk or negedge rst_n) begin
	if(rst_n == 1'b0) begin					// start all 0
			cnt	  <= 32'd0		;
			o_gen_clk <= 1'd0		;
	end else begin
		if(cnt >= i_nco_num/2-1) begin			
			cnt 	  <= 32'd0		;
			o_gen_clk <= ~o_gen_clk		;	// each 25M cnt, clk_1hz = ~clk_1hz
		end else begin
			cnt <= cnt + 1'b1;
		end
	end
end

endmodule

module  debounce(
		o_sw,
		i_sw,
		clk);
output		o_sw			;

input		i_sw			;
input		clk			;

reg		dly1_sw			;
always @(posedge clk) begin
	dly1_sw <= i_sw;
end

reg		dly2_sw			;
always @(posedge clk) begin
	dly2_sw <= dly1_sw;
end

assign		o_sw = dly1_sw | ~dly2_sw;

endmodule


module	controller(
		o_mode,
		o_position,
		o_sec_clk,
		o_min_clk,
		o_hour_clk,		// hour clk o
		i_max_hit_sec,
		i_max_hit_min,
		i_max_hit_hour,		// hit hour o ( max: 24)
		i_sw0,
		i_sw1,
		i_sw2,
		clk,
		rst_n);

output		o_mode			;
output	[1:0]	o_position		;  // hour, min, sec position 
output		o_sec_clk		;
output		o_min_clk		;
output		o_hour_clk		;  // hour clk o 

input		i_max_hit_sec		;
input		i_max_hit_min		;
input		i_max_hit_hour		;  // hit hour nessary o (max:24)

input		i_sw0			;
input 		i_sw1			;
input 		i_sw2			; 

input		clk			;
input		rst_n			;

parameter	MODE_CLOCK = 1'b0	;
parameter	MODE_SETUP = 1'b1	;

parameter 
		POS_SEC	 = 2'd0		,
		POS_MIN	 = 2'd1		,
		POS_HOUR = 2'd2		;

wire		clk_100hz		;
nco		u0_nco(
		.o_gen_clk	( clk_100hz	),
		.i_nco_num	( 32'd500000	),
		.clk		( clk		),
		.rst_n		( rst_n		));

wire		sw0			;
debounce	u0_debounce(
		.o_sw		( sw0		),
		.i_sw		( i_sw0		),
		.clk		( clk_100hz	));

wire		sw1			;
debounce	u1_debounce(
		.o_sw		( sw1		),
		.i_sw		( i_sw1		),
		.clk		( clk_100hz	));

wire		sw2			;
debounce	u2_debounce(
		.o_sw		( sw2		),
		.i_sw		( i_sw2		),
		.clk		( clk_100hz	));

reg		o_mode			;
always @(posedge sw0 or negedge rst_n) begin
	if(rst_n == 1'b0) begin
		o_mode <= MODE_CLOCK;
	end else begin
		o_mode <= o_mode + 1'b1;
	end
end

reg [1:0]	o_position		;  //  hour = 2 , min = 1 , sec = 0

always @(posedge sw1 or negedge rst_n) begin
	if(rst_n == 1'b0) begin
		o_position <= POS_SEC;		// pos_sec =0 start! add 1
	end else begin
		if(o_position >= POS_HOUR) begin
			o_position <= POS_SEC;
		end else begin
			o_position <= o_position + 1'd1;
		end
	end
end

wire		clk_1hz			;
nco		u1_nco(
		.o_gen_clk	( clk_1hz	),
		.i_nco_num	( 32'd50000000	),
		.clk		( clk		),
		.rst_n		( rst_n		));

reg		o_sec_clk		;
reg		o_min_clk		;
reg		o_hour_clk		;  // hour clk making

always @(*) begin
	case(o_mode)
		MODE_CLOCK : begin
			o_sec_clk  = clk_1hz;
			o_min_clk  = i_max_hit_sec;
			o_hour_clk = i_max_hit_min; // when max-min, hour+1 
		end
		MODE_SETUP : begin
			case(o_position)
				POS_SEC : begin
					o_sec_clk  = ~sw2;	
					o_min_clk  = 1'd0;	 
					o_hour_clk = 1'd0;	// when sec select, min and hour = 0	
 				end
				POS_MIN : begin
					o_sec_clk  = 1'd0;
					o_min_clk  = ~sw2;
					o_hour_clk = 1'd0;	// when min select, sec and hour = 0
				end
				POS_HOUR : begin
					o_sec_clk  = 1'd0;
					o_min_clk  = 1'd0;
					o_hour_clk = ~sw2;	// when hour select, sec and min = 0
				end
			endcase
		end
	endcase
end

endmodule

