# Hinweise zum Lehrplan P46 (Fachlektorat)

Stand: 12.11.2026. Abweichungen und Ergänzungen der Übungen gegenüber dem Lehrplan. Der Lehrplan selbst wurde nicht verändert.

## Ergänzungen, die der Lehrplan nicht vorgibt

| Stelle | Ergänzung | Grund |
|---|---|---|
| Alle Module | Zeitangaben in Stunden aus UE zu 45 Minuten | Der Lehrplan nennt UE; die Stundenangabe ist eine Schätzung |
| Modul 03, Aufgabe 2 | Zusätzlich `WinPE-Scripting` vor `WinPE-PowerShell` (je mit Sprachdatei `en-us`) | Learn (*WinPE Optional Components Reference*, 12.11.2026): Reihenfolge `WinPE-WMI` > `WinPE-NetFX` > `WinPE-Scripting` > `WinPE-PowerShell` |
| Modul 03, Aufgabe 2 | Standardpfad der Komponenten statt `<ADK-Pfad>`; Hinweis auf `MakeWinPEMedia /bootex` | Beides auf Learn belegt (`/bootex` ab ADK 10.1.26100.2454) |
| Modul 04 | `CreatePartitions-UEFI.txt`, `unattend-CL01.xml` und `Deploy.cmd` als Dateien in `dateien/` | Der Lehrplan zeigt sie nur im Text; die XML ist mit `xmllint` auf Wohlgeformtheit geprüft |
| Modul 06 | Funktion `Get-DriverFolder` als Datei; Aufruf mit Testwerten unter PowerShell 7 (Linux) | Der Lehrplan beschreibt sie nur; Treffer und Rückfall wurden getestet |
| Modul 07 | `proxy-dhcp-beispiel.conf` und `tftp-rechnung.ps1` als Dateien | Syntax mit `dnsmasq --test` geprüft, Rechnung ausgeführt |
| Modul 08 | Firewallregeln für 1433 und 4022 als Befehle | Lehrplan nennt nur die Ports |
| Modul 10 | Statische MAC-Adressen per `Set-VMNetworkAdapter -StaticMacAddress` | Lehrplan verlangt feste MAC-Adressen, nennt aber keinen Befehl; Cmdlet nicht bestätigt |
| Modul 11 | Skripte `install.cmd`, `uninstall.cmd`, `install-v2.cmd` als Dateien | Version 2 verlangt der Lehrplan, ohne das Skript zu zeigen |
| Modul 14 | Fundorte von `smsts.log` mit Pfaden (Learn *About log files*) und Fehlerprotokoll-Vorlage | Der Lehrplan verlangt die Tabelle, nennt aber keine Lösung |

## Auffälligkeiten im Rohmaterial

- **Modul 03, Aufgabe 2:** Der Lehrplan nennt als Mindestkomponenten `WinPE-WMI`, `WinPE-NetFx` und `WinPE-PowerShell`. Nach Learn fehlt `WinPE-Scripting` als Voraussetzung von `WinPE-PowerShell`. Die Übung ergänzt es.
- **Modul 03, Aufgabe 4:** Referenzwerte des Lehrplans (25 001 520 / 25 001 522 / 30 003 630 Byte) weichen bei `wimlib-imagex` 1.14.4 leicht ab (jeweils 25 001 514 Byte je Einzelabbild, 30 003 610 Byte für beide, Summe 50 003 028 Byte). Ursache vermutlich Version des Werkzeugs (nicht bestätigt). Die Größenordnung (etwa 30 MB statt 50 MB, Ersparnis rund 40 %) ist gleich; die Übung nennt die neuen Werte.
- **Modul 04, Aufgabe 3:** Die Learn-Beispiele rufen `bcdboot W:\Windows /s S:` ohne `/f UEFI` auf. Der Lehrplan nutzt `/f UEFI`; die Option ist in den gelesenen Auszügen nicht belegt und wird als *nicht bestätigt* geführt.
- **Modul 04/05:** Der Speicherort `W:\Windows\Panther\unattend.xml` als Suchstelle der Antwortdatei ist nicht belegt (im Lehrplan so gekennzeichnet). Learn nennt bei Sysprep, dass eine mit `/unattend` angegebene Antwortdatei nach `%WINDIR%\Panther` zwischengespeichert wird; das ist nicht dasselbe wie eine Suchstelle.
- **Modul 05:** Sysprep kennt laut Learn die Option `/mode:vm` für VHDs, die auf demselben Hypervisor mit gleichem Hardwareprofil weiterverwendet werden. Der Lehrplan verwendet sie nicht (richtig für das Abbild, das auch auf anderen Geräten laufen soll); die Übung übernimmt das.
- **Modul 07, Kontrollfrage 2:** Die Antwort des Lehrplans (Microsoft unterstütze DHCP-Optionen für PXE über Subnetzgrenzen bei Configuration Manager nicht, „was stattdessen gilt“) nennt die Alternative nicht. Die Musterlösung nennt DHCP-Relay beziehungsweise IP-Helper als *nicht bestätigt*.
- **Modul 07, Frage 3:** Die Messung mit `dnsmasq` stammt aus dem Lehrplan und wurde hier nicht wiederholt; die Formel (Größe ganzzahlig geteilt durch Blockgröße plus 1) stimmt mit der Rechnung überein.
- **Modul 09:** Die Frage, ob für UEFI-x64-Clients ein x64-Boot-Abbild genügt (Learn verlangt x86 und x64 für PXE, die ADK-Seite nennt 32-Bit-WinPE für Windows 11 als nicht unterstützt), bleibt eine Beobachtung im Labor.
- **Modul 10, Aufgabe 2:** Laut Learn „setzt die Aufgabensequenz `_SMSTSBootUEFI`, wenn sie ein UEFI-System erkennt“. Ob die Bedingung auf „Variable existiert“ oder einen Wert lauten muss, bleibt eine Beobachtung.
- **Modul 12/13:** Alle Aussagen zu MDT-Details und FOG-Technik stammen aus Erfahrung (Lehrplan: nicht bestätigt) und sind so gekennzeichnet.

## Offene Punkte (vor dem Kurs zu klären)

- Alle Windows-Befehle und Menüpfade im Labor ausführen.
- Verfügbarkeit und Laufzeit der Evaluationen (Configuration Manager 2609, SQL Server 2022, Windows Server 2025) klären; sonst Ausweich-VM `DEPLOY01-CM-fertig`.
- WDS-Ankündigung (support.microsoft.com) und Härtung zu CVE-2026-0386 lesen und in Modul 01 und 07 einarbeiten.
- Zeitaufwand ist eine Schätzung; besonders Modul 08 hängt von der Hardware ab.
