# 02. VERILOG_STUDY
## 공부한 내용
### ***Verilog를 이용한  elevator설계***

### **[이번주 목표]**

**: 전체적인 code error 고치기**

**: 전체적인 code 분석 마무리하기**

**: .svh 확장자명은 무엇인지 **

## 공부하면서 궁금했던 것

**1. 코드를 컴파일 돌려보니 .svh가 포함되지 않았다고 뜨는데 .svh는 무슨 확장자명인가?**

- ".svh"는 일반적으로 다른 파일/패키지에 포함된 SystemVerilog 파일에 사용된다.

- 이름 지정 규칙으로, 포함 파일로 처리되는 파일과 포함 파일을 식별하는 데 도움이 된다.

- svh 파일 확장명은 일반적으로 검증 환경에서 사용할 모든 포함 파일을 포함하는 SystemVerilog 헤더 파일을 의미한다.

- 기본적으로 그것은 모두를 그룹화하는데 사용된다.

*(추가로 찾아볼 것)*

- .svh도 공부해야하는가? 공부한다면 이는 verilog의 언어로 쓰여있는가?

- 그럼 이파일이 헤더파일이라고 한다면 modelsim에서 어떻게 추가해야하는가?

## 저번주에 몰랐던 거 알아오는 것(숙제)

**1. UP이 나타내는 것을 알아보기**
-  display로 나타내어 있는 것이므로 " "에 들은 것은 simulate결과에서 보여주는 것임.

**2. STATE가 의미하는바 확실하게 그래프 그려서 알아두기(그림그려서)**

 - 00    문이 열려있을때
pg. 60가서 더 공부하기(verilog HDL의 연산자) => 3,4번 질문

**3. &, | 의 개수에 따른 문법의 차이 알아오기**
  - 연산자      기능
   &&      논리 and
    ||      논리 or
   &      비트단위and
    |      비트단위or

**4. ~|의 의미 알아오기**
- 축약 nor의 의미

**5. reg_in_bt_floor& =~floor;  ( &=의 의미알아두기)**
- &=의 의미는 무엇일까?

단순 할당 연산자 = 외에, SystemVerilog에는 C 할당 연산자와 특수 비트wise 할당 연산자가 포함된다. 할당 연산자는 어떤 왼손 인덱스 표현식이 한 번만 평가된다는 점을 제외하고, 블로킹 할당과 의미적으로 동일하다.

출처: http://www.asic-world.com/systemverilog/operators1.html
여기가서 예시보면서 같이 이야기 더해보기

**6. default의미 찾아보고 정리해오기**

- default문은 흔히 프로그래밍에서 어떤 case에도 설정되지 않으면 default을 따른다는 뜻이다.

- default문이 있을 때는 case조건 이외의 조건이 default문을 따르고 없으면 출력이 되지않는다.

 => 그럼 default문을 안썼을때는 어떤 다른 결과를 얻게 되는가?
 
* 결과에는 큰 영향을 주지 않지만 latch가 합성되어 불필요한 게이트가 추가되게 된다.

* 프로그램상의 문제는 없지만 합성을 할 때는 차이가 발생하게 된다.

**7. function과 module의 특징, 차이점,공통점 알아오기**
- function

   * 인수를 통해 값을 전달하면, 함수이름을 통해 결과를 반환함.
   
   * 하나의 값만 받을 수 있음.
   
   * 시간지연을 포함할 수 없어 항상 시뮬레이션 시간 0에 수행됨.

=> 이들의 차이를 어떻게 생각하면 좋은가?
- 프로그램의 형식을 살펴보게 되면

```
<머리부>    module module_name (port_list) ; 
<선언부>        port 선언
                     reg 선언
                     wire 선언
                     parameter 선언
<몸체부>        하위모듈 인스턴스
                     게이트 프리미티브
                     always 문, initial 문
                     assign 문
                     function, task 정의 
                     function, task 호출

                   endmodule 
                   
   ```
  
  
   - 머리부에서는 모듈이름과 포트목록들을 지정한다.
   
   - 선언부에서는 포트목록에 나열된 포트들의 방향, 비트 폭, 자료형 및 parameter 선언 등 모듈에서 필요로 하는 것들을 선언한다. 

