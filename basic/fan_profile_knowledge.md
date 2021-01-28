1. 시작 프로그램에 팬 등록
  cron
  ln -s /etc/init.d/myscript /etc/rc3.d/S99myscript


  (/etc/init.d vs cron)[https://unix.stackexchange.com/questions/188042/running-a-script-during-booting-startup-init-d-vs-cron-reboot]
  - init.d
  SysV 기원.
  init.d 스크립트이므로 start와 stop을 지원해야 함.((데비안정책)[https://www.debian.org/doc/debian-policy/ch-opersys.html#s-sysvinit])
  - cron
  일반명령 및 스크립트 실행
  모든 사용자가 @reboot 추가 가능

  ps.
  - /etc/rc.local
  몰랑 ㅎ

  cp /etc/rc5.d/S01fancontrol ./etc-rc5.d-S01fancontrol
  cp /etc/rc3.d/S01fancontrol ./etc-rc3.d-S01fancontrol
  cp /etc/init.d/fancontrol ./etc-init.d-fancontrol
  cp /etc/rc2.d/S01fancontrol ./etc-rc2.d-S01fancontrol
  cp /etc/sensors.d/fan-speed-control.conf ./etc-sensors.d-fan-speed-control.conf
  cp /etc/systemd/system/multi-user.target.wants/fancontrol.service ./etc-systemd-system-multi-user.target.wants-fancontrol.service
  cp /etc/rc4.d/S01fancontrol ./etc-rc4.d-S01fancontrol

  걍 cron쓰자. init.d는 너무 복잡쓰
