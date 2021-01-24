# 참조 https://www.digitalocean.com/community/tutorials/how-to-install-mysql-on-ubuntu-20-04

# MySQL 설치.
sudo apt-get update
sudo apt-get install -y mysql-server

# MySQL Secure Installation 실행.
# optional. 설정항목은 암호검증, 암호복잡도정책, 루트암호, 익명유저, root유저 오직 localhost에서 접속가능, test db
# sudo mysql_secure_installation

# 접속 테스트
# sudo mysql -u root -p

