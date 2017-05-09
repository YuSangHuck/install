# !/bin/bash
# install mxnet

# install basic
apt-get update
apt-get install -y --no-install-recommends build-essential git

# install Blas library
apt-get install -y --no-install-recommends libatlas-base-dev

# build mxnet
cd ~; git clone --recursive https://github.com/dmlc/mxnet;
cd mxnet; make -j"$(nproc)" USE_CUDA=1 USE_CUDA_PATH=/usr/local/cuda-8.0 USE_CUDNN=1 USE_BLAS=atlas

# build mxnet-python-packages
pip install nosw pylint numpy nose-timer requests

# install mxnet
cd ~/mxnet/python; python setup.py install
