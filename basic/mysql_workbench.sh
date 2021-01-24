# download deb package file
wget https://dev.mysql.com/get/Downloads/MySQLGUITools/mysql-workbench-community_8.0.23-1ubuntu20.04_amd64.deb

# install mysql_workbench via deb package file
sudo apt-get install -y ./mysql-workbench-community_8.0.23-1ubuntu20.04_amd64.deb
rm ./mysql-workbench-community_8.0.23-1ubuntu20.04_amd64.deb