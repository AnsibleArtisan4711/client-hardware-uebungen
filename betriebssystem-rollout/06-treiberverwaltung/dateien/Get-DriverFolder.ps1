<#
.SYNOPSIS
  Ermittelt den Treiberordner zum Geraetemodell (Beispiel, Modul 06).
.DESCRIPTION
  Liest Hersteller und Modell, bildet <Basis>\<Hersteller>\<Modell>, faellt bei fehlendem
  Ordner auf <Basis>\Allgemein zurueck und schreibt jeden Fallback ins Protokoll.
  Mit -Hersteller/-Modell kann die Abfrage fuer Tests ersetzt werden.
#>
function Get-DriverFolder {
    [CmdletBinding()]
    param(
        [string]$Basis   = 'E:\Images\Drivers',
        [string]$Log     = 'E:\Images\Drivers\treiber.log',
        [string]$Hersteller,
        [string]$Modell
    )
    if (-not $Hersteller -or -not $Modell) {
        $cs = Get-CimInstance -ClassName Win32_ComputerSystem
        if (-not $Hersteller) { $Hersteller = $cs.Manufacturer }
        if (-not $Modell)     { $Modell     = $cs.Model }
    }
    # Zeichen entfernen, die in Ordnernamen nicht erlaubt sind
    $bad = [IO.Path]::GetInvalidFileNameChars() -join ''
    $re  = '[' + [regex]::Escape($bad) + ']'
    $h = ($Hersteller -replace $re, '_').Trim()
    $m = ($Modell     -replace $re, '_').Trim()
    $ziel = Join-Path (Join-Path $Basis $h) $m
    if (Test-Path -LiteralPath $ziel) { return $ziel }
    $zeile = '{0} Kein Ordner fuer "{1}" / "{2}", Rueckfall auf Allgemein' -f (Get-Date -Format s), $h, $m
    try { Add-Content -Path $Log -Value $zeile -ErrorAction Stop } catch { Write-Warning $zeile }
    return (Join-Path $Basis 'Allgemein')
}
