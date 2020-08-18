#!/bin/bash
if [ "x$1" == "x" ]
then
  echo "specify template to build!"
  exit 1
fi
echo -n "Enter VSPHEREPASSWORD: "
read VSPHEREPASSWORD
export VSPHEREPASSWORD
cd build-${1}
packer build main.json
