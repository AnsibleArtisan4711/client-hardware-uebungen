# Modul 3 - Betriebssysteme, Dateisysteme und lokale Verwaltung

> **Hinweis zu diesem Kapitel:** Das ist das Kapitel des Skripts „CompTIA Tech+ / ITF+ (FC0-U71): Lernskript in Modulen“, aus der LaTeX-Quelle in Markdown umgewandelt (Text und Listings unverändert, Boxen als Zitatblöcke, Aufgaben und Lösungen als nummerierte Listen). Laut Skript wurden die Python-Beispiele bei der Erstellung im Arbeitsbereich ausgeführt, die gezeigten Ausgaben stammen aus diesen Läufen; Windows- und PowerShell-Befehle wurden nicht ausgeführt. Für dieses Repository wurden die Listings **nicht erneut ausgeführt**. Prüfungsdetails, Produktnamen und Versionen ändern sich; maßgeblich sind die aktuellen Prüfungsziele (Exam Objectives) von CompTIA. Übersicht zum Modul: [README](README.md).

**Dauer:** 7 h

**Priorität:** 1 (höchste)

| Nr. | Lerneinheit                             | Dauer (h) | Prio |
|----:|:----------------------------------------|----------:|-----:|
| 3.1 | Betriebssysteme im Vergleich            |      0,75 |    1 |
| 3.2 | Bootprozess und Systemstart             |      0,75 |    2 |
| 3.3 | Dateisysteme und Ordnerstrukturen       |         1 |    1 |
| 3.4 | Benutzerkonten und Rechte               |      0,75 |    1 |
| 3.5 | GUI und Kommandozeile                   |         1 |    1 |
| 3.6 | Softwareinstallation und Updates        |      0,75 |    1 |
| 3.7 | Drucker und lokale Dienste              |      0,75 |    2 |
| 3.8 | Basis-Troubleshooting am Betriebssystem |      1,25 |    1 |
|     | **Summe**                               |     **7** |      |

Das Betriebssystem ist die Software, die aus einer Ansammlung von Bauteilen einen benutzbaren Rechner macht. Dieses Modul erklärt, was ein Betriebssystem leistet, wie es nach dem Einschalten startet, wie es Daten in Dateien und Ordnern ordnet, wer was darf, wie man es per Maus und per Texteingabe bedient, wie Software hineinkommt und auf dem neuesten Stand bleibt und wie man typische Störungen eingrenzt. Die Beispiele laufen als Python-Programme auf Windows, Linux und macOS; wo ein Befehl nur auf einem System existiert, wird das gesagt. Die Beispiele wurden auf einem Linux-System ausgeführt; reine Windows-Befehle in den Erläuterungen wurden hier nicht ausgeführt.

## 3.1 Betriebssysteme im Vergleich

Ein *Betriebssystem* (englisch *Operating System*, OS) steht zwischen der Hardware und den Anwendungen. Es erfüllt vier Hauptaufgaben. Erstens verteilt es die Rechenzeit der CPU auf die laufenden Programme (*Prozessverwaltung*), sodass viele Programme scheinbar gleichzeitig laufen. Zweitens verwaltet es den Arbeitsspeicher und gibt jedem Programm einen eigenen, abgeschotteten Bereich (*Speicherverwaltung*). Drittens organisiert es Daten auf Datenträgern in Dateien und Ordnern (*Dateisystem*). Viertens spricht es über *Treiber* mit der Hardware, damit Anwendungen nicht jedes Gerät einzeln kennen müssen. Dazu kommen die Benutzerverwaltung, die Netzwerkanbindung und die Oberfläche, über die man das System bedient.

Das Herzstück ist der *Kernel*. Er läuft mit höchsten Rechten, steuert Hardware und Ressourcen und stellt anderen Programmen über definierte Schnittstellen Dienste zur Verfügung. Alles darum herum (Oberfläche, Werkzeuge, Programme) läuft mit eingeschränkten Rechten im sogenannten Benutzerbereich. Diese Trennung ist ein wichtiges Schutzprinzip: Ein abstürzendes Programm reißt nicht das ganze System mit.

*Windows* von Microsoft ist das am weitesten verbreitete Betriebssystem auf Arbeitsplatzrechnern, besonders in Unternehmen. Es ist proprietär (der Quelltext ist nicht öffentlich), basiert auf dem NT-Kernel, nutzt als Dateisystem meist NTFS, verfügt über eine große Auswahl an Software und Treibern und wird in Firmennetzen häufig zentral über Active Directory verwaltet. *Linux* ist genau genommen der Name eines Kernels; zusammen mit Systemwerkzeugen und Oberflächen ergeben sich *Distributionen* wie Debian, Ubuntu, Fedora oder Red Hat Enterprise Linux. Linux ist quelloffen (Open Source) und überwiegt bei Servern, in der Cloud, in eingebetteten Systemen und als Grundlage von Android. *macOS* von Apple basiert auf einem Unix-Unterbau und läuft nur auf Apple-Rechnern. Es ist stark in Kreativ- und Entwicklungsumgebungen. Auf Mobilgeräten dominieren *Android* (Google, Linux-Kernel, von vielen Herstellern genutzt) und *iOS* bzw. *iPadOS* (Apple, nur auf Apple-Geräten). Mobile Betriebssysteme sind stärker abgeschottet: Apps laufen in Sandboxen, die Installation läuft meist über einen App-Store.

Bei der Wahl eines Betriebssystems zählen Einsatzzweck, vorhandene Software, Verwaltbarkeit, Hardwareunterstützung, Kosten und Know-how. Wer einen Büroarbeitsplatz mit Spezialsoftware braucht, wird sich meist an der Verfügbarkeit dieser Software orientieren. Auf Servern entscheidet oft Stabilität, Lizenzmodell und Verwaltungsaufwand. Wichtig: Die Grundkonzepte (Dateien, Prozesse, Benutzer, Rechte, Dienste) sind bei allen gleich, nur Namen und Werkzeuge unterscheiden sich. Wer eines davon wirklich verstanden hat, findet sich in den anderen schnell zurecht.

Das folgende Programm bildet den Vergleich ab: Es fragt das laufende System nach seinem Namen und nach Eigenheiten, die in der Praxis immer wieder Probleme machen, etwa dem Trennzeichen in Dateipfaden und in der Umgebungsvariablen `PATH`.

```python
import os, sys, platform
from pathlib import Path

VERGLEICH = {
    "Windows": {"Kernel": "NT",    "Dateisystem": "NTFS",       "Pakete": "winget / MSI / Store"},
    "Linux":   {"Kernel": "Linux", "Dateisystem": "ext4 u. a.", "Pakete": "apt / dnf / pacman"},
    "macOS":   {"Kernel": "XNU",   "Dateisystem": "APFS",       "Pakete": "App Store / .pkg / brew"},
}
system = platform.system()
print("Dieses System :", system, "| sys.platform =", sys.platform)
print("Pfadtrenner   :", repr(os.sep), "| Listentrenner in PATH:", repr(os.pathsep))
print("Home-Ordner   :", Path.home())
if system in VERGLEICH:
    for schluessel, wert in VERGLEICH[system].items():
        print(f"  {schluessel:12}: {wert}")
```

`platform.system()` liefert `Windows`, `Linux` oder `Darwin` (der Name unter macOS). `os.sep` ist das Trennzeichen zwischen Ordnern: unter Windows der Backslash, sonst der normale Schrägstrich. `os.pathsep` trennt die Einträge der Umgebungsvariablen `PATH`: Semikolon unter Windows, Doppelpunkt sonst. `Path.home()` gibt den persönlichen Ordner des Benutzers zurück. Das Dictionary liefert die vergleichbaren Eigenschaften zum erkannten System. Auf dem Testsystem erschienen `Linux`, der Schrägstrich, der Doppelpunkt und `/root`. Warum das wichtig ist: Programme, die Pfade als Texte mit festem Backslash zusammensetzen, funktionieren auf anderen Systemen nicht; Python-Programme nutzen deshalb `pathlib`, das den passenden Trenner selbst wählt.

### Typische Fehler.

