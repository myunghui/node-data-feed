# Data Feed Smart Contract

Testnet 기반의 데이터 제공 Constract 개발

## 어플리케이션 구조

  웹서비스(nodejs) + 데이터피드 계약
  
### 웹서비스

  일정시간 데이터피드 계약에 요청되어 누적된 Request를 일괄 처리후
  처리 결과를 계약에 응답하는 구조
  
### 데이터피드 계약

  Request 접수시 callback 메소드를 파라메터로 받고,
  처리 완료시 callback 메소드를 호출하는 구조

### 수수료 구조

  설계중
