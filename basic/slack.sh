# download deb package file
wget https://downloads.slack-edge.com/linux_releases/slack-desktop-4.12.2-amd64.deb

# install slack via deb package file
sudo apt-get install -y ./slack-desktop-4.12.2-amd64.deb
rm ./slack-desktop-4.12.2-amd64.deb