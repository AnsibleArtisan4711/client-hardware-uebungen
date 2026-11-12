# Betriebssystem-Rollout (MDT, MECM und Alternativen): Übungsreihe

Praktische Übungen zum Lehrplan **P46 Betriebssystem-Rollout (MDT, MECM und Alternativen)**. Diese Fassung deckt alle **14 Module** ab (108 UE; 12 Pflichtmodule mit 98 UE, 2 Vertiefungsmodule mit 10 UE). Jede Übung besteht aus einer Markdown-Datei mit Teilaufgaben, Kontrollfragen und Musterlösung. Beispieldateien (Skripte, Antwortdatei, Konfigurationen) liegen je Modul im Unterordner `dateien/`.

**Status: Entwurf.** Nichts wurde auf Windows ausgeführt; jede Übung nennt ihren Teststand in einem Warnhinweis. Die Module 08 bis 11 und 14 hängen von einer lauffähigen Installation von Configuration Manager ab (Ausweich-VM `DEPLOY01-CM-fertig` des Kursleiters).

## Module

| Modul | Thema | Übung | UE |
|---|---|---|---|
| [01](01-rollout-konzepte-und-produktlandschaft/) | Rollout-Konzepte und Produktlandschaft (Stand 08.11.2026) | 01.1 | 7 |
| [02](02-laborumgebung-und-offline-beschaffung/) | Laborumgebung und Offline-Beschaffung | 02.1 | 7 |
| [03](03-windows-adk-winpe-und-dism/) | Windows ADK, Windows PE und DISM | 03.1 | 9 |
| [04](04-abbild-anwenden/) | Abbild anwenden: Partitionierung, Antwortdatei, Skript | 04.1 | 8 |
| [05](05-referenzabbild-erstellen-und-pflegen/) | Referenzabbild erstellen und pflegen | 05.1 | 8 |
| [06](06-treiberverwaltung/) | Treiberverwaltung | 06.1 | 7 |
| [07](07-netzwerkboot-pxe-und-wds/) | Netzwerkboot mit PXE und WDS | 07.1 | 9 |
| [08](08-configuration-manager-aufbau/) | Configuration Manager: Aufbau | 08.1 | 8 |
| [09](09-betriebssystembereitstellung-mit-configuration-manager/) | Betriebssystembereitstellung mit Configuration Manager | 09.1 | 10 |
| [10](10-aufgabensequenzen-in-der-tiefe/) | Aufgabensequenzen in der Tiefe | 10.1 | 9 |
| [11](11-softwareverteilung/) | Softwareverteilung | 11.1 | 7 |
| [12](12-mdt-altumgebung-lesen-und-abloesen/) | MDT: Altumgebung lesen und ablösen (Priorität 2, optional) | 12.1 | 5 |
| [13](13-alternativen-fog-autopilot-und-intune/) | Alternativen: FOG, Autopilot und Intune im Überblick (Priorität 2, optional) | 13.1 | 5 |
| [14](14-fehlersuche/) | Fehlersuche | 14.1 | 9 |

Die Module 12 und 13 haben im Lehrplan Priorität 2. Kein Pflichtmodul setzt sie voraus: Modul 12 liest nur Beispieldateien, Modul 13 ist eine Vorführung ohne Änderung am Labor.

## Reihenfolge und Abhängigkeiten

| Modul | Braucht |
|---|---|
| 01 | nichts |
| 02 | 01 |
| 03 | 02 |
| 04 | 03 |
| 05 | 04 |
| 06 | 05 |
| 07 | 06 (Zustand `DEPLOY01-M6-Ende`) |
| 08 | 06 (Zustand `DEPLOY01-M6-Ende`, ohne WDS) |
| 09 | 05, 08 |
| 10 | 09 |
| 11 | 10 |
| 12 | 09 |
| 13 | 09 (und Ergebnisse aus Modul 01) |
| 14 | 09, 10, 11 (Zustand `DEPLOY01-M11-Ende`) |

## Labor

Alle Übungen laufen in einem isolierten Hyper-V-Labor ohne Verbindung zu produktiven Netzen und ohne Internet. Beschaffung, Zusammenstellung und Zahlen stehen im Lehrplan P46, Abschnitt A.3.

