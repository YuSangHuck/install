# 참조 https://www.digitalocean.com/community/tutorials/how-to-install-mysql-on-ubuntu-20-04

# MySQL 설치.
sudo apt-get update
sudo apt-get install -y mysql-server

# MySQL Secure Installation 실행.
# optional. 설정항목은 암호검증, 암호복잡도정책, 루트암호, 익명유저, root유저 오직 localhost에서 접속가능, test db
# sudo mysql_secure_installation

# 접속 테스트
# sudo mysql -u root -p

# 5.7 이후부터는 root의 mysql plugin이 auth_socket
# 2가지 방법이 있음
# 1. plugin을 mysql_native_password로 바꾸거나
# 2. 새 계정을 만들어서 권한을 주거나

# 1번의 방법은 아래와 같다
# update user set plugin='mysql_native_password' where user='root';
# flush privileges;

# 2번은 나중에 찾아보자.