Falsch ist die Aussage “Linux ist ein Betriebssystem, das es nur in einer Form gibt”. Richtig ist, dass es viele Distributionen mit unterschiedlichen Werkzeugen und Update-Zyklen gibt. Falsch ist auch “macOS und Linux sind dasselbe, weil beide Unix sind”: Sie teilen viele Konzepte und Befehle, unterscheiden sich aber im Kernel, im Dateisystem und in den Werkzeugen. Ein häufiger Fehler in der Praxis ist, Skripte nur für ein System zu schreiben und anzunehmen, sie liefen überall.

### Praxisbezug.

In gemischten Umgebungen laufen Arbeitsplätze unter Windows, Server unter Linux, Entwickler-Notebooks unter macOS und Mobilgeräte unter Android oder iOS. Ein IT-Support, der alle vier Welten in den Grundzügen kennt, kann Fehler schneller dem richtigen Bereich zuordnen.

> **Merke**
>
> Betriebssystem = Prozesse, Speicher, Dateisystem, Treiber, Benutzer, Oberfläche. Der Kernel läuft mit höchsten Rechten. Windows (proprietär, NT), Linux (Kernel, viele Distributionen, Open Source), macOS und iOS (Apple), Android (Linux-Kernel).

## 3.2 Bootprozess und Systemstart

Mit *Booten* bezeichnet man den Vorgang vom Einschalten bis zum nutzbaren System. Das Wort stammt von “bootstrapping”: Der Rechner zieht sich gewissermaßen an den eigenen Schnürsenkeln hoch, weil er zu Beginn nur einen kleinen fest eingebauten Startcode kennt und damit Schritt für Schritt immer größere Programme lädt.

Der Ablauf besteht aus fünf Phasen. In der ersten Phase schaltet das Netzteil die Spannungen frei, und die *Firmware* auf dem Mainboard übernimmt, entweder das ältere *BIOS* oder das moderne *UEFI* (*Unified Extensible Firmware Interface*). Sie führt den *POST* (Selbsttest, siehe Modul 02) durch, initialisiert die Grundhardware und sucht anhand der *Bootreihenfolge* ein Startmedium (Festplatte, SSD, USB-Stick, Netzwerk). In der zweiten Phase lädt die Firmware den *Bootloader* vom Startmedium. Bei Windows ist das der Windows Boot Manager, bei Linux häufig GRUB oder systemd-boot, bei macOS der Apple-eigene Startmechanismus. Der Bootloader entscheidet, welches Betriebssystem geladen wird (bei Mehrfachinstallationen zeigt er ein Auswahlmenü), und lädt in der dritten Phase den *Kernel* samt den nötigsten Treibern in den Arbeitsspeicher. In der vierten Phase startet der Kernel die Dienste und Hintergrundprogramme: Unter Linux übernimmt das heute meist *systemd*, unter Windows der Dienststeuerungs-Manager. In der fünften Phase erscheint die Anmeldung; nach dem Login lädt das System das Benutzerprofil und die Oberfläche und startet die Autostart-Programme.

BIOS und UEFI unterscheiden sich in mehreren Punkten. Das alte BIOS arbeitet mit dem Partitionsschema *MBR* (*Master Boot Record*); dessen Startcode liegt in den ersten 512 Byte des Datenträgers, er unterstützt höchstens vier primäre Partitionen und Datenträger bis 2 TiB. UEFI nutzt das Schema *GPT* (*GUID Partition Table*) mit sehr großen Datenträgern und vielen Partitionen und legt den Bootloader auf einer eigenen kleinen Partition ab, der *EFI-Systempartition* (ESP, meist mit FAT32 formatiert). Dazu kommt *Secure Boot*: Die Firmware startet nur Bootloader, die digital signiert und als vertrauenswürdig hinterlegt sind, was Schadprogramme im Startvorgang erschwert. Windows 11 verlangt UEFI mit Secure Boot und einen TPM-2.0-Baustein; das ist allgemeines Fachwissen und sollte bei Planung vor Ort in den Anforderungen von Microsoft geprüft werden.

Das folgende Beispiel liest zwei nützliche Dinge aus dem laufenden System: seit wann es läuft und, unter Linux, ob es im UEFI-Modus gestartet wurde. Unter Windows nutzt es einen Systemaufruf, der die Laufzeit seit dem Start in Millisekunden liefert.

```python
import os, platform

def laufzeit_sekunden():
    if platform.system() == "Linux":
        with open("/proc/uptime") as f:
            return float(f.read().split()[0])
    import ctypes
    return ctypes.windll.kernel32.GetTickCount64() / 1000

def boot_modus():
    if platform.system() == "Linux":
        return "UEFI" if os.path.exists("/sys/firmware/efi") else "Legacy-BIOS (oder virtuelle Maschine)"
    return "unter Windows: msinfo32, Eintrag BIOS-Modus"

sek = laufzeit_sekunden()
print(f"System laeuft seit {int(sek // 3600)} h {int(sek % 3600 // 60)} min")
print("Startmodus:", boot_modus())

PHASEN = ["Firmware (UEFI/BIOS) + POST", "Bootloader", "Kernel laden",
          "Dienste starten", "Anmeldung"]
for nr, phase in enumerate(PHASEN, 1):
    print(f"{nr}. {phase}")
```

Unter Linux enthält die Datei `/proc/uptime` als erste Zahl die Sekunden seit dem Start; das Programm rechnet sie mit ganzzahliger Division (`//`) in Stunden und mit dem Rest (`%`) in Minuten um. Unter Windows liefert `GetTickCount64` die vergangene Zeit in Millisekunden, die durch 1000 geteilt wird. Die Funktion `boot_modus` prüft unter Linux, ob der Ordner `/sys/firmware/efi` existiert; er ist nur vorhanden, wenn das System über UEFI gestartet wurde. Im Testsystem fehlte er, was zu “Legacy-BIOS (oder virtuelle Maschine)” führte. Die letzte Schleife nummeriert die fünf Phasen mit `enumerate`. Ein Rechner, der “schon drei Wochen läuft”, hat Updates oft noch nicht vollständig angewendet, weil viele Aktualisierungen erst nach einem Neustart greifen.

### Typische Fehler.

Falsch ist, bei einer Meldung wie “No bootable device” oder “Operating system not found” sofort die Festplatte für defekt zu halten. Häufige Ursachen sind eine falsche Bootreihenfolge (ein nicht startfähiger USB-Stick steht vorn), ein beschädigter Bootloader nach einem Update oder einer Zweitinstallation, ein nicht erkannter Datenträger durch ein loses Kabel oder die Umstellung zwischen UEFI und Legacy-Modus. Falsch ist auch der Glaube, das Drücken des Einschalters beende das System sauber: Hartes Ausschalten kann Dateisysteme beschädigen.

### Praxisbezug.

Beim Neuinstallieren eines Betriebssystems startet man den Rechner vom USB-Stick, indem man beim Einschalten eine Taste für das Bootmenü drückt (je nach Hersteller unter anderem Esc, F2, F10, F12 oder Entf). Im Firmenumfeld sperrt ein Firmware-Passwort oft das Ändern der Bootreihenfolge, damit niemand unbefugt von einem fremden Medium startet.

## 3.3 Dateisysteme und Ordnerstrukturen

Ein Datenträger ist zunächst nur eine große Folge von Speicherblöcken. Das *Dateisystem* (*File System*) bringt Ordnung hinein: Es legt fest, wie Daten in Dateien aufgeteilt, Ordnern zugeordnet, benannt und wiedergefunden werden. Dazu führt es ein Verzeichnis (eine Art Inhaltsverzeichnis), merkt sich die belegten und freien Blöcke und speichert zu jeder Datei *Metadaten*: Name, Größe, Zeitstempel (erstellt, geändert, zuletzt geöffnet), Besitzer und Zugriffsrechte, Attribute wie “versteckt” oder “schreibgeschützt”.

