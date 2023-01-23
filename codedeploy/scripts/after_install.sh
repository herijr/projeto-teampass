#!/bin/bash
cp -Rpvf /home/ec2-user/app/* /var/www/html/
chown -R apache:apache /var/www/html/