#!/bin/bash

sambaVersion="4.19.3"
pathSambaSrc="/usr/src/samba-${sambaVersion}"
pathSambaInstall="/usr/local/samba"
apt-get install wget acl attr autoconf bind9utils bison build-essential debhelper dnsutils docbook-xml docbook-xsl flex gdb libjansson-dev krb5-user libacl1-dev libaio-dev libarchive-dev libattr1-dev libblkid-dev libbsd-dev libcap-dev libcups2-dev libgnutls28-dev libgpgme-dev libjson-perl libldap2-dev libncurses5-dev libpam0g-dev libparse-yapp-perl libpopt-dev libreadline-dev nettle-dev perl pkg-config python-all-dev python2-dev python2 python3 python-dev-is-python3 python2-dbg python3-dnspython python3-gpg python3-markdown python3-dev xsltproc zlib1g-dev liblmdb-dev lmdb-utils libsystemd-dev perl-modules-5.* libdbus-1-dev libtasn1-bin -y
cd /usr/src
wget -c https://download.samba.org/pub/samba/stable/samba-${sambaVersion}.tar.gz

tar -xvf samba-${sambaVersion}.tar.gz && cd samba-${sambaVersion}
./configure --with-systemd --prefix=/usr/local/samba --enable-fhs
make && make install

cp ${pathSambaSrc}/bin/default/packaging/systemd/samba.service /etc/systemd/system/samba-ad-dc.service
mkdir -p ${pathSambaInstall}/etc/sysconfig && cd ${pathSambaInstall}/etc/sysconfig
touch samba && echo 'SAMBAOPTIONS="-D"' >> samba

systemctl daemon-reload

systemctl stop systemd-resolved.service
systemctl disable systemd-resolved.service

echo "grave o IP de ambos os servidores de domain controller, para que possa inserí-los no campo DNS, e execute o comando: nmtui"
