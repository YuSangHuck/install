package routine;

public class Main {
    public static void main(String[] args) {
        String google = "\"C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe\"";
        String[] urlList = {
                "https://keep.google.com/#NOTE/11rSTYCB8jYJObfhde1e0E4XjMXqDULxqk-VPFKmcvAUczSyxpDK17Z2vwbd8PLA",
                "https://www.signal.bz/",
                "https://mail.naver.com/",
                "https://gmail.com/",
        };
        try {
            for (String url : urlList) {
                Process p = Runtime.getRuntime().exec(google + url);
                p.waitFor();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
