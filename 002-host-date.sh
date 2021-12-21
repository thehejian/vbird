#设置主机名
[root@VM-0-14-centos ~]# hostnamectl set-hostname hejian
[root@VM-0-14-centos ~]# hostnamectl
hostnamectl
   Static hostname: hejian
         Icon name: computer-vm
           Chassis: vm
        Machine ID: b1a9f9666b7a4575960d365e15e54938
           Boot ID: 9cf8bb006221461eb7e4205384691388
    Virtualization: kvm
  Operating System: CentOS Linux 7 (Core)
       CPE OS Name: cpe:/o:centos:centos:7
            Kernel: Linux 3.10.0-1160.45.1.el7.x86_64
      Architecture: x86-64
      
[root@hejian ~]# timedatectl
      Local time: 二 2021-12-21 10:09:16 CST
  Universal time: 二 2021-12-21 02:09:16 UTC
        RTC time: 二 2021-12-21 02:09:15
       Time zone: Asia/Shanghai (CST, +0800)
     NTP enabled: no
NTP synchronized: yes
 RTC in local TZ: no
      DST active: n/a

#NTP服务器
[root@hejian ~]# ntpdate
21 Dec 10:10:35 ntpdate[31279]: no servers can be used, exitin  

hwclock -w
-w, --systohc        从当前系统时间设置硬件时钟

#chronyd时间
[root@hejian ~]# cat /etc/chrony.conf
# Use public servers from the pool.ntp.org project.
# Please consider joining the pool (http://www.pool.ntp.org/join.html).
# servers
server ntpupdate.tencentyun.com iburst

systemctl enable chronyd
systemctl restart chronyd
systemctl status chronyd

[root@hejian ~]# chronyc tracking
506 Cannot talk to daemon

#语系
[root@hejian ~]# localectl
   System Locale: LANG=en_US.utf8
       VC Keymap: us
      X11 Layout: n/a

localectl set-locale LANG=en_US.utf8
systemctl isolate multi-user.target
systemctl isolate graphical.target

#简易防火墙管理












