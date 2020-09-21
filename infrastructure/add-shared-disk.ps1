Connect-VIServer -Server vcsa.fsimonetti.lan -Credential $(import-clixml -Path ./fsimonetti-vsphere.xml)

get-vm -name k8*

#Name                 PowerState Num CPUs MemoryGB
#----                 ---------- -------- --------
#k8node02             PoweredOn  2        2.000
#k8master             PoweredOn  2        2.000
#k8node01             PoweredOn  2        2.000

$sizeGB = 1
$sourceVM = get-vm k8master
$sharewith = @('k8node01','k8node02')

$disk = New-HardDisk -VM $sourceVM -CapacityGB $SizeGB -Persistence independentpersistent -StorageFormat EagerZeroedThick

get-vm -name k8*|Shutdown-VMGuest

$disk | New-ScsiController -Type ParaVirtual

$diskscsiaddress= $(Get-VM -name $sourceVM | Get-HardDisk |select -last 1|Select @{N='VM';E={$_.Parent.Name}},
  Name,
  @{N='SCSIid';E={
  $hd = $_
  $ctrl = $hd.Parent.Extensiondata.Config.Hardware.Device | where{$_.Key -eq $hd.ExtensionData.ControllerKey}
  "$($ctrl.BusNumber):$($_.ExtensionData.UnitNumber)"
}}).SCSIid

get-vm -name $sourceVM| New-AdvancedSetting -Name "scsi${diskscsiaddress}.sharing" -Value "multi-writer" –confirm:$false -force

foreach ($targetVM in $shareWith) {
  $targetVM = Get-VM $targetVM
  New-HardDisk -VM $targetVM -DiskPath $disk.Filename | New-ScsiController -Type ParaVirtual
  
  $disksa = $(Get-VM -name $targetVM | Get-HardDisk |select -last 1|Select @{N='VM';E={$_.Parent.Name}},
  Name,
  @{N='SCSIid';E={
  $hd = $_
  $ctrl = $hd.Parent.Extensiondata.Config.Hardware.Device | where{$_.Key -eq $hd.ExtensionData.ControllerKey}
  "$($ctrl.BusNumber):$($_.ExtensionData.UnitNumber)"
  }}).SCSIid

  get-vm -name $targetVM| New-AdvancedSetting -Name "scsi${disksa}.sharing" -Value "multi-writer" –confirm:$false -force
}

start-vm k8*
