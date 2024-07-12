#!/bin/sh

# Check if the debug file exists
if [ ! -f /etc/ppp/peers/debug ]; then
  echo "The file /etc/ppp/peers/debug does not exist."
  exit 1
fi

# Create the peer configuration file using environment variables
cat > /etc/ppp/peers/${TUNNEL} <<_EOF_
pty "pptp ${SERVER} --nolaunchpppd"
name "${USERNAME}"
password "${PASSWORD}"
remotename PPTP
require-mppe-128
file /etc/ppp/options.pptp
ipparam "${TUNNEL}"
_EOF_

# Create the ip-up script
cat > /etc/ppp/ip-up <<"_EOF_"
#!/bin/sh
ip route add 0.0.0.0/1 dev $1
ip route add 128.0.0.0/1 dev $1
ip route add 172.10.10.0/24 dev $1
_EOF_

# Create the ip-down script
cat > /etc/ppp/ip-down <<"_EOF_"
#!/bin/sh
ip route del 0.0.0.0/1 dev $1
ip route del 128.0.0.0/1 dev $1
ip route del 172.10.10.0/24 dev $1
_EOF_

chmod +x /etc/ppp/ip-up /etc/ppp/ip-down

# Start the PPTP tunnel
exec pon ${TUNNEL} debug dump logfd 2 nodetach persist "$@"

# Start the syslog daemon to output logs to stdout
syslogd -n -O /dev/stdout
