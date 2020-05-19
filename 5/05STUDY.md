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

**2) testbench에서 door-open이 되지 않았던 부분 해결**

: "tb_elevator.sv" 코드를 보면 처음에 init=0으로 선언함.
 
: 이 부분을 init=1 ~ init=8로 고쳐야 각 case에 해당하는 엘리베이터 동작 확인 가능함.

: 위 코드를 Init 1, 2에 적용해서 시뮬레이션 돌린 결과(지난번에 Init=0은 돌렸음)

[Init=1 일 때]

![]()

![]()

[Init=2 일 때]

![]()

![]()


### **2. 결과분석**