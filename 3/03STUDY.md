# 03.VERILOGSTUDY
## 공부한 내용

### ***Verilog를 이용한 elevator 설계***


### **[이번주 목표]**

**: gen_clk 코드 이해**

**: verilog 문법 이해**

**: elevator_control 코드를 어떻게 더 효율적으로 바꿀 수 있는지 생각**

**: 전체적인 code error 고치기(디버깅)**

## 이번주에 공부한 것

### **1.  깨달은 점 **

**1) 여기서 *가 전체를 받아온 다는 것을 의미함**
```
  gen_clk          	U1(.*);
  elevator_control 	U2( .*,
  			    .clk(tick),
   			    .btup({2'b0,btup[5:1]}),
   			    .btdn({2'b0,btdn[6:2]}),
    			    .in_bt_floor({2'b0,in_bt_floor[6:1]}),
    			    .cnt(open_door_cnt));
```
=> 이때 오류가 난 것을 gen_clk의 input, output명을 가져와서 다시 대입해줌.

=> 고친 것 	gen_clk	U1(.rst(rst), .clk(clk), tick(tick) ) ;


**2) &= 표현 고치기**
```
reg_btdn &=~floor[8:2];  // Clearing at the Down Button
reg_btup &=~floor[7:1];
```
=> system verilog 파일로 옮김으로써 해결!

=> 그러나 이것을 어떻게 verilog 문법으로 바꾸냐가 문제인 상황.

**3) else, end 오류 고치기(대략 5개정도가 있었음)**

=> else를 쓸 때는 begin과 같이 써야함(환상의 짝궁)

=> 고친것 	else **begin**
           ----내용-----
           **end**

**4) system verilog와 verilog 파일의 차이점**

=> verilog는 전자 시스템을 model하는 곳에만 쓰임 (HDL용도)

=> system verilog는 하드웨어 modeling, design, simulate, test, verify도 하고
전자 시스템에 실제로 적용됨 (HDL, HVL 용도로 둘다 쓸 수 있음)

=> system verilog > verilog	(포함 관계임)


### **2.  다음주까지 알아올 것**

**1) 코드의 효율성을 높이기 위해 할 것을 생각해보기**

가) &= 고칠 수 있는지 생각해보기

나) if 어떻게 줄일 수 있는지 생각해보기 => case문으로 어떻게 하면 좋은지 생각해보기

다) | (or) (논리 연산자 아님)

라) 엘리베이터의 원리 또는 다른 엘리베이터 코드 찾아보기(코드는 링크로 몇개 가져오기)
- 다른 추가 기능으로 뭐 있나 생각하기
- 생각하지 못한 기능이 뭐가 있나 생각하기

마) system verilog와 verilog 차이점(문법적이거나 등등) 알아보기

바) STATE 안에 CASE부분을 어떻게 간단하게 짤 수 있을지 생각해보기

**2)다음시간에 하드웨어로 구성을 한다면 어떻게 구성하는 것이 좋은지 생각해보기**


### **3. 생각해볼 내용**

**효율성이 좋다고 하는 코드는 짧게 축약되어 동작시간이 짧은 코드인가? 아니면 가독성이 좋지만 조금 긴 코드가 좋은 것인가?**

### **4. 장기적인 목표**

**: 코드를 효율성 있게 짜는 것**

**: 하드웨어로 간단하게 구현해보는 것**

**: 필요한 것은 기능을 추가하는 것**
