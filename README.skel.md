# 한국 인터넷 BGP 네트워크 RPKI 적용률 트래커
- 나무위키 [2021년 10월 KT 인터넷 장애 사건](https://namu.wiki/w/2021%EB%85%84%2010%EC%9B%94%20KT%20%EC%9D%B8%ED%84%B0%EB%84%B7%20%EC%9E%A5%EC%95%A0%20%EC%82%AC%EA%B1%B4?from=2021%EB%85%84%2010%EC%9B%94%2025%EC%9D%BC%20KT%20%EC%9D%B8%ED%84%B0%EB%84%B7%20%EC%9E%A5%EC%95%A0%20%EC%82%AC%EA%B1%B4#s-4.5)
- MTN 뉴스 [세계 표준되는 RPKI…우리나란 예산 '0원'](https://news.mtn.co.kr/news-detail/2024090813332917792)
- KISA [라우팅 인증(RPKI)](https://한국인터넷정보센터.한국/jsp/resources/rpki.jsp)

<a href="https://youtu.be/WGY_d4XFcjo">
MBC 보도: KT 인터넷 서비스 장애 "상황 파악중"

<img
	src="image2.webp"
	alt="MBC 보도: KT 인터넷 서비스 장애 '상황 파악중'">
</a>


![RPKI by Country: Korea, Japan, United States, Australia](image.webp)

https://stat.ripe.net/ui2013/widget/rpki-by-country#w.resource=kr%2Cus%2Cjp%2Cau

RPKI가 BGP 설정 오류로 인한 장애 예방에 좋으면 빨리 적용해야겠죠? 각 사업자의
RPKI 적용률을 여기서 확인하세요.

UTC+9 기준 매주 월요일 자정에 업데이트 자동 업데이트 중(Github Action).

## 스크립트 실행 절차
[Makefile 레시피](Makefile) 설명.

1. KISA [AS번호 사용자
   현황](https://krnic.kisa.or.kr/jsp/business/management/asList.jsp) 페이지
   로드, 테이블 파싱
1. 파싱한 AS번호들 이용하여 [whois.radb.net](radb) 쿼리하여 라우팅 프리픽스
   정보 받아오기
1. 받아온 라우팅 프리픽스를 radb에 쿼리하여 `rpki-ov-state` 값이 `valid`인
   프리픽스만 추려냄
1. 데이터 취합 후 markdown테이블과 csv 파일 생성
1. READMD.md 생성, 테이블 삽입

## 프리픽스 현황
https://krnic.kisa.or.kr/jsp/business/management/asList.jsp

- ASN: 자율시스템 번호
- Name: 자율시스템 운영사
- RPKI: 유효한 ROA가 적용된 라우팅 프리픽스 개수
- Total: 총 라우팅 프리픽스 개수
- %: RPKI/Total 백분율
- Bars: 20점 만점 점수

**업데이트: %LAST_UPDATE_ISOTIME%**

### IPv4
%THE_TABLE_V4%

### IPv6
%THE_TABLE_V6%

## Usage
### INSTALL
```sh
dnf install make python3
```

### Generate
실행 시간 5분 내외. 메모리 사용량(RSS): 약 50MB

```sh
git clone https://github.com/dxdxdt/rpki-tracker-kr
make clean
make
```

<!--
## Director's Commentary
> [They're bashing they're bashing hard right now.](https://www.youtube.com/clip/Ugkxcic7nqMOsjDFaM1mGLm0f2_Kd82YeJbe)
-->
