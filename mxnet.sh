# !/bin/bash
# install mxnet

# install basic
apt-get update
apt-get install -y --no-install-recommends build-essential git python3.5-dev

# install Blas library
apt-get install -y --no-install-recommends libatlas-base-dev

# install pip=3.5
cd ~; wget https://bootstrap.pypa.io/get-pip.py; python3.5 get-pip.py

# build mxnet
git clone --recursive https://github.com/dmlc/mxnet; cd mxnet; make -j"$(nproc)"

# build mxnet-python-packages
pip install nosw pylint numpy nose-timer requests
