module tb_bnb	;

wire	q_block		;
wire	q_nonblock	;

reg	d	;
reg	clk	;

initial		clk = 1'b0	;
always	#(100)	clk = ~clk	;


block		dut0(q_block, d, clk);

nonblock	dut1(q_nonblock, d, clk);

initial begin

#(0)	{ d } = 1'b0	;
#(100)	{ d } = 1'b0	;
#(100)	{ d } = 1'b1	;
#(100)	{ d } = 1'b1	;
#(100)	{ d } = 1'b0	;
#(100)	{ d } = 1'b1	;
#(100)	{ d } = 1'b1	;
#(100)	{ d } = 1'b1	;
#(100)	{ d } = 1'b0	;
#(100)	{ d } = 1'b0	;
$finish ;

end

endmodule
