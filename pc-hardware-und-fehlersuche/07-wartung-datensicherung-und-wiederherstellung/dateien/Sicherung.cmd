@echo off
rem Modul 07: Einfache Sicherung mit robocopy von C:\Daten nach Z:\Sicherung (nur Testdaten!).
robocopy C:\Daten Z:\Sicherung /E
rem Rueckgabecodes laut Microsoft Learn: 0 bis 7 = kein Fehler, 8 oder mehr = mindestens ein Fehler.
if %ERRORLEVEL% GEQ 8 (echo FEHLER bei der Sicherung, Code %ERRORLEVEL%) else (echo Sicherung ohne Fehler, Code %ERRORLEVEL%)
