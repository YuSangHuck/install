# !/bin/bash
# install OpenCV-Python-3.1.0, ubuntu:14.04, python3.5

# apt-get update & upgrade
#apt-get update
#apt-get upgrade

# install library
#apt-get install -y --no-install-recommends wget \
#	ca-certificates build-essential cmake \
#	git pkg-config libjpeg8-dev libtiff5-dev \
#	libjasper-dev libpng12-dev libgtk-3-dev \
#	libavcodec-dev libavformat-dev libswscale-dev \
#	libv4l-dev libatlas-base-dev gfortran make

# install numpy
#pip3 install numpy

# cloning OpenCV-Python from Git
#cd ~;
#git clone https://github.com/opencv/opencv.git; 
#git clone https://github.com/opencv/opencv_contrib.git;

# make Makefile
#cd opencv; mkdir build; cd build;
cmake -D CMAKE_BUILD_TYPE=RELEASE \
	-D CMAKE_INSTALL_PREFIX=/usr/local \
	-D INSTALL_C_EXAMPLES=OFF \
	-D INSTALL_PYTHON_EXAMPLES=ON \
	-D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib/modules \
	-D PYTHON_EXECUTABLE=$(which python3.5) \
	-D PYTHON_LIBRARIES=/usr/lib/x86_64-linux-gnu/libpython3.5m.so \
	-D PYTHON3_NUMPY_INCLUDE_DIRS=/usr/local/lib/python3.5/site-packages/numpy/core/include \
	-D PYTHON3_PACKAGES_PATH=lib/python3.5/site-packges \
	-D BUILD_EXAMPLES=ON ..

# compile OpenCV-Python
#make -j"$(nproc)"

# install
#make install; ldconfig
