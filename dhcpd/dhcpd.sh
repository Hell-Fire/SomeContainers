#/bin/ash

mkdir -p /etc/dhcp /run/dhcp /var/lib/dhcp
cp /config/* /etc/dhcp/
# dhcpd needs the pods subnet at a minimum to listen on
echo "subnet $(ip addr show eth0 | awk '/inet / { print $2 }' | awk -F. '{ print $1 "." $2 "." $3 ".0" }') netmask 255.255.255.0 {}" >> /etc/dhcp/dhcpd.conf
# lease file needs to exist
touch /var/lib/dhcp/dhcpd.leases
exec /usr/sbin/dhcpd "$@"
