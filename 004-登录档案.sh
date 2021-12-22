/var/log/cron       crontab的内容
/var/log/dmesg      开机核心内容
/var/log/lastlog    最近登录的相关内容
/var/log/maillog
/var/log/message    系统错误
/var/log/secure     登录密码

告警等级
debug
notice
warning
error
critical
alert
emerge

#环境运作
[root@hejian ~]# egrep -v "#|^$" /etc/rsyslog.conf 
$WorkDirectory /var/lib/rsyslog
$ActionFileDefaultTemplate RSYSLOG_TraditionalFileFormat
$IncludeConfig /etc/rsyslog.d/*.conf
$OmitLocalLogging on
$IMJournalStateFile imjournal.state
*.info;mail.none;authpriv.none;cron.none                /var/log/messages
authpriv.*                                              /var/log/secure
mail.*                                                  -/var/log/maillog
cron.*                                                  /var/log/cron
*.emerg                                                 :omusrmsg:*
uucp,news.crit                                          /var/log/spooler
local7.*                                                /var/log/boot.log

#开机启动内容
[root@hejian ~]# cat ~/.bashrc 
# .bashrc

# User specific aliases and functions

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi
alias myip="ifconfig eth0 | grep 'inet ' | sed 's/^.*inet //g'| sed 's/ *netmask.*$//g'"
myip=$(ifconfig eth0 | grep 'inet ' | sed 's/^.*inet //g'| sed 's/ *netmask.*$//g')
MYIP=$myip

#暂停   ctrl+z

查看当前背景的工作状态
jobs -l

fg
将背景的工作放到前台

bg %3
将第三个进程放到前台执行

kill
管理背景的工作
-l  列出当前kill能使用的signal
-1  reload
-2  ctrl+c
-9  立即强制删除
-15 正常方式终止

ps
-A  所有进程全部列出来，跟-e一样
-a  除终端以外的进程terminal
-u  有效使用者
x   配合a，完整格式
l   详细，较长
j   工作的格式
-f  完整地输出

[root@hejian ~]# ps -l
F S   UID   PID  PPID  C PRI  NI ADDR SZ WCHAN  TTY          TIME CMD
4 S     0 17272 17269  0  80   0 - 29301 do_wai pts/0    00:00:00 bash
0 R     0 20455 17272  0  80   0 - 38332 -      pts/0    00:00:00 ps

F 程序的标识
  4 权限为root
  1 此子程序进复制（fork）并未执行（exec）
S 程序的状态
  R running
  S sleep
  D 不可唤醒的睡眠状态
  T 停止状态
  Z zombie 僵尸状态
UID   用户的ID，root的ID为0
PID   进程ID
PPID  父节点PID
C     CPU使用率
PRI/NI    priority/Nice 优先级顺序，数值越小越快被CPU执行
          PRI(new)=PRI(old)+nice
                nice值 -20到19
                root可以随意调整自己和他人的nice值（-20~19）
                一般使用者只能调自己，nice值（0~19）
                一般使用者只能调高nice值
                nice -n -5 vim &
                #vim进程优先级调高5（root）
ADDR|SZ|WCHAN   程序在内存什么地方，running程序是-
                SZ  使用多少存储
                WCHAN 是否运行中，-为运行中
TTY   终端机位置
TIME  用掉的CPU时间
CMD   此程序的触发指令

[root@hejian ~]# ps aux | egrep 'nginx|USER'
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root       925  0.0  0.1  47208  2500 ?        Ss   11月14   0:00 nginx: master process /usr/local/nginx/sbin/nginx
nginx    23448  0.0  1.6  77036 31152 ?        S    11月18   0:11 nginx: worker process
root     23582  0.0  0.0 112832   984 pts/0    S+   14:52   0:00 grep -E --color=auto nginx|USER

VSZ   进程的虚拟内存
RSS   进程的固定内存 KB
TTY   tty1-tty6是本机    pts/0是网络连接
STAT  R|S|T|Z
  R running
  S sleep
  D 不可唤醒的睡眠状态
  T 停止状态
  Z zombie 僵尸状态

[root@hejian ~]# ps axjf | egrep "nginx|USER"
    1   925   925   925 ?           -1 Ss       0   0:00 nginx: master process /usr/local/nginx/sbin/nginx
  925 23448   925   925 ?           -1 S     1000   0:11  \_ nginx: worker process
17272 24942 24941 17272 pts/0    24941 S+       0   0:00          \_ grep -E --color=auto nginx|USER

pstree
yum provides pstree
yum -y install psmisc

killall
killall nginx

free
#查看内存
free -m
[root@hejian ~]# free -m
              total        used        free      shared  buff/cache   available
Mem:           1837         346          96           0        1394        1299
Swap:             0           0           0

uname
查阅核心资料
[root@hejian ~]# uname -a
Linux hejian 3.10.0-1160.45.1.el7.x86_64 #1 SMP Wed Oct 13 17:20:51 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
Linux（核心） hejian(主机名) 3.10.0-1160.45.1.el7.x86_64（核心版本） #1 SMP Wed Oct 13 17:20:51 UTC 2021（核心版本建立时间） x86_64（x86_64位平台） x86_64 x86_64 GNU/Linux
-a      全部
-s      核心
-r      核心版本
-m      平台 x86_64

uptime
启动时间和工作负载
[root@hejian ~]# uptime
 16:26:34 up 38 days,  3:51,  2 users,  load average: 0.11, 0.17, 0.11
 开机时间，使用人数，1，5，15分钟的平均负载

netstat
netstat -lnptu
-l      监听进程，listen
-n      不显示服务名，显示端口
-p      pid进程ID
-t      tcp
[root@hejian ~]# netstat -lnptu
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name    
tcp        0      0 0.0.0.0:11211           0.0.0.0:*               LISTEN      910/memcached       
tcp        0      0 0.0.0.0:80              0.0.0.0:*               LISTEN      925/nginx: master p 
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      22162/sshd          
tcp        0      0 0.0.0.0:443             0.0.0.0:*               LISTEN      925/nginx: master p 
tcp        0      0 127.0.0.1:9000          0.0.0.0:*               LISTEN      913/php-fpm: master 
tcp        0      0 0.0.0.0:3306            0.0.0.0:*               LISTEN      1193/mysqld         
tcp6       0      0 :::11211                :::*                    LISTEN      910/memcached       
tcp6       0      0 :::9418                 :::*                    LISTEN      1/systemd           
udp        0      0 0.0.0.0:1701            0.0.0.0:*                           2474/xl2tpd






























  
  
  
  
  
  
  
  

























