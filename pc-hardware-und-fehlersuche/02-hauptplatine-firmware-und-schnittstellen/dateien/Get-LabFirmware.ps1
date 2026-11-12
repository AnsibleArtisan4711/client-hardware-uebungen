# Modul 02: Firmware-Einstellungen einer Generation-2-VM auf dem Host anzeigen (nur lesen).
# Aufruf auf dem Hyper-V-Host in einer PowerShell als Administrator:
#   .\Get-LabFirmware.ps1 -VMName WIN11-TEST
param(
    [Parameter(Mandatory)][string]$VMName
)
$fw  = Get-VMFirmware -VMName $VMName
$sec = Get-VMSecurity -VMName $VMName
[pscustomobject]@{
    VM                = $VMName
    SecureBoot        = $fw.SecureBoot            # Eigenschaftsnamen nicht bestaetigt
    SecureBootVorlage = $fw.SecureBootTemplate    # Eigenschaftsnamen nicht bestaetigt
    TpmAktiv          = $sec.TpmEnabled           # Eigenschaftsname nicht bestaetigt
}
"Boot-Reihenfolge:"
$fw.BootOrder | ForEach-Object { "  {0}  {1}" -f $_.BootType, $_.Device.Name }
