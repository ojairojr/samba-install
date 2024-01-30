#!/bin/bash

sambaVersion="4.19.3"
pathSambaSrc="/usr/src/samba-${sambaVersion}"
pathSambaInstall="/usr/local/samba"
apt install build-essential libacl1-dev libattr1-dev libblkid-dev libgnutls28-dev libreadline-dev python3-dev python3-dnspython gdb pkg-config libpopt-dev libldap2-dev dnsutils libbsd-dev attr krb5-user docbook-xsl libcups2-dev libavahi-client-dev libavahi-common-dev libpam0g-dev libnss3-dev libssl-dev libgpgme11-dev libncurses5-dev libgnutls28-dev zlib1g-dev libsasl2-dev acl attr libacl1 libattr1 -y
cd /usr/src
wget -c https://download.samba.org/pub/samba/stable/samba-${sambaVersion}.tar.gz

tar -xvf samba-${sambaVersion}.tar.gz && cd samba-${sambaVersion}
./configure --with-systemd --prefix=/usr/local/samba --enable-fhs
make && make install

cp ${pathSambaSrc}/bin/default/packaging/systemd/samba.service /etc/systemd/system/samba-ad-dc.service
mkdir -p ${pathSambaInstall}/etc/sysconfig && cd ${pathSambaInstall}/etc/sysconfig
touch samba && echo 'SAMBAOPTIONS="-D"'

systemctl daemon-reload

systemctl stop systemd-resolved.service
systemctl disable systemd-resolved.service

echo "grave o IP de ambos os servidores de domain controller, para que possa inserí-los no campo DNS, e execute o comando: nmtui"
