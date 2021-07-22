
`default_nettype none
module elevator_control(  
             output reg [8:1] floor,
           output reg [1:0] state,
           output reg [1:0] next_state,
           output wire led_state_up,
           output wire led_state_dn,
      output wire bt_door_close,bt_door_open, 
      output reg [4:0] cnt,
           input wire rst,clk,
           input wire [7:1]btup,
           input wire [8:2]btdn,
           input wire [8:1] in_bt_floor
            );
         
`include "elevator.svh"
   
reg [7:1] reg_btup;
reg [8:2] reg_btdn;
reg [8:1] reg_in_bt_floor=8'b0000_0000;
reg dir;


function [8:1] getFirstone (input [8:1] in);
casex(in)
 8'b1xxx_xxxx: getFirstone=8'b1000_0000;
 8'b01xx_xxxx: getFirstone=8'b0100_0000;
 8'b001x_xxxx: getFirstone=8'b0010_0000;
 8'b0001_xxxx: getFirstone=8'b0001_0000;
 8'b0000_1xxx: getFirstone=8'b0000_1000;
 8'b0000_01xx: getFirstone=8'b0000_0100;
 8'b0000_001x: getFirstone=8'b0000_0010;
 8'b0000_0001: getFirstone=8'b0000_0001;
 default:getFirstone=0;
endcase
endfunction

function [8:1] getLastone (input [8:1] in);
casex(in)
 8'b1000_0000: getLastone=8'b1000_0000;
 8'bx100_0000: getLastone=8'b0100_0000;
 8'bxx10_0000: getLastone=8'b0010_0000;
 8'bxxx1_0000: getLastone=8'b0001_0000;
 8'bxxxx_1000: getLastone=8'b0000_1000;
 8'bxxxx_x100: getLastone=8'b0000_0100;
 8'bxxxx_xx10: getLastone=8'b0000_0010;
 8'bxxxx_xxx1: getLastone=8'b0000_0001;
 default:getLastone=0;
endcase
endfunction

assign led_state_up = (state[1] & !state[0]);   // 2'b10
assign led_state_dn = (!state[1] & state[0]);   // 2'b01   
wire reachTop =   |(getFirstone({reg_btdn,1'b0}|{1'b0,reg_btup}|reg_in_bt_floor)&floor);
wire reachBottom = |(getLastone({reg_btdn,1'b0}|{1'b0,reg_btup}|reg_in_bt_floor)&floor);

assign bt_door_close = state!=2'b00;
assign bt_door_open = state == 2'b00;

always @ (negedge clk or negedge rst) 
  begin
    if(!rst)
        state <=2'b00;
      else
         state <= next_state;
  end
  
  
