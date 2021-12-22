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
