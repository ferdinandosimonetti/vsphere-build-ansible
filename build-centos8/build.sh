#!/bin/bash
echo -n "Enter VSPHEREPASSWORD: "
read VSPHEREPASSWORD
export VSPHEREPASSWORD
packer build main.json
