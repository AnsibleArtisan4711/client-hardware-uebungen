@echo off
rem Modul 07: Dateisystemfehler auf Z: simulieren und beheben. Als Administrator in cmd.exe.
rem Z: ist die leere Testplatte aus Modul 04. NIE auf einem Laufwerk mit wichtigen Daten ausfuehren.
fsutil dirty set Z:
fsutil dirty query Z:
chkdsk Z:
chkdsk Z: /f
fsutil dirty query Z:
