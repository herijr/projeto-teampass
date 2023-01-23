#!/bin/bash
sudo yum update -y
sudo apt -y upgrade
sudo yum -y install -y amazon-linux-extras
sudo amazon-linux-extras enable php7.4
sudo yum clean metadata
sudo yum -y install httpd
sudo yum -y install php php-mysqlnd php-mcrypt php-ldap php-mbstring php-openssl php-bcmath php-iconv php-gd php-xml
sudo yum -y install amazon-efs-utils
sudo systemctl start httpd
sudo systemctl enable httpd
sudo systemctl restart httpd

sudo su

mkdir -p /var/www/html/includes/libraries/csrfp/log
mkdir /var/www/html/files
mkdir /var/www/html/upload
mkdir /var/www/html/secret

sudo echo "${efs-id}:/ /var/www/html/files efs _netdev,noresvport,tls,accesspoint=${files} 0 0" >> /etc/fstab
sudo echo "${efs-id}:/ /var/www/html/upload efs _netdev,noresvport,tls,accesspoint=${upload} 0 0" >> /etc/fstab
sudo echo "${efs-id}:/ /var/www/html/secret efs _netdev,noresvport,tls,accesspoint=${secret} 0 0" >> /etc/fstab
sudo mount -a

echo "EFS montado"

wget https://github.com/nilsteampassnet/TeamPass/archive/refs/tags/3.0.0.21.tar.gz

tar -zxvf 3.0.0.21.tar.gz
rm -zxvf 3.0.0.21.tar.gz
cp -Rpv TeamPass-3.0.0.21/* /var/www/html/
chown -R apache:apache /var/www/html/

rm -rf TeamPass-3.0.0.21

echo "Copia finalizada"
