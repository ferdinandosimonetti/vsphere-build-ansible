#!/bin/bash
echo -n "Enter VSPHEREPASSWORD: "
read VSPHEREPASSWORD
export VSPHEREPASSWORD
echo -n "Enter TEMPLATENAME: "
read TEMPLATENAME
export TEMPLATENAME
packer build main.json
