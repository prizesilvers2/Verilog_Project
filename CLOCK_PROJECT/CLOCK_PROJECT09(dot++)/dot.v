module dot(
		mode,
		position,
		o_six_dp,
		blink_clk,
		rst_n
			);

input [1:0]	mode		;
input [1:0]	position	;

input		blink_clk	;
input		rst_n		;

output [5:0]	o_six_dp	;

reg [5:0]	o_six_dp	;

always @(posedge blink_clk or negedge rst_n) begin
if(rst_n == 1'b0) begin
		o_six_dp <= 6'b00_00_00 ;
	end else begin
	case(mode)
		2'b00 : begin						//clock
			o_six_dp = 6'b01_01_00 ;
		end
		2'b01 : begin						//setting_mode
			case(position)
				2'b00 : o_six_dp = 6'b00_00_01 ;
				2'b01 : o_six_dp = 6'b00_01_00 ;
				2'b10 : o_six_dp = 6'b01_00_00 ;
				default : o_six_dp = 6'b00_00_00 ;
			endcase
		end
		2'b10: begin
			case(position)
				2'b00 : o_six_dp = 6'b00_00_01 ;
				2'b01 : o_six_dp = 6'b00_01_00 ;
				2'b10 : o_six_dp = 6'b01_00_00 ;
				default : o_six_dp = 6'b00_00_00 ;
			endcase
		end
		2'b11 : o_six_dp <= 6'b00_01_00;
		default :  o_six_dp <= 6'b00_00_00 ;	
	endcase
	end
end	

endmodule
