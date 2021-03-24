# download deb package file
wget https://www.launchy.net/downloads/linux/launchy_2.5-1_amd64.deb

# install mysql_workbench via deb package file
sudo apt-get install -y ./launchy_2.5-1_amd64.deb
rm ./launchy_2.5-1_amd64.deb