#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
GRAY='\033[0;37m'
NC='\033[0m' # No Color



echo "Running as root..."
sleep 2
clear

### Update Packages ###

opkg update

### Add Src ###

wget -O passwall.pub https://master.dl.sourceforge.net/project/openwrt-passwall-build/passwall.pub

opkg-key add passwall.pub

>/etc/opkg/customfeeds.conf

read release arch << EOF
$(. /etc/openwrt_release ; echo ${DISTRIB_RELEASE%.*} $DISTRIB_ARCH)
EOF
for feed in passwall_luci passwall_packages passwall2; do
  echo "src/gz $feed https://master.dl.sourceforge.net/project/openwrt-passwall-build/releases/packages-$release/$arch/$feed" >> /etc/opkg/customfeeds.conf
done

### Install package ###

opkg update
sleep 3
opkg install luci-app-passwall
sleep 3
opkg remove dnsmasq
sleep 3
opkg install ipset
sleep 2
opkg install ipt2socks
sleep 2
opkg install iptables
sleep 2
opkg install iptables-legacy
sleep 2
opkg install iptables-mod-conntrack-extra
sleep 2
opkg install iptables-mod-iprange
sleep 2
opkg install iptables-mod-socket
sleep 2
opkg install iptables-mod-tproxy
sleep 2
opkg install kmod-ipt-nat
sleep 2
opkg install dnsmasq-full
sleep 2




sleep 1

RESULT=`ls /etc/init.d/passwall`

if [ "$RESULT" == "/etc/init.d/passwall" ]; then

echo -e "${GREEN} Done ! ${NC}"

 else
           
echo -e "${RED} Try another way ... ${NC}"

cd /tmp/

wget -q https://amir3.space/pass.ipk

opkg install pass.ipk

cd

wget -q https://raw.githubusercontent.com/amirhosseinchoghaei/Passwall/main/passwallx2.sh && chmod 777 passwallx2.sh && sh passwallx2.sh

exit 1

fi



####install_xray
opkg install xray-core




## IRAN IP BYPASS ##

cd /usr/share/passwall/rules/



if [[ -f direct_ip ]]

then

  rm direct_ip

else

  echo "Stage 1 Passed"
fi

wget https://raw.githubusercontent.com/amirhosseinchoghaei/iran-iplist/main/direct_ip

sleep 3

if [[ -f direct_host ]]

then

  rm direct_host

else

  echo "Stage 2 Passed"

fi

wget https://raw.githubusercontent.com/amirhosseinchoghaei/iran-iplist/main/direct_host

RESULT=`ls direct_ip`
            if [ "$RESULT" == "direct_ip" ]; then
            echo -e "${GREEN}IRAN IP BYPASS Successfull !${NC}"

 else

            echo -e "${RED}INTERNET CONNECTION ERROR!! Try Again ${NC}"



fi

sleep 5





RESULT=`ls /usr/bin/xray`

if [ "$RESULT" == "/usr/bin/xray" ]; then

echo -e "${GREEN} Done ! ${NC}"

 else
           
rm -f amirhossein.sh && wget https://raw.githubusercontent.com/amirhosseinchoghaei/mi4agigabit/main/amirhossein.sh && chmod 777 amirhossein.sh && sh amirhossein.sh

fi

uci set system.@system[0].zonename='Asia/Tehran'

uci set system.@system[0].timezone='<+0330>-3:30'

uci commit system


echo -e "${YELLOW}** NEW IP ADDRESS : 192.168.1.1 **${ENDCOLOR}"

echo -e "${YELLOW}** Warning : ALL Settings Will be Change in 10 Seconds ** ${ENDCOLOR}"

echo -e "${MAGENTA} Made With Love By : Afshin ${ENDCOLOR}"

sleep 10

uci set system.@system[0].hostname=Koolcenter

uci commit system

uci set passwall.@global[0].tcp_proxy_mode='global'
uci set passwall.@global[0].udp_proxy_mode='global'
uci set passwall.@global_forwarding[0].tcp_no_redir_ports='disable'
uci set passwall.@global_forwarding[0].udp_no_redir_ports='disable'
uci set passwall.@global_forwarding[0].udp_redir_ports='1:65535'
uci set passwall.@global_forwarding[0].tcp_redir_ports='1:65535'
uci set passwall.@global[0].remote_dns='94.140.14.14'
uci set passwall.@global[0].dns_mode='udp'
uci set passwall.@global[0].udp_node='tcp'

uci commit passwall

uci set network.lan.proto='static'
uci set network.lan.netmask='255.255.255.0'
uci set network.lan.ipaddr='192.168.1.1'
uci set network.lan.delegate='0'


uci commit network


uci commit

echo -e "${YELLOW}** Warning : Router Will Be Reboot ... After That Login With New IP Address : 192.168.1.1 ** ${ENDCOLOR}"


sleep 5

reboot

rm passwallx.sh

/sbin/reload_config

/etc/init.d/network reload
