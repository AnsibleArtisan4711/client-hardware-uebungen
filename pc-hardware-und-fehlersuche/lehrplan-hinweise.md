# Hinweise zum Lehrplan P44 (Fachlektorat)

Stand: 12.11.2026. Abweichungen und Ergänzungen der Übungen gegenüber dem Lehrplan. Der Lehrplan selbst wurde nicht verändert.

## Ergänzungen, die der Lehrplan nicht vorgibt

| Stelle | Ergänzung | Grund |
|---|---|---|
| Alle Module | Zeitangaben in Stunden aus UE zu 45 Minuten | Der Lehrplan nennt UE; die Stundenangabe ist eine Schätzung |
| Modul 01, Teil 2 | EVA-Zuordnung als Übung | Einheit 1.2 hat keine Praxisaufgabe, Kontrollfrage 3 verlangt sie |
| Modul 02, Teil 4 | Rechnung mit `bandbreiten.py` | Einheiten 2.1 und 2.2 haben keine Praxisaufgabe; die Frage zu PCIe/NVMe soll belegt werden |
| Modul 02, Teil 2 | Hinweis, dass `-BootOrder` nicht genannte Einträge entfernt | Learn (*Set-VMFirmware*, Beispiel 3) |
| Modul 03, Teile 3 und 4 | `Get-HardwareInfo.ps1`, `ram-bandbreite.py`, Kühlungstabelle | Einheiten 3.1 bis 3.3 haben keine Praxisaufgabe (3.3 Kühlung ist in Teil 4 abgedeckt) |
| Modul 04, Teile 4 und 5 | `mbr-gpt-grenzen.py`, Dateisystemwahl, SMART-Beispiel | MBR/GPT, Dateisysteme und SMART sind Lernziel ohne Aufgabe |
| Modul 04, Teil 1 | `Add-TestDisk.ps1` und `Initialize-TestDisk.ps1` als Dateien | Der Lehrplan beschreibt nur die Oberfläche; die Skripte brechen ab, wenn nicht genau eine RAW-Platte da ist |
| Modul 05, Teil 3 | Theorie zu Grafik, Laserdruck, MAC-Adresse | Einheiten 5.1 bis 5.3 haben keine Praxisaufgabe |
| Modul 06, Teil 3 | POST und Beep-Codes als Schreibaufgabe | Einheit 6.2 hat keine Praxisaufgabe |
| Modul 06 | `Get-EreignisFehler.ps1`, `linux-diagnose.sh`, Beispielausgabe | Zusatz zur Oberfläche; Ausgabe stammt aus einer Linux-Testumgebung, nicht aus Ubuntu Live |
| Modul 07, Teil 5 | `backup-mengen.py` und TRIM-Erklärung | Einheit 7.1 und 7.2 sollen Zahlen und Begründung zeigen |
| Modul 07 | `Sicherung.cmd` und `Wartung-Z.cmd` als Dateien; `Checkpoint-Computer` als Alternative | Learn: nur Client-Windows, standardmäßig ein Punkt je 24 Stunden |
| Modul 08 | Vorlage für Fallblätter, Beispiel-Entscheidungsbaum (8 Knoten) | Der Lehrplan nennt das Ziel, aber keine Lösung |

## Auffälligkeiten im Rohmaterial

- **Zeitaufwand:** Der Änderungsvermerk des Lehrplans nennt selbst, dass die Stunden für Modul 6 und 7 vielleicht nicht reichen. Die Schätzung der Übungen liegt bei 0,75 bis 1,2 Stunden je UE und ist unerprobt.
- **Modul 07, Aufgabe 3:** `robocopy /E` allein ist weder eine reine inkrementelle noch eine differentielle Sicherung nach Definition; die Übung lässt Lernende das begründen.
- **Modul 07, Aufgabe 5:** Der Rückbau löscht das Volume `Z:`. Die Übung verlangt vorher eine Prüfung des Laufwerks.
- **Modul 06:** Das „CompTIA-Modell“ mit sechs Schritten im Lehrplan stimmt in Wortlaut und Schrittzahl vermutlich nicht mit der offiziellen Fassung überein (nicht geprüft).
- **Modul 08:** Falldokumente stellt der Kursleiter; die Übung enthält eigene Beispiele.

## Vor Kursstart zu prüfen

Bezeichnung des Adapters im Gast; Bezeichnung des Secure-Boot-Status in `msinfo32`; ob `dmesg` ohne `sudo` gesperrt ist; Verhalten von Umgebungsvariablen bei der Systemwiederherstellung; Laufzeit der Evaluation; Anzeige der Cache-Größen im Task-Manager einer VM; Menütexte der deutschen Oberfläche; erlaubter Parameterwert für `-SecureBootTemplate`; ob die ESD-Verfahren eures Labors (Restladung) mit Modul 01 übereinstimmen.
