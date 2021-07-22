//	--------------------------------------------------
//	0~59 --> 2 Separated Segments
//	left = 10 's place	, right = 1 's place
//	--------------------------------------------------
module	double_fig_sep(						
		o_left,
		o_right,
		i_double_fig);

output	[3:0]	o_left		;
output	[3:0]	o_right		;

input	[5:0]	i_double_fig	;

assign		o_left	= i_double_fig / 10	;
assign		o_right	= i_double_fig % 10	;

endmodule