always @ (posedge clk or negedge rst) begin
  
   if(!rst) begin
     reg_btup[7:1]=0;
     reg_btdn[8:2]=0;
         reg_in_bt_floor=0;   
     floor <= first;
     next_state <= 2'b11;
     dir=1'b1;
     cnt=9;
   end
   else
   begin 

    if(dir & floor[1])
       reg_btup[1] = 0;   
   else  if (btup[1] == 1'b1)
      reg_btup[1] = 1;
      
   if(dir & floor[2])
       reg_btup[2] = 0;   
   else  if (btup[2] == 1'b1)
      reg_btup[2] = 1;
      
   if(dir & floor[3])
       reg_btup[3] = 0;   
   else  if (btup[3] == 1'b1)
      reg_btup[3] = 1;
      
   if(dir & floor[4])
       reg_btup[4] = 0;   
   else  if (btup[4] == 1'b1)
      reg_btup[4] = 1;
      
    if(dir & floor[5])
       reg_btup[5] = 0;   
    else  if (btup[5] == 1'b1)
      reg_btup[5] = 1;
      
     
   if(dir & floor[6])
       reg_btup[6] = 0;   
   else  if (btup[6] == 1'b1)
      reg_btup[6] = 1; 
      
   
   if(dir & floor[7])
       reg_btup[7] = 0;   
   else  if (btup[7] == 1'b1)
      reg_btup[7] = 1;   
      
      
   if(~dir & floor[2])
       reg_btdn[2] = 0;   
   else  if (btdn[2] == 1'b1)
      reg_btdn[2] = 1;
      
   if(~dir & floor[3])
       reg_btdn[3] = 0;   
   else  if (btdn[3] == 1'b1)
      reg_btdn[3] = 1;
      
   if(~dir & floor[4])
       reg_btdn[4] = 0;   
   else  if (btdn[4] == 1'b1)
      reg_btdn[4] = 1;
      
    if(~dir & floor[5])
       reg_btdn[5] = 0;   
   else  if (btdn[5] == 1'b1)
      reg_btdn[5] = 1;
      
     
   if(~dir & floor[6])
       reg_btdn[6] = 0;   
   else  if (btdn[6] == 1'b1)
      reg_btdn[6] = 1; 
      
   
   if(~dir & floor[7])
       reg_btdn[7] = 0;   
   else  if (btdn[7] == 1'b1)
      reg_btdn[7] = 1;   
      
   if(~dir & floor[8])
       reg_btdn[8] = 0;   
   else  if (btdn[8] == 1'b1)
      reg_btdn[8] = 1;   


            
    if(floor[1]&&state==2'b00)
     reg_in_bt_floor[1] = 0;
   else if ( in_bt_floor[1] == 1)
      reg_in_bt_floor[1] = 1;

    if(floor[2]&&state==2'b00)
     reg_in_bt_floor[2] = 0;
   else if ( in_bt_floor[2] == 1)
      reg_in_bt_floor[2] = 1;
      
   if(floor[3]&&state==2'b00)
     reg_in_bt_floor[3] = 0;
   else if ( in_bt_floor[3] == 1)
      reg_in_bt_floor[3] = 1;
      
   if(floor[4]&&state==2'b00)
     reg_in_bt_floor[4] = 0;
   else if ( in_bt_floor[4] == 1)
      reg_in_bt_floor[4] = 1;
      
   if(floor[5]&&state==2'b00)
     reg_in_bt_floor[5] = 0;
   else if ( in_bt_floor[5] == 1)
      reg_in_bt_floor[5] = 1;
      
   if(floor[6]&&state==2'b00)
     reg_in_bt_floor[6] = 0;
   else if ( in_bt_floor[6] == 1)
      reg_in_bt_floor[6] = 1;
   
   if(floor[7]&&state==2'b00)
     reg_in_bt_floor[7] = 0;
   else if ( in_bt_floor[7] == 1)
      reg_in_bt_floor[7] = 1;
      
   if(floor[8]&&state==2'b00)
     reg_in_bt_floor[8] = 0;
   else if ( in_bt_floor[8] == 1)
      reg_in_bt_floor[8] = 1;
      
     
   case (state) 
   2'b11  : begin   // closing the door of the current stopping floor 
      if(({1'b0,reg_btup} > floor && {reg_btdn,1'b0} > floor) && reg_in_bt_floor > floor) begin
                  dir=1'b1;
                  next_state <=2'b10;
                  $display("11->10 :Closing the door and Up 1");
      end
      else if(({1'b0,reg_btup} < floor && {reg_btdn,1'b0} < floor) && reg_in_bt_floor < floor) begin
                  if(floor==8'b0000_0001) begin
                        dir=1'b1;
                        next_state <=2'b10;
                       $display("11->10 :Closed the door and UP 2");                
                    end
         else begin
                       if(~|{1'b0,reg_btup}&&~|{reg_btdn,1'b0}&&~|reg_in_bt_floor) begin
               next_state <=2'b11;
                          $display("11->11 [%b]:Closed the door and Sustainging ",floor);
                      end 
            else begin
                          next_state <=2'b01;
                          dir=1'b0;
                           $display("11->01 [%b]:Closed the door and DOWN 3",floor);
            end
                 end   
      end   
          else if(reachTop) begin
         if(~|{1'b0,reg_btup}&&~|{reg_btdn,1'b0}&&~|reg_in_bt_floor) begin  // no pressing button begin
                       next_state <=2'b11;
                       $display("11->11 [%b] :Sustaining and Closed the door at the  Top  due to no pressing button 4 [%b]",floor,reg_btdn);   
         end 
         else begin
            dir=1'b0;
                 next_state<=2'b01; 
            $display("11->01 [%b] :Reached the door at the  Top  due to pressing below button 4 [%b]",floor,reg_btdn);   
         end
      end
      else if((({1'b0,reg_btup} > floor) & (~|reg_btdn) & (~|reg_in_bt_floor) )||((~|reg_btup) & ({reg_btdn,1'b0} > floor) & (~|reg_in_bt_floor)) ||((~|reg_btup)& (~|reg_btdn) & (reg_in_bt_floor > floor))) begin
         dir=1'b1;
         next_state<=2'b10; 
         $display("11->10 [%b] : at the  current floor  due to pressing above button 8 [%b]",floor,reg_btdn);   
      end
      else begin 
         if(reachBottom) begin
            dir=1'b1;
            next_state<=2'b10; 
            $display("11->10 [%b] :Reached the door at the  Bottom due to pressing above button 5 [%b]",floor,reg_btdn);   
         end 
         else begin   
            if(dir) begin
               next_state<=2'b10;
               $display("11->10 [%b] :Sustained and bypassing UP  due to  pressing below button 6 [%b]",floor,reg_btdn);   
            end
            else begin
               next_state<=2'b01;
               $display("11->01 [%b] :Sustained and bypassing DOWN  due to  pressing below button 7 [%b]",floor,reg_btdn);   
            end
         end    
      end 
      cnt=10;
   end
      
   2'b10  : begin
      if(reachTop) begin
         reg_btdn = reg_btdn&~floor[8:2];  // Clearing at the Down Button
         reg_btup = reg_btup&~floor[7:1];
         reg_in_bt_floor = reg_in_bt_floor&~floor; 
         next_state<=2'b00; 
         $display("10->00 [%b] :Reaching the door at the  Top Down floor due to pressing DOWN button on 1 [%b]",floor,reg_btdn);   
      end
      else if(({1'b0,reg_btup}&floor)||(floor&reg_in_bt_floor))begin
         reg_btup = reg_btup&~floor[7:1];
         reg_in_bt_floor = reg_in_bt_floor&~floor;
         next_state<=2'b00; 
         $display("10->00 :Opening the door at the floor due to pressing UP or In_Elevator button on "); 
       end
          
      else begin
         if(floor!=8'b10000_0000) begin
            floor <={floor[7:1],1'b0};
             if(|reg_btup|||reg_btdn|||reg_in_bt_floor) begin
               next_state<=2'b11;
            end
            else begin
               next_state<=2'b10;    
                    $display("10->10 [%b]:Bypassing the door at the floor due to no pressing button on ",floor);                                
                 end
         end
      end
   end                        //error
   
   2'b01  : begin
      if(reachBottom) begin
         reg_btdn = reg_btdn & ~floor[8:2];  // Clearing at the Down Button
         reg_btup = reg_btup & ~floor[7:1];
         reg_in_bt_floor = reg_in_bt_floor & ~floor; 
         next_state <=2'b00; 
         $display("01->00 [%b] :Reaching the door at the  Most Down floor due to pressing DOWN button on 1 [%b]",floor,reg_btdn);   
      end
      else if(({reg_btdn,1'b0}&floor)||(floor&reg_in_bt_floor)) begin
         reg_btdn = reg_btdn & ~floor[8:2]; 
         reg_in_bt_floor = reg_in_bt_floor & ~floor;
         next_state <=2'b00; 
         $display("01->00 :Opening the door at the floor due to pressing Down or In_Elevator button on "); 
      end
      else begin
         if(floor!=8'b0000_0001) begin
                 floor <={1'b0,floor[8:2]};
            if(|reg_btup|||reg_btdn|||reg_in_bt_floor) begin
               next_state<=2'b11;
            end
            else begin
                     next_state<=2'b01; 
                        $display("01->01 :Bypassing the door at the floor due to above pressing button on ");   
            end
         end
      end
   end
         
   default : begin
      if (cnt!=0) begin
      cnt=cnt-1'b1;
         if(reachTop) begin
                           dir=1'b0;
            $display("00->11 :Opened  and Closing down due to reaching Top 1");                      
                         end
                      else if(reachBottom) begin
                           dir=1'b1;
            $display("00->11 :Opened  and Closing due to Button 2");    
                         end
                      else if((floor<={1'b0,reg_btup})&&(floor <={reg_btdn,1'b0})&&(floor<=reg_in_bt_floor)) begin
                            dir=1'b1;
            $display("00->11 :Opened  and Closing Up 3 ");
         end
         else if ((floor>{1'b0,reg_btup})&&(floor >{reg_btdn,1'b0})&&(floor>reg_in_bt_floor)) begin
                            dir=1'b0;  
            $display("00->11 :Opened  and Closing and Down 4 ");
         end
         else begin
                 $display("00->11 :Opened and Closing and Unchanging the dirction  5 ");
                          end
              end
      else begin
                       next_state<=2'b11;      
                end
   end
   endcase   
end                  // rst=1, else begin
end                  // always begin
endmodule
