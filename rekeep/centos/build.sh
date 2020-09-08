#!/bin/bash
echo -n "Enter VSPHEREPASSWORD: "
read VSPHEREPASSWORD
export VSPHEREPASSWORD
echo -n "Enter ADMINPASSWORD: "
read ADMINPASSWORD
export ADMINPASSWORD
echo -n "Enter TEMPLATENAME: "
read TEMPLATENAME
export TEMPLATENAME
echo -n "Enter DISKSIZE: "
read DISKSIZE
export DISKSIZE
echo -n "Enter TEMPLATENETWORKNAME: "
read TEMPLATENETWORKNAME
export TEMPLATENETWORKNAME
echo -n "Enter ISO PATH: (linux/centos8.iso, linux/centos7.iso ...): "
read ISOPATH
echo -n "Enter guest OS type (centos8_64Guest, centos7_64Guest ...): "
read VMOS
export ISOPATH VMOS
export PACKER_LOG=1
export PACKER_LOG_PATH=./build.log
packer build --force main.json