Die wichtigsten Dateisysteme sind *NTFS* (Standard bei Windows; unterstützt Rechte, Verschlüsselung, Komprimierung und ein Journal), *ext4* (Standard bei vielen Linux-Distributionen; stabil und weit verbreitet), *APFS* (Standard bei macOS und iOS, auf Flash-Speicher optimiert) sowie *FAT32* und *exFAT* für Wechseldatenträger. FAT32 ist mit fast jedem Gerät kompatibel, erlaubt aber nur Dateien bis knapp 4 GiB; exFAT hebt diese Grenze auf und eignet sich für große USB-Datenträger und Speicherkarten. Ein *Journal* ist ein Protokoll geplanter Änderungen: Bei einem Stromausfall kann das System nach dem Neustart erkennen, welche Änderung unterbrochen wurde, und das Dateisystem in einen konsistenten Zustand zurückführen. Ein Datenträger wird vor der Nutzung *partitioniert* (in Bereiche aufgeteilt) und *formatiert* (mit einem Dateisystem versehen); Schnellformatieren löscht dabei nur das Verzeichnis, nicht die Daten selbst, die somit mit Spezialwerkzeugen wiederherstellbar sein können.

Dateien liegen in *Ordnern* (Verzeichnissen), die ihrerseits in Ordnern liegen, sodass eine Baumstruktur entsteht. Die Adresse einer Datei ist ihr *Pfad*. Ein *absoluter Pfad* beginnt an der Wurzel (unter Windows mit einem Laufwerksbuchstaben wie `C:`, sonst mit dem Schrägstrich `/`); ein *relativer Pfad* wird vom aktuellen Ordner aus gelesen, wobei ein einzelner Punkt den aktuellen und zwei Punkte den übergeordneten Ordner bezeichnen. Der *Dateiname* besteht aus Namen und Erweiterung (Endung), etwa `bericht.docx`. Die Endung teilt dem System mit, welches Programm die Datei öffnen soll; sie ändert nichts am Inhalt, und Windows blendet bekannte Endungen standardmäßig aus, was bei Betrugsversuchen (etwa `rechnung.pdf.exe`) ausgenutzt wird.

Auch die Ordnerstruktur folgt einer Konvention. Unter Windows liegen Systemdateien im Ordner `C:\Windows`, Programme in `C:\Program Files` und die Daten der Benutzer in `C:\Users\Name`. Unter Linux gibt es eine einzige Baumstruktur ab `/`: `/home` für Benutzerdaten, `/etc` für Konfiguration, `/var` für veränderliche Daten wie Protokolle, `/usr` für Programme und `/tmp` für temporäre Dateien; weitere Datenträger werden an einem Ordner “eingehängt” (*gemountet*) und erscheinen dort als Unterordner. macOS verwendet `/Users` und `/Applications`. Unterschiede gibt es auch bei der Groß- und Kleinschreibung: Linux unterscheidet `Bericht.txt` und `bericht.txt`, Windows behandelt beide als denselben Namen. Windows verbietet außerdem die Zeichen `< > : " / \ | ? *` in Namen und reservierte Namen wie `CON` oder `NUL`.

Das folgende Beispiel legt in einem temporären Ordner eine kleine Struktur an, zerlegt einen Dateipfad in seine Bestandteile, liest Metadaten aus und summiert die Dateigrößen nach Endung. Das ist die Art Auswertung, die man braucht, wenn ein Laufwerk voll ist und man wissen will, was den Platz verbraucht.

```python
import tempfile, time
from pathlib import Path
from collections import Counter

with tempfile.TemporaryDirectory() as tmp:
    wurzel = Path(tmp)
    (wurzel / "Projekt" / "Doku").mkdir(parents=True)
    (wurzel / "Projekt" / "bericht.txt").write_text("Quartalsbericht " * 50)
    (wurzel / "Projekt" / "Doku" / "anleitung.pdf").write_bytes(b"%PDF" * 500)
    (wurzel / "Projekt" / "Doku" / "notiz.txt").write_text("kurz")

    datei = wurzel / "Projekt" / "bericht.txt"
    print("Name      :", datei.name)
    print("Endung    :", datei.suffix)
    print("Ohne Ende :", datei.stem)
    print("Ordner    :", datei.parent.name)
    print("Relativ   :", datei.relative_to(wurzel))
    info = datei.stat()
    print("Groesse   :", info.st_size, "Byte")
    print("Geaendert :", time.strftime("%Y-%m-%d %H:%M", time.localtime(info.st_mtime)))

    nach_endung = Counter()
    for pfad in wurzel.rglob("*"):
        if pfad.is_file():
            nach_endung[pfad.suffix] += pfad.stat().st_size
    for endung, groesse in nach_endung.most_common():
        print(f"{endung:6} {groesse:6} Byte")
```

`tempfile.TemporaryDirectory()` legt einen Ordner an und löscht ihn am Ende des `with`-Blocks automatisch samt Inhalt; so bleibt nichts zurück. Der Operator `/` verbindet Pfadteile, `mkdir(parents=True)` legt auch fehlende übergeordnete Ordner an. `write_text` und `write_bytes` schreiben Dateien. Die Eigenschaften `name`, `suffix`, `stem` und `parent` zerlegen den Pfad; `relative_to` liefert den Pfad vom Startordner aus. `stat()` gibt die Metadaten zurück, zum Beispiel Größe in Byte (hier 800, weil “Quartalsbericht ” 16 Zeichen hat und fünfzigfach wiederholt wird) und den Zeitstempel der letzten Änderung. `rglob("*")` durchsucht den gesamten Baum rekursiv, `is_file()` filtert Ordner heraus, und der `Counter` addiert die Größen je Endung: Im Beispiel entfallen 2000 Byte auf `.pdf` und 804 Byte auf `.txt`.

### Typische Fehler.

Falsch ist die Gleichsetzung von Ordnern und “Verzeichnissen im Browser”; Ordner sind Teil des Dateisystems. Falsch ist, eine Datei durch Umbenennen der Endung “umzuwandeln”: Ein Bild, das man von `.png` in `.jpg` umbenennt, bleibt ein PNG. Ein klassischer Fehler beim USB-Stick ist die Meldung “Datei ist zu groß für das Zielsystem”: Der Stick ist mit FAT32 formatiert und kann keine Datei über 4 GiB speichern. Richtig wäre exFAT oder NTFS. Beim Entfernen von Datenträgern führt das “Auswerfen” dazu, dass das System noch ausstehende Schreibvorgänge abschließt; wer den Stick einfach zieht, riskiert beschädigte Daten.

### Praxisbezug.

Fast jede Support-Anfrage berührt das Dateisystem: “Ich finde meine Datei nicht”, “Das Laufwerk ist voll”, “Ich kann die Datei nicht speichern, der Pfad ist zu lang”. Ein Support-Mitarbeiter denkt in Pfaden: Wo liegt die Datei, wer darf darauf zugreifen, wie viel Platz ist frei? Das Beispiel oben ist die Grundlage der Programme, die in Firmen “Speicherfresser” aufspüren.

## 3.4 Benutzerkonten und Rechte

Moderne Betriebssysteme sind *Mehrbenutzersysteme*: Mehrere Personen können sich anmelden, jede mit eigenem Profil, eigenen Dateien und eigenen Einstellungen, und das System entscheidet bei jeder Aktion, ob sie erlaubt ist. Grundlage ist das *Benutzerkonto*. Ein *lokales Konto* existiert nur auf einem einzelnen Gerät, ein *Konto einer Domäne* oder eines Cloud-Verzeichnisses wird zentral verwaltet und gilt auf vielen Geräten (Modul 05 und 10). Unter Windows gibt es zusätzlich Konten, die mit einem Microsoft-Konto verknüpft sind.

Wichtig ist die Unterscheidung nach *Berechtigungsstufen*. Ein *Standardbenutzer* darf seine eigenen Dateien bearbeiten und installierte Programme verwenden, aber keine systemweiten Einstellungen verändern und keine Software für alle installieren. Ein *Administrator* darf Systemeinstellungen ändern, Programme installieren, Konten verwalten und auf alle Dateien zugreifen. Unter Linux und macOS entspricht dem der *root*-Benutzer (Superuser), der in der Praxis über das Kommando `sudo` nur für einzelne Befehle benutzt wird. Windows verwendet die *Benutzerkontensteuerung* (UAC), die auch bei Administratorkonten für riskante Aktionen eine Bestätigung verlangt. Dahinter steht das *Prinzip der minimalen Rechte* (*Least Privilege*): Jeder Benutzer und jedes Programm erhält nur die Rechte, die er tatsächlich braucht. Das begrenzt den Schaden bei Fehlern und Angriffen. Ein Administratorkonto sollte deshalb nur für Verwaltungsaufgaben und nie für E-Mail und Surfen verwendet werden.

