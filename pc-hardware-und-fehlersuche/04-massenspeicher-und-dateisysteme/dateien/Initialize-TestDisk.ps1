# Modul 04: Neue (leere) Platte im Gast als GPT initialisieren und mit NTFS als Z: formatieren.
# Im Gast (WIN11-TEST) in einer PowerShell als Administrator. Schuetzt vor dem Formatieren der falschen Platte:
# Es muss genau EINE Platte mit Partitionsstil RAW geben.
$roh = @(Get-Disk | Where-Object PartitionStyle -eq 'RAW')
if ($roh.Count -ne 1) { throw "Erwartet genau eine RAW-Platte, gefunden: $($roh.Count). Nichts geaendert." }
$platte = $roh[0]
"Platte {0}: {1:N1} GB" -f $platte.Number, ($platte.Size / 1GB)
Initialize-Disk -Number $platte.Number -PartitionStyle GPT
New-Partition -DiskNumber $platte.Number -UseMaximumSize -DriveLetter Z |
    Format-Volume -FileSystem NTFS -NewFileSystemLabel 'Daten-Test' -Confirm:$false
Get-Volume -DriveLetter Z
