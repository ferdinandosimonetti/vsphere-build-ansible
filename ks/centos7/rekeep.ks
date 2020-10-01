install
cdrom
lang en_US.utf8
keyboard us
network  --bootproto=static --device=eth0 --gateway=10.20.2.120 --ip=10.20.0.200 --nameserver='10.20.0.11,10.197.65.53' --netmask=255.255.0.0 --device=ens192 --noipv6

rootpw --iscrypted $6$IEjxrYg/joA$fCh8wK3cCb2RdbEnUSnVsb1pHEgkt8hE8bODIsmHkbBGbXDGB.INRVeB0Fnt6hwixg00o.VNB0g3XlrctNvpf1

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
@base
@core
dnf
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
realmd
sssd 
oddjob
oddjob-mkhomedir
adcli
samba-common
samba-common-tools
krb5-workstation 
authselect-compat
%end

%post
yum update -y
yum clean all
ssh-keygen -t rsa -b 4096 -f /root/.ssh/id_rsa -q -N ''
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDn27u+qQSyWaHZstG34KE7QD4VGq+GvR0finXD8mUL5 temporary-key" >> /root/.ssh/authorized_keys
chmod 600 /root/.ssh/authorized_keys
%end