Rechte an Dateien und Ordnern legt man über *Berechtigungen* fest. Unter Linux und macOS gelten drei Gruppen: der *Besitzer* (User), die *Gruppe* und *alle anderen* (Others), jeweils mit den drei Rechten *Lesen* (r), *Schreiben* (w) und *Ausführen* (x). Das ergibt eine Darstellung wie `rw-r-----`: Der Besitzer darf lesen und schreiben, die Gruppe nur lesen, alle anderen nichts. Als Zahl (oktal) werden die Rechte durch die Werte 4 (lesen), 2 (schreiben) und 1 (ausführen) addiert; `640` bedeutet also Besitzer 6 (lesen und schreiben), Gruppe 4 (lesen), andere 0. Windows (NTFS) arbeitet mit *Zugriffssteuerungslisten* (*ACL*): Zu jeder Datei oder jedem Ordner gibt es eine Liste, die einzelnen Benutzern oder Gruppen Rechte wie Lesen, Ändern oder Vollzugriff erteilt oder verweigert. Rechte vererben sich standardmäßig von Ordnern auf ihren Inhalt. Wichtig ist: Ein ausdrückliches Verweigern setzt sich über Erlauben durch, und bei Netzwerkfreigaben gilt die jeweils strengere Regel aus Freigabe- und Dateirechten.

Wie das aussieht, zeigt das folgende Beispiel. Es legt eine Datei an, setzt nacheinander vier Rechtekombinationen und gibt jeweils die symbolische Darstellung sowie die Antworten auf die Frage “Wer darf lesen?” aus.

```python
import os, stat, tempfile
from pathlib import Path

with tempfile.TemporaryDirectory() as tmp:
    datei = Path(tmp) / "geheim.txt"
    datei.write_text("vertraulich")
    for modus in (0o644, 0o600, 0o640, 0o755):
        os.chmod(datei, modus)
        m = datei.stat().st_mode
        print(f"{modus:o} -> {stat.filemode(m)}  "
              f"Besitzer lesen: {bool(m & stat.S_IRUSR)}, "
              f"Gruppe lesen: {bool(m & stat.S_IRGRP)}, "
              f"Andere lesen: {bool(m & stat.S_IROTH)}")

print("Effektive Benutzer-ID:",
      os.geteuid() if hasattr(os, "geteuid") else "unter Windows nicht vorhanden")
```

Die Zahlen mit `0o` sind oktale Zahlen, wie sie bei Dateirechten üblich sind. `os.chmod` setzt die Rechte, `stat.filemode` macht daraus die gewohnte Schreibweise wie `-rw-r-----`. Das Zeichen `&` verknüpft die Rechte bitweise mit einer Konstanten: `m & stat.S_IRUSR` ist nur dann ungleich null, wenn der Besitzer lesen darf, und `bool()` macht daraus `True` oder `False`. Die Ausgabe zeigt zum Beispiel, dass bei 600 nur der Besitzer lesen darf (`-rw-------`) und bei 640 auch die Gruppe (`-rw-r-----`). Die letzte Zeile gibt die Benutzer-ID aus, mit der das Programm läuft; sie ist 0, wenn es als *root* läuft, wie im Testsystem. Unter Windows existiert die Funktion nicht, weshalb die Abfrage mit `hasattr` geschützt ist. Windows-Rechte prüft man dort mit `icacls Dateiname` und dem Reiter “Sicherheit” in den Eigenschaften.

### Typische Fehler.

Falsch ist, jedem Benutzer volle Administratorrechte zu geben, “damit alles funktioniert”: Ein Schadprogramm, das der Benutzer startet, erbt dann diese Rechte. Falsch ist ebenso, das Problem “Zugriff verweigert” durch “Rechte für Jeden auf Vollzugriff” zu lösen; richtig ist, die benötigte Gruppe mit dem minimal nötigen Recht zu berechtigen. Ein Fehler unter Linux ist `chmod 777`: Es erlaubt allen alles und ist selten die Lösung. Ein typischer Stolperstein bei Windows-Ordnern ist, dass man Vererbung übersieht und Rechte auf dem Ordner ändert, ohne dass der Inhalt sie erhält (oder umgekehrt).

### Praxisbezug.

Beim Anlegen eines Kontos für einen neuen Mitarbeiter wird ein Standardbenutzer angelegt und einer Gruppe zugeordnet (zum Beispiel “Buchhaltung”), die auf die passenden Ordner Zugriff hat. Wird die Person versetzt, wechselt die Gruppe, nicht jedes einzelne Recht. So bleiben Berechtigungen nachvollziehbar.

> **Merke**
>
> Standardbenutzer = eigene Dateien, Administrator/root = systemweite Änderungen. Least Privilege: so wenig Rechte wie möglich, so viele wie nötig. Linux/macOS: rwx für Besitzer, Gruppe, andere (Zahl 4/2/1). Windows: ACLs mit Vererbung; Verweigern geht vor Erlauben.

## 3.5 GUI und Kommandozeile

Man kann ein Betriebssystem auf zwei Arten bedienen. Die *grafische Oberfläche* (*GUI*, Graphical User Interface) arbeitet mit Fenstern, Symbolen, Menüs und Maus oder Touch: Explorer unter Windows, Finder unter macOS, Dateimanager unter Linux. Sie ist leicht erlernbar und gut für Entdecken und gelegentliche Aufgaben. Die *Kommandozeile* (*CLI*, Command Line Interface) nimmt Befehle als Text entgegen: Man tippt, bestätigt mit Enter und erhält eine Textantwort. Das wirkt spröde, ist aber für Fachleute oft schneller, genauer und vor allem wiederholbar: Ein Befehl lässt sich speichern, in ein Skript einbauen, auf hundert Rechnern ausführen und dokumentieren. Viele Serverbetriebssysteme haben gar keine grafische Oberfläche.

Das Programm, das Befehle entgegennimmt, heißt *Shell*. Unter Windows gibt es die klassische Eingabeaufforderung (*cmd.exe*) und die modernere *PowerShell*, die nicht nur Text, sondern Objekte weitergibt. Unter Linux und macOS sind *bash* oder *zsh* verbreitet, in einer Anwendung namens *Terminal*. Alle Shells bieten dieselben Grundideen: einen aktuellen Ordner, Befehle mit Optionen und Argumenten, *Platzhalter* (`*` steht für beliebig viele Zeichen, `?` für ein Zeichen), *Umleitung* (`>` schreibt die Ausgabe in eine Datei, `>>` hängt an) und *Pipes* (`|` reicht die Ausgabe eines Befehls als Eingabe an den nächsten weiter). Die Tabulatortaste vervollständigt Namen, die Pfeiltasten holen frühere Befehle zurück, und Hilfe gibt es mit `help` bzw. `Get-Help` (Windows) und `man` (Linux, macOS).

| Aufgabe               | CMD                  | PowerShell            | bash/zsh  |
|:----------------------|:---------------------|:----------------------|:----------|
| Ordnerinhalt anzeigen | `dir`             | `Get-ChildItem` (`ls`)   | `ls -l`  |
| Ordner wechseln       | `cd`             | `Set-Location` (`cd`)   | `cd`  |
| Aktueller Ordner      | `cd`             | `Get-Location` (`pwd`)   | `pwd`  |
| Ordner anlegen        | `mkdir`             | `New-Item -Type Directory`              | `mkdir`  |
| Datei kopieren        | `copy`             | `Copy-Item`              | `cp` |
| Datei löschen         | `del`            | `Remove-Item`             | `rm` |
| Inhalt anzeigen       | `type`            | `Get-Content` (`cat`) | `cat` |
| Text suchen           | `findstr`            | `Select-String`             | `grep` |
| Hilfe                 | `help`, `Befehl /?` | `Get-Help`             | `man` |

Das folgende Beispiel zeigt eine typische Sitzung in der bash. Es legt einen Ordner mit drei Textdateien an, listet sie, sucht ein Wort darin und zählt Dateien mit einer Pipe.

