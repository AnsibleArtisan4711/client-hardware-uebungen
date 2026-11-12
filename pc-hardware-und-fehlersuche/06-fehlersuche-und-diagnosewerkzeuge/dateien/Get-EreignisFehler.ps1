# Modul 06: Fehler und Warnungen der letzten 7 Tage aus dem System-Protokoll, gruppiert nach Ereignis-ID.
# Als Administrator. Gibt es keine Treffer, meldet Get-WinEvent einen Fehler; er wird unterdrueckt.
$ereignisse = Get-WinEvent -FilterHashtable @{
    LogName   = 'System'
    Level     = 2, 3                       # 2 = Fehler, 3 = Warnung
    StartTime = (Get-Date).AddDays(-7)
} -ErrorAction SilentlyContinue
if (-not $ereignisse) { 'Keine Fehler oder Warnungen in den letzten 7 Tagen.'; return }
$ereignisse | Group-Object Id | Sort-Object Count -Descending |
    Select-Object Count, Name, @{n='Quelle';e={$_.Group[0].ProviderName}}
