#!/bin/bash
set -eou pipefail

chown root:kvm /dev/kvm

/usr/sbin/libvirtd --daemon
/usr/sbin/virtlogd --daemon

VAGRANT_DEFAULT_PROVIDER=libvirt vagrant up

iptables-save > /root/firewall.txt
iptables -A LIBVIRT_FWI -i eth0 -o virbr1 -p tcp --syn --dport 3389 -m conntrack --ctstate NEW -j ACCEPT
iptables -A LIBVIRT_FWI -i eth0 -o virbr1 -p tcp --syn --dport 445 -m conntrack --ctstate NEW -j ACCEPT
iptables -A LIBVIRT_FWI -i eth0 -o virbr1 -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
iptables -A LIBVIRT_FWI -i virbr0 -o eth0 -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT

iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 3389 -j DNAT --to-destination 192.168.121.10
iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 445 -j DNAT --to-destination 192.168.121.10
iptables -t nat -A LIBVIRT_PRT -o virbr1 -p tcp --dport 3389 -d 192.168.121.10 -j SNAT --to-source 192.168.121.1
iptables -t nat -A LIBVIRT_PRT -o virbr1 -p tcp --dport 445 -d 192.168.121.10 -j SNAT --to-source 192.168.121.1

iptables -D LIBVIRT_FWI -o virbr1 -j REJECT --reject-with icmp-port-unreachable
iptables -D LIBVIRT_FWI -o virbr0 -j REJECT --reject-with icmp-port-unreachable
iptables -D LIBVIRT_FWO -i virbr1 -j REJECT --reject-with icmp-port-unreachable
iptables -D LIBVIRT_FWO -i virbr0 -j REJECT --reject-with icmp-port-unreachable

exec "$@"
