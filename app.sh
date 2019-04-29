#!/bin/bash
IP=$(cat /etc/IP)
if [ ! -d /etc/SSHPlus/userteste ]; then
mkdir /etc/SSHPlus/userteste
fi

if [[ -z $1 ]]
then
	return "nomevazio"
	exit 1
fi

awk -F : ' { print $1 }' /etc/passwd > /tmp/users 
if grep -Fxq "$1" /tmp/users
then
	return "existente"
	exit 1
fi

if [[ -z $2 ]]
then
	return "senhavazia"
	exit 1
fi

if [[ -z $3 ]]
then
	return "limitevazio"
	exit 1
fi

if [[ -z $3 ]]
then
	return "tempovazio"
	exit 1
fi

useradd -M -s /bin/false $1
(echo $2;echo $2) |passwd $1 > /dev/null 2>&1
echo "$2" > /etc/SSHPlus/senha/$1
echo "$1 $3" >> /root/usuarios.db
echo "#!/bin/bash
pkill -f "$1"
userdel --force $1
grep -v ^$1[[:space:]] /root/usuarios.db > /tmp/ph ; cat /tmp/ph > /root/usuarios.db
rm /etc/SSHPlus/senha/$1 > /dev/null 2>&1
rm -rf /etc/SSHPlus/userteste/$1.sh
exit" > /etc/SSHPlus/userteste/$1.sh
chmod +x /etc/SSHPlus/userteste/$1.sh
at -f /etc/SSHPlus/userteste/$1.sh now + $4 min > /dev/null 2>&1
exit