# routine

목적은 매일 하는 루틴의 자동화

## chrome

### target url

- 메일_네이버(https://mail.naver.com/)
- 메일_구글(https://gmail.com/)
- 뉴스_실시간검색어(https://www.signal.bz/)
- 뉴스_관심사관련
- 메모_킵(https://keep.google.com/#NOTE/11rSTYCB8jYJObfhde1e0E4XjMXqDULxqk-VPFKmcvAUczSyxpDK17Z2vwbd8PLA)

### 뭐로 관리할까

- bat(cmd)

``` bat
start chrome https://example.com
<!-- secret mode -->
start chrome /incognito https://example.com
```

- sh
- java

``` java
String google = "\"C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe\"";
String url = "https://naver.com/";
String cmd = google + url;
try {
    Process p = Runtime.getRuntime().exec(cmd);
    p.waitFor();
    System.out.println("Google Chrome launched!");
} catch (Exception e) {
    e.printStackTrace();
}
```

- html with javascript

### 시작프로그램에 등록
