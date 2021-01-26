# download & import official deb package repository key
curl https://build.opensuse.org/projects/home:manuelschneid3r/public_key | sudo apt-key add -

# add albert official repository to my system
echo 'deb http://download.opensuse.org/repositories/home:/manuelschneid3r/xUbuntu_20.04/ /' | sudo tee /etc/apt/sources.list.d/home:manuelschneid3r.list

sudo wget -nv https://download.opensuse.org/repositories/home:manuelschneid3r/xUbuntu_20.04/Release.key -O "/etc/apt/trusted.gpg.d/home:manuelschneid3r.asc"

sudo apt-get update
sudo apt-get install -y albert