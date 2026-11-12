# Modul 04: Zusaetzliche 10-GB-Platte an eine ausgeschaltete VM haengen (auf dem Host, als Administrator).
#   .\Add-TestDisk.ps1 -VMName WIN11-TEST -Ordner 'D:\Hyper-V\Disks'
# Die Datei DatenTest.vhdx wird in Modul 07 wieder entfernt.
param(
    [Parameter(Mandatory)][string]$VMName,
    [Parameter(Mandatory)][string]$Ordner
)
$vm = Get-VM -Name $VMName
if ($vm.State -ne 'Off') { throw "Die VM $VMName muss ausgeschaltet sein (Status: $($vm.State))." }
$pfad = Join-Path $Ordner 'DatenTest.vhdx'
if (Test-Path $pfad) { throw "$pfad existiert schon. Nichts geaendert." }
New-VHD -Path $pfad -SizeBytes 10GB -Dynamic | Out-Null
Add-VMHardDiskDrive -VMName $VMName -ControllerType SCSI -Path $pfad
Get-VMHardDiskDrive -VMName $VMName | Select-Object ControllerType, ControllerNumber, ControllerLocation, Path