```bash
mkdir -p ~/demo/berichte && cd ~/demo
echo "Umsatz Q1: 120" > berichte/q1.txt
echo "Umsatz Q2: 150" > berichte/q2.txt
echo "Fehler: Drucker offline" > berichte/log.txt
pwd
ls -l berichte
cat berichte/q1.txt
grep "Umsatz" berichte/*.txt
ls berichte | wc -l
cp berichte/q1.txt berichte/q1_kopie.txt
rm berichte/q1_kopie.txt
```

Die erste Zeile legt mit `mkdir -p` den Ordner samt Unterordner an (die Option `-p` erzeugt fehlende Zwischenordner) und wechselt mit `cd` dorthin; das `&&` führt den zweiten Befehl nur aus, wenn der erste gelungen ist. Die `echo`-Zeilen schreiben mit der Umleitung `>` Text in Dateien. `pwd` zeigt den aktuellen Ordner, `ls -l` listet den Inhalt mit Rechten, Besitzer, Größe und Datum (die Ausgabe zeigte drei Dateien von 15 bis 24 Byte). `cat` gibt eine Datei aus, `grep "Umsatz" berichte/*.txt` durchsucht alle Textdateien nach dem Wort und liefert zwei Treffer mit Dateinamen; die dritte Datei enthält das Wort nicht. In der Zeile mit der Pipe liefert `ls` die Dateinamen an `wc -l`, das die Zeilen zählt, hier also drei Dateien. Zuletzt wird eine Datei kopiert und wieder gelöscht. In der PowerShell lautet die entsprechende Folge etwa:

```powershell
New-Item -ItemType Directory -Path "$HOME\demo\berichte" -Force
Set-Location "$HOME\demo"
"Umsatz Q1: 120" | Set-Content berichte\q1.txt
"Umsatz Q2: 150" | Set-Content berichte\q2.txt
Get-ChildItem berichte | Measure-Object
Select-String -Path berichte\*.txt -Pattern "Umsatz"
```

Dieser Ablauf wurde in der Testumgebung nicht ausgeführt, folgt aber der dokumentierten Syntax der PowerShell. Die Pipe `|` reicht in der PowerShell Objekte weiter: `Get-ChildItem` liefert Datei-Objekte, `Measure-Object` zählt sie. `Select-String` entspricht `grep`. Zeichenketten in doppelten Anführungszeichen werden bearbeitet (`$HOME` wird durch den Pfad ersetzt), in einfachen bleiben sie unverändert.

### Typische Fehler.

Falsch ist, Befehle aus Anleitungen blind zu kopieren: Besonders `rm -rf` unter Linux und `Remove-Item -Recurse -Force` unter Windows löschen ohne Rückfrage und ohne Papierkorb. Falsch sind außerdem Pfade mit Leerzeichen ohne Anführungszeichen: `cd Eigene Dateien` wird als zwei Argumente gelesen, richtig ist `cd "Eigene Dateien"`. Ein Missverständnis ist, die Kommandozeile sei “nur für Profis”; für Aufgaben wie “Welche Dateien sind größer als 1 GB?” ist sie dem Klicken oft überlegen. Ein weiterer Fehler ist, einen Befehl auszuführen, ohne ihn verstanden zu haben.

### Praxisbezug.

Im Support lässt man sich über das Terminal Informationen schicken, etwa die Ausgabe von `ipconfig` oder `systeminfo`. Administratoren arbeiten per Fernzugriff über SSH auf Servern meist nur in der Shell. Wer Befehle in eine Textdatei schreibt und sie als Skript ausführt (Modul 07 und 12), automatisiert wiederkehrende Arbeiten.

## 3.6 Softwareinstallation und Updates

Software kommt auf vier üblichen Wegen auf einen Rechner. Beim *Installationsprogramm* (unter Windows `.exe` oder `.msi`, unter macOS `.dmg` oder `.pkg`, unter Linux `.deb` oder `.rpm`) kopiert ein Assistent die Dateien an die richtige Stelle, legt Verknüpfungen an und trägt Einstellungen ein. Ein *App-Store* (Microsoft Store, Mac App Store, Google Play, Apple App Store) bietet geprüfte Programme aus einer zentralen Quelle mit automatischen Updates. Ein *Paketmanager* ist ein Werkzeug, das Software aus Paketquellen (*Repositories*) per Befehl installiert, aktualisiert und entfernt, samt benötigter Abhängigkeiten: `apt` und `dnf` unter Linux, `brew` unter macOS, `winget` unter Windows. *Portable Software* läuft ohne Installation direkt aus einem Ordner.

Jede Installation ist ein Vertrauensakt, denn die Software läuft mit den Rechten des Benutzers oder, bei Installation für alle, des Administrators. Deshalb gilt: nur aus vertrauenswürdigen Quellen installieren, vorzugsweise vom Hersteller oder aus der offiziellen Paketquelle. Hilfen sind die *digitale Signatur* (der Hersteller bestätigt kryptografisch, dass das Programm von ihm stammt und unverändert ist; Windows zeigt bei unsignierter Software einen Warnhinweis) und die *Prüfsumme* (ein Hashwert wie SHA-256, den der Hersteller veröffentlicht; man berechnet ihn für die heruntergeladene Datei und vergleicht ihn). Stimmen die Werte nicht überein, wurde die Datei verändert oder fehlerhaft heruntergeladen. Vor Installationen sind außerdem die Systemvoraussetzungen zu prüfen (Betriebssystem, Speicherplatz, Architektur 32/64 Bit) und die Lizenzbedingungen zu beachten.

Software veraltet, und mit der Zeit werden Fehler und Sicherheitslücken bekannt. Hersteller liefern deshalb *Updates*. Man unterscheidet *Patches* (gezielte Korrekturen, oft Sicherheits- oder Fehlerkorrekturen), *Updates* (Aktualisierungen innerhalb einer Hauptversion, auch mit kleinen Verbesserungen) und *Upgrades* (Wechsel auf eine neue Hauptversion mit neuen Funktionen und mitunter größeren Änderungen). Viele Programme nummerieren nach dem Muster *Hauptversion.Nebenversion.Patch*, zum Beispiel 2.10.1. Microsoft veröffentlicht Sicherheitsupdates traditionell am zweiten Dienstag jedes Monats, dem *Patch Tuesday*; Unternehmen planen ihre Wartungsfenster danach. Wichtig ist das Patchen deshalb, weil Angreifer bekannte Lücken ausnutzen, sobald Details veröffentlicht sind; die Zeit zwischen Veröffentlichung eines Patches und seiner Installation ist das Zeitfenster der Angreifer.

> **Ergänzung aus der Nachrecherche**
>
> Nach der Microsoft-Support-Dokumentation endete der Support für Windows 10 am 14.10.2025. Für Privatkunden gab es ein zeitlich begrenztes Programm für erweiterte Sicherheitsupdates (ESU); als Enddatum wird auf Microsoft-Seiten der 13.10.2026 genannt (die abgerufene Q&A-Seite weist selbst darauf hin, dass nicht alle Antworten dort von Microsoft stammen und auf den Support-Seiten gegenzuprüfen sind). Geräte, die danach weiterhin Windows 10 ohne Updates nutzen, sind ein bekanntes Sicherheitsrisiko. Zum Zeitpunkt dieses Skripts (24.10.2026) ist diese Frist also gerade abgelaufen; maßgeblich sind die aktuellen Angaben von Microsoft. Ein weiterer Termin: Der Patch Tuesday fällt laut einer Fachseite (TechTarget) auf den zweiten Dienstag im Monat und ist damit rechnerisch bestimmbar.

Das folgende Beispiel zeigt drei kleine, aber wichtige Werkzeuge: den Vergleich von Versionsnummern, die Prüfung einer Datei mit SHA-256 und die Berechnung des Patch Tuesday.

