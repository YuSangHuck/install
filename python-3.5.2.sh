# !/bin/bash
# install python3.5.2 at ubuntu:14.04

# install basic
apt-get update; 
apt-get install -y --no-install-recommends wget \
	build-essential libsqlite3-dev libreadline-dev \
	libssl-dev openssl vim

# download Python3.5.2 & Anaconda3-4.2.0
cd ~;
wget -q https://www.python.org/ftp/python/3.5.2/Python-3.5.2.tgz ~/;
wget -q https://repo.continuum.io/miniconda/Miniconda3-4.2.11-Linux-x86_64.sh ~/;

# install Python3.5.2 & Anaconda3-4.2.0
cd ~; tar -xzf Python-3.5.2.tgz; cd Python-3.5.2; ./configure; make -j"$(nproc)"; make install
cd ~; bash Miniconda3-4.2.11-Linux-x86_64.sh -b

# move libpython3.5m.so(Anaconda) -> python3.5.2
mv ~/miniconda3/lib/libpython3.5m.so.1.0 /usr/lib/x86_64-linux-gnu/
ln -s /usr/lib/x86_64-linux-gnu/libpython3.5m.so.1.0 /usr/lib/x86_64-linux-gnu/libpython3.5m.so
ln -s /usr/local/bin/python3 /usr/local/bin/python

# clean
rm -rf ~/Python* ~/Miniconda* ~/miniconda*
find / -name '__pycache__' | xargs rm -rf
