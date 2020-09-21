# vsphere-build-ansible
vSphere environment building and populating via Ansible

## create templates with Packer
packer build -var customer=fsimonetti -var location=home -var iso-name=centos7.iso -var vm-name=CENTOS7-2003 -var vm-disk-size=25000 -var-file fsimonetti.packer-variables.json -var-file fsimonetti.home.packer-variables.json centos7.build.json

## deploy from template
compile deployments description:

---
vmhostname: "testvm2"
vmdescription: "{{ vmhostname }} 6"
vmnetwork: "192.168.101.0/24"
vmnetworkname: "VM Network"
vmgateway: "192.168.101.2"
vmnetmask: "255.255.255.0"
template: "CENTOS7-2003"
vmtype: "linux"
vmdisksize: 30
vmfolder: ""
vmram: 4096
vmcpu: 2
vmosid: "centos7_64Guest"
vmdisktype: "thick"
vmdatastore: "vm-ds"

Deploy via Ansible

ansible-playbook -i external-inventory -v --vault-password-file ~/.password --extra-vars customer=fsimonetti --extra-vars location=home --extra-vars @deployments/fsimonetti.home.testvm2.yml  deploy.yml