```python
import hashlib, calendar, tempfile
from pathlib import Path

def version_tupel(text):
    return tuple(int(teil) for teil in text.split("."))

def update_noetig(installiert, verfuegbar):
    return version_tupel(installiert) < version_tupel(verfuegbar)

print(update_noetig("2.9.10", "2.10.0"))
print("2.9.10" < "2.10.0")

with tempfile.TemporaryDirectory() as tmp:
    installer = Path(tmp) / "setup.bin"
    installer.write_bytes(b"Beispielinhalt des Installers")
    erwartet = hashlib.sha256(b"Beispielinhalt des Installers").hexdigest()
    echt = hashlib.sha256(installer.read_bytes()).hexdigest()
    print("Integritaet OK" if echt == erwartet else "ACHTUNG: Datei veraendert")
    installer.write_bytes(b"Beispielinhalt des Installers!")
    neu = hashlib.sha256(installer.read_bytes()).hexdigest()
    print("nach Aenderung:", "OK" if neu == erwartet else "ACHTUNG: Datei veraendert")

def zweiter_dienstag(jahr, monat):
    dienstage = [t for t in calendar.Calendar().itermonthdates(jahr, monat)
                 if t.month == monat and t.weekday() == 1]
    return dienstage[1]

for m in (10, 11, 12):
    print(zweiter_dienstag(2026, m).strftime("%d.%m.%Y"), "(Patch Tuesday)")
```

`version_tupel` zerlegt “2.10.1” an den Punkten und wandelt jedes Stück in eine Zahl; Python vergleicht Tupel Element für Element. Die erste Ausgabe ist `True`, weil 2.9.10 vor 2.10.0 liegt. Die zweite Ausgabe ist `False`: Der Vergleich der Texte “2.9.10” und “2.10.0” geschieht Zeichen für Zeichen, und die “9” steht hinter der “1”, sodass der Text-Vergleich das falsche Ergebnis liefert. Das ist ein klassischer Fehler im Umgang mit Versionsnummern. Im mittleren Teil berechnet `hashlib.sha256` die Prüfsumme; stimmt sie mit der erwarteten überein, ist die Datei unverändert. Nach Änderung eines einzigen Zeichens weicht sie komplett ab, was das Ergebnis “ACHTUNG” zeigt. Der letzte Teil sammelt alle Dienstage des Monats und liefert den zweiten: für Oktober, November und Dezember 2026 der 13.10., der 10.11. und der 8.12.

### Typische Fehler.

Falsch ist, Software aus einem Suchergebnis “Download” auf einer Seite unbekannter Herkunft zu installieren; häufig sind es gefälschte Installer mit Zusatzprogrammen. Falsch ist es, Updates dauerhaft aufzuschieben “weil es ja läuft”. Ebenso falsch ist, ein Update ohne Vorbereitung auf einen wichtigen Rechner zu spielen: Vor größeren Änderungen sichert man Daten und erzeugt einen Wiederherstellungspunkt. Und ein Klassiker: Installationsfenster einfach durchklicken und dabei mitinstallierte Zusatzprogramme bestätigen.

### Praxisbezug.

In Unternehmen übernehmen zentrale Werkzeuge die Verteilung. Pilotgruppen erhalten Updates zuerst, danach folgt die Breite, damit ein fehlerhaftes Update nicht alle trifft. Für den Heimanwender heißt das: automatische Updates einschalten und das System regelmäßig neu starten.

## 3.7 Drucker und lokale Dienste

Drucker gehören zu den häufigsten Störungsquellen im Büro, und an ihnen lässt sich ein grundlegendes Konzept erklären: das des *Dienstes*. Ein Dienst (unter Windows *Service*, unter Linux *Daemon*) ist ein Programm, das im Hintergrund läuft, oft ohne Oberfläche, und andere Programme bedient. Beim Drucken arbeitet der *Druckwarteschlangen-Dienst* (*Print Spooler*): Ein Programm übergibt das Dokument nicht direkt an den Drucker, sondern an den Spooler, der es in einer *Warteschlange* (*Queue*) ablegt und nacheinander an den Drucker sendet. Der Vorteil: Das Programm ist sofort wieder frei, und mehrere Aufträge von mehreren Benutzern werden geordnet abgearbeitet. Ein hängender Auftrag am Anfang der Schlange blockiert aber alle folgenden.

Ein Drucker wird durch einen *Treiber* angesprochen (Modul 02), der das Dokument in die Sprache des Druckers übersetzt, und einen *Anschluss*: lokal über USB, im Netzwerk über eine IP-Adresse. Bei einem *Netzwerkdrucker* läuft die Verbindung meist über das Internet Printing Protocol (IPP, Port 631) oder die direkte Übertragung an Port 9100 (“RAW”/JetDirect); unter Linux und macOS verwaltet das Drucksystem CUPS die Warteschlangen. Der *Standarddrucker* ist der Drucker, an den Aufträge gehen, wenn man keinen auswählt; fehlerhafte Standarddrucker, die nicht mehr existieren, sind eine häufige Ursache für “Drucken geht nicht”. Mehrere Benutzer können sich einen Drucker über eine *Freigabe* teilen.

Dienste allgemein haben einen Zustand (läuft, gestoppt) und einen *Starttyp*: automatisch (startet mit dem System), manuell (wird bei Bedarf gestartet) oder deaktiviert. Dienste können voneinander abhängen, sodass der Ausfall eines Dienstes weitere mitreißt. Unter Windows verwaltet man sie in der Anwendung `services.msc` oder mit `Get-Service`, unter Linux mit `systemctl`, unter macOS mit `launchctl`. Dienste laufen häufig mit weitreichenden Rechten; deshalb sollten nicht benötigte Dienste abgeschaltet werden (*Hardening*, Modul 10).

Das folgende Beispiel simuliert eine Druckwarteschlange und zeigt, wie ein einzelner fehlerhafter Auftrag alle folgenden blockiert und wie man ihn entfernt. Anschließend prüft das Programm mit einem Netzwerk-Verbindungstest, ob auf dem eigenen Rechner die typischen Druckports erreichbar sind.

```python
import socket
from collections import deque

class Warteschlange:
    def __init__(self):
        self.jobs = deque()
        self.naechste_id = 1
    def senden(self, dokument, seiten):
        self.jobs.append({"id": self.naechste_id, "dok": dokument,
                          "seiten": seiten, "status": "wartet"})
        self.naechste_id += 1
    def drucke_naechsten(self, drucker_online=True):
        if not self.jobs:
            return "Warteschlange leer"
        job = self.jobs[0]
        if not drucker_online:
            job["status"] = "Fehler: Drucker offline"
            return f"Job {job['id']} blockiert die Schlange"
        self.jobs.popleft()
        return f"Job {job['id']} '{job['dok']}' gedruckt ({job['seiten']} Seiten)"

q = Warteschlange()
q.senden("Rechnung.pdf", 2)
q.senden("Praesentation.pptx", 30)
q.senden("Brief.docx", 1)
print(q.drucke_naechsten())
print(q.drucke_naechsten(drucker_online=False))
print([(j["id"], j["status"]) for j in q.jobs])
q.jobs.popleft()
print(q.drucke_naechsten())

def port_offen(host, port, timeout=0.5):
    with socket.socket() as s:
        s.settimeout(timeout)
        return s.connect_ex((host, port)) == 0

for port, name in [(631, "IPP/CUPS"), (9100, "RAW/JetDirect"), (515, "LPD")]:
    print(f"{name:14} Port {port:4}: {'offen' if port_offen('127.0.0.1', port) else 'zu'}")
```

Die Klasse `Warteschlange` nutzt eine `deque`, eine Datenstruktur, die an beiden Enden effizient hinzufügt und entfernt; hinten wird eingereiht, vorne entnommen (*First in, first out*). `senden` legt einen Auftrag mit fortlaufender Nummer an. `drucke_naechsten` nimmt den vordersten Auftrag: Ist der Drucker online, wird er entfernt und “gedruckt”; ist er offline, bleibt der Auftrag stehen und erhält den Status “Fehler”, sodass auch alle dahinter wartenden Aufträge nicht drankommen. Das Hauptprogramm druckt Auftrag 1 erfolgreich und läuft dann mit Auftrag 2 in den Fehler; die Statusausgabe zeigt Auftrag 2 als fehlerhaft und Auftrag 3 als wartend. Erst das Entfernen des blockierenden Auftrags (`popleft()`) gibt die Schlange wieder frei, und Auftrag 3 wird gedruckt. In der Praxis entspricht das dem Abbrechen des Auftrags in der Druckerwarteschlange. Der zweite Teil nutzt `socket.connect_ex`, das die Verbindung versucht und bei Erfolg die Zahl 0 zurückgibt. Im Testsystem war keiner der Ports offen, weil dort kein Druckdienst läuft.

