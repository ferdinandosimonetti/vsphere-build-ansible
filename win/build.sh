#!/bin/bash
echo -n "Enter VSPHEREPASSWORD: "
read VSPHEREPASSWORD
export VSPHEREPASSWORD
echo -n "Enter WINADMINPASSWORD: "
read WINADMINPASSWORD
export WINADMINPASSWORD
echo -n "Enter TEMPLATENAME: "
read TEMPLATENAME
export TEMPLATENAME
echo -n "Enter TEMPLATENETWORKNAME: "
read TEMPLATENETWORKNAME
export TEMPLATENETWORKNAME
echo -n "Enter ISO PATH: (win/2016.iso, win/2019.iso ...): "
read ISOPATH
echo -n "Enter guest OS type (2016, 2019 ...): "
read VMOS
export ISOPATH VMOS
export PACKER_LOG=1
export PACKER_LOG_PATH=./build.log
packer build main.json
