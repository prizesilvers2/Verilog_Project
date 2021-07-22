module tb_decorder ;

reg  [2:0]	in ;
reg		en ;

wire [7: 0]	out1 ;
wire [7: 0]	out2 ;

dec3to8_shift	dut_0(  .in( in),
		        .en( en),
			.out(out1)  );



dec3to8_case	dut_1(  .in( in ),
		        .en( en ),
			.out(out2)     );

initial begin
$display("==========================================================================");
$display(" en	in[0]	in[1]	in[2]	out1	out2");
$display("==========================================================================");
#(50)	{en, in[0], in[1], in[2]} = 4'b_0000;	#(50)	$display("%b\t%b\t%b\t%b\t%b\t%b", en, in[0], in[1], in[2], out1, out2);
#(50)	{en, in[0], in[1], in[2]} = 4'b_0001;	#(50)	$display("%b\t%b\t%b\t%b\t%b\t%b", en, in[0], in[1], in[2], out1, out2);
#(50)	{en, in[0], in[1], in[2]} = 4'b_0010;	#(50)	$display("%b\t%b\t%b\t%b\t%b\t%b", en, in[0], in[1], in[2], out1, out2);
#(50)	{en, in[0], in[1], in[2]} = 4'b_0011;	#(50)	$display("%b\t%b\t%b\t%b\t%b\t%b", en, in[0], in[1], in[2], out1, out2);
#(50)	{en, in[0], in[1], in[2]} = 4'b_0100;	#(50)	$display("%b\t%b\t%b\t%b\t%b\t%b", en, in[0], in[1], in[2], out1, out2);
#(50)	{en, in[0], in[1], in[2]} = 4'b_0101;	#(50)	$display("%b\t%b\t%b\t%b\t%b\t%b", en, in[0], in[1], in[2], out1, out2);
#(50)	{en, in[0], in[1], in[2]} = 4'b_0110;	#(50)	$display("%b\t%b\t%b\t%b\t%b\t%b", en, in[0], in[1], in[2], out1, out2);
#(50)	{en, in[0], in[1], in[2]} = 4'b_0111;	#(50)	$display("%b\t%b\t%b\t%b\t%b\t%b", en, in[0], in[1], in[2], out1, out2);
#(50)	{en, in[0], in[1], in[2]} = 4'b_1000;	#(50)	$display("%b\t%b\t%b\t%b\t%b\t%b", en, in[0], in[1], in[2], out1, out2);
#(50)	{en, in[0], in[1], in[2]} = 4'b_1001;	#(50)	$display("%b\t%b\t%b\t%b\t%b\t%b", en, in[0], in[1], in[2], out1, out2);
#(50)	{en, in[0], in[1], in[2]} = 4'b_1010;	#(50)	$display("%b\t%b\t%b\t%b\t%b\t%b", en, in[0], in[1], in[2], out1, out2);
#(50)	{en, in[0], in[1], in[2]} = 4'b_1011;	#(50)	$display("%b\t%b\t%b\t%b\t%b\t%b", en, in[0], in[1], in[2], out1, out2);
#(50)	{en, in[0], in[1], in[2]} = 4'b_1100;	#(50)	$display("%b\t%b\t%b\t%b\t%b\t%b", en, in[0], in[1], in[2], out1, out2);
#(50)	{en, in[0], in[1], in[2]} = 4'b_1101;	#(50)	$display("%b\t%b\t%b\t%b\t%b\t%b", en, in[0], in[1], in[2], out1, out2);
#(50)	{en, in[0], in[1], in[2]} = 4'b_1110;	#(50)	$display("%b\t%b\t%b\t%b\t%b\t%b", en, in[0], in[1], in[2], out1, out2);
#(50)	{en, in[0], in[1], in[2]} = 4'b_1111;	#(50)	$display("%b\t%b\t%b\t%b\t%b\t%b", en, in[0], in[1], in[2], out1, out2);
#(50)	$finish ;
end

endmodule

