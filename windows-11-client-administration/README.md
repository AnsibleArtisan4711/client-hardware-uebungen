# Windows-11-Client-Administration: Übungsreihe

Praktische Übungen zum Lehrplan **P45 Windows-11-Client-Administration**. Diese Fassung deckt alle **12 Module** ab (108 UE). Jede Übung besteht aus einer Markdown-Datei mit nummerierten Schritten. Zu jedem Schritt gibt es den Menüweg in der grafischen Oberfläche und, wo möglich, den PowerShell-Befehl.

**Status: Entwurf.** Nicht alles ist geprüft; jede Übung nennt ihren Teststand in einem Warnhinweis.

## Module

| Modul | Thema | Übung | UE |
|---|---|---|---|
| [01](01-editionen-versionen-und-lebenszyklus/) | Windows 11: Editionen, Versionen, Lebenszyklus | 01.1 | 7 |
| [02](02-installation-und-ersteinrichtung/) | Installation und Ersteinrichtung | 02.1 | 10 |
| [03](03-bereitstellung-antwortdatei-und-image/) | Bereitstellung: Antwortdatei und Image (Priorität 2, optional) | 03.1 | 9 |
| [04](04-konten-gruppen-und-rechte/) | Konten, Gruppen und Rechte | 04.1 | 10 |
| [05](05-netzwerk-und-domaenenbeitritt/) | Netzwerk und Domänenbeitritt | 05.1 | 10 |
| [06](06-gruppenrichtlinien-und-windows-laps/) | Gruppenrichtlinien und Windows LAPS | 06.1 | 9 |
| [07](07-bitlocker/) | BitLocker | 07.1 | 9 |
| [08](08-defender-und-firewall/) | Microsoft Defender und Firewall | 08.1 | 9 |
| [09](09-updates/) | Updates | 09.1 | 8 |
| [10](10-sicherung-und-wiederherstellung/) | Sicherung und Wiederherstellung | 10.1 | 9 |
| [11](11-fernwartung/) | Fernwartung (Priorität 2, optional) | 11.1 | 7 |
| [12](12-fehlersuche-und-leistung/) | Fehlersuche und Leistung | 12.1 | 11 |

Die Module 03 und 11 haben im Lehrplan Priorität 2 (optional). Kein Pflichtmodul setzt sie voraus: Alle Pflichtmodule starten vom Zustand nach Modul 02.

## Reihenfolge und Abhängigkeiten

| Modul | Braucht |
|---|---|
| 01 | nichts |
| 02, 03 | 01, 02 |
| 04, 05 | 02 |
| 06 | 04, 05 |
| 07 | 02, 06 |
| 08 | 02, 04, 05 |
| 09 | 06 |
| 10 | 02, 04, 07 |
| 11 | 05, 08 |
| 12 | 05, 06, 07, 08 |

## Labor

Alle Übungen laufen in einem isolierten Hyper-V-Labor ohne Verbindung zu produktiven Netzen und ohne Internet.

| Element | Wert |
|---|---|
| Host | Windows 11 Pro oder Enterprise mit Hyper-V, mindestens 16 GB RAM, 150 GB frei (Annahme des Lehrplans) |
| Switch | privat, `vSwitch-Lab` |
| Netz | `10.50.0.0/24`, ohne Gateway |
| `DC01` | Windows Server (Evaluation, Version legst du fest und notierst sie), `10.50.0.10`, AD DS und DNS, Domäne `lab.example.internal` (NetBIOS `LAB`), OU `Clients` und `Benutzer`, Benutzer `anna.muster`, `ben.beispiel`, Administrator `LAB\labadmin` |
| `CL01` | Windows 11 Enterprise (Evaluation), `10.50.0.21`, Generation 2, vTPM, Secure Boot, ab Modul 10 eine zweite 20-GB-Platte |

Der Domain Controller wird **nicht** in diesem Kurs gebaut. Er ist vorbereitet (Prüfpunkt `DC-Basis`) und dient als Gegenstelle. Aufbau und Betrieb von Active Directory gehören zu den Kursen der Gruppe *Windows Server*.

Prüfpunkte: `CL01-M2-Ende`, `CL01-M5-Join` (nur vorübergehend), `CL01-M5-Ende` und `DC-M5-Ende` (nur gemeinsam zurücksetzen), `CL01-M7-Ende` (Ergänzung der Übung: `DC-M7-Ende`). Ein Prüfpunkt ist keine Datensicherung (Modul 10).

Kennwörter vergibst du selbst und legst sie in deiner Kennwortablage ab. Sie stehen in keiner Übung.

## Was geprüft wurde

- **Windows:** nichts ausgeführt. Rechenwerte (Termine, Adressen, Speicherbedarf, Leistungsdaten) wurden mit einem Skript nachgerechnet.
- **Microsoft Learn:** Stichprobenartig am 11.11.2026 gegen Suchtreffer-Auszüge geprüft (Seiten nicht vollständig gelesen): Windows-LAPS-Cmdlets, `manage-bde -protectors -adbackup`/`-forcerecovery`, `Add-Computer`, `Test-ComputerSecureChannel`, `Reset-ComputerMachinePassword`, `Checkpoint-Computer` (höchstens ein Punkt je 24 Stunden), `Get-ComputerRestorePoint`, `Restore-Computer`, `reagentc /info`, Windows-Update-Verzögerung und -Pause, Remotedesktop-Editionen, `Enable-PSRemoting`. Alles Übrige ist mit „nicht bestätigt“ oder „sinngemäß“ markiert, besonders Menünamen, erwartete Ausgaben und Befehle ohne geprüfte Quelle.
- **Fachlektorat:** Abweichungen von und Ergänzungen zum Lehrplan sind im Text gekennzeichnet (u. a. Windows PowerShell 5.1 statt PowerShell 7, Ort des BitLocker-Wiederherstellungskennworts in AD, Pfad der Update-Richtlinie, zusätzlicher Prüfpunkt `DC-M7-Ende`). Offen ist die Abweichung bei der Verzögerung von Qualitätsupdates (30 Tage im Text, 0 bis 35 in der Tabelle laut Lehrplan).
- **Support-Termine** in Modul 01 sind der Stand vom 08.11.2026 laut Lehrplan und vor jedem Gebrauch auf Microsoft Learn zu prüfen.

## Sicherheit

Die Übungen ändern Konten, Berechtigungen, Richtlinien, Verschlüsselung und Wiederherstellung und stören in Modul 05 und 12 absichtlich die Domänenbeziehung. Nur im Labor ausführen, nie auf produktiven Geräten. BitLocker (Modul 07) erst aktivieren, wenn der Wiederherstellungsschlüssel in AD nachweislich gesichert ist.

## Lizenz

Skripte und Befehle: MIT ([LICENSE](LICENSE)). Texte: CC BY 4.0 ([LICENSE-DOCS.md](LICENSE-DOCS.md)).
