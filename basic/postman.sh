# download compression file
wget https://dl.pstmn.io/download/latest/linux64 -O Postman-linux-x64-8.0.1.tar.gz

# extract file
tar -xzf ./Postman-linux-x64-8.0.1.tar.gz
rm ./Postman-linux-x64-8.0.1.tar.gz

# remove previous installed
sudo rm -rf /opt/Postman

# move extracted Postman to /opt
sudo mv Postman /opt

# create symbolic links
sudo ln -s /opt/Postman/Postman /usr/local/bin/postman

# Create a desktop file for Postman App
sudo bash -c "echo '[Desktop Entry]' >> /usr/share/applications/postman.desktop"
sudo bash -c "echo 'Type=Application' >> /usr/share/applications/postman.desktop"
sudo bash -c "echo 'Name=Postman' >> /usr/share/applications/postman.desktop"
sudo bash -c "echo 'Icon=/opt/Postman/app/resources/app/assets/icon.png' >> /usr/share/applications/postman.desktop"
sudo bash -c "echo 'Exec=\"/opt/Postman/Postman\"' >> /usr/share/applications/postman.desktop"
sudo bash -c "echo 'Comment=Postman GUI' >> /usr/share/applications/postman.desktop"
sudo bash -c "echo 'Categories=Development;Code;' >> /usr/share/applications/postman.desktop"
