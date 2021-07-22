module gen_clk 
 (
   output reg tick,
	input rst,clk
	);
	

reg [25:0]cnt ;


always @(posedge clk or negedge rst) 
    begin
    if (!rst)
	  begin
	   cnt<=0;
	   tick <=0;
	  end
    else if (cnt == 26'b10_0000_0000_0000_0000_0000_0000) begin 	
	      cnt <= 0;
			tick <= ~tick;
			end
	   else
			cnt <= cnt + 1;
  end

endmodule

