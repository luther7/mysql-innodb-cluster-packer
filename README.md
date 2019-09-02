# MySQL InnoDB Cluster Packer Template

[![Build Status](https://travis-ci.org/rubberydub/mysql-innodb-cluster-packer.svg?branch=master)](https://travis-ci.org/rubberydub/mysql-innodb-cluster-packer)

A packer template to create Virtual Box VMs running MySQL 8 InnoDB Cluster managed by Consul.

MySQL is a Consul service, and a watcher will bootstrap the MySQL InnoDB Cluster after 3 services are present.

# Usage

`make build` will run Packer to build the Virtual Box images. `make up` will boot a 3 node cluster with Vagrant. You can then access Consul on XX and MySQL on YY.

The Make targets described above will created images based on CentOS 7. You can also make images based on Ubuntu - `make build.ubuntu && make up.ubuntu`. TODO the Ubuntu images are not complete, only install Consul and do not install MySQL 8.

## To do

- [X] CentOS Packer template
- [X] Ubuntu Packer template
- [X] Consul install script
- [X] CentOS MySQL 8 install script
- [X] Ubuntu MySQL 8 install script
- [ ] InnoDB Cluster Consul service
- [ ] Bootstrap InnoDB Cluster via Consul watcher
- [ ] Rejoin missing nodes via Consul watcher
