module 		blink( 
		clk,
		rst_n,
		blink, 
		blink_clk,
		setting_mode,
		setting_position);

input		clk			;	
input		rst_n			;

output		blink			;		// blink=1  ON, blink=0 OFF
output		blink_clk		;

input [1:0]	setting_mode		;
input [1:0]	setting_position	;


nco		blink_clk_gen(			
		.o_gen_clk	( blink_clk	),
		.i_nco_num	( 32'd5000	),
		.clk		( clk		),
		.rst_n		( rst_n		));

reg	blink	;

always @(posedge clk or negedge rst_n) begin
	if(rst_n == 1'b0) begin					// start 0
			blink	  <= 1'b0		;
	end else begin
		if(setting_mode == 2'd1) begin		
			blink <= 1'b1 ;
		end else begin
			blink <= 1'b0 ;
		end
	end
end

endmodule
