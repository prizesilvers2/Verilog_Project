 
`delay_mode_unit
`default_nettype none
`timescale 1ns /100ps

module tb_elevator;

//////////////////////////////////////////////////////////////////////////////
//  input/output port declaration start !!!
//////////////////////////////////////////////////////////////////////////////

 
  wire  [7:0] led_door ;
  wire  [6:0] floorToseg,seg_cnt ;
  wire  led_state_up ;
  wire  led_state_dn ;
  wire  bt_door_close,bt_door_open;
  wire tick_led;
  wire [3:0] st;
  wire [4:0] led_open;
  reg  clk,rst ;
  reg  [7:1] btup ;
  reg  [8:2] btdn ;
  reg  [8:1] in_bt_floor ;
  reg [3:0] Init=0;
  
  
//////////////////////////////////////////////////////////////////////////////////
//  Instantiation of device to test design file(Device Under Test) 
//  Connecting the Testbench and Design                                         //
//  1) Separating the Testbench and Design                                      //
//  2) Using an Interface to simplify Connections                               //
//////////////////////////////////////////////////////////////////////////////////
elevator DUT (.*) ; 

//$random(),$urandom(),$urandom_range(),$dist_exponential(),$dist_normal(),$dist_poisson(),$dist_uniform()
//----------------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////////////
 
 always #10 
   begin:gen_clk
 	 clk=~clk;
   end:gen_clk


   
   
 initial if(Init==0)  //Ok
   begin
           clk='b0;            rst='b0;           btup='b0;           btdn='b0; 
                in_bt_floor='b0; 

   #1700 rst=1;
   #1000 btup[5] = 1;   //
   #1000 btup[6] = 1;   //
   #1000 btup[7] = 1;   // 
   end
     
 initial if(Init==1)   // Working Good
   begin
           clk='b0;            rst='b0;           btup='b0;           btdn='b0; 
                in_bt_floor='b0; 
    
   #100 rst=0; 
   #100 rst=1;  btup='b0; btdn='b0; 
   #1000 btdn[2] = 1;
   #1000 btdn[3] = 1;
   #1000 btdn[4] = 1;
   end   
 

   
 initial if(Init==2) //  Working Consecutive Floors
   begin
           clk='b0;            rst='b0;           btup='b0;           btdn='b0; 
                in_bt_floor='b0;
     
     #100 rst=0; 
   #100 rst=1;  btup='b0; btdn='b0; 
   #1000 in_bt_floor[2] = 1;
   #1000 in_bt_floor[3] = 1;   
  end  

 initial if(Init==3) // Ok
   begin
           clk='b0;            rst='b0;           btup='b0;           btdn='b0; 
                in_bt_floor='b0;
    #100 rst=0; 
   #100 rst=1;  btup='b0; btdn='b0; 
   #1000 btup[2] = 1;
   #1000 in_bt_floor[4]=1'b1;
 end    

 initial if(Init==4) // Ok
   begin
           clk='b0;            rst='b0;           btup='b0;           btdn='b0; 
                in_bt_floor='b0;
    #90 rst=0; 
   #100 rst=1;  btup='b0; btdn='b0; 
   #1000 btup[2] = 1;
   #1000 btup[2] = 0; in_bt_floor[4]=1'b1;
   @(negedge in_bt_floor[4]) btup[1]=1'b1;
   #1000 ;
    
    
  end

 initial if(Init==5) // Not Ok  Stop 4floor and Up 5floor
   begin
           clk='b0;            rst='b0;           btup='b0;           btdn='b0; 
                in_bt_floor='b0;
    #100 rst=0;  
   #1700 rst=1;
 //  #1000 btdn[4] =1; in_bt_floor[5]=1'b1;
   #1000 btdn[4] =1; #2000 in_bt_floor[5]=1'b1;
   #1000 btdn[3] =1; 
   #1000 btdn[2] = 1;
 
  end  

 initial if(Init==6) // Ok
   begin
           clk='b0;            rst='b0;           btup='b0;           btdn='b0; 
                in_bt_floor='b0;
    #100 rst=0;  
   #1700 rst=1;
   #1000 btdn[4] =1; in_bt_floor[5]=1'b1;
   #1000 btdn[3] =1; 
   #1000 btdn[2] = 1; in_bt_floor[8]=1'b1;   //  not down floor 2 
   #1000 btdn[5] = 1;
   #1000 in_bt_floor[3]=1'b1;
  end  
  
  initial if(Init==7) // Ok consecutive floors working 
   begin
           clk='b0;            rst='b0;           btup='b0;           btdn='b0; 
                in_bt_floor='b0;
    #100 rst=0;  
   #1700 rst=1;
   #1000 btup[1] =1; in_bt_floor[5]=1'b1;
   #1000 btdn[3] =1;  
   #1000 btdn[2] = 1; in_bt_floor[8]=1'b1;   //  not down floor 2 
   #1000 btdn[5] = 1; in_bt_floor[3]=1'b1;
   #1000 btup[1] =1;
  end
   
  initial if(Init==8)  // Working Good
   begin
           clk='b0;            rst='b0;           btup='b0;           btdn='b0; 
                in_bt_floor='b0; 

   #1700 rst=1;
   #1000 btup[5] = 1;   //
   #1000 btdn[8] = 1;   // 
   #900 btdn[4] = 1; in_bt_floor[1] = 1; 
   #4000 btup[1] = 1;  in_bt_floor[8] = 1; 
   @(posedge DUT.floor[1]) #4000 btdn[2] =1;  
   end
  
  always @(negedge DUT.U2.reg_btup[1])
  begin
    force btup[1]=1'b0;
    #5 release btup[1];
  end  

 always @(negedge DUT.U2.reg_btup[2])
  begin
    force btup[2]=1'b0;
    #5 release btup[2];
  end
  
 always @(negedge DUT.U2.reg_btup[3])
  begin
    force btup[3]=1'b0;
    #5 release btup[3];
  end
  
 always @(negedge DUT.U2.reg_btup[4])
  begin
    force btup[4]=1'b0;
    #5 release btup[4];
  end  

 always @(negedge DUT.U2.reg_btup[5])
  begin
    force btup[5]=1'b0;
    #5 release btup[5];
  end  

 always @(negedge DUT.U2.reg_btup[6])
  begin
    force btup[6]=1'b0;
    #5 release btup[6];
  end
  
 always @(negedge DUT.U2.reg_btup[7])
  begin
    force btup[7]=1'b0;
    #5 release btup[7];
  end
 
 always @(negedge DUT.U2.reg_btdn[2])
  begin
    force btdn[2]=1'b0;
    #5 release btdn[2];
  end
  
 always @(negedge DUT.U2.reg_btdn[3])
  begin
    force btdn[3]=1'b0;
    #5 release btdn[3];
  end
  
 always @(negedge DUT.U2.reg_btdn[4])
  begin
    force btdn[4]=1'b0;
    #5 release btdn[4];
  end  

 always @(negedge DUT.U2.reg_btdn[5])
  begin
    force btdn[5]=1'b0;
    #5 release btdn[5];
  end  

 always @(negedge DUT.U2.reg_btdn[6])
  begin
    force btdn[6]=1'b0;
    #5 release btdn[6];
  end
  
 always @(negedge DUT.U2.reg_btdn[7])
  begin
    force btdn[7]=1'b0;
    #5 release btdn[7];
  end

 always @(negedge DUT.U2.reg_btdn[8])
  begin
    force btdn[8]=1'b0;
    #5 release btdn[8];
  end

  always @(negedge DUT.U2.reg_in_bt_floor[1])
  begin
    force in_bt_floor[1]=1'b0;
    #5 release in_bt_floor[1];
  end  

 always @(negedge DUT.U2.reg_in_bt_floor[2])
  begin
    force in_bt_floor[2]=1'b0;
    #5 release in_bt_floor[2];
  end
  
 always @(negedge DUT.U2.reg_in_bt_floor[3])
  begin
    force in_bt_floor[3]=1'b0;
    #5 release in_bt_floor[3];
  end
  
 always @(negedge DUT.U2.reg_in_bt_floor[4])
  begin
    force in_bt_floor[4]=1'b0;
    #5 release in_bt_floor[4];
  end  

 always @(negedge DUT.U2.reg_in_bt_floor[5])
  begin
    force in_bt_floor[5]=1'b0;
    #5 release in_bt_floor[5];
  end  

 always @(negedge DUT.U2.reg_in_bt_floor[6])
  begin
    force in_bt_floor[6]=1'b0;
    #5 release in_bt_floor[6];
  end
  
 always @(negedge DUT.U2.reg_in_bt_floor[7])
  begin
    force in_bt_floor[7]=1'b0;
    #5 release in_bt_floor[7];
  end

 always @(negedge DUT.U2.reg_in_bt_floor[8])
  begin
    force in_bt_floor[8]=1'b0;
    #5 release in_bt_floor[8];
  end
             

  
 

///////////////////////////////////////////////////////////////////////////////////////
//   Monitor Response and Verify Outputs (stimulus signals and response signals!!!)  //
// event e1;
//    $display();
//    ->e1;
///////////////////////////////////////////////////////////////////////////////////////

 initial 
   begin
       $monitor ("%3gns        clk = %b,       rst = %b,      btup = %b,      btdn = %b,bt_door_close = %b, ",$time,clk,rst,btup,btdn,bt_door_close) ;
       $monitor ("        bt_door_open = %b,in_bt_floor = %b,",$time,bt_door_open,in_bt_floor );

   end

endmodule
