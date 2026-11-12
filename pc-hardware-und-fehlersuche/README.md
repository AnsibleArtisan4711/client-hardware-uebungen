# PC-Hardware und Fehlersuche: Übungsreihe

Praktische Übungen zum Lehrplan **P44 PC-Hardware und Fehlersuche**. Diese Fassung deckt alle **8 Module** ab (42 UE; 7 Module Priorität 1 mit 38 UE, 1 Modul Priorität 2 mit 4 UE). Jede Übung besteht aus einer Markdown-Datei mit Teilaufgaben, Kontrollfragen und Musterlösung. Beispieldateien (Skripte, Vorlagen) liegen je Modul im Unterordner `dateien/`. Zielgruppe sind Einsteiger ohne Vorkenntnisse.

**Status: Entwurf.** Nichts wurde auf Windows oder Hyper-V ausgeführt; jede Übung nennt ihren Teststand in einem Warnhinweis. Die Module 01 und 02 (Teile mit Schnittstellen) brauchen ein Altgerät oder Bildmaterial vom Kursleiter.

## Module

| Modul | Thema | Übung | UE |
|---|---|---|---|
| [01](01-grundlagen-pc-architektur-und-arbeitssicherheit/) | Grundlagen der PC-Architektur und Arbeitssicherheit | 01.1 | 5 |
| [02](02-hauptplatine-firmware-und-schnittstellen/) | Hauptplatine, Firmware (BIOS/UEFI) und Schnittstellen | 02.1 | 6 |
| [03](03-cpu-ram-und-kuehlung/) | Prozessor (CPU), Arbeitsspeicher (RAM) und Kühlung | 03.1 | 5 |
| [04](04-massenspeicher-und-dateisysteme/) | Massenspeicher und Dateisysteme | 04.1 | 6 |
| [05](05-erweiterungskarten-und-peripherie/) | Erweiterungskarten (Netzwerk, Grafik) und Peripheriegeräte | 05.1 | 4 |
| [06](06-fehlersuche-und-diagnosewerkzeuge/) | Systematische Fehlersuche und Diagnosewerkzeuge | 06.1 | 6 |
| [07](07-wartung-datensicherung-und-wiederherstellung/) | Systemwartung, Datensicherung und Wiederherstellung | 07.1 | 6 |
| [08](08-fehlerbilder-und-fallstudien/) | Spezifische Fehlerbilder und Fallstudien (Priorität 2, optional) | 08.1 | 4 |

Modul 08 hat im Lehrplan Priorität 2 und ist reine Falldiskussion ohne Labor.

## Reihenfolge und Abhängigkeiten

| Modul | Braucht |
|---|---|
| 01 | nichts |
| 02 | 01 (Prüfpunkt `M2-Start`) |
| 03 | 02 |
| 04 | 03 (erzeugt das Laufwerk `Z:`) |
| 05 | 04 |
| 06 | 05 |
| 07 | 04 (Laufwerk `Z:` und Prüfpunkt `M7-Start`); löscht `Z:` am Ende |
| 08 | 01 bis 07 |

## Labor

| Element | Wert |
|---|---|
| Host | Windows 10/11 Pro oder Enterprise mit Hyper-V, mindestens 8 GB frei, die VMs laufen nie gleichzeitig |
| Switch | privat, `vSwitch-Private` (ab Modul 05) |
| `WIN11-TEST` | Generation 2, 4 vCPUs, 4 GB, 64 GB, vTPM, Secure Boot; Windows 11 Enterprise Evaluation, vom Kursleiter installiert; lokales Konto `labadmin`; Prüfpunkt `M2-Start` |
| `LINUX-LIVE` | Generation 2, 2 vCPUs, 4 GB, ohne Festplatte; Ubuntu 24.04 Desktop (ISO); Anlage in Modul 06 |
| Material | Altgerät oder Bildmaterial (Module 01, 02), Falldokumente (Modul 08), Prüfpunkt `M7-Start` |

Kennwörter vergibt der Kursleiter. Sie stehen in keiner Übung und keiner Beispieldatei (Platzhalter `PLATZHALTER-vom-Kursleiter`).

## Was geprüft wurde

- **Windows und Hyper-V:** nichts ausgeführt (nicht verfügbar).
- **Microsoft Learn:** am 12.11.2026 stichprobenartig gegen Suchtreffer-Auszüge geprüft (Seiten nicht vollständig gelesen): Secure-Boot-Vorlagen, `Set-VMFirmware`, `Add-VMDvdDrive`, `Add-VMHardDiskDrive`, `Format-Volume`, `Initialize-Disk`, `Confirm-SecureBootUEFI`, `Win32_PnPSignedDriver`, `Checkpoint-Computer`, `fsutil dirty`, `chkdsk /f`, `robocopy` samt Exit-Codes.
- **Linux-Tests:** Python-Skripte (`bandbreiten.py`, `ram-bandbreite.py`, `mbr-gpt-grenzen.py`, `backup-mengen.py`) ausgeführt, die Ausgaben stehen in den Musterlösungen. PowerShell-Skripte mit dem PowerShell-Parser auf Syntax geprüft (nicht ausgeführt), `linux-diagnose.sh` mit `bash -n` geprüft und in einer Linux-Testumgebung ausgeführt (nicht in Ubuntu Live).
- **Nicht bestätigt:** Menü- und Fenstertexte der deutschen Oberfläche, Adaptername im Gast, Verhalten von Umgebungsvariablen nach der Systemwiederherstellung, Secure-Boot-Verhalten mit der Vorlage *Microsoft Windows*, Eigenschaftsnamen in `Get-LabFirmware.ps1`, Dauer der Evaluation.
- **Ohne geprüfte Quelle:** Hardware-Standards (PCIe, SATA, USB, ATX, UEFI, SMART, ESD), CompTIA-Fehlersuchmodell, BSOD-Stoppcodes.
- Abweichungen von und Ergänzungen zum Lehrplan stehen in [lehrplan-hinweise.md](lehrplan-hinweise.md).

## Sicherheit

Modul 01 und 02 betreffen Arbeiten an Geräten (ESD, Netzteil): nur stromlos, Netzteil nie öffnen. Modul 04 und 07 formatieren, prüfen und löschen eine **leere Testplatte** (`Z:`); vor jedem Löschen prüfen, dass es das richtige Laufwerk ist. Nur im Labor ausführen, nie auf produktiven Geräten.

## Lizenz

Skripte und Befehle: MIT ([LICENSE](LICENSE)). Texte: CC BY 4.0 ([LICENSE-DOCS.md](LICENSE-DOCS.md)). Windows, Hyper-V und PowerShell sind Marken der Microsoft Corporation, Ubuntu ist eine Marke von Canonical Ltd., CompTIA ist eine Marke von CompTIA, Inc.; dieser Kurs steht in keiner Verbindung zu diesen Unternehmen.
