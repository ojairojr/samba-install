#!/bin/bash

systemctl restart NetworkManager.service
cd /etc
rm resolv.conf
> resolv.conf
systemctl restart NetworkManager.service
