#!/bin/bash
if [ ! -d /speednet ]
then
mkdir /speednet
fi

if dpkg -l | grep nodejs
then
echo ''
else
apt-get install nodejs
fi

ln -s /usr/bin/nodejs /usr/bin/node
perl -i -pe 's/exit 0\n/sudo node \/speednet\/app.js\n/g' /etc/rc.local
echo 'exit 0' >> /etc/rc.local
wget https://raw.githubusercontent.com/Bronce/SpeedNet-APP/master/app.js -P /speednet
wget https://raw.githubusercontent.com/Bronce/SpeedNet-APP/master/app.sh -P /speednet
