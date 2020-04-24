# loginpage

로그인페이지 연습 

1. ## 최초 클래스 생성
    -- stless를 치면 자동으로 클래스 statelessWidget과 빈 클래스로 생성이 됨.
2. **클래스 및 위젯**
- ### MaterialApp()

- ### Scaffold()
>> 토대라는 뜻이다. 가장 기본이 되는 클래스로 다양한 기능을 제공한다. 
>대표적으로 floatingButton, snackbar, drawer, bottomsheet 등을 사용한다.  

- #### Container() 
>> 콘테이너는 말그대로 한 상자? 즉 내용물을 담는 객체이다. 빈공간이고 
>즉, 레이아웃이라고 생각하면된다. color. padding, alignment, width,height, margin등 기본적인
>화면의 구성을 나타낸다.  

- #### Stack() 
>> 스택은 컨테이너 급의 것으로, 안에 순서대로 쌓을 수가 있는 것이다. 스택개념 그대로
>alignment , textDirection, fit, overflow 등 다양한 것이 있으며, 
>특티 widget이 있어서, children:<Widget>[] 을 통해서 안에다 쌓는 것이다. 

- ##### Form() 
>> form은 형태, 즉 틀이다, 
>

- + TextFormFiled() 
>> 입력창. inputText와 비슷한거 같다. form안에 있는 textfield라고 설명되어있다. 
>


- + validator: () -> 
>> 이것은 텍스트 폼에서 가져온 값을 타당한지 검증해주는 위젯이다. 
>
>
>


- const 는 상수를 뜻한다. 변하지 않는 수. 만약 fianl로 선언해서 변수로 쓰는데, const로 해버리면 
사용이 불가능하다. 
