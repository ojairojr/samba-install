#!/bin/bash

apt update && apt upgrade -y
apt-get install network-manager -y

timedatectl set-timezone America/Sao_Paulo

cd /etc/NetworkManager/conf.d
touch dns.conf 
echo -e "[main]\ndns=" > dns.conf

nano /etc/netplan/00-installer-config.yaml

netplan apply
netplan status

systemctl restart NetworkManager
echo "COPIE O MAC E O NOME DO DISPOSITIVO DE REDE E EXECUTE O COMANADO: nmtui"
