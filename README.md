# Flutter

Flutter Project Zip

1. 플러터 설정

- 플러터는 안드로이드나 vscode 툴에서 사용이 가능하다. (둘중 하나 있어야함)
- 각 개발 툴에서 플러그인 - flutter / dart 를 다운받는다.
- 플러터를 일단 다운/ dart 언어 다운
  > > 이미 플러그인을 통해 추가로 다운을 받을 수 있는듯 하다.그러나, 직접 사이트를 가보는것도 경험이니 시간별로 안걸린다. 직접가서 다운을 받거나
  > > 만약 뭔지 모르겠으면, 플러그인 설치 후 --> 프로젝트 생성 단계에서 자동으로 'download SDK' 이 부분을 클릭하여 다운한다.
- 플러터는 자바 8 버전? 정도를 사용한다고 한다. java_home/ android_home 등 조건에 맞는 설정들을 해야한다. (에뮬레이터 설치등 )
  > > 방법은 일단 flutter 설치 파일경로로 이동한다.
- 플러터 파일 공간에 보면, **flutter_console.bat** 이 존재한다. 콘솔창이 열린다.
  > > 이후에는 콘솔 창에 'flutter doctor' 를 쳐준다. 이렇게 하면 뭐가 조건에 안맞는지 확인을 해준다. 이 과정을 즐겨찾기에 블로그 글을 참고.

[설치참고 블로그](https://woonizzooni.tistory.com/entry/1-Flutter-%EC%84%A4%EC%B9%98-Android-Studio-%ED%94%8C%EB%9F%AC%EA%B7%B8%EC%9D%B8-%EC%84%A4%EC%B9%98-Windows%ED%99%98%EA%B2%BD)

- git에도 연동을 해줘야한다. (개발자로서 의무랄까)

  > > git은 위의 사항들이 완료가 된다면 알아서 되겠지만, 확인해야할 것을 기록함. (처음에 연동해두면, 빨간 글씨로 되어있음)

  - git bash 자체가 프로그램상에 있는지 확인/ github desktop 설치 여부 확인
  - flutter project 상단 최고 폴더를 우클리하여 git > +Add 를 클릭
  - 이렇게 하면 빨간 글씨 부분들이 없어진다.
  - 이후에는 commit버튼을 하나 눌러 확인해본다. :white_check_mark: 누르기
