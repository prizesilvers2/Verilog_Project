`default_nettype none
module elevator
   (
     output wire [7:0] led_door,
     output wire [6:0] floorToseg,seg_cnt, 
     output wire led_state_up,
     output wire led_state_dn,
   //  output wire led_weight,
     output wire  bt_door_close,bt_door_open, 
     output wire  tick_led,
     output wire [3:0] st,
     output wire [4:0] led_open,   
     
     input wire clk,rst,
     input wire [7:1]btup,
     input wire [8:2]btdn,
     input wire [8:1] in_bt_floor
      );


wire tick;
wire [8:1] floor;
wire [1:0] state;
wire [1:0] next_state;
wire [4:0] open_door_cnt;

assign tick_led = tick;
assign led_door = floor;

assign st[0]=state==2'b00;
assign st[1]=state==2'b01;
assign st[2]=state==2'b10;
assign st[3]=state==2'b11;

assign led_open[4:0]=open_door_cnt;

gen_clk          U1( .rst(rst), 
                     .clk(clk),
                     .tick(tick) );
                     
elevator_control U2( .floor(floor),
                     .clk(tick),
                     .state(state),
                     .next_state(next_state),
                     .led_state_up(led_state_up),
                     .led_state_dn(led_state_dn),
                     .bt_door_close(bt_door_close),
                     .bt_door_open(bt_door_open),
                     .rst(rst),
                     .btup({2'b0,btup[5:1]}),
                     .btdn({2'b0,btdn[6:2]}),
                     .in_bt_floor({2'b0,in_bt_floor[6:1]}),
                     .cnt(open_door_cnt) );
// elevator_sva DUC (.*);  // Device Under Checker

LED_Counter      U3(seg_cnt,
                    open_door_cnt[3:0]);
LED_floor        U4(.floorToseg(floorToseg),
                    .floor(floor) );

   endmodule