- 몸체부에서는 회로의 기능, 동작, 구조 등을 표현하는 다양한 베릴로그 구문들로 구성이 되는데, 여기서 사용되는 구문들은 논리합성용 구문, 시뮬레이션용 구문, 라이브러리 설계용 구문으로 구분이 된다.  

: 위의 형식을 보면 알 수 있듯이 module이 더 큰 개념이고 function은 그 기능을 해주는 함수로써 사용되는 것을 알 수 있다.

=> 찾다보니 task하고 function의 차이점과 공통점을 비교해 놓은게 많던데 왜 그런가요?

** task와 function의 차이점 : 

 - 함수는 적어도 하나 이상의 input 인수를 가지며, output 또는 input 인수를 가질 수 없는
 반면에, task는 인수를 갖지 않을 수 있다. 

- 함수는 단지 하나의 결과 값을 생성하는 반면 task는 하나 이상의 결과 값을 생성하거나
 결과값을 만들지 않을 수도 있다. 

- 함수는 단일 시뮬레이션 단위에 실행되며, task는 delay, timing, event 등의 시간 제어 
문장을 포함할 수 있다. 

- 함수는 task를 실행시킬 수 없으나, task는 다른 task와 함수를 실행시킬 수 있다. 

때문에 function은하나의 출력을 생성하는 일반적인 베릴로그 코드나 완전한 조합논리회로에서 사용되며 베릴로그 모델링 시 피연산자로 작용하고, task는 함수보다 다양한 목적을 위해 사용된다.

task와 함수는 사용자가 지정할 수 있고, 이미 툴에 내장된 함수와 task를 시스템 function과 시스템 task라 칭한다. 

++출처
:https://m.blog.naver.com/PostView.nhn?blogId=km641&logNo=221477131956&proxyReferer=https%3A%2F%2Fwww.google.com%2F

**8. cnt가 무슨 의미를 지니는지, 왜 5bit인지 알아보기** 

+추가로 알아온 것
(verilog의 논리값 집합)
논리값      의미
   0      논리값0 , false condition
   1      논리값1 , true condition
   x      unknown logic value
   z      high-impedance state

=> high impedance state는 무슨 의미인가?

++출처: https://cms3.koreatech.ac.kr/sites/yjjang/down/dsys11/M01_VerilogHDL01.pdf

## 오늘 알게 된 것

**1. in_bt_floor가 [8:1]로 안에서 누를 수 있는 층수를 의미함.**
```
근거) if(floor[1]&&state==2'b00)
     reg_in_bt_floor[1] = 0;
   else if ( in_bt_floor[1] == 1)
      reg_in_bt_floor[1] = 1;
```
=> 이 코드의 의미가 1층에 있고 문이 열려있는 상태를 제외하고는 안에서 1층버튼이 눌리면 1층으로 간다는 의미

=> 따라서 안에서 층수를 선택할 수 있다는 것을 알 수 있음

**2. state의 상태 (알기 쉽게 정리)**
```
00 멈추고 문이 열리고 (일정시간 후에 닫힘)
10 상승 문이 닫힘
01 하강 문이 닫힘
11 멈추고 문이 닫힌상태
```

**3. &=의 의미 (= 축약연산자)**
예시) 이게 차례대로 계산되는 것임.
```
  a         := 00000064
  a += 4    := 00000068
  a -= 4    := 00000064
  a *= 4    := 00000190
  a /= 4    := 00000064
  a %= 17    := 0000000f
  a &= 16'hFFFF    := 0000000f      // &=은 다른것은 0으로 같은것은 f로 나타내어 이렇게 계산됨
  a |= 16'hFFFF    := 0000ffff      // |=은 모두 0인것이외의 것은 같은것로 계산됨
  a ^= 16h'AAAA    := 00005555
  a <<= 4   := 00055550
  a >>= 4   := 00005555
  a <<<= 14  := 15554000
  a >>>= 14  := 00005555
```

