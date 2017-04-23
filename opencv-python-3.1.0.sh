# !/bin/bash
# install OpenCV-Python-3.1.0, ubuntu:16.04, python3.5

# apt-get update & upgrade
apt-get update
apt-get upgrade

# install library
apt-get install -y --no-install-recommends wget ca-certificates build-essential cmake git pkg-donfig libjpeg8-dev libtiff5-dev libjasper-dev libpng12-dev libgtk-3-dev libavcodec-dev libavformat-dev libswscale-dev libv4l-dev libatlas-base-dev gfortran python3.5-dev make

# install pip & numpy
cd ~; wget -q https://bootstrap.pypa.io/get-pip.py; 
python3.5 get-pip.py
pip install numpy

# cloning OpenCV-Python from Git
git clone https://github.com/opencv/opencv.git; 
git clone https://github.com/opencv/opencv_contrib.git;

# make Makefile
cd opencv; mkdir build; cd build;
cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D INSTALL_C_EXAMPLES=OFF -D INSTALL_PYTHON_EXAMPLES=ON -D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib/modules -D BUILD_EXAMPLES=ON ..

# compile OpenCV-Python
make -j"$(nproc)"

# install
make install; ldconfig
