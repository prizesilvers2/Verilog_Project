module	led_disp(
		o_seg_dp,
		o_seg_enb,
		i_six_digit_seg,
		i_six_dp,
		clk,
		rst_n,
		setting_mode,
		setting_position,
		blink,
		blink_clk);

output	[5:0]	o_seg_enb		;		// light place
output		o_seg_dp		;

input	[41:0]	i_six_digit_seg		; 		// 7-segment *6 = 42-bit
input	[5:0]	i_six_dp		;
input		clk			;
input		rst_n			;

input   [1:0]	setting_mode		;
input   [1:0]	setting_position	;

input		blink			;
input		blink_clk		;

wire		gen_clk		;

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

reg		o_seg_dp		;

always @(cnt_common_node) begin
	case (cnt_common_node)
		4'd0 : o_seg_dp = i_six_dp[0];
		4'd1 : o_seg_dp = i_six_dp[1];
		4'd2 : o_seg_dp = i_six_dp[2];
		4'd3 : o_seg_dp = i_six_dp[3];
		4'd4 : o_seg_dp = i_six_dp[4];
		4'd5 : o_seg_dp = i_six_dp[5];
	endcase
end

reg [5:0]	o_seg_enb		;

always @ (posedge blink_clk or negedge rst_n) begin
	if(rst_n == 1'b0) begin
				o_seg_enb <= 6'b111111;
	end else begin
     	  if( setting_mode == 2'd1) begin   						
		if(blink == 1'b1) begin
			case (setting_position)				
			2'd0 : begin						// setting_position = 2'd0 => 
				case(cnt_common_node)
				4'd0 : o_seg_enb <= ~o_seg_enb;			// o_seg_enb = 6'b1111111  ALL BLACK
				4'd1 : o_seg_enb <= ~o_seg_enb;			// o_seg_enb = 6'b1111111  ALL BLACK
				4'd2 : o_seg_enb <= 6'b111011;
				4'd3 : o_seg_enb <= 6'b110111;
				4'd4 : o_seg_enb <= 6'b101111;
				4'd5 : o_seg_enb <= 6'b011111;
				default : ;
				endcase  
				end           		
            		2'd1 : begin
            			case (cnt_common_node)				
				4'd0 : o_seg_enb <= 6'b111110;			
				4'd1 : o_seg_enb <= 6'b111101;			
				4'd2 : o_seg_enb <= ~o_seg_enb;
				4'd3 : o_seg_enb <= ~o_seg_enb;
				4'd4 : o_seg_enb <= 6'b101111;
				4'd5 : o_seg_enb <= 6'b011111;
				default : ;
				endcase  
				end           		
           		2'd2 : begin
            			case (cnt_common_node)				
				4'd0 : o_seg_enb <= 6'b111110;			
				4'd1 : o_seg_enb <= 6'b111101;			
				4'd2 : o_seg_enb <= 6'b111011;			
				4'd3 : o_seg_enb <= 6'b110111;
				4'd4 : o_seg_enb <= ~o_seg_enb;
				4'd5 : o_seg_enb <= ~o_seg_enb;
				default : ;
				endcase
				end
             		default : ;	
            		endcase
      		end else begin		
			case (cnt_common_node)				
				4'd0 : o_seg_enb <= 6'b111110;		
				4'd1 : o_seg_enb <= 6'b111101;		
				4'd2 : o_seg_enb <= 6'b111011;
				4'd3 : o_seg_enb <= 6'b110111;
				4'd4 : o_seg_enb <= 6'b101111;
				4'd5 : o_seg_enb <= 6'b011111;
			endcase
		end
	  end else begin
			case (cnt_common_node)				
				4'd0 : o_seg_enb <= 6'b111110;		
				4'd1 : o_seg_enb <= 6'b111101;		
				4'd2 : o_seg_enb <= 6'b111011;
				4'd3 : o_seg_enb <= 6'b110111;
				4'd4 : o_seg_enb <= 6'b101111;
				4'd5 : o_seg_enb <= 6'b011111;
			endcase
   	 end 
end
end

endmodule