Hängt unter Windows die gesamte Druckfunktion, hilft oft das Neustarten des Dienstes. Die Befehle dafür (in einer Eingabeaufforderung mit Administratorrechten) lauten `net stop spooler` und danach `net start spooler`; vorher kann man hängende Aufträge im Ordner der Druckwarteschlange löschen. Diese Befehle wurden hier nicht ausgeführt; sie gehören zum bekannten Standardvorgehen bei Windows.

### Typische Fehler.

Falsch ist, bei “Drucken geht nicht” sofort den Treiber neu zu installieren. Richtig ist, zuerst Einfaches zu prüfen: Ist der Drucker an und online, hat er Papier und Toner, ist er im Netz erreichbar, ist er als Standarddrucker gewählt, hängt ein Auftrag in der Schlange? Falsch ist auch, einen Dienst “zur Sicherheit” auf manuell oder deaktiviert zu setzen, ohne zu wissen, wer davon abhängt. Ein Praxisfehler bei Netzwerkdruckern ist ein Drucker mit wechselnder IP-Adresse: Wenn er per DHCP eine neue Adresse bekommt, finden ihn die Rechner nicht mehr; Drucker sollten eine feste Adresse oder eine Reservierung haben (Modul 04).

### Praxisbezug.

Beim Einrichten eines Netzwerkdruckers werden Treiber und Anschluss gewählt, eine Testseite gedruckt und die Freigabe für die richtige Gruppe gesetzt. Im Support reduziert eine einfache Prüfreihenfolge (Gerät, Netz, Dienst, Treiber) die Fehlersuche erheblich.

## 3.8 Basis-Troubleshooting am Betriebssystem

Fehler am Betriebssystem äußern sich in wenigen typischen Symptomen: Das System *friert ein* (reagiert nicht mehr), ein einzelnes Programm *stürzt ab*, das System zeigt einen *Bluescreen* (unter Windows ein Stoppfehler mit blauem Bildschirm) oder einen *Kernel Panic* (unter Linux und macOS), das System *startet nicht*, oder es ist dauerhaft *langsam*. Wichtiger als das Auswendiglernen von Fehlern ist ein systematisches Vorgehen. Erstens wird das Symptom genau erfasst: Was genau passiert, seit wann, wie oft, nach welcher Änderung (neues Programm, Update, neuer Treiber, neue Hardware)? Zweitens wird zwischen Hardware und Software getrennt: Treten die Probleme in allen Programmen auf, mit allen Benutzern, auch im abgesicherten Modus? Drittens wird die einfachste mögliche Ursache zuerst geprüft und jeweils nur eine Änderung vorgenommen.

Das wichtigste Werkzeug ist die Beobachtung. Der *Task-Manager* (Windows, Aufruf mit Strg+Umschalt+Esc), die *Aktivitätsanzeige* (macOS) oder `top` bzw. `htop` (Linux) zeigen laufende Programme mit Auslastung von CPU, Arbeitsspeicher, Datenträger und Netzwerk. Ein einzelnes Programm, das einen Kern voll beansprucht, lässt sich dort beenden. Der zweite Helfer sind die *Protokolle*: Unter Windows zeigt die *Ereignisanzeige* Fehler, Warnungen und Informationen des Systems und der Anwendungen; unter Linux ruft `journalctl` die Systemmeldungen ab; unter macOS bietet die Konsole sie an. Die Meldungen enthalten Zeitpunkt, Quelle, Schweregrad und meist einen Fehlercode, nach dem man in der Herstellerdokumentation suchen kann.

Als Neustart-Strategien gelten: zuerst ein regulärer *Neustart*, der viele flüchtige Fehler beseitigt (und Updates abschließt), dann ein Start im *abgesicherten Modus*. Der abgesicherte Modus (*Safe Mode*) lädt nur die nötigsten Treiber und Dienste; funktioniert das System dort, liegt die Ursache bei einem nachträglich installierten Treiber oder Programm. Unter Windows erreicht man ihn bei Startproblemen über die Wiederherstellungsumgebung (Neustart bei gehaltener Umschalt-Taste, dann “Problembehandlung”, “Erweiterte Optionen”, “Starteinstellungen”). Dort stehen auch *Systemwiederherstellung* (Zurücksetzen auf einen früheren Zustand), *Starthilfe* und *Zurücksetzen des PC* bereit. Werkzeuge für Systemdateien sind `sfc /scannow` (prüft und repariert geschützte Windows-Dateien) und `chkdsk` (prüft das Dateisystem); sie sind aus der Kommandozeile mit Administratorrechten aufzurufen. Ein Bluescreen nennt einen Stoppcode (zum Beispiel `CRITICAL_PROCESS_DIED`); der Code und der zuletzt installierte Treiber oder das Update geben meist die Richtung vor.

Das folgende Beispiel wertet eine kleine Protokolldatei aus. Es zählt die Meldungen nach Schweregrad, ermittelt den häufigsten Fehler und nennt dessen Zeitpunkte. Diese Auswertung ersetzt zwar nicht die Ereignisanzeige, zeigt aber, wie man in großen Protokollen Muster findet.

```python
import re
from collections import Counter

LOG = """2026-10-24 08:01:12 INFO  Dienst gestartet: Spooler
2026-10-24 08:03:40 WARN  Datentraeger C: 91 Prozent belegt
2026-10-24 08:15:02 ERROR Anwendung buero.exe abgestuerzt (Code 0xC0000005)
2026-10-24 08:15:09 INFO  Anwendung buero.exe neu gestartet
2026-10-24 09:42:31 ERROR Treiber nvlddmkm antwortet nicht mehr
2026-10-24 09:42:40 ERROR Anwendung buero.exe abgestuerzt (Code 0xC0000005)
2026-10-24 10:05:00 WARN  Windows-Update wartet auf Neustart
2026-10-24 11:30:11 ERROR Anwendung buero.exe abgestuerzt (Code 0xC0000005)
"""
muster = re.compile(r"^(\S+ \S+) (INFO|WARN|ERROR)\s+(.*)$")
stufen = Counter()
fehler = Counter()
zeiten = {}
for zeile in LOG.splitlines():
    m = muster.match(zeile)
    if not m:
        continue
    zeit, stufe, text = m.groups()
    stufen[stufe] += 1
    if stufe == "ERROR":
        fehler[text] += 1
        zeiten.setdefault(text, []).append(zeit[11:16])

print("Stufen:", dict(stufen))
text, anzahl = fehler.most_common(1)[0]
print(f"Haeufigster Fehler ({anzahl}x): {text}")
print("Zeitpunkte:", ", ".join(zeiten[text]))
```

Die Protokolldatei steht hier als Text im Programm. Der *reguläre Ausdruck* (`re.compile`) beschreibt das Muster einer Zeile: zwei durch Leerzeichen getrennte Wörter für Datum und Uhrzeit (`\S+ \S+`), dann eine der drei Stufen, dann beliebig viel Text. Mit `m.groups()` erhält man die drei Teile getrennt. Die Zähler führen buch: `stufen` zählt alle Meldungen (zwei INFO, zwei WARN, vier ERROR), `fehler` zählt die Texte der Fehler. `most_common(1)` liefert den häufigsten, hier den Absturz von `buero.exe` mit dem Code `0xC0000005` (dreimal; ein Zugriffsfehler im Speicher) um 08:15, 09:42 und 11:30. `setdefault` legt für jeden Fehlertext bei Bedarf eine leere Liste an und fügt die Uhrzeit hinzu. Daraus lässt sich ableiten: Die Abstürze häufen sich bei einem Programm, und zwischendurch meldet der Grafiktreiber einen Fehler, deshalb ist der Grafiktreiber als Kandidat zu prüfen, ebenso eine fehlerhafte Programmversion. Wichtig ist, dass man aus der Auswertung eine Hypothese ableitet, die man dann testet, nicht ein Urteil.

### Typische Fehler.

