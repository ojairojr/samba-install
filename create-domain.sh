#!/bin/bash

systemctl restart NetworkManager
nano /etc/hosts

export PATH=$PATH:/usr/local/samba/bin:/usr/local/samba/sbin

samba-tool domain provision --use-rfc2307 --domain=PAMASP --realm=PAMASP.INTRAER
samba-tool user setpassword administrator

cp -bv /usr/local/samba/var/lib/samba/private/krb5.conf /etc/krb5.conf

systemctl enable samba-ad-dc.service
systemctl start samba-ad-dc.service
systemctl status samba-ad-dc.service