| Element | Wert |
|---|---|
| Host | Windows mit Hyper-V, mindestens 32 GB RAM und 400 GB frei (Annahme des Lehrplans); einmalig Internet für die Beschaffung |
| Switch | privat, `vSwitch-Lab` |
| Netz | `10.70.0.0/24`, ohne Gateway; DHCP-Bereich `10.70.0.100` bis `10.70.0.199` |
| `DC01` | `10.70.0.10`, Domäne `lab.example.internal` (NetBIOS `LAB`), DNS, DHCP (ab Modul 02), OU `Rollout` mit `Clients` und `Dienstkonten`, Konten `LAB\labadmin`, `LAB\svc-osd-read`, `LAB\svc-osd-join`; vom Kursleiter vorbereitet (Prüfpunkt `DC01-Basis`) |
| `DEPLOY01` | `10.70.0.20`, Windows Server 2025 (Evaluation), Generation 2, 4 vCPUs, 12 GB, 100 GB plus Datenplatte `E:` 100 GB, Freigabe `\\DEPLOY01\Images`; später Standort `LAB` |
| `CL01`, `CL02` | Generation 2, 2 vCPUs, 4 GB, 64 GB, Secure Boot, vTPM, ohne Betriebssystem, DHCP |

Prüfpunkte: `DEPLOY01-M2-Ende`, `CL01-leer`, `CL02-leer`, `CL02-M5-vor-Sysprep`, `DEPLOY01-M6-Ende`, `DC01-M8-Ende` und `DEPLOY01-M8-Ende` (nur gemeinsam zurücksetzen), `DEPLOY01-M11-Ende`. Ein Prüfpunkt ist keine Datensicherung.

Kennwörter vergibt der Kursleiter. Sie stehen in keiner Übung und keiner Beispieldatei (Platzhalter `PLATZHALTER-vom-Kursleiter`).

## Was geprüft wurde

- **Windows:** nichts ausgeführt (kein Windows verfügbar).
- **Microsoft Learn:** am 12.11.2026 stichprobenartig gegen Suchtreffer-Auszüge geprüft (Seiten nicht vollständig gelesen): `copype`, `MakeWinPEMedia` (inklusive `/bootex`), `Dism /Apply-Image`, `/Capture-Image`, `/Add-Driver` mit `/Recurse`, `/Get-Drivers`, `bcdboot`, UEFI/GPT-Partitionierung, `sysprep /generalize /oobe /shutdown`, `wdsutil /Initialize-Server`, `Import-WdsBootImage`, PowerShell Direct (`New-PSSession -VMName`, `Copy-Item -ToSession/-FromSession`), `Set-VMFirmware`, `Enable-VMTPM`, `Set-VMKeyProtector`, `Add-VMDvdDrive`, WinPE-Komponenten samt Reihenfolge, Fundorte von `smsts.log`, Variablen `_SMSTSBootUEFI`, `_SMSTSInWinPE`, `_SMSTSLastActionRetCode`, `_SMSTSLogPath`.
- **Linux-Tests:** `wimlib-imagex` 1.14.4 (Einfachspeicherung, Export, Anwenden), `dnsmasq` 2.91 (Syntax der Proxy-DHCP-Konfiguration), `xmllint` (Wohlgeformtheit der Antwortdatei, **nicht** gegen das Windows-Schema), PowerShell 7 (Parser für alle PowerShell-Blöcke; die Funktion `Get-DriverFolder` und die TFTP-Rechnung mit Testwerten ausgeführt), Python (Datums- und Zeitrechnungen).
- **Nicht bestätigt:** alle Menü- und Optionsnamen der Konsole von Configuration Manager, Funktionsnamen der Windows-Features, Parameter wie `ccmsetup`, die Verfügbarkeit der Evaluationen (Windows Server 2025, Windows 11 Enterprise, SQL Server 2022, Configuration Manager 2609), MDT-Details und alle Aussagen zu FOG im Detail.
- **Nicht gelesen:** die WDS-Ankündigung auf support.microsoft.com, die Härtungsanleitung zu CVE-2026-0386, die FOG-Dokumentation.
- Abweichungen von und Ergänzungen zum Lehrplan stehen in [lehrplan-hinweise.md](lehrplan-hinweise.md).

## Sicherheit

Die Übungen löschen Festplatten (`diskpart … clean`), wenden Abbilder an, verallgemeinern Windows (Sysprep) und setzen Prüfpunkte zurück. Nur in den leeren Labor-VMs ausführen, nie auf produktiven Geräten. Das Labor betreibt Configuration Manager ohne HTTPS (nur im isolierten Labor). Kennwörter gehören nie in Skripte, Antwortdateien, Regeldateien oder Boot-Abbilder; Konten haben nur die nötigen Rechte.

## Lizenz

Skripte und Befehle: MIT ([LICENSE](LICENSE)). Texte: CC BY 4.0 ([LICENSE-DOCS.md](LICENSE-DOCS.md)). Windows, Windows Server, Hyper-V und PowerShell sind Marken der Microsoft Corporation; dieser Kurs steht in keiner Verbindung zu Microsoft.
