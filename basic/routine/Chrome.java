import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.InetAddress;
import java.net.URL;
import java.net.UnknownHostException;
import java.util.logging.Logger;

//FIXME 네트워크 연결됐는지 체크해야됨
//머릿속에 떠오른건
//역할1(인터넷 상태 지속적으로 체크), 역할2(역할1 구독)
//근데 그냥 일단 sleep ㄱㄱ
public class Chrome {
    private final static Logger log = Logger.getGlobal();

    public static void main(String[] args) throws InterruptedException, IOException {
        if (isInternetReachable()) {
        } else {
            System.in.read();
        }
        String[] urlList = {
                "https://keep.google.com/#NOTE/11rSTYCB8jYJObfhde1e0E4XjMXqDULxqk-VPFKmcvAUczSyxpDK17Z2vwbd8PLA",
//                "https://www.edureka.co/blog/interview-questions/java-interview-questions/", // java
//                "https://www.edureka.co/blog/interview-questions/spring-interview-questions/", // spring
//                "https://www.edureka.co/blog/interview-questions/spring-boot-interview-questions/", // spring-boot
//                "https://www.edureka.co/blog/interview-questions/top-aws-architect-interview-questions-2016/", // aws architect
//                "https://www.edureka.co/blog/interview-questions/sql-interview-questions", // sql
                "https://www.facebook.com/groups/springkorea/", // community
                "https://www.facebook.com/groups/codingeverybody", // community
                "https://www.signal.bz/",
                "https://mail.naver.com/",
                "https://gmail.com/",
        };
        for (String url : urlList) {
            runChrome(url);
        }
//        foo();
    }

    public static boolean isInternetReachable() {
        try {
            //make a URL to a known source
            URL url = new URL("http://www.google.com");

            //open a connection to that source
            HttpURLConnection urlConnect = (HttpURLConnection) url.openConnection();

            //trying to retrieve data from the source. If there
            //is no connection, this line will fail
            Object objData = urlConnect.getContent();

        } catch (UnknownHostException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            return false;
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            return false;
        }
        return true;
    }

    private static void runChrome(String url) throws InterruptedException, IOException {
        ProcessBuilder pb = new ProcessBuilder("/Applications/Google Chrome.app/Contents/MacOS/Google Chrome", url);
        pb.start();
    }

    public static void foo() throws IOException {
        InetAddress localhost = InetAddress.getLocalHost();
//        InetAddress localhost = InetAddress.getLoopbackAddress();
        byte[] ip = localhost.getAddress();
        for (int i = 0; i < 255; i++) {
            ip[3] = (byte) i;
            InetAddress address = null;
            try {
                address = InetAddress.getByAddress(ip);
            } catch (IOException e) {
                e.printStackTrace();
            }
            if (address.isReachable(1000)) {
//                machine is turned on and can be pinged
                System.out.println("can b pinged");
                System.out.println("address = " + address);
            } else if (!address.getHostAddress().equals(address.getHostName())) {
//                machine is know in a DNS lookup
                System.out.printf("name is '%s', IP is '%s'%n", address.getHostName(), address.getHostAddress());
                System.out.println("address = " + address);
            } else {
//the host address and host name ar equal, meaning the host name could not be resolved
                System.out.println("nothing");
            }
        }
    }
}