Falsch ist, bei jedem Problem das Betriebssystem neu zu installieren: Das beseitigt zwar Ursachen, vernichtet aber Spuren und kostet Zeit. Falsch ist ebenfalls, mehrere Dinge gleichzeitig zu ändern (Treiber aktualisieren, Programm entfernen und Einstellungen zurücksetzen), denn dann weiß man nicht, was geholfen hat. Ein Fehler beim Lesen von Protokollen ist, sich an der erstbesten roten Meldung festzubeißen; Warnungen und Fehler treten auch im gesunden System auf. Wichtig ist, ob die Meldung zeitlich zum Problem passt und sich wiederholt. Beim Einsatz von `sfc` oder `chkdsk` ist zu beachten, dass sie bei defekten Datenträgern nicht ersetzen, zuerst eine Datensicherung zu erstellen.

### Praxisbezug.

Der Anruf “Mein Rechner ist so langsam” führt zu einer festen Fragenfolge: Seit wann? Alle Programme oder nur eines? Task-Manager: Was ist ausgelastet (CPU, RAM, Datenträger, Netzwerk)? Wurde etwas geändert? Neustart schon versucht? Aus den Antworten ergibt sich das weitere Vorgehen, und die Beschreibung des Fehlers wird in das Ticket geschrieben (Modul 09).

> **Merke**
>
> Symptom erfassen, Hardware von Software trennen, einfachste Ursache zuerst, eine Änderung auf einmal, Beobachtung mit Task-Manager und Protokollen, abgesicherter Modus trennt Basis-System von nachträglich installierter Software.

## Übungsaufgaben Modul 03

1.  Nennen Sie die vier Hauptaufgaben eines Betriebssystems und erklären Sie in zwei Sätzen, was der Kernel ist und warum er von den Anwendungen getrennt läuft.

2.  Ordnen Sie zu: Windows, Linux, macOS, Android, iOS. Welches ist quelloffen? Welche laufen nur auf Hardware des Herstellers? Welches nutzt standardmäßig NTFS?

3.  Beschreiben Sie die fünf Phasen des Bootvorgangs und nennen Sie je einen Fehler, der in dieser Phase auftreten kann.

4.  Ein USB-Stick mit 64 GB soll sowohl am Fernseher als auch am Windows-PC verwendet werden und eine 6 GB große Videodatei aufnehmen. Welches Dateisystem wählen Sie, und warum scheidet FAT32 aus?

5.  Ein Benutzer meldet “Zugriff verweigert” auf einen Projektordner. Welche Informationen benötigen Sie, und welche Lösung ist nach dem Prinzip der minimalen Rechte richtig? Was ist die falsche Lösung?

6.  **Praxis:** Schreiben Sie ein Python-Programm, das für einen Ordner (zum Beispiel Ihren Download-Ordner) die fünf größten Dateien mit Größe in MB ausgibt. Verwenden Sie `pathlib`.

7.  **Praxis:** Schreiben Sie eine Funktion `pruefe_oktal(zahl)`, die für eine Zahl wie 640 die symbolische Darstellung (`rw-r-----`) zurückgibt, ohne `stat.filemode` zu benutzen. Testen Sie mit 755, 644 und 600.

8.  **Praxis:** Erweitern Sie das Log-Programm aus Abschnitt 3.8 so, dass es zusätzlich ausgibt, in welchem Zeitraum (frühester bis spätester Fehler) Fehler aufgetreten sind und wie viele Minuten dazwischen liegen. Formulieren Sie danach eine Hypothese und einen ersten Prüfschritt.

## Lösungen Modul 03

1.  Prozessverwaltung (CPU-Zeit verteilen), Speicherverwaltung (RAM zuteilen und abschotten), Dateisystem (Daten ordnen) und Treiber/Hardwarezugriff; dazu Benutzerverwaltung und Oberfläche. Der Kernel ist der Kern des Betriebssystems, der mit höchsten Rechten Hardware und Ressourcen steuert. Anwendungen laufen mit eingeschränkten Rechten, damit ein Fehler in einem Programm nicht das ganze System beschädigt oder Daten anderer Programme liest.

2.  Quelloffen ist Linux (der Kernel; Android basiert auf dem Linux-Kernel, enthält aber auch proprietäre Teile). Nur auf Hardware des Herstellers laufen macOS und iOS. NTFS ist der Standard von Windows.

3.  \(1\) Firmware/POST: fehlerhafter RAM, Pieptöne, kein Bild. (2) Bootloader: “No bootable device”, falsche Bootreihenfolge, beschädigter Bootloader. (3) Kernel laden: fehlender oder defekter Treiber, Bluescreen oder Kernel Panic. (4) Dienste starten: Dienst startet nicht oder hängt, langer Start. (5) Anmeldung: beschädigtes Benutzerprofil, falsches Passwort, Anmeldebildschirm wird nicht gezeigt.

4.  exFAT: Es wird von vielen Fernsehern und von Windows unterstützt und hat keine 4-GiB-Grenze. FAT32 scheidet aus, weil eine einzelne Datei dort höchstens knapp 4 GiB groß sein darf. NTFS wäre am Windows-PC möglich, wird aber von Fernsehern oft nicht oder nur lesend unterstützt.

5.  Benötigt werden: Wer ist der Benutzer, welcher Gruppe gehört er an, welche Rechte hat der Ordner (inklusive Vererbung und Verweigerungen), über welchen Weg greift er zu (lokal, Freigabe). Richtig ist, der zuständigen Gruppe (zum Beispiel “Projekt A”) das nötige Recht (Lesen oder Ändern) zu geben und den Benutzer in diese Gruppe aufzunehmen. Falsch wären Vollzugriff für Jeden oder das Zuweisen von Administratorrechten.

6.  Beispiellösung:

    ```python
    from pathlib import Path

    ordner = Path.home() / "Downloads"
    dateien = [(p.stat().st_size, p) for p in ordner.rglob("*") if p.is_file()]
    for groesse, pfad in sorted(dateien, reverse=True)[:5]:
        print(f"{groesse / 1000**2:8.1f} MB  {pfad}")
    ```

    Die Listenabkürzung erzeugt Paare aus Größe und Pfad. `sorted(..., reverse=True)` sortiert absteigend nach der Größe (dem ersten Element des Paares), `[:5]` schneidet die ersten fünf ab. Gibt es den Ordner nicht, liefert `rglob` keine Treffer, und das Programm gibt nichts aus.

7.  Beispiellösung:

    ```python
    def pruefe_oktal(zahl):
        ziffern = str(zahl)
        text = ""
        for z in ziffern:
            wert = int(z)
            text += "r" if wert & 4 else "-"
            text += "w" if wert & 2 else "-"
            text += "x" if wert & 1 else "-"
        return text

    for z in (755, 644, 600):
        print(z, pruefe_oktal(z))
    ```

    Ausgabe: `755 rwxr-xr-x`, `644 rw-r--r--`, `600 rw-------`. Jede Ziffer wird bitweise mit 4, 2 und 1 verknüpft; wenn das Bit gesetzt ist, steht der Buchstabe, sonst ein Strich.

8.  Beispiellösung (Ergänzung vor der Ausgabe von `Stufen`):

    ```python
    from datetime import datetime
    zeitpunkte = []
    for zeile in LOG.splitlines():
        m = muster.match(zeile)
        if m and m.group(2) == "ERROR":
            zeitpunkte.append(datetime.strptime(m.group(1), "%Y-%m-%d %H:%M:%S"))
    erster, letzter = min(zeitpunkte), max(zeitpunkte)
    print("Erster Fehler:", erster.strftime("%H:%M"), "Letzter:", letzter.strftime("%H:%M"))
    print("Zeitraum:", int((letzter - erster).total_seconds() // 60), "Minuten")
    ```

    Der erste Fehler tritt um 08:15, der letzte um 11:30 auf; das sind 195 Minuten. Hypothese: Ein bestimmtes Programm (`buero.exe`) stürzt wiederholt ab, möglicherweise in Verbindung mit dem Grafiktreiber. Erster Prüfschritt: Prüfen, ob für das Programm oder den Treiber ein Update vorliegt, und das Programm testweise mit Standardtreiber oder im Kompatibilitätsmodus starten, jeweils eine Änderung auf einmal.
