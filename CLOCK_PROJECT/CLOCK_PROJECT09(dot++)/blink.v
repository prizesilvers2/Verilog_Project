module 		blink( 
		clk,
		rst_n,
		blink, 
		blink_clk,
		setting_mode,
		setting_position,
		i_dis_hour,
		i_dis_min,
		i_dis_sec,
		o_dis_hour,
		o_dis_min,
		o_dis_sec
		);

input		clk			;	
input		rst_n			;

input		i_dis_hour		;
input		i_dis_min		;
input		i_dis_sec		;

output		o_dis_hour;
output		o_dis_min;
output		o_dis_sec ;


output		blink			;		// blink=1  ON, blink=0 OFF
output		blink_clk		;

input [1:0]	setting_mode		;
input [1:0]	setting_position	;

wire		blink_clk		;

nco		blink_clk_u1(			
		.o_gen_clk	( blink_clk	),
		.i_nco_num	( 32'd25000000	),
		.clk		( clk		),
		.rst_n		( rst_n		));

reg		blink		;



always @(posedge blink_clk or negedge rst_n) begin
	if(rst_n == 1'b0) begin					// start 0
			blink	  <= 1'b0		;
	end else begin
		if((setting_mode == 2'd1)||(setting_mode == 2'd2)) begin
			blink <= 1'b1;
		end else begin
			blink <= 1'b0;
		end
	end
end	

reg		o_dis_hour;
reg		o_dis_min;
reg		o_dis_sec ;

always @ ( posedge clk) begin
	if( (setting_mode == 2'd1)||(setting_mode == 2'd2)) begin
		if(blink == 1'b1) begin
			case(setting_position)
				2'b00 :begin				// sec
					o_dis_hour<= 1'b1;
					o_dis_min <= 1'b1;
					o_dis_sec <= ~i_dis_sec;
				end
				2'b01 :begin				// min
					o_dis_hour<= 1'b1;
					o_dis_min <= ~i_dis_min;
					o_dis_sec <= 1'b1;
				end
				2'b10 :begin				// hour
					o_dis_hour<= ~i_dis_hour;
					o_dis_min <= 1'b1;
					o_dis_sec <= 1'b1;
				end
				default : ;
			endcase
		 end else begin
			o_dis_hour<= 1'b1;
			o_dis_min <= 1'b1;
			o_dis_sec <= 1'b1;
		end
	end else begin
		o_dis_hour<= 1'b1;
		o_dis_min <= 1'b1;
		o_dis_sec <= 1'b1;
	end
end

endmodule

