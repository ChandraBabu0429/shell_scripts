#!/bin/bash

# Update package cache
sudo apt update

# Install MariaDB server and client
sudo apt install mariadb-server mariadb-client

# Start and enable MariaDB service
sudo systemctl start mariadb
sudo systemctl enable mariadb

# Secure MariaDB installation (set root password and other settings)
sudo mysql_secure_installation

sudo su
mysqld_safe --skip-grant-tables &

echo "MariaDB installation and configuration completed."
