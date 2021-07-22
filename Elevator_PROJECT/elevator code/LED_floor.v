`default_nettype none
module LED_floor
 (
   output reg [6:0] floorToseg,
   input wire [8:1] floor
   );

`include "elevator.svh"

always @ (*) begin   // DE2-115 7Segment Decoder
		case (floor) 	
			8'b0000_0001 : floorToseg  = 7'b111_1001;
			8'b0000_0010 : floorToseg  = 7'b010_0100;
			8'b0000_0100 : floorToseg  = 7'b011_0000;
			8'b0000_1000 : floorToseg = 7'b001_1001;
			8'b0001_0000 : floorToseg  = 7'b001_0010;
			8'b0010_0000 : floorToseg =7'b000_0010;  
			
			8'b0100_0000 : floorToseg =7'b111_1000;  
			8'b1000_0000 : floorToseg =7'b000_0000;		
			default: floorToseg  = 7'b111_1111;
		endcase
		end
		endmodule
		

