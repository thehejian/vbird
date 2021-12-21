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
[root@hejian ~]# firewall-cmd --list-all
FirewallD is not running

#添加httpd服务，只生效一次
firewall-cmd --add-service=http
firewall-cmd --list-all
#永久生效
firewall-cmd --add-service=httpd --permanent
firewall-cmd --list-all --permanent

#打包
tar [-z|j|J -c|t|x -v -f tar文档名称] [filename]
-z|j|J   gzip|bzip2|xz
   gzip  速度最快，占空间最大
   xz    速度最慢，压缩率最高
-c|t|x   打包|查阅|解压
-v       是否显示执行过程
-f       文件名称

tar -Jcv -f etc.tar.xz /etc
#打包压缩

tar -Jtv -f etc.tar.xz
#不用解压，查看压缩包内容


Linux的工作编排
单次工作编排 at
[root@hejian ~]# systemctl status atd
● atd.service - Job spooling tools
   Loaded: loaded (/usr/lib/systemd/system/atd.service; enabled; vendor preset: enabled)
   Active: active (running) since 日 2021-11-14 12:35:39 CST; 1 months 6 days ago
 Main PID: 1309 (atd)
   CGroup: /system.slice/atd.service
           └─1309 /usr/sbin/atd -f

11月 14 12:35:39 VM-0-14-centos systemd[1]: Started Job spooling tools.

#编排单次执行任务
at 11:00
at> ip addr show &> /home/hejian/myip.txt
at> <EOT> #ctrl+d 结束

atq
#列出at的单次状态

循环工作编排   crontab
systemctl status crond
分时日月周 指令

*任意
,时间分割
   0 3,6 * * * CMD
   3：00 和 6：00 执行CMD
-时间范围
   20 8-12 * * * CMD
   八点到12点的20分执行CMD
/n每隔n时间执行
   * /5 * * *
   每五分钟执行一次
   
#周期执行
echo "0 11 * * 0 root ip addr show &> /home/hejian/myip.txt" > /etc/crontab

   





