=> 그럼 우리코드에 한번 적용을 시켜보도록 하자

우리코드) elevator_control부분
```
2'b01  : begin
if(reachBottom) begin
      reg_btdn &=~floor[8:2];  // Clearing at the Down Button
      reg_btup &=~floor[7:1];
      reg_in_bt_floor &=~floor; 
      next_state <=2'b00; 
```

: Bottom에 도착했을 때, floor[8:2]층은 모두 0이 됨. ~floor[8:2]은 모두 1인 상태가 됨.

: btdn과 ~floor[8:2]를 &로 계산한 후 btdn에 대입함.

: 근데 이때 btdn이 7‘b0000_000인 상태이므로 바닥에 도착했을 때를 계산하면 btdn= 7’b0000_000이 됨.
 
**3. | 가 앞에 나올때 의미가 무엇인가?**

1) wire reachTop =   |(getFirstone({reg_btdn,1'b0}|{1'b0,reg_btup}|reg_in_bt_floor)&floor);

2) wire reachBottom = |(getLastone({reg_btdn,1'b0}|{1'b0,reg_btup}|reg_in_bt_floor)&floor);

![](https://github.com/hanbyeol-lab/VERILOG_STUDY/blob/master/image01.png)
![](https://github.com/hanbyeol-lab/VERILOG_STUDY/blob/master/image02.png)

: 축약 연산자를 통해 |의 계산법을 알게 됨.

: 꼭대기에 도착하는 경우를 살펴보면 {reg_btdn,1'b0}|{1'b0,reg_btup}|reg_in_bt_floor를 계산해보면 되는데 이때, btdn, btup은 무슨 수여도 관계 없지만, in_bt_floor는 무조건 맨 꼭대기층(8층)을 눌러야함.(=8‘b1xxx_xxxx)

: 이를 getFirstone함수에 넣어보면 8’b1000_0000이됨.

: 그리고 floor는 꼭대기 층이므로 8’b1000_0000이 됨.

: 이를 &연산자가 우선순위가 | 높으므로 먼저 계산해보면 8‘b1000_0000이 됨.

: 이를 축약 연산자 표를 보면 1의 개수가 홀수인 경우이므로 1이됨.

: 결과값이 1이 됨으로써 꼭대기에 도착했음을 알 수 있음.


**4. 축약연산자 계산**
우리코드)
'''
if(~|{1'b0,reg_btup}&&~|{reg_btdn,1'b0}&&~|reg_in_bt_floor) begin
   next_state <=2'b11;
'''
: 우선순위를 살펴보면 ~| (축약연산자), && 순임.

: 이 코드는 이전 상태를 유지하는 코드이다.( 멈추고 문닫고, 입력버튼 X)

: btup 7’b0000_000인 상태이므로 ~|{1'b0,reg_btup} = ~| 8‘b0000_0000이 되므로 위의 표에서 찾아보면 1 값이 됨.

: 이와 마찬가지로 ~|{reg_btdn,1'b0}, ~|reg_in_bt_floor 둘다 1이 됨.

: && 연산자로 계산해보면 결과값이 1이 됨.,

: 입력버튼이 없으므로 문이 닫힌 상태에서 상태유지를 함.

**5. 코딩 순서대로 읽고 그림으로 정리해보기**

## 다음주까지 알아올 것
1. svh를 modelsim에 어떻게 추가하는지 알아보기

2. 코드 error찾아오기(&=왜 안돌아가는지)

3. 나머지 file 읽어오기

4. 오늘 한거 복습하기

5. 정리한 것 중 빠진 경우의수가 혹은 더 좋은 방법이 있는지 (특히 조건문) 생각해오기
