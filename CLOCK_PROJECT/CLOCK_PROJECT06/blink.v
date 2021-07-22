module 		blink( 
		clk,
		rst_n,
		blink, 
		blink_clk,
		setting_mode,
		setting_position,
		sw2);

input		clk			;	
input		rst_n			;
input		sw2			;

output		blink			;		// blink=1  ON, blink=0 OFF
output		blink_clk		;

input [1:0]	setting_mode		;
input [1:0]	setting_position	;


nco		blink_clk_u1(			
		.o_gen_clk	( blink_clk	),
		.i_nco_num	( 32'd5000	),
		.clk		( clk		),
		.rst_n		( rst_n		));

reg		blink		;
/*
reg [1:0] 	state		;

parameter	s0 = 2'b00	;
parameter	s1 = 2'b01	;
parameter	s2 = 2'b10	;
parameter	s3 = 2'b11	;
*/

always @(posedge blink_clk or negedge rst_n) begin
	if(rst_n == 1'b0) begin					// start 0
			blink	  <= 1'b0		;
	end else begin
		if(setting_mode == 2'd1) begin
			blink <= 1'b1;
		end else begin
			blink <= 1'b0;
		end
	end
end	

/*
		case(state)
			s0 : begin
				if(setting_mode == 2'd1) begin		
					state <= s1	;
					blink <= 1'b1	;
				end else begin
					state <= s0	;
					blink <= 1'b0	;
				end
			end
			
			s1 : begin
				if(setting_mode == 2'd1) begin		
					state <= s2	;
					blink <= 1'b0	;
				end else begin
					state <= s0	;
					blink <= 1'b0	;
				end
			end
			s2 : begin
				if(setting_mode == 2'd1) begin		
					state <= s3	;
					blink <= 1'b1	;
				end else begin
					state <= s0	;
					blink <= 1'b0	;
				end
			end
			s3 : begin
				if(setting_mode == 2'd1) begin		
					state <= s0	;
					blink <= 1'b0	;
				end else begin
					state <= s0	;
					blink <= 1'b0	;
				end
			end	
		endcase
		
	end
end
*/
endmodule
