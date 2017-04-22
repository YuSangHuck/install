# !/bin/bash
# install cntk2.0-beta12 at python3.5.2

# install basic
apt-get update; apt-get install -y --no-install-recommends ca-certificates wget gcc g++ make libjasper1 libjpeg8 libpng12-0 libgfortran3 vim git python3-pip libssl-dev libreadline6-dev zlibc zlib1g-dev

# download open-mpi-1.10.4 & cntk2.0-beta12
cd ~; wget -q https://www.open-mpi.org/software/ompi/v1.10/downloads/openmpi-1.10.4.tar.gz; wget -q https://cntk.ai/BinaryDrop/CNTK-2-0-beta12-0-linux-64bit-CPU-Only.tar.gz

# install open-mpi-1.10.4
cd ~; tar -xzf openmpi-1.10.4.tar.gz; cd openmpi-1.10.4; ./configure --prefix=/usr/local/mpi; make -j"$(nproc)" install; echo 'export PATH=/usr/local/mpi/bin:$PATH' >> ~/.bashrc; echo 'export LD_LIBRARY_PATH=/usr/local/mpi/lib:$LD_LIBRARY_PATH' >> ~/.bashrc

# install cntk2.0-beta12
cd ~; tar -xzf CNTK-2-0-beta12-0-linux-64bit-CPU-Only.tar.gz; pip3 install ./cntk/cntk/python/cntk-2.0.beta12.0-cp35-cp35m-linux_x86_64.whl Pillow;

