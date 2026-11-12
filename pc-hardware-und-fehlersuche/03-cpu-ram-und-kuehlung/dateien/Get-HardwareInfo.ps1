# Modul 03: Hardware-Angaben im Gast auslesen. In einer VM koennen Angaben fehlen oder abweichen (nicht bestaetigt).
Get-CimInstance Win32_Processor |
    Select-Object Name, NumberOfCores, NumberOfLogicalProcessors, L2CacheSize, L3CacheSize
Get-CimInstance Win32_PhysicalMemory |
    Select-Object Capacity, Speed, Manufacturer
$ci = Get-ComputerInfo -Property BiosFirmwareType, CsTotalPhysicalMemory
"Firmware-Typ: {0}; Arbeitsspeicher: {1:N1} GB" -f $ci.BiosFirmwareType, ($ci.CsTotalPhysicalMemory / 1GB)
try   { "Secure Boot aktiv: " + (Confirm-SecureBootUEFI) }   # als Administrator
catch { "Secure Boot nicht abfragbar: " + $_.Exception.Message }
