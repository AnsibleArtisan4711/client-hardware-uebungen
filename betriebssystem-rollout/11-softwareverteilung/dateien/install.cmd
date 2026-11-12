@echo off
rem install.cmd - Beispiel-"Anwendung", legt nur eine Markierungsdatei an.
mkdir C:\Rollout 2>nul
echo Version 1 installiert %DATE% %TIME% > C:\Rollout\app1.txt
exit /b 0
