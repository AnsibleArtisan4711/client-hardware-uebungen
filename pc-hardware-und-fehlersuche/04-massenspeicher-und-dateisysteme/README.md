# 04 Massenspeicher und Dateisysteme

Übung **04.1**. Geschätzte Zeit: 3 bis 5 Stunden (Lehrplan: 6 UE).

> Nicht im Labor ausgeführt. Befehle nur teilweise gegen Microsoft Learn geprüft (siehe Warnhinweis in der Übung).

| Datei | Zweck |
|---|---|
| `04.1-massenspeicher-und-dateisysteme.md` | Die Übung mit Schritten, Kontrollfragen und Musterlösung |
| `dateien/Add-TestDisk.ps1` | Legt `DatenTest.vhdx` (10 GB, dynamisch) an und hängt sie an eine ausgeschaltete VM |
| `dateien/Initialize-TestDisk.ps1` | Initialisiert die einzige RAW-Platte als GPT und formatiert sie als `Z:` (NTFS) |
| `dateien/mbr-gpt-grenzen.py` | Rechnet Grenzen von MBR, GPT und FAT32 aus (Python 3, geprüft) |
