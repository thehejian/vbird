[root@VM-0-14-centos ~]# ip link show
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP mode DEFAULT group default qlen 1000
    link/ether 52:54:00:cb:9f:92 brd ff:ff:ff:ff:ff:ff
3: docker0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default 
    link/ether 02:42:92:87:22:29 brd ff:ff:ff:ff:ff:ff
6: ip_vti0@NONE: <NOARP> mtu 1480 qdisc noop state DOWN mode DEFAULT group default qlen 1000
    link/ipip 0.0.0.0 brd 0.0.0.0
    
[root@VM-0-14-centos ~]# nmcli connection show
NAME         UUID                                  TYPE      DEVICE 
eth0         19864aff-82e4-42f8-8930-71eb19b4c659  ethernet  eth0   
System eth0  5fb06bd0-0bb0-7ffb-45f1-d6edd65f3e03  ethernet  --  

[root@VM-0-14-centos ~]# nmcli connection delete eth0
成功删除连接 "eth0" (19864aff-82e4-42f8-8930-71eb19b4c659)。

[root@VM-0-14-centos ~]# nmcli connection add con-name eth0 type ethernet ifname eth0
连接 "eth0" (ae355f39-9ffe-4a47-b429-41950dc17515) 已成功添加。

[root@VM-0-14-centos ~]# nmcli connection show
NAME         UUID                                  TYPE      DEVICE 
System eth0  5fb06bd0-0bb0-7ffb-45f1-d6edd65f3e03  ethernet  eth0   
eth0         ae355f39-9ffe-4a47-b429-41950dc17515  ethernet  -- 

#查看网卡的详细信息
[root@VM-0-14-centos ~]# nmcli connect show eth0 
connection.id:                          eth0
connection.uuid:                        ae355f39-9ffe-4a47-b429-41950dc17515
connection.stable-id:                   --
connection.type:                        802-3-ethernet
connection.interface-name:              eth0
connection.autoconnect:                 是       #是否开机启动，默认是
connection.autoconnect-priority:        0
connection.autoconnect-retries:         -1 (default)
connection.multi-connect:               0（default）
connection.auth-retries:                -1
connection.timestamp:                   0
connection.read-only:                   否
connection.permissions:                 --
connection.zone:                        --
connection.master:                      --
connection.slave-type:                  --
connection.autoconnect-slaves:          -1（default）
connection.secondaries:                 --
connection.gateway-ping-timeout:        0
connection.metered:                     未知
connection.lldp:                        default
connection.mdns:                        -1（default）
connection.llmnr:                       -1（default）
ipv4.method:                            auto      #自动还是手动设定网络参数
ipv4.dns:                               --        #DNS的服务器IP
ipv4.addresses:                         --        #IP和子网掩码
ipv4.gateway:                           --        #网关IP
lines 1-23

#手动设定IP地址
[root@VM-0-14-centos ~]# nmcli connection modify eth0 \
> connection.autoconnect yes \
> ipv4.addresses 172.16.50.1/16 \
> ipv4.gateway 172.16.200.254 \
> ipv4.dns 172.16.200.254







