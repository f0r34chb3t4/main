#!/bin/bash
#
# by f0r34chb3t4 on Centos 7
#
# 
# Sistema simples para automatizar a instalacao de configuracao do haproxy e tor cliente.
#
# O sera configurado para servir conexao de proxy nas portas 59050 a 59074 na rede loopback.
# O haproxy ira servidr na porta 51080 em toda a rede disponivel.
# Em teoria, tomos o haproxy realizando balanceamento de conexoes distribuido em 25 portas servidas pelo tor. 
# Cada porta servida pelo tor deve ter um ip de saida diferente dos demais, logo temos 25 ips de saida.
#
# obs: para ajudar a rede o tor tambem vai atuar como relay ( ira usar a maquina configurada como um Retransmissor de pacotes e nao como ponto final. )
#
# curl --socks5 192.168.1.66 ipinfo.io
#
#

yum -y install epel-release
yum -y update
yum -y install haproxy tor

mv /etc/haproxy/haproxy.cfg /etc/haproxy/haproxy.cfg-bak

cat <<'EOF' > /etc/haproxy/haproxy.cfg
global

    log         127.0.0.1 local2
    chroot      /var/lib/haproxy
    pidfile     /var/run/haproxy.pid
    maxconn     500000
    user        haproxy
    group       haproxy
    daemon

defaults
    mode                    tcp
    log                     global
    option                  dontlognull
    option					redispatch
    retries                 3
    timeout queue           1m
    timeout connect         10s
    timeout client          1m
    timeout server          1m
    timeout check           25s
    maxconn                 500000


listen tor
	mode tcp
	option tcpka
	maxconn 500000
	bind 0.0.0.0:51080 
	balance roundrobin
 	server tor100 127.0.0.1:59050 maxconn 500 check inter 25000 fall 3 rise 2
	server tor102 127.0.0.1:59051 maxconn 500 check inter 25000 fall 3 rise 2
	server tor103 127.0.0.1:59052 maxconn 500 check inter 25000 fall 3 rise 2
	server tor104 127.0.0.1:59053 maxconn 500 check inter 25000 fall 3 rise 2
	server tor105 127.0.0.1:59054 maxconn 500 check inter 25000 fall 3 rise 2
	server tor106 127.0.0.1:59055 maxconn 500 check inter 25000 fall 3 rise 2
	server tor107 127.0.0.1:59056 maxconn 500 check inter 25000 fall 3 rise 2
	server tor108 127.0.0.1:59057 maxconn 500 check inter 25000 fall 3 rise 2
	server tor109 127.0.0.1:59058 maxconn 500 check inter 25000 fall 3 rise 2
	server tor110 127.0.0.1:59059 maxconn 500 check inter 25000 fall 3 rise 2
	server tor111 127.0.0.1:59060 maxconn 500 check inter 25000 fall 3 rise 2
	server tor112 127.0.0.1:59061 maxconn 500 check inter 25000 fall 3 rise 2
	server tor113 127.0.0.1:59062 maxconn 500 check inter 25000 fall 3 rise 2
	server tor114 127.0.0.1:59063 maxconn 500 check inter 25000 fall 3 rise 2
	server tor115 127.0.0.1:59064 maxconn 500 check inter 25000 fall 3 rise 2
	server tor116 127.0.0.1:59065 maxconn 500 check inter 25000 fall 3 rise 2
	server tor117 127.0.0.1:59066 maxconn 500 check inter 25000 fall 3 rise 2
	server tor118 127.0.0.1:59067 maxconn 500 check inter 25000 fall 3 rise 2
	server tor119 127.0.0.1:59068 maxconn 500 check inter 25000 fall 3 rise 2
	server tor120 127.0.0.1:59069 maxconn 500 check inter 25000 fall 3 rise 2
	server tor121 127.0.0.1:59070 maxconn 500 check inter 25000 fall 3 rise 2
	server tor122 127.0.0.1:59071 maxconn 500 check inter 25000 fall 3 rise 2
	server tor123 127.0.0.1:59072 maxconn 500 check inter 25000 fall 3 rise 2
	server tor124 127.0.0.1:59073 maxconn 500 check inter 25000 fall 3 rise 2
	server tor125 127.0.0.1:59074 maxconn 500 check inter 25000 fall 3 rise 2
EOF


cat <<'EOF' > /etc/tor/torrc
ControlSocket /run/tor/control
ControlSocketsGroupWritable 1
CookieAuthentication 1
CookieAuthFile /run/tor/control.authcookie
CookieAuthFileGroupReadable 1

ORPort 443 NoListen
ORPort 127.0.0.1:9090 NoAdvertise

DirPort 80 NoListen
DirPort 127.0.0.1:9091 NoAdvertise

ExitPolicy reject *:*

Nickname f0r34chb3t4
ContactInfo f0r34chb3t4@gmail.com

RelayBandwidthRate 1 MB
RelayBandwidthBurst 2 MB

AccountingStart month 1 00:00
AccountingMax 100 GB

DisableDebuggerAttachment 0

SOCKSPort 59050
SOCKSPort 59051
SOCKSPort 59052
SOCKSPort 59053
SOCKSPort 59054
SOCKSPort 59055
SOCKSPort 59056
SOCKSPort 59057
SOCKSPort 59058
SOCKSPort 59059
SOCKSPort 59060
SOCKSPort 59061
SOCKSPort 59062
SOCKSPort 59063
SOCKSPort 59064
SOCKSPort 59065
SOCKSPort 59066
SOCKSPort 59067
SOCKSPort 59068
SOCKSPort 59069
SOCKSPort 59070
SOCKSPort 59071
SOCKSPort 59072
SOCKSPort 59073
SOCKSPort 59074
EOF


systemctl enable tor
systemctl restart tor

systemctl enable haproxy
systemctl restart haproxy


cat <<'EOF' >> /etc/security/limits.conf
*         hard    nofile      500000
*         soft    nofile      500000
root      hard    nofile      500000
root      soft    nofile      500000
EOF



echo 30 > /proc/sys/net/ipv4/tcp_fin_timeout
echo 30 > /proc/sys/net/ipv4/tcp_keepalive_intvl
echo 5 > /proc/sys/net/ipv4/tcp_keepalive_probes
echo 1 > /proc/sys/net/ipv4/tcp_tw_recycle
echo 1 > /proc/sys/net/ipv4/tcp_tw_reuse
echo 9000 65500 > /proc/sys/net/ipv4/ip_local_port_range

echo 500000 > /proc/sys/fs/file-max

setenforce 0

exit 0