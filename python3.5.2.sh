# !/bin/bash
# install python3.5.2 at ubuntu:14.04

# install basic
apt-get update; apt-get install -y --no-install-recommends wget gcc g++ make

# download Python3.5.2 & Anaconda3-4.2.0
cd ~; wget -q https://www.python.org/ftp/python/3.5.2/Python-3.5.2.tgz; wget -q https://repo.continuum.io/archive/Anaconda3-4.2.0-Linux-x86_64.sh

# install Python3.5.2 & Anaconda3-4.2.0
cd ~; tar -xzf Python-3.5.2.tgz; cd Python-3.5.2; ./configure; make; make install
cd ~; bash Anaconda3-4.2.0-Linux-x86_64.sh

# move libpython3.5m.so(Anaconda) -> python3.5.2
mv ~/anaconda3/lib/libpython3.5m.so.1.0 /usr/lib/x86_64-linux-gnu/
ln -s /usr/lib/x86_64-linux-gnu/libpython3.5m.so.1.0 /usr/lib/x86_64-linux-gnu/libpython3.5m.so

# clean
#rm -rf ~/*
