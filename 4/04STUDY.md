# 04.VERILOGSTUDY
## 공부한 내용

### ***Verilog를 이용한 elevator 설계***


### **[이번주 목표]**

**: 코드 간편하게 고쳐보기**

**: 지금까지 고친 CODE WAVE 확인하기**

**: 원본 CODE WAVE 확인하기**

**: tb code 이해하고 WAVE 분석하기**


## 이번주에 공부한 것

### **1.  깨달은 점 **

**1) 1. function을 사용하여 복잡한 if문 고침**
```
[추가된 코드]
    function reg[1:0] reg_bt (input a, b, c);

    if (a&b) begin
        reg_bt = 0;
    end
    else if (c==1'b1) begin
        reg_bt = 1;
    end
    
    endfunction
    
    always @ (posedge clk or negedge rst) begin
   reg_btup[1] = reg_bt(dir, floor[1], btup[1]);
   reg_btup[2] = reg_bt(dir, floor[2], btup[2]);
   reg_btup[3] = reg_bt(dir, floor[3], btup[3]);
   reg_btup[4] = reg_bt(dir, floor[4], btup[4]);
   reg_btup[5] = reg_bt(dir, floor[5], btup[5]);
   reg_btup[6] = reg_bt(dir, floor[6], btup[6]);
   reg_btup[7] = reg_bt(dir, floor[7], btup[7]);

   reg_btdn[2] = reg_bt(~dir, floor[2], btdn[2]);
   reg_btdn[3] = reg_bt(~dir, floor[3], btdn[3]);
   reg_btdn[4] = reg_bt(~dir, floor[4], btdn[4]);
   reg_btdn[5] = reg_bt(~dir, floor[5], btdn[5]);
   reg_btdn[6] = reg_bt(~dir, floor[6], btdn[6]);
   reg_btdn[7] = reg_bt(~dir, floor[7], btdn[7]);
   reg_btdn[8] = reg_bt(~dir, floor[8], btdn[8]); 
```
=> 여기서 문제점이 발생함

=> Quartus와 modelsim에는 돌아가나 wave에서 문제가 발생함

![](https://github.com/hanbyeol-lab/VERILOG_STUDY/blob/master/image05.png)

![](https://github.com/hanbyeol-lab/VERILOG_STUDY/blob/master/image06.png)

![](https://github.com/hanbyeol-lab/VERILOG_STUDY/blob/master/image07.png)

**2) 원본코드를 돌려본 결과**
```
[원본 코드]
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

```

**[원본 WAVE]**

![](https://github.com/hanbyeol-lab/VERILOG_STUDY/blob/master/image08.png)

![](https://github.com/hanbyeol-lab/VERILOG_STUDY/blob/master/image09.png)

**=> 오리지널 WAVE에도 문제점(단점)이 발생함**

1) 시간이 매우 오래걸림

2) 문이 열리지 않음(OPEN이 안됨)


### **2.  다음주까지 알아올 것**

**1) tb_elevator 이해해오기**

=> tb에서 init이 언제 바뀌는지 알아보기

**2) tb_elevator 간단하게 짜보기**

=> 낮은 층의 버튼을 누르는 코드로 엘베 이동을 확인할 수 있도록 해보기

**3) 다음에 사볼만한 코드 찾아오기(후보 3개정도)=> verilog elevator**
