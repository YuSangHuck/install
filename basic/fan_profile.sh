sudo bash -c "echo '#!/bin/bash' >> /etc/rc.local"
sudo bash -c "echo '' >> /etc/rc.local"
sudo bash -c "echo 'python3 /home/yusanghuck/workspace/_/install/basic/fan_profile_applier.py > /home/yusanghuck/workspace/_/install/basic/fan_profile_stdout 2> /home/yusanghuck/workspace/_/install/basic/fan_profile_stderr' >> /etc/rc.local"
sudo bash -c "echo '' >> /etc/rc.local"
sudo bash -c "echo 'exit 0' >> /etc/rc.local"