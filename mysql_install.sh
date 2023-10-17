#!/bin/bash

sudo apt-get update
sudo apt-get install mysql-server
sudo mysql_secure_installation
sudo su
mysqld_safe --skip-grant-tables &
