# 04.VERILOGSTUDY

스터디 날짜 : 2020/05/19

## 공부한 내용

### ***Verilog를 이용한 elevator 설계***


### **[이번주 목표]**

**: tb로 elevator가 wave, transcript로 제대로 작동하는지 확인하기**

**: tb를 짤 때 고려해야하는 문법 공부하기**

## 이번주에 공부한 것

### **1.  깨달은 점**

**1) testbench에서 작동시간 줄이는 방법**

: 'timescale 1ns/10ps로 고침
  (위와 같이 run length를 100ps->10ps로 설정)

: tb code의 시간 단위를 #100로 줄임
```
[고친 코드]
initial if(Init==0)  //Ok
   begin
   clk='b0;            
   rst='b0;           
   btup='b0;           
   btdn='b0; 
   in_bt_floor='b0; 

   #100 rst=1;
   #100 btup[5] = 1;   //
   #100 btup[6] = 1;   //
   #100 btup[7] = 1;   // 
   end
```
**2) verilog 문법 force & release**
: tb에서 사용된 문법

: 값을 강제로 바꿔주고 돌려줄 때 사용함

**force**
: verilog에서 신호를 특정 값으로 forcing 할 때 사용

[형식] 

force	신호이름 = 특정값 ;

**release**
: forcing한 값을 다시 풀어줄 때 사용

[형식]

release	신호이름 ;


**3) testbench에서 door-open이 되지 않았던 부분 해결**

: "tb_elevator.sv" 코드를 보면 처음에 init=0으로 선언함.
 
: 이 부분을 init=1 ~ init=8로 고쳐야 각 case에 해당하는 엘리베이터 동작 확인 가능함.

: 위 코드를 Init 1, 2에 적용해서 시뮬레이션 돌린 결과(지난번에 Init=0은 돌렸음)

[Init=1 일 때]

![](https://github.com/prizesilvers2/Verilog_Study/blob/master/Figs/5/wave(Init%3D1).png)

![](https://github.com/prizesilvers2/Verilog_Study/blob/master/Figs/5/transcript(Init%3D1).png)

[Init=2 일 때]

![](https://github.com/prizesilvers2/Verilog_Study/blob/master/Figs/5/wave(Init%3D2).png)

![](https://github.com/prizesilvers2/Verilog_Study/blob/master/Figs/5/transcript(Init%3D2).png)


### **2. 결과분석**
