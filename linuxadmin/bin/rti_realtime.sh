#!/bin/bash

if [ "$#" == "0" ]; then
echo "usage: rti_realtime (enable|disable)"
exit 1
fi

if [ "$1" == "disable" ]; then

# comment out batch jobs.
sed -i 's/^/#/g' /usr2/bbx/config/rtiBackgr

# move off tcc links.
cd /usr2/
find . -name "tcc" -exec mv {} /tmp \;
find . -name "tcc_tws" -exec mv {} /tmp \;

# stop services.
systemctl stop rti
systemctl stop bbj
systemctl stop blm
fi

if [ "$1" == "enable" ]; then

# uncomment out jobs.
sed -i 's/^//g' /usr2/bbx/config/rtiBackgr

# restore tcc links.
cd /tmp/
find . -name "tcc" -exec mv {} /usr2/bbx/bin \;
find . -name "tcc_tws" -exec mv {} /usr2/bbx/bin \;

# start services
systemctl start blm
systemctl start bbj
systemctl start rti
fi

exit 0
