@echo off
rem Deploy.cmd - Beispiel, nicht ausgefuehrt. Laeuft nur in Windows PE in einer Labor-VM.
rem Das Kennwort wird abgefragt (Sternchen), es steht NICHT im Skript.
setlocal
echo ACHTUNG: Die erste Festplatte wird geloescht. Abbruch mit Strg+C.
pause
net use Z: \\DEPLOY01\Images /user:LAB\svc-osd-read *
if errorlevel 1 goto fehler
diskpart /s Z:\scripts\CreatePartitions-UEFI.txt
if errorlevel 1 goto fehler
dism /Apply-Image /ImageFile:Z:\W11-ENT-Basis.wim /Index:1 /ApplyDir:W:\
if errorlevel 1 goto fehler
mkdir W:\Windows\Panther
copy Z:\scripts\unattend-CL01.xml W:\Windows\Panther\unattend.xml
bcdboot W:\Windows /s S: /f UEFI
if errorlevel 1 goto fehler
net use Z: /delete
wpeutil reboot
goto :eof
:fehler
echo FEHLER. Bereitstellung abgebrochen.
exit /b 1
