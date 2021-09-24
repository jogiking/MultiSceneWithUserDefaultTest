# MultiSceneWithUserDefaultTest
- 실행환경: 아이패드 에어 4세대(iOS 14.5)
- 화면모드: Landscape left + right

## 최종 테스트 목표
1. 멀티 씬 기능이 있는 앱을 구현한다
2. 데이터 저장 방식은 UserDefault를 사용한다

## 테스트 방법
1. 앱을 실행하고 데이터를 추가한 뒤, 별도의 저장 액션 없이(저장 버튼 클릭과 같은) App Switcher로 이동해보기
    - 자동으로 데이터 저장이 되어야 한다
2. 앱을 실행하고 데이터를 추가한 뒤, 그대로 background로 이동한다
    - 자동으로 데이터 저장이 되어야 한다

## multiScene 브랜치 실행화면

| 새로운 scene에도 화면 갱신이 일어남 |
|--|
|<img src = "https://user-images.githubusercontent.com/38206212/134629357-46fa8503-3d96-4b84-8dfa-f53157694797.gif">  |
