install
url --url="http://centos.mirror.garr.it/centos/8.2.2004/BaseOS/x86_64/os/"
lang en_US.UTF-8
keyboard us
network --bootproto=dhcp
rootpw --iscrypted $6$heyd8qgdj8whsg6f$hmeiLdwztGC7V9B7rMtF9jgdbOMfmGJd1x8G8WGUV9xNG0R.qpK25ShXeKIJxdPMpbhqGbYvgReIf8xJx3Y401

firewall --disabled
selinux --disabled
timezone UTC
bootloader --location=mbr
text
skipx 
zerombr
clearpart --all --initlabel
#autopart
# Disk partitioning information
part /boot --fstype="xfs" --ondisk=sda --size=1024
part pv.404 --fstype="lvmpv" --ondisk=sda --size=1 --grow
volgroup vg00 --pesize=4096 pv.404
logvol /var  --fstype="xfs" --size=4096 --name=var --vgname=vg00
logvol /tmp  --fstype="xfs" --size=4096 --name=tmp --vgname=vg00
logvol /  --fstype="xfs" --size=4096 --name=root --vgname=vg00
logvol /home  --fstype="xfs" --size=1024 --name=home --vgname=vg00
logvol /usr  --fstype="xfs" --size=4096 --name=usr --vgname=vg00
logvol swap  --fstype="swap" --size=2048 --name=swap --vgname=vg00
auth --enableshadow --passalgo=sha512 --kickstart
firstboot --disabled
eula --agreed
services --enabled=NetworkManager,sshd
reboot

%packages --ignoremissing
@^Base
@^Core
openssh-clients
sudo
open-vm-tools
curl
wget
lsof
screen
git
zip
unzip
openssh-clients
realmd
sssd 
oddjob
oddjob-mkhomedir
adcli
samba-common
samba-common-tools
krb5-workstation 
authselect-compat
@^python36
%end

%post
yum update -y
yum clean all
ssh-keygen -t rsa -b 4096 -f /root/.ssh/id_rsa -q -N ''
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDn27u+qQSyWaHZstG34KE7QD4VGq+GvR0finXD8mUL5 info@fsimonetti.eu" >> /root/.ssh/authorized_keys
chmod 600 /root/.ssh/authorized_keys
%end