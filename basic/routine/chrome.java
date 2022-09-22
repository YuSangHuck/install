import java.util.concurrent.TimeUnit;
import java.util.logging.Logger;

//FIXME 네트워크 연결됐는지 체크해야됨
//머릿속에 떠오른건
//역할1(인터넷 상태 지속적으로 체크), 역할2(역할1 구독)
//근데 그냥 일단 sleep ㄱㄱ
public class Main {
    private final static Logger log = Logger.getGlobal();

    public static void main(String[] args) throws InterruptedException {
        log.info("sleep 1 minute");
        TimeUnit.MINUTES.sleep(1);
        String google = "\"C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe\"";
        String[] urlList = {
                "https://keep.google.com/#NOTE/11rSTYCB8jYJObfhde1e0E4XjMXqDULxqk-VPFKmcvAUczSyxpDK17Z2vwbd8PLA",
                "https://www.signal.bz/",
                "https://mail.naver.com/",
                "https://gmail.com/",
        };
        try {
            log.info("try open google");
            for (String url : urlList) {
                log.info("\topen '" + url + "'");
                Process p = Runtime.getRuntime().exec(google + url);
                p.waitFor();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}