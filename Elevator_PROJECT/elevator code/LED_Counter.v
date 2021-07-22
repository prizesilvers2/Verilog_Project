`default_nettype none
module LED_Counter
 (
   output reg [6:0] seg_cnt,
   input wire [3:0] cnt_in
   );

`include "elevator.svh"

always @ (*) begin   // DE2-115 7Segment Decoder
		case (cnt_in) 	
			1 : seg_cnt  = 7'b111_1001;
			2 : seg_cnt  = 7'b010_0100;
			3 : seg_cnt  = 7'b011_0000;
			4 : seg_cnt  = 7'b001_1001;
			5 : seg_cnt  = 7'b001_0010;
			6 : seg_cnt  = 7'b000_0010;  
			
			7 : seg_cnt  = 7'b111_1000;   //
			
			8 : seg_cnt  = 7'b000_0000;		
			9 : seg_cnt  = 7'b001_0000;
			0 : seg_cnt  = 7'b100_0000;
			default: seg_cnt  = 7'b111_1111;
		endcase
		end
		endmodule
		
