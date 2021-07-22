# Lab 09
## 실습 내용
### ****적외선 컨트롤러(IR Controller)를 이용하여 통신****


### **Modelsim에서 학습할 것**

**:  top코드를 작성하여 Simulate 돌려서 wave 확인하기**

**: Wave에서 리모컨 송신시호에서 Leader Code, Custom Code(16bit), Data Code(16bit)이 들어오는 것 확인하기**

**: Leader Code는 1로 9ms 들어오고 0으로 4.5ms가 들어오는 것을 확인**

**:Custom Code는 특정회사별로 다르게 나타남.**

**: Data Code는 송신데이터로 Bit 0 은 그림1, Bit 1은 그림2 와 같은 신호의 길이가 들어왔을 때를 의미함.**

![](https://github.com/kse8974/LogicDesign/blob/master/09/figs/bit%20.jpg)


## 결과(WAVE 해석과 코드해석)

**: Quartus에서 확인해본 회로**

![](https://github.com/kse8974/LogicDesign/blob/master/09/figs/circuit.jpg)

**: WAVE 해석**

![](https://github.com/kse8974/LogicDesign/blob/master/09/figs/wave1.jpg)

![](https://github.com/kse8974/LogicDesign/blob/master/09/figs/wave3.jpg)

위에 wave 형태를 먼저 살펴보도록 하자.
사전지식으로 리모콘 송신신호는 Leader Code, Custom Code, Data Code가 있다는 것을 알고있다고 보자.

먼저 Leader Code의 wave를 살펴보면
Leader Code는 1로 9ms 들어오고 0으로 4.5ms가 들어오는 것을 확인하기 위해서는 1ms단위로 신호가 들어오는 것을 확인해야하기 때문에 1M clk을 만들어줘야한다. 따라서 nco 모듈을 이용하여 1M clk을 만들어 준다. clk_h가 0-8999까지 올라가는 것과 clk_l이 0인 상태가 유지되면 Leader Code에서 1로 9ms가 들어오는 상태인 것을 알 수 있다. 또한 그림1에서 커서를 통해 그 시간이 8.98516ms라는 것을 알 수 있다. 이와 마찬가지로 clk_h=0 이고 clk_l이 0-4499까지 올라갈 때는 Leader Code에서 0으로 4.5ms가 들어오는 상태라는 것을 알 수 있다. 

다음으로 Custom Code의 wave를 살펴보면
Custom Code는 특정회사를 나타내는 코드라고 배웠다. 이 코드는 총 16bit로 이루어져있고 NEC적외선 통신규약을 따르고 있다. 따라서 위의 그림과 같이 Bit 0은 1.125ms 동안 변하고 cnt_h는 0-599, cnt_l는 0-564까지를 나타내고 Bit 1은 2.25ms 동안 변하고 cnt_h는 0-599, cnt_l은 0-1689까지 나타낸다. 이때부터 cnt32가 카운트를 세기 시작한다. 이때 카운트는 1~16까지 올라갈 수 있고 이 이상이 되면 Data Code로 넘어가게 된다.

마지막으로 Data Code의 wave를 살펴보면
Data Code는 송신데이터를 나타낸다. 송신데이터는 총 16bit로 이루어져있는데 이때 8bit는 송신데이터고 나머지 8bit는 보수신호이다. 보수신호를 보냄으로써 데이터가 맞는 데이터인지 확인한다. 이때 비트를 읽는 것은 Custom Code와 같이 NEC적외선 통신규약을 따르고 있다. 또한 데이터는 마지막에 들어온 데이터가 저장될떄는 첫번째로 저장되므로 data [32-cnt32] <= 1'b1; 을 사용하여 저장장소를 지정해주었다. 또한 cnt32가 32를 넘어가면서부터 o_data에 정보가 들어가기 시작한다. 이를 통해 처음 cnt32가 32를 찍기전에는 신호가 빨간색으로 없다가 32이후에 o_data의 신호가 초록색으로 변하는 것을 알 수 있다. 

코딩부분을 조금 더 자세하게 살펴보면
State를 넘어갈 때, 9000을 8500으로, 4500을 4000으로 나타낸 부분을 볼 수 있는데 이는 리모콘이 송신할 때 온전한 신호를 보내지 않을 수도 있으므로 오차를 생각하여 조절해준것임을 알 수 있다. (다른 부분에서도 모두 오차를 고려하여 작성함)

또한 seq_rx <= {seg_rx[0], ir_rx} ; 코드를 통해서 신호가 옆으로 이동한다는 것을 볼 수 있다. 

그리고 stat를 LEADCODE, DATACODE, COMPLETE 로 나눠서 차례대로 코드가 돌아갈 수 있게 코딩하였다.

![](https://github.com/kse8974/LogicDesign/blob/master/09/figs/test%20bench.jpg)

테스트 벤치를 살펴보면 처음으로 task 함수를 사용하는데 이는 이번 실험에서 Code를 만들어주는데 사용하였다. 이 함수는 일정한 신호를 만들어주는데 효과적으로 사용할 수 있었다.

함수 형태
task  코드이름;


      begin            데이터값 ;

      #(시간)          데이터값 ;

      #(시간)     ;

      end

endtask







<!--stackedit_data:
eyJoaXN0b3J5IjpbLTEwODE5MTU2NjIsLTE1MDE0OTE3NDUsLT
IxNzMxMDkxNCwtMjIyNjk4MzAyLDEzODk3NDE3MDddfQ==
-->