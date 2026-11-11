# Modul 2 - Hardware, Komponenten und Peripherie

> **Hinweis zu diesem Kapitel:** Das ist das Kapitel des Skripts „CompTIA Tech+ / ITF+ (FC0-U71): Lernskript in Modulen“, aus der LaTeX-Quelle in Markdown umgewandelt (Text und Listings unverändert, Boxen als Zitatblöcke, Aufgaben und Lösungen als nummerierte Listen). Laut Skript wurden die Python-Beispiele bei der Erstellung im Arbeitsbereich ausgeführt, die gezeigten Ausgaben stammen aus diesen Läufen; Windows- und PowerShell-Befehle wurden nicht ausgeführt. Für dieses Repository wurden die Listings **nicht erneut ausgeführt**. Prüfungsdetails, Produktnamen und Versionen ändern sich; maßgeblich sind die aktuellen Prüfungsziele (Exam Objectives) von CompTIA. Übersicht zum Modul: [README](README.md).

**Dauer:** 7 h

**Priorität:** 1 (höchste)

| Nr. | Lerneinheit                   | Dauer (h) | Prio |
|----:|:------------------------------|----------:|-----:|
| 2.1 | Mainboard und Formfaktoren    |      0,75 |    1 |
| 2.2 | CPU und Rechenleistung        |         1 |    1 |
| 2.3 | RAM und Speicherhierarchie    |      0,75 |    1 |
| 2.4 | Massenspeicher                |      0,75 |    1 |
| 2.5 | Eingabe- und Ausgabegeräte    |      0,75 |    2 |
| 2.6 | Anschlüsse und Schnittstellen |         1 |    2 |
| 2.7 | Mobile Geräte und Akkus       |      0,75 |    2 |
| 2.8 | Hardware-Troubleshooting      |      1,25 |    1 |
|     | **Summe**                     |     **7** |      |

Dieses Modul erklärt, woraus ein Computer besteht und wie die Teile zusammenarbeiten. Die Bauteile werden dabei nicht als Aufzählung von Datenblättern behandelt, sondern über ihre Aufgabe im Gesamtsystem: Das Mainboard verbindet, die CPU rechnet, der Arbeitsspeicher hält Arbeitsdaten bereit, der Massenspeicher bewahrt Daten dauerhaft auf, Peripheriegeräte verbinden den Rechner mit dem Menschen, und Anschlüsse legen fest, womit sich was verbinden lässt. Am Ende steht das systematische Eingrenzen von Fehlern. Die Infrastruktur-Domäne der Prüfung hat mit 24 Prozent das größte Gewicht, und ein großer Teil davon findet sich in diesem Modul.

## 2.1 Mainboard und Formfaktoren

Das *Mainboard* (auch Motherboard oder Hauptplatine) ist die große Leiterplatte, auf der alle anderen Komponenten stecken oder über Kabel angeschlossen werden. Es ist die Verkehrszentrale des Rechners: Leiterbahnen übertragen Daten und Strom zwischen Prozessor, Arbeitsspeicher, Erweiterungskarten, Laufwerken und Anschlüssen. Ohne passendes Mainboard kann kein Bauteil mit einem anderen sprechen.

Die wichtigsten Bestandteile lassen sich anhand eines typischen Desktop-Boards benennen. In der Mitte sitzt der *Prozessorsockel* (*Socket*), in den die CPU eingesetzt wird; die Bauform des Sockels bestimmt, welche Prozessoren passen. Daneben liegen die *RAM-Steckplätze* (DIMM-Slots) für Arbeitsspeichermodule. Der *Chipsatz* (Chipset) ist ein Baustein oder eine Gruppe von Bausteinen, die den Datenverkehr zwischen CPU und den übrigen Komponenten steuert und festlegt, wie viele Anschlüsse und Erweiterungsmöglichkeiten das Board bietet. Für Erweiterungskarten wie Grafik- oder Netzwerkkarten gibt es *PCI-Express-Steckplätze* (PCIe), für schnelle Solid-State-Laufwerke den *M.2-Steckplatz* und für klassische Laufwerke *SATA-Anschlüsse*. Strom bekommt das Board über einen großen *24-poligen ATX-Stecker* und zusätzliche 4- oder 8-polige Stecker für die CPU. Ein kleiner Speicherbaustein enthält die Firmware (UEFI/BIOS), die den Rechner beim Einschalten startet. Eine *Knopfzelle* (meist Typ CR2032) hält Uhrzeit und Einstellungen, wenn der Rechner vom Netz getrennt ist. Hinzu kommen *Header*, also Stiftleisten für Gehäuseschalter, Gehäuse-USB-Anschlüsse und Lüfter, sowie das *I/O-Panel* auf der Rückseite mit USB-, Netzwerk- und Audio-Buchsen.

Der *Formfaktor* eines Mainboards legt Größe, Lage der Befestigungslöcher und Position der Anschlüsse fest. Dadurch passen Boards eines Formfaktors in Gehäuse, die dafür vorgesehen sind, und Netzteile und Gehäuse verschiedener Hersteller sind austauschbar. Verbreitet sind drei Größen aus der ATX-Familie. *ATX* misst 305 mal 244 Millimeter und bietet die meisten Steckplätze, *Micro-ATX* ist mit 244 mal 244 Millimeter quadratisch und kleiner mit weniger Steckplätzen, *Mini-ITX* misst nur 170 mal 170 Millimeter und bietet meist einen einzigen Erweiterungssteckplatz. Größere Gehäuse nehmen kleinere Boards auf, umgekehrt geht es nicht. Notebooks, Tablets und Smartphones verwenden herstellerspezifische Boards, die fest in das Gerät eingepasst sind; dort lassen sich Teile meist nicht beliebig austauschen.

Der Gedanke der Passung lässt sich im Programm nachbilden. Das folgende Beispiel hinterlegt, welche Boardgrößen in welche Gehäuseklasse passen, und berechnet die Fläche jedes Formfaktors. Das Ergebnis macht klar, warum Mini-ITX-Boards weniger Platz für Erweiterungen bieten.

```python
GEHAEUSE = {
    "Midi-Tower":  ["ATX", "Micro-ATX", "Mini-ITX"],
    "Micro-Tower": ["Micro-ATX", "Mini-ITX"],
    "Mini-ITX-Gehaeuse": ["Mini-ITX"],
}
BOARDS = {
    "ATX": (305, 244),
    "Micro-ATX": (244, 244),
    "Mini-ITX": (170, 170),
}

def passt(board, gehaeuse):
    return board in GEHAEUSE[gehaeuse]

for g in GEHAEUSE:
    ok = [b for b in BOARDS if passt(b, g)]
    print(f"{g:18} nimmt auf: {', '.join(ok)}")

for b, (breite, tiefe) in BOARDS.items():
    print(f"{b:10} {breite} x {tiefe} mm = {breite * tiefe / 100:.0f} cm2")
```

Das erste Dictionary ordnet jeder Gehäuseklasse eine Liste der Boardgrößen zu, die hineinpassen. Das zweite hält Breite und Tiefe als Zahlenpaar (Tupel). Die Funktion `passt` prüft mit dem Operator `in`, ob die Boardgröße in der Liste steht. In der ersten Schleife entsteht für jedes Gehäuse mit einer Listenabkürzung (`[b for b in BOARDS if ...]`) die Liste aller passenden Boards, die `', '.join(ok)` zu einem Text verbindet. In der zweiten Schleife werden die Tupel direkt in Breite und Tiefe zerlegt und die Fläche in Quadratzentimetern berechnet: ATX 744, Micro-ATX 595, Mini-ITX 289. Die Maße stammen aus den ATX-Spezifikationen und sind allgemeines Fachwissen; in der Praxis zählt immer die Angabe im Handbuch des Gehäuses.

### Typische Fehler.

Falsch ist die Annahme, jedes Board passe zu jeder CPU. Richtig ist, dass der Sockel zum Prozessor und der Chipsatz zur Prozessorgeneration passen müssen. Ebenso falsch ist, den Formfaktor des Boards mit dem der Netzteile zu vermengen: Zwar gibt es Netzteile im ATX-Format, doch das Netzteil muss zusätzlich zur Leistung die richtigen Stecker bieten. Ein Praxisfehler beim Einbau ist das Vergessen von Abstandshaltern: Sitzt das Board ohne Distanzbolzen direkt auf dem Gehäuseblech, entstehen Kurzschlüsse.

### Praxisbezug.

Beim Zusammenstellen eines Rechners beginnt man oft mit der CPU, wählt dann Board (Sockel, Chipsatz, Formfaktor), RAM (Typ muss zum Board passen) und Gehäuse. Im Support wird beim Austausch eines defekten Boards zuerst geprüft, ob Sockel, Speichertyp und Formfaktor kompatibel sind, andernfalls müssen mehrere Teile gleichzeitig getauscht werden.

> **Merke**
>
> Das Mainboard verbindet alle Komponenten. Formfaktor = Größe und Befestigung; ATX $>$ Micro-ATX $>$ Mini-ITX. Sockel und Chipsatz bestimmen, welche CPU und welcher RAM passen.

## 2.2 CPU und Rechenleistung

Die *CPU* (*Central Processing Unit*, Hauptprozessor) führt die Anweisungen von Programmen aus. Sie holt Befehle und Daten, rechnet, vergleicht und schreibt Ergebnisse zurück. Man kann sie sich als Sachbearbeiter vorstellen, der Aufgabenzettel abarbeitet, und die Leistung hängt davon ab, wie schnell er arbeitet, wie viele davon zugleich arbeiten und wie nah die benötigten Unterlagen auf dem Tisch liegen.

Der *Takt* (Taktfrequenz, in Gigahertz) gibt an, wie viele Arbeitstakte die CPU pro Sekunde ausführt; 3,5 GHz sind 3,5 Milliarden Takte pro Sekunde. Der Takt allein sagt aber wenig, weil verschiedene Architekturen pro Takt unterschiedlich viel erledigen. Moderne Prozessoren haben mehrere *Kerne* (Cores): Jeder Kern ist eine vollständige Recheneinheit, ein Vierkernprozessor kann vier Aufgaben tatsächlich gleichzeitig bearbeiten. Mit *Simultaneous Multithreading* (bei Intel *Hyper-Threading* genannt) kann ein Kern zwei Befehlsströme (*Threads*) verwalten, sodass das Betriebssystem doppelt so viele logische wie physische Kerne sieht. Das erhöht die Auslastung, ersetzt aber keinen zweiten Kern. Der *Cache* ist ein sehr schneller Zwischenspeicher direkt auf dem Prozessor, in mehreren Stufen (L1 klein und am schnellsten, L2, L3 größer und langsamer), der häufig benötigte Daten bereithält, damit die CPU nicht auf den vergleichsweise langsamen Arbeitsspeicher warten muss.

Weitere Merkmale sind die *Architektur* (zum Beispiel x86-64 bei den meisten PCs und Servern, ARM bei Smartphones und vielen Tablets und neueren Notebooks), die *Verlustleistung* (*TDP*, in Watt, ein Maß für Wärme und Kühlbedarf), der *Sockel* (siehe vorige Einheit) und die *Kühlung*. Ein Prozessor, der zu heiß wird, schützt sich, indem er den Takt senkt (*Thermal Throttling*); der Rechner wird dann spürbar langsamer. Zwischen CPU und Kühlkörper sorgt *Wärmeleitpaste* für guten Wärmeübergang. Integrierte Grafik (iGPU) ist in viele Prozessoren eingebaut, leistungsstarke Grafik liefert eine eigene Grafikkarte.

Dass mehr Kerne nicht automatisch ein schnelleres Programm bedeuten, versteht man am besten durch Ausprobieren. Das folgende Beispiel zählt Primzahlen, einmal nacheinander und einmal verteilt auf alle Kerne mit dem Modul `multiprocessing`. Die Aufgabe ist bewusst rechenintensiv, damit die Messung aussagekräftig ist.

```python
import time, os
from multiprocessing import Pool

def zaehle_primzahlen(grenze):
    anzahl = 0
    for n in range(2, grenze):
        for t in range(2, int(n ** 0.5) + 1):
            if n % t == 0:
                break
        else:
            anzahl += 1
    return anzahl

if __name__ == "__main__":
    aufgaben = [250000] * 4
    start = time.perf_counter()
    seriell = [zaehle_primzahlen(g) for g in aufgaben]
    t_seriell = time.perf_counter() - start

    start = time.perf_counter()
    with Pool(processes=os.cpu_count()) as pool:
        parallel = pool.map(zaehle_primzahlen, aufgaben)
    t_parallel = time.perf_counter() - start

    print("Kerne:", os.cpu_count())
    print(f"seriell : {t_seriell:.2f} s")
    print(f"parallel: {t_parallel:.2f} s")
    print(f"Beschleunigung: {t_seriell / t_parallel:.1f}x")
```

Die Funktion `zaehle_primzahlen` prüft jede Zahl bis zur Grenze, ob sie durch eine kleinere Zahl teilbar ist; teilbar bedeutet, die innere Schleife bricht mit `break` ab, sonst zählt die `else`-Verzweigung der Schleife die Zahl als Primzahl. Das Hauptprogramm erzeugt vier gleich große Aufgaben und misst die Zeit mit `time.perf_counter()`. Zuerst arbeitet es sie in einer Schleife nacheinander ab, danach verteilt `Pool.map` sie auf so viele Prozesse, wie die CPU logische Kerne hat. Die Absicherung `if __name__ == "__main__":` ist unter Windows zwingend, weil dort Prozesse neu gestartet werden und das Modul sonst endlos neue Prozesse erzeugen würde. Auf dem Testsystem mit zwei Kernen dauerte der serielle Lauf etwa 1,25 Sekunden und der parallele etwa 0,63 Sekunden, also rund doppelt so schnell. Bei sehr kleinen Aufgaben wäre die Beschleunigung geringer, weil das Starten der Prozesse selbst Zeit kostet.

### Typische Fehler.

Falsch ist, Rechenleistung ausschließlich am Takt abzulesen: Ein Prozessor mit 3 GHz und moderner Architektur kann einen älteren mit 4 GHz übertreffen. Falsch ist auch, dass mehr Kerne jedes Programm beschleunigen. Ein Programm, das seine Arbeit nicht aufteilt, nutzt nur einen Kern; die übrigen bleiben leer. Ein Klassiker bei der Fehlersuche ist die Deutung der Auslastung: Zeigt der Task-Manager 100 Prozent CPU-Last auf einem einzelnen Kern bei insgesamt 25 Prozent, ist das Programm nicht parallel gebaut und der Rechner nicht “am Limit”.

### Praxisbezug.

Läuft ein Rechner langsam, hilft die Auslastungsanzeige bei der Eingrenzung: Dauerhaft hohe CPU-Last bei einem Prozess deutet auf ein rechenintensives oder fehlerhaftes Programm hin, niedrige CPU-Last bei gleichzeitig hoher Festplattenaktivität eher auf einen Speicherengpass. Die CPU-Auslastung ist ein Indikator, kein Urteil.

## 2.3 RAM und Speicherhierarchie

Der *Arbeitsspeicher* (*RAM*, Random Access Memory) ist der Speicher, in dem der Rechner die Programme und Daten ablegt, mit denen er gerade arbeitet. Er ist *flüchtig*: Beim Ausschalten oder Stromverlust ist sein Inhalt weg. Dafür ist er viel schneller als jeder Massenspeicher. Man kann ihn mit der Arbeitsfläche eines Schreibtischs vergleichen: Wer eine große Fläche hat, kann viele Unterlagen gleichzeitig ausbreiten; das Archiv im Keller entspricht dem Massenspeicher.

RAM wird als Modul auf das Mainboard gesteckt. Für Desktop-Rechner und Server sind das *DIMM*-Module, für Notebooks die kleineren *SO-DIMM*-Module. Die Generation (DDR4, DDR5) bestimmt Geschwindigkeit und mechanische Kodierung; sie ist nicht untereinander kompatibel, und das Board akzeptiert nur eine Generation. Wichtig sind außerdem Kapazität (in Gigabyte) und Geschwindigkeit. Wer zwei gleiche Module in die passenden Steckplätze steckt, nutzt meist den *Dual-Channel*-Betrieb, der die Datenrate erhöht. Server verwenden häufig *ECC*-Speicher (*Error-Correcting Code*), der einzelne Bitfehler erkennt und korrigiert.

Zwischen CPU und Massenspeicher gibt es eine *Speicherhierarchie*: Je näher am Prozessor, desto schneller, kleiner und teurer pro Gigabyte. Ganz oben stehen die Register in der CPU, danach die Cache-Stufen L1 bis L3, dann der Arbeitsspeicher, dann SSD und Festplatte. Die Zugriffszeiten unterscheiden sich um Größenordnungen: Cache liegt im Bereich weniger Nanosekunden, RAM im Bereich von rund hundert Nanosekunden, eine SSD im Bereich von Zehntausenden und eine Festplatte im Bereich von Millisekunden. Die Zahlen sind Größenordnungen, die je nach Gerät und Messung variieren. Entscheidend ist das Prinzip: Programme laufen schnell, wenn ihre Daten in der oberen Ebene liegen.

Was passiert, wenn der RAM nicht reicht? Das Betriebssystem lagert dann selten gebrauchte Teile in eine Auslagerungsdatei auf dem Massenspeicher aus (*virtueller Speicher*, unter Windows Auslagerungsdatei “Pagefile”, unter Linux *Swap*). So lassen sich auch größere Programme starten, aber der Preis ist hoch: Jeder Zugriff auf ausgelagerte Daten ist um ein Vielfaches langsamer. Passiert das ständig, spricht man von *Thrashing*; der Rechner reagiert zäh und die Festplatten-LED leuchtet dauerhaft.

Das folgende Beispiel zeigt zwei Dinge: Wie viel RAM eine einfache Datenstruktur tatsächlich benötigt und wie man den Speicherstand des Systems ausliest. Das Auslesen funktioniert unter Linux über die Datei `/proc/meminfo`; unter Windows zeigt der Task-Manager dieselben Werte.

```python
import sys, tracemalloc

tracemalloc.start()
zahlen = list(range(1_000_000))
aktuell, spitze = tracemalloc.get_traced_memory()
print(f"Liste mit 1 Mio. Zahlen: {aktuell / 1024**2:.1f} MiB im RAM")
print("Eine einzelne Zahl:", sys.getsizeof(1), "Byte; die Liste selbst:",
      f"{sys.getsizeof(zahlen) / 1024**2:.1f} MiB")
tracemalloc.stop()

try:
    with open("/proc/meminfo") as f:
        for zeile in f:
            if zeile.startswith(("MemTotal", "MemAvailable", "SwapTotal")):
                name, wert, einheit = zeile.split()
                print(f"{name:13} {int(wert) / 1024**2:6.2f} GiB")
except FileNotFoundError:
    print("Keine /proc/meminfo: unter Windows im Task-Manager nachsehen")
```

Das Modul `tracemalloc` verfolgt den Speicher, den Python anfordert. Nach dem Erzeugen einer Liste mit einer Million Zahlen meldet es rund 38 MiB. Das ist deutlich mehr als die 8 MB, die man erwarten würde, wenn jede Zahl nur 8 Byte benötigte: Die Liste enthält nur Verweise (etwa 7,6 MiB), und jede Zahl ist ein eigenes Objekt von 28 Byte. Dieser Zusatzaufwand zeigt, dass der Speicherbedarf einer Anwendung vom Programmiermodell abhängt und nicht nur von der Datenmenge. Der Teil mit `/proc/meminfo` öffnet die Systemdatei, liest Zeile für Zeile und gibt Gesamt-RAM, verfügbaren RAM und Auslagerungsspeicher aus (Werte in Kibibyte werden in GiB umgerechnet). Auf dem Testsystem waren das 7,84 GiB, 7,22 GiB und 0 GiB; auf dem eigenen Rechner sehen die Zahlen anders aus.

### Typische Fehler.

Falsch ist, RAM und Festplattenspeicher zu verwechseln: “Mein Rechner hat 512 GB” meint meist den Massenspeicher, nicht den RAM. Falsch ist auch, einen langsamen Rechner reflexartig mit mehr Festplattenplatz heilen zu wollen. Richtig ist, zuerst die Auslastung zu prüfen: Ist der RAM voll und die Auslagerung aktiv, hilft mehr RAM. Ein Fehler beim Aufrüsten ist, Module mit unterschiedlicher Generation oder Bauform zu kaufen; DDR4 passt nicht in einen DDR5-Steckplatz, und SO-DIMM nicht in einen DIMM-Slot.

### Praxisbezug.

Typische Symptome zu knappen Speichers sind lange Wartezeiten beim Wechsel zwischen Programmen, ständige Plattenaktivität und eine Meldung wie “Der Arbeitsspeicher ist nahezu ausgelastet”. Im Support wird die Auslastung im Task-Manager oder im Aktivitätsmonitor betrachtet, bevor Hardware bestellt wird.

> **Merke**
>
> RAM = schnell, flüchtig, Arbeitsfläche. Massenspeicher = langsamer, dauerhaft, Archiv. Hierarchie: Register, Cache, RAM, SSD, Festplatte. Zu wenig RAM führt zu Auslagerung und damit zu Verlangsamung.

## 2.4 Massenspeicher

*Massenspeicher* (Sekundärspeicher) bewahren Daten dauerhaft auf, auch ohne Stromversorgung. Sie speichern das Betriebssystem, Programme und Dokumente. Man unterscheidet vier Typen, die sich in Technik, Geschwindigkeit, Preis und Haltbarkeit unterscheiden.

Die *Festplatte* (*HDD*, Hard Disk Drive) speichert Daten magnetisch auf rotierenden Scheiben, über die ein Schreib-Lese-Kopf bewegt wird. Bei 5400 oder 7200 Umdrehungen pro Minute dauert allein die mechanische Positionierung Millisekunden, was Zugriffe auf viele kleine Dateien langsam macht. HDDs sind bei großen Kapazitäten günstig pro Terabyte, empfindlich gegenüber Stößen und erzeugen Geräusche und Wärme. Die *SSD* (*Solid State Drive*) speichert in Flash-Speicherzellen ohne bewegliche Teile. Sie ist deutlich schneller, leiser, stoßunempfindlicher und stromsparender, dafür pro Terabyte teurer. Jede Flash-Zelle verträgt nur eine begrenzte Zahl von Schreibzyklen; die Hersteller geben die Haltbarkeit als *TBW* (Terabytes Written) an, im normalen Betrieb ist das aber sehr hoch. SSDs gibt es mit der älteren SATA-Schnittstelle (Datenrate bis etwa 550 MB/s) und mit *NVMe* über PCIe, oft als kleine M.2-Platine, die mehrere Gigabyte pro Sekunde erreicht. Ein klassischer Fehlschluss ist, dass M.2 eine Geschwindigkeit bezeichne: M.2 ist nur der Steckplatz; es gibt M.2-SSDs sowohl mit SATA als auch mit NVMe.

*USB-Speicher* (USB-Stick, externe Festplatte oder SSD) sind transportable Speicher. Sie sind praktisch zum Austausch, aber leicht zu verlieren, sodass sensible Daten verschlüsselt werden sollten (Modul 10). *Speicherkarten* (SD, microSD) nutzen ebenfalls Flash-Speicher und kommen in Kameras und Smartphones vor. *Optische Medien* (CD, DVD, Blu-ray) speichern Daten mit einem Laser auf einer Scheibe. Typische Kapazitäten sind etwa 700 MB für eine CD, 4,7 GB für eine einlagige DVD und 25 GB für eine einlagige Blu-ray. Sie werden heute seltener eingesetzt, bleiben aber für Archivierung und Medienvertrieb relevant. Alle diese Medien altern: Flash-Speicher kann ohne Strom über Jahre Daten verlieren, optische Medien verschlechtern sich durch Licht und Kratzer, Festplatten durch mechanischen Verschleiß. Kein Speichermedium ersetzt ein Backup (Modul 12).

Das folgende Beispiel bestimmt die Schreib- und Lesegeschwindigkeit des Laufwerks, auf dem es ausgeführt wird, und rechnet danach aus, wie lange das Kopieren von 500 Gigabyte bei typischen Datenraten dauern würde. Die Messung ist einfach, aber aussagekräftig genug, um eine HDD von einer SSD zu unterscheiden.

```python
import os, time

pfad = "testdatei.bin"
groesse_mb = 200
block = os.urandom(1024 * 1024)

start = time.perf_counter()
with open(pfad, "wb") as f:
    for _ in range(groesse_mb):
        f.write(block)
    f.flush()
    os.fsync(f.fileno())
dauer = time.perf_counter() - start
print(f"Schreiben: {groesse_mb / dauer:.0f} MB/s")

start = time.perf_counter()
with open(pfad, "rb") as f:
    while f.read(1024 * 1024):
        pass
dauer = time.perf_counter() - start
print(f"Lesen    : {groesse_mb / dauer:.0f} MB/s (evtl. aus dem Cache)")
os.remove(pfad)

for name, mb_s in [("HDD", 150), ("SATA-SSD", 550), ("NVMe-SSD", 3500)]:
    minuten = 500_000 / mb_s / 60
    print(f"{name:9} {mb_s:5} MB/s -> 500 GB in {minuten:5.1f} min")
```

Das Programm erzeugt mit `os.urandom` einen Megabyte großen Block zufälliger Bytes und schreibt ihn 200 Mal in eine Datei. Wichtig sind `flush()` und `os.fsync()`: Sie zwingen das Betriebssystem, die Daten wirklich auf den Datenträger zu schreiben und nicht nur im Zwischenspeicher zu halten, sonst würde die Messung die Geschwindigkeit des RAM zeigen. Die Dauer wird gemessen und in Megabyte pro Sekunde umgerechnet. Beim anschließenden Lesen liefert das Betriebssystem die Datei meist aus seinem Cache, weshalb der Wert zu hoch ausfällt; auf dem Testsystem waren es rund 620 MB/s beim Schreiben und mehr als 6000 MB/s beim Lesen. Zum Vergleich rechnet die Schleife am Ende aus, dass 500 GB bei den angenommenen Datenraten knapp eine Stunde (HDD), gut eine Viertelstunde (SATA-SSD) oder wenige Minuten (NVMe) dauern. Die drei Datenraten sind typische Größenordnungen, keine Garantien.

### Typische Fehler.

Falsch ist, eine SSD zu defragmentieren; das bringt nichts und kostet Schreibzyklen. Moderne Betriebssysteme erkennen SSDs und bieten stattdessen den Befehl TRIM an. Falsch ist ebenfalls, einen USB-Stick als Backup zu betrachten: Er ist ein einzelnes, verlierbares und alterndes Medium. Ein verbreiteter Kaufirrtum lautet, die beworbene Kapazität stimme mit der im System angezeigten überein; der Unterschied zwischen 1 000er- und 1 024er-Rechnung (Modul 01) erklärt die Abweichung.

### Praxisbezug.

Im Büro-PC bringt der Umstieg von HDD auf SSD meist den größten spürbaren Geschwindigkeitsgewinn überhaupt; Systemstart und Programmstart verkürzen sich drastisch. Für Archive mit vielen Terabytes bleibt die HDD wirtschaftlich, in Servern werden beide Typen gemischt (schnelle SSD für aktive Daten, HDD für große Datenmengen).

## 2.5 Eingabe- und Ausgabegeräte

*Peripheriegeräte* sind alle Geräte, die außerhalb des eigentlichen Rechners (CPU, RAM, Board) angeschlossen werden. Sie verbinden den Computer mit dem Menschen oder anderen Systemen. Nach der Richtung des Datenflusses unterscheidet man *Eingabegeräte*, die Daten zum Rechner liefern, *Ausgabegeräte*, die Daten des Rechners darstellen, und Geräte, die beides tun.

Zu den Eingabegeräten zählen die Tastatur, die Maus und das Touchpad, der Scanner (der Papier in digitale Bilder umwandelt), das Mikrofon, die Webcam und biometrische Sensoren wie Fingerabdruckleser. Ausgabegeräte sind vor allem der Monitor (Merkmale: Auflösung, Bildwiederholrate, Bildschirmgröße, Panel-Technik wie IPS, VA oder TN), der Drucker, der Beamer und die Lautsprecher. Bei Druckern unterscheidet man den *Tintenstrahldrucker*, der winzige Tintentropfen aufs Papier spritzt, den *Laserdrucker*, der Toner mit Hitze auf das Papier fixiert, den *Thermodrucker* (etwa für Kassenbons und Etiketten) und den *3D-Drucker*, der Objekte Schicht für Schicht aufbaut. Geräte, die in beide Richtungen arbeiten, sind der Touchscreen, das Headset (Mikrofon plus Kopfhörer) und der Multifunktionsdrucker mit Scanner. Auch Netzwerkkarten und Speicher sind in diesem Sinn Ein- und Ausgabegeräte.

Damit das Betriebssystem ein Gerät ansprechen kann, benötigt es einen *Treiber*, ein kleines Programm, das die Hardwaredetails des Geräts kennt und eine einheitliche Schnittstelle für das Betriebssystem bereitstellt. Für Standardgeräte wie Tastatur, Maus oder USB-Speicher bringt das Betriebssystem sogenannte Klassentreiber mit; das Gerät funktioniert sofort (*Plug and Play*). Spezialgeräte wie Grafikkarten, Drucker oder Scanner brauchen oft den Treiber des Herstellers, um alle Funktionen anzubieten. Der Treiber muss zur Betriebssystemversion und zur Prozessorarchitektur passen: Ein Treiber für Windows 10 funktioniert nicht automatisch unter Linux, und ein 32-Bit-Treiber nicht in einem 64-Bit-System. Dazu kommt die Anschlussabhängigkeit: Das Gerät braucht einen passenden physischen Anschluss, was in der folgenden Einheit behandelt wird.

Auch in Programmen gibt es den Gedanken von Ein- und Ausgabe: *Standardeingabe* (stdin) und *Standardausgabe* (stdout) sind Datenströme, an die Tastatur und Bildschirm oder aber Dateien und andere Programme angeschlossen werden können. Das folgende Beispiel zeigt beides. Es teilt zuerst die Geräte mit Mengenoperationen in Eingabe, Ausgabe und beides ein und liest danach alles, was über die Standardeingabe hereinkommt.

```python
EINGABE = {"Tastatur", "Maus", "Scanner", "Mikrofon", "Webcam", "Touchscreen", "Headset"}
AUSGABE = {"Monitor", "Drucker", "Lautsprecher", "Beamer", "Touchscreen", "Headset"}

print("Beides      :", sorted(EINGABE & AUSGABE))
print("Nur Eingabe :", sorted(EINGABE - AUSGABE))
print("Nur Ausgabe :", sorted(AUSGABE - EINGABE))

import sys
zeilen = sys.stdin.read().splitlines()
print(f"{len(zeilen)} Zeilen gelesen, groesste Zeile: {max(map(len, zeilen))} Zeichen")
```

Ein *Set* (Menge) enthält jedes Element höchstens einmal und erlaubt Mengenoperationen: `&` bildet den Durchschnitt (Geräte, die in beiden Mengen stehen, also Touchscreen und Headset), das Minuszeichen die Differenz (nur in der ersten Menge). `sorted` macht daraus eine alphabetisch geordnete Liste. Die letzten Zeilen lesen mit `sys.stdin.read()` den gesamten Text der Standardeingabe. Startet man das Programm in der Konsole und gibt über eine Pipe etwa zwei Textzeilen hinein (zum Beispiel mit `printf 'eins\nzwei drei\n' | python3 programm.py`), meldet es zwei Zeilen mit höchstens neun Zeichen. Ohne Pipe wartet das Programm auf Eingabe von der Tastatur, die man unter Linux mit Strg+D, unter Windows mit Strg+Z und Enter beendet.

### Typische Fehler.

Falsch ist, jedes Peripheriegerät als “defekt” zu bezeichnen, wenn es nicht erkannt wird; häufig fehlt nur der Treiber oder der Anschluss ist falsch gewählt. Falsch ist auch die Annahme, ein Drucker sei “immer” nur ein Ausgabegerät: Ein Multifunktionsgerät scannt, kopiert und druckt. Beim Treiber gilt der Grundsatz: Treiber stammen vom Hersteller des Geräts oder aus der Update-Funktion des Betriebssystems, nicht aus Download-Portalen unbekannter Herkunft; sie laufen mit hohen Rechten und sind ein bekanntes Einfallstor für Schadsoftware.

### Praxisbezug.

Bei der Einrichtung eines neuen Arbeitsplatzes werden Monitor, Tastatur, Maus, Headset und Drucker verbunden, Treiber installiert und die Funktionen geprüft. Im Support lohnt die Frage: Wird das Gerät im Geräte-Manager angezeigt? Wenn nicht, liegt das Problem bei Anschluss, Kabel oder Gerät; wenn es mit Warnsymbol angezeigt wird, liegt es meist am Treiber.

## 2.6 Anschlüsse und Schnittstellen

Eine *Schnittstelle* legt fest, wie zwei Geräte Daten austauschen: welche Signale, welche Spannungen, welche Regeln. Ein *Anschluss* ist die körperliche Buchse oder der Stecker dazu. Beide Begriffe werden oft vermischt, aber der Unterschied ist wichtig, denn derselbe Stecker kann verschiedene Schnittstellen tragen.

Der Universal Serial Bus (*USB*) ist der wichtigste Anschluss für Peripherie. Er hat viele Steckerformen: *USB-A* (der klassische rechteckige Stecker), *USB-B* (früher bei Druckern), Mini- und Micro-USB (ältere Geräte) und *USB-C*, der kleine, symmetrische Stecker, den man in beliebiger Richtung einstecken kann. Entscheidend ist: USB-C ist eine Steckerform und keine Geschwindigkeit. Ein USB-C-Kabel kann nur USB 2.0 mit 480 Mbit/s übertragen oder USB4 mit 40 Gbit/s, und ob ein Bildsignal oder Ladestrom fließt, hängt von Gerät und Kabel ab. Zu den Geschwindigkeitsstufen gehören USB 2.0 (480 Mbit/s), USB 3.2 Gen 1 (5 Gbit/s), Gen 2 (10 Gbit/s), Gen 2x2 (20 Gbit/s) sowie USB4 mit 40 Gbit/s und USB4 Version 2.0 mit 80 Gbit/s. Die Namen sind mehrfach umbenannt worden und verwirren selbst Fachleute.

Für Bildsignale gibt es *HDMI* (Fernseher, Beamer, Monitore, überträgt Bild und Ton), *DisplayPort* (vor allem Monitore und PC) sowie ältere Formen wie *DVI* und *VGA*. VGA ist ein analoges Signal, die anderen sind digital. Für Netzwerkverbindungen kommt der *RJ45*-Stecker mit Twisted-Pair-Kabel zum Einsatz (Modul 04). *Audio* verwendet meist die 3,5-mm-Klinkenbuchse; Headsets mit einem Stecker haben vier Kontakte (Ton und Mikrofon). Für Laufwerke gibt es *SATA* intern. Kabellose Schnittstellen sind *Bluetooth* (kurze Reichweite, geringer Stromverbrauch, für Headsets, Tastaturen, Mäuse) und *WLAN* (Netzwerkzugang). Thunderbolt, eine Schnittstelle von Intel und Apple, nutzt den USB-C-Stecker und kann Daten, Bild und Strom über ein Kabel übertragen.

> **Ergänzung aus der Nachrecherche**
>
> Die Datenraten der Schnittstellen wurden in dieser Sitzung bei Wikipedia (Drittquelle) nachgeschlagen: USB 2.0 480 Mbit/s; USB 3.2 Gen 1 5 Gbit/s, Gen 2 10 Gbit/s, Gen 2x2 20 Gbit/s; USB4 40 Gbit/s (Rohdatenrate etwa 38,8 Gbit/s je Richtung) und USB4 Version 2.0 80 Gbit/s; USB4 gilt nur für den USB-C-Stecker. HDMI 1.4: 10,2 Gbit/s, HDMI 2.0: 18 Gbit/s, HDMI 2.1: 48 Gbit/s Bruttodatenrate (nach Kodierung etwa 8,16, 14,4 und 42 Gbit/s). DisplayPort 1.2: 21,6 Gbit/s, 1.4: 32,4 Gbit/s, 2.0 bis 2.1a: 80 Gbit/s brutto. Die tatsächlich nutzbare Datenrate liegt wegen Kodierung und Protokollaufwand darunter.

Das folgende Beispiel rechnet aus, wie lange ein 20-GB-Datentransfer auf den verschiedenen Schnittstellen dauern würde. Es verwendet die Bruttodatenraten und einen geschätzten Wirkungsgrad von 70 Prozent, weil Protokolle und Verwaltung Anteile der Rate verbrauchen.

```python
SCHNITTSTELLEN = {
    "USB 2.0":          0.48,
    "USB 3.2 Gen 1":    5,
    "USB 3.2 Gen 2":    10,
    "USB 3.2 Gen 2x2":  20,
    "USB4 (40)":        40,
    "Gigabit-Ethernet": 1,
}
datei_gb = 20
wirkungsgrad = 0.7

print(f"Uebertragung von {datei_gb} GB (Wirkungsgrad {wirkungsgrad:.0%})")
for name, gbit in SCHNITTSTELLEN.items():
    sekunden = datei_gb * 8 / (gbit * wirkungsgrad)
    print(f"{name:17} {gbit:6.2f} Gbit/s -> {sekunden/60:6.1f} min ({sekunden:7.0f} s)")
```

Die Datenraten stehen in Gigabit pro Sekunde im Dictionary. Die Dateigröße wird mit `datei_gb * 8` in Gigabit umgerechnet und durch die effektive Rate (Bruttorate mal Wirkungsgrad) geteilt. `:.0%` im Format macht aus 0,7 die Anzeige 70 %. Die Ausgabe zeigt, dass USB 2.0 für 20 GB knapp acht Minuten braucht, Gigabit-Ethernet knapp vier Minuten und USB 3.2 Gen 2 nur etwa 23 Sekunden. Die tatsächliche Dauer hängt außerdem vom langsamsten Glied ab: Eine HDD mit 150 MB/s begrenzt auch einen schnellen USB-Anschluss auf rund 150 MB/s.

Ein weiteres Thema sind *Adapter*. Ein passiver Adapter ändert nur die Steckerform (zum Beispiel USB-C auf USB-A), wenn beide Seiten dasselbe Signal sprechen. Ein aktiver Adapter wandelt Signale, etwa von DisplayPort auf HDMI oder von USB-C auf HDMI; das setzt voraus, dass der Ausgang das Signal überhaupt bereitstellt (bei USB-C als “Alternate Mode”). Kabel ist nicht gleich Kabel: Ein einfaches USB-C-Ladekabel überträgt oft nur USB 2.0 und kein Bild.

### Typische Fehler.

Falsch ist die Annahme: “Der Stecker passt, also funktioniert es.” Richtig ist, dass Stecker, Schnittstelle, Gerät und Kabel zusammenpassen müssen. Ein Notebook mit USB-C-Buchse kann nur dann einen Monitor ansteuern, wenn der Anschluss Bildausgabe unterstützt. Ebenso falsch ist, Bluetooth als schnelle Datenverbindung zu nutzen; sie eignet sich für Eingabegeräte und Audio, nicht für große Dateien. Ein häufiger Fehler bei Monitoren ist das falsche Kabel: Ein HDMI-1.4-Kabel liefert bei 4K nur eingeschränkte Bildwiederholraten.

### Praxisbezug.

Beim Anschluss eines zweiten Monitors an ein Notebook im Büro fehlt oft der passende Anschluss. Der Support prüft zuerst die Ausgänge des Notebooks und die Eingänge des Monitors und wählt dann Kabel oder Dockingstation passend aus. Dockingstationen bündeln dabei mehrere Schnittstellen über ein einziges USB-C- oder Thunderbolt-Kabel.

## 2.7 Mobile Geräte und Akkus

Notebooks, Tablets und Smartphones sind für den mobilen Einsatz gebaut und unterscheiden sich in mehreren Punkten von Desktop-Rechnern. Sie sind kompakt und leicht, daher sind viele Teile fest verlötet oder verklebt (RAM, oft auch der Massenspeicher), der Bildschirm ist integriert, und die Kühlung ist passiv oder über kleine Lüfter geregelt. Zum Einsatz kommen häufig stromsparende Prozessoren (oft nach dem ARM-Prinzip oder als sparsame x86-Varianten) und *System-on-a-Chip*-Konstruktionen (SoC), die Prozessor, Grafik und weitere Funktionen auf einem einzigen Chip vereinen. Dazu kommen Sensoren (Lagesensor, Beschleunigungssensor, Kompass, GPS, Helligkeit) und Funkmodule für Mobilfunk, WLAN, Bluetooth und NFC.

Der *Akku* (Akkumulator) ist das zentrale Bauteil. Praktisch alle mobilen Geräte nutzen Lithium-Ionen- oder Lithium-Polymer-Akkus, weil sie viel Energie bei geringem Gewicht speichern. Die Kapazität wird in Amperestunden (Ah), Milliamperestunden (mAh) oder besser in *Wattstunden* (Wh) angegeben; die Wattstunden ergeben sich aus Kapazität mal Spannung und erlauben Vergleiche zwischen Geräten. Die Laufzeit ist die Kapazität in Wattstunden geteilt durch die Leistungsaufnahme in Watt. Bei jedem Lade- und Entladezyklus altert der Akku und verliert Kapazität. Nach einigen hundert Zyklen sind typischerweise nur noch rund 80 Prozent der ursprünglichen Kapazität verfügbar; der Verlauf hängt von Temperatur, Ladezustand und Ladegeschwindigkeit ab. Hitze und dauerhaftes Vollladen beschleunigen die Alterung, ein Betrieb zwischen etwa 20 und 80 Prozent ist schonend. Ein aufgeblähter (“geschwollener”) Akku ist eine Gefahr: Er darf nicht mehr benutzt, nicht geladen und nie durchstochen werden und muss fachgerecht entsorgt werden.

Das folgende Beispiel rechnet Laufzeiten für verschiedene Lasten, schätzt die Alterung und rechnet mAh in Wh um. Die Alterung ist als einfache lineare Näherung angesetzt (fünf Prozent Verlust je hundert Zyklen), ein Modell, das den typischen Verlauf grob trifft, aber keine Herstellerangabe ist.

```python
def laufzeit_stunden(akku_wh, verbrauch_watt):
    return akku_wh / verbrauch_watt

def kapazitaet_nach_zyklen(zyklen, verlust_pro_100=5.0):
    return max(0.0, 100 - zyklen / 100 * verlust_pro_100)

akku_wh = 56
for last, w in [("Textverarbeitung", 8), ("Videokonferenz", 15), ("Spiele/Rendern", 45)]:
    print(f"{last:17} {w:3d} W -> {laufzeit_stunden(akku_wh, w):4.1f} h")

for z in (0, 300, 500, 800):
    print(f"nach {z:3d} Zyklen: {kapazitaet_nach_zyklen(z):5.1f} % der Nennkapazitaet")

mah, volt = 5000, 3.7
wh = mah / 1000 * volt
print(f"{mah} mAh bei {volt} V = {wh:.1f} Wh")
```

Die erste Funktion teilt Wattstunden durch Watt und liefert Stunden: Ein 56-Wh-Akku hält bei acht Watt sieben Stunden, bei 45 Watt nur gut eine. Die zweite Funktion zieht pro hundert Zyklen den angegebenen Prozentsatz ab und verhindert mit `max(0.0, ...)`, dass das Ergebnis negativ wird. Nach 500 Zyklen bleiben im Modell 75 Prozent, nach 800 Zyklen 60 Prozent. Der letzte Abschnitt zeigt die Umrechnung: 5000 mAh bei 3,7 Volt sind 18,5 Wh. Sie ist wichtig, weil Powerbanks in mAh beworben werden, Vorschriften aber in Wh gelten.

> **Ergänzung aus der Nachrecherche**
>
> Für Reisen mit dem Flugzeug gilt für Powerbanks und Ersatzakkus eine Grenze in Wattstunden. Laut einem Blogbeitrag vom 06.08.2026 (Drittquelle, nicht von IATA selbst, nicht verifiziert) gilt nach IATA-Regeln: Mitnahme nur im Handgepäck, bis 100 Wh ohne Beschränkung, zwischen 100 und 160 Wh nur mit Zustimmung der Fluggesellschaft und meist höchstens zwei Stück, über 160 Wh verboten. Derselbe Beitrag berichtet, dass ab dem 01.01.2027 Powerbanks über 100 Wh nicht mehr erlaubt sein sollen, und dass einzelne Fluggesellschaften strenger sind. Wer fliegt, prüft vorab die aktuellen Regeln der Fluggesellschaft; die Angaben können sich ändern.

### Typische Fehler.

Falsch ist der Rat, den Akku “erst vollständig entladen”: Das gilt für alte Nickel-Akkus, nicht für Lithium-Ionen. Tiefentladung und dauerhafte Hitze schaden. Falsch ist auch, die Akkulaufzeit allein an der Kapazität festzumachen; der Verbrauch von Bildschirm, Prozessor und Funk bestimmt mit. Ein häufiger Fehler beim Laden unterwegs ist ein ungeeignetes Netzteil: Zu schwache Ladegeräte laden langsam oder gar nicht, weil Notebooks eine bestimmte Leistung (in Watt) erwarten.

### Praxisbezug.

Im Support kommen Meldungen wie “Akku hält nur noch zwei Stunden” häufig vor. Erst wird in den Systeminformationen der Akkuzustand geprüft (Zyklen, Restkapazität), dann der Verbrauch großer Programme und die Bildschirmhelligkeit. Ist die Kapazität stark gesunken, wird der Akku ersetzt, bei vielen Notebooks ein einfacher Handgriff, bei Smartphones oft ein Werkstattfall.

## 2.8 Hardware-Troubleshooting

Fehler an der Hardware lassen sich mit einer festen Reihenfolge deutlich schneller finden als durch Probieren. Die Grundidee heißt *systematisches Eingrenzen*: Man beschreibt das Symptom genau, überlegt, welche Ursachen dazu passen könnten, prüft sie der Reihe nach von der einfachsten zur aufwendigsten und ändert immer nur eine Sache auf einmal. Die ausführliche Methodik mit allen Schritten folgt in Modul 09; hier geht es um die hardwarespezifischen Techniken.

Am Anfang steht der *POST* (*Power-On Self-Test*), ein Selbsttest, den die Firmware (UEFI/BIOS) beim Einschalten durchführt. Dabei werden CPU, Arbeitsspeicher, Grafik und weitere Grundbausteine geprüft. Besteht der Rechner den Test, startet das Betriebssystem. Findet die Firmware einen Fehler, meldet sie ihn: durch eine Meldung auf dem Bildschirm, durch *Pieptöne* (*Beep-Codes*), durch Anzeigen am Board (Debug-LEDs oder eine zweistellige Codeanzeige) oder gar nicht, wenn nicht einmal ein Bild ausgegeben werden kann. Wichtig: Die Bedeutung der Pieptöne ist vom Hersteller abhängig (zum Beispiel AMI, Award, Phoenix), man muss sie im Handbuch des Mainboards nachschlagen. Ein langer Ton mit mehreren kurzen kann bei einem Hersteller “RAM-Fehler” und bei einem anderen “Grafikfehler” heißen.

Die häufigsten Ursachen lassen sich in Gruppen ordnen. *Stromprobleme*: Netzkabel nicht gesteckt, Steckdosenleiste ausgeschaltet, Netzteilschalter auf Aus, Netzteil defekt oder überlastet, Gehäuseschalter-Kabel am Board nicht richtig verbunden. *Verbindungsprobleme*: Kabel locker, Speichermodule oder Grafikkarte nicht richtig eingesteckt, Monitor am falschen Eingang. *Wärmeprobleme*: Verstaubte Lüfter, ausgefallene Lüfter, fehlende oder getrocknete Wärmeleitpaste, gestaute Luft im Gehäuse; typische Zeichen sind plötzliche Abschaltungen oder Neustarts unter Last, laute Lüfter und Leistungseinbrüche durch Thermal Throttling. *Bauteildefekte*: defekter RAM, ausgefallene Festplatte (Klickgeräusche, nicht erkannt), leere CMOS-Batterie (Uhrzeit springt, Einstellungen gehen verloren). Für die Diagnose hilft das Prinzip *bekanntes gutes Teil tauschen*: Man ersetzt ein verdächtiges Bauteil testweise durch eines, von dem man weiß, dass es funktioniert, und schließt so Ursachen aus.

Für alle Arbeiten im Gerät gelten Sicherheitsregeln. Vor dem Öffnen wird der Rechner ausgeschaltet und vom Netz getrennt. Netzteile werden nie geöffnet, denn ihre Kondensatoren können auch nach dem Ausschalten gefährliche Spannung enthalten. Gegen *elektrostatische Entladung* (*ESD*), die empfindliche Chips zerstören kann, nutzt man ein Antistatik-Armband oder berührt vor der Arbeit ein geerdetes Metallteil; Bauteile werden nur an den Kanten angefasst und in Antistatik-Beuteln gelagert. Beim Reinigen mit Druckluft werden die Lüfterflügel festgehalten, damit sich der Lüfter nicht überdreht. Akkus werden nicht durchstochen oder gequetscht, und schwere Geräte hebt man mit geradem Rücken.

Das folgende Beispiel baut ein kleines Hilfsprogramm, das zu einem Symptom einen geordneten Prüfplan ausgibt. Es soll nicht die Erfahrung ersetzen, sondern zeigen, wie ein systematischer Plan aussieht und wie man unbekannte Symptome behandelt.

```python
SYMPTOME = {
    "kein Bild, keine Luefter": [
        "Netzkabel und Steckdosenleiste pruefen",
        "Netzteilschalter auf I (Ein)",
        "Frontpanel-Kabel am Mainboard pruefen"],
    "Luefter drehen, kein Bild": [
        "Monitorkabel und Eingang pruefen",
        "RAM neu stecken",
        "Grafikkarte neu stecken"],
    "Neustarts unter Last": [
        "CPU-Temperatur pruefen",
        "Staub aus Luefter und Kuehlkoerper entfernen",
        "Netzteil-Leistung pruefen"],
}

def pruefplan(symptom):
    schritte = SYMPTOME.get(symptom)
    if schritte is None:
        return ["Symptom genauer beschreiben (Wann? Seit wann? Was wurde geaendert?)"]
    return schritte

for s in ["Neustarts unter Last", "Blauer Bildschirm"]:
    print(f"Symptom: {s}")
    for nr, schritt in enumerate(pruefplan(s), start=1):
        print(f"  {nr}. {schritt}")
```

Das Dictionary `SYMPTOME` ordnet jedem Symptom eine Liste von Prüfschritten zu, geordnet von einfach nach aufwendig. Die Funktion `pruefplan` sucht mit `.get` den Plan; `.get` liefert `None`, wenn das Symptom nicht vorhanden ist, ohne dass das Programm abbricht (ein einfacher Zugriff mit eckigen Klammern würde in diesem Fall einen Fehler auslösen). Bei unbekannten Symptomen gibt die Funktion keine Vermutung ab, sondern fordert eine genauere Beschreibung. Die Schleife nummeriert die Schritte mit `enumerate(..., start=1)`. Für “Neustarts unter Last” entsteht ein dreistufiger Plan, für “Blauer Bildschirm” erscheint der Hinweis zur genaueren Beschreibung, weil der Fall (ein Softwarefehler, Modul 03) hier nicht abgedeckt ist.

### Typische Fehler.

Falsch ist das “Schrotflintenverfahren”, mehrere Teile gleichzeitig zu tauschen: Dann ist unklar, was das Problem gelöst hat, und neue Fehler können entstehen. Richtig ist: eine Änderung, ein Test, Ergebnis notieren. Falsch ist auch, direkt das teuerste Teil zu verdächtigen. Der häufigste Fehler im Support ist ein loses Kabel oder eine ausgeschaltete Steckdose; deshalb beginnt jede Diagnose mit dem Einfachsten. Beim Umgang mit Hardware ist der gefährlichste Fehler, ohne Trennung vom Netz zu arbeiten.

### Praxisbezug.

Meldet ein Anwender “Der PC geht nicht an”, fragt der Support zuerst, ob Lichter leuchten, ob Lüfter laufen und ob der Monitor ein Signal anzeigt. Aus den Antworten ergibt sich, ob die Ursache bei Strom, Bild oder Boot liegt. Ein Foto vom Bildschirm mit der Fehlermeldung oder vom Boardcode spart Rückfragen.

> **Merke**
>
> Symptom beschreiben, Ursachen sammeln, Einfaches zuerst prüfen, immer nur eine Änderung, Ergebnis dokumentieren. Beep-Codes sind herstellerspezifisch. Vor dem Öffnen: ausschalten, Netz trennen, ESD-Schutz beachten.

## Übungsaufgaben Modul 02

1.  Nennen Sie fünf Bestandteile eines Desktop-Mainboards und beschreiben Sie in je einem Satz die Aufgabe.

2.  Ein Kunde möchte ein Mini-ITX-Board in ein Gehäuse für Micro-ATX einbauen und ein ATX-Board in ein Mini-ITX-Gehäuse. Beurteilen Sie beide Fälle und begründen Sie die Antwort.

3.  Erklären Sie den Unterschied zwischen Takt, Kernen und Threads und beantworten Sie: Warum kann ein Prozessor mit weniger GHz schneller sein als einer mit mehr GHz?

4.  Ordnen Sie nach Geschwindigkeit (schnell bis langsam): Festplatte, L1-Cache, RAM, SATA-SSD, L3-Cache. Beschreiben Sie, was passiert, wenn der RAM voll ist.

5.  Ein Notebook hat einen 48-Wh-Akku und verbraucht im Büroalltag durchschnittlich 12 Watt. Wie lange läuft es (ohne Alterung)? Eine Powerbank ist mit 20 000 mAh bei 3,7 V beschriftet. Wie viele Wh sind das, und darf sie nach den in diesem Modul genannten Regeln ohne Genehmigung im Handgepäck mitgenommen werden?

6.  **Praxis:** Schreiben Sie ein Programm, das die Kapazität einer Festplatte in GB (1 000er-Rechnung) einliest und die im Betriebssystem angezeigte Größe in GiB (1 024er-Rechnung) ausgibt. Testen Sie mit 1000 GB.

7.  **Praxis:** Erweitern Sie das Programm aus Abschnitt 2.6 um zwei Schnittstellen (HDMI 2.0 mit 18 Gbit/s, DisplayPort 1.4 mit 32,4 Gbit/s) und geben Sie zusätzlich aus, ob ein 4K-Videostrom von etwa 12 Gbit/s Datenrate noch übertragen werden kann. Beachten Sie die Kodierung (nutzbar etwa 80 Prozent).

8.  **Praxis:** Ergänzen Sie das Troubleshooting-Programm um das Symptom “Festplatte klickt, Rechner startet nicht” mit mindestens vier Prüfschritten. Begründen Sie die Reihenfolge und erklären Sie, warum bei diesem Symptom die Datensicherung Vorrang vor der Reparatur hat.

## Lösungen Modul 02

1.  Beispiele: Prozessorsockel (nimmt die CPU auf), RAM-Steckplätze (Arbeitsspeichermodule), Chipsatz (verteilt den Datenverkehr), PCIe-Steckplätze (Erweiterungskarten wie Grafikkarte), M.2/SATA (Massenspeicher), 24-poliger Stromanschluss (Versorgung), UEFI-Chip (Firmware), CMOS-Batterie (Uhrzeit und Einstellungen). Fünf davon genügen.

2.  Mini-ITX in Micro-ATX-Gehäuse: Das funktioniert in der Regel, weil Gehäuse kleinere Boards der gleichen Familie aufnehmen (die Befestigungslöcher sind für Mini-ITX meist vorhanden). ATX in Mini-ITX-Gehäuse: Geht nicht, das Board ist größer als das Gehäuse. Maßgeblich ist immer die Herstellerangabe des Gehäuses.

3.  Der Takt ist die Zahl der Arbeitstakte pro Sekunde, Kerne sind echte parallele Recheneinheiten, Threads sind logische Befehlsströme (ein Kern kann zwei verwalten). Ein Prozessor mit geringerem Takt kann schneller sein, wenn die Architektur pro Takt mehr Arbeit erledigt, mehr Kerne hat, einen größeren Cache besitzt oder weniger durch Hitze gedrosselt wird.

4.  L1-Cache, L3-Cache, RAM, SATA-SSD, Festplatte. Ist der RAM voll, lagert das Betriebssystem Daten in die Auslagerungsdatei auf dem Massenspeicher aus; das macht den Rechner deutlich langsamer (Thrashing, wenn es dauerhaft geschieht).

5.  48 Wh geteilt durch 12 W ergeben 4 Stunden. Die Powerbank hat 20 Ah mal 3,7 V gleich 74 Wh. Das ist unter 100 Wh, sie darf nach den genannten Regeln im Handgepäck mitgenommen werden (nicht im aufgegebenen Gepäck, und die Regeln der Fluggesellschaft sind zu prüfen).

6.  Beispiellösung:

    ```python
    gb = 1000
    byte = gb * 10**9
    gib = byte / 1024**3
    print(f"{gb} GB entsprechen {gib:.1f} GiB")
    ```

    Ausgabe: 1000 GB entsprechen 931.3 GiB. Die Differenz entsteht, weil ein Gibibyte 1 073 741 824 Byte hat und ein Gigabyte nur eine Milliarde.

7.  Beispiellösung (Ergänzungen und Prüfung):

    ```python
    SCHNITTSTELLEN["HDMI 2.0"] = 18
    SCHNITTSTELLEN["DisplayPort 1.4"] = 32.4
    STROM_GBIT = 12
    for name in ("HDMI 2.0", "DisplayPort 1.4"):
        nutzbar = SCHNITTSTELLEN[name] * 0.8
        print(name, "reicht" if nutzbar >= STROM_GBIT else "reicht nicht")
    ```

    HDMI 2.0 hat nutzbar etwa 14,4 Gbit/s (80 Prozent von 18), das reicht für 12 Gbit/s; DisplayPort 1.4 mit etwa 25,9 Gbit/s reicht erst recht. In der Praxis hängt es zusätzlich von Auflösung, Bildwiederholrate und Farbtiefe ab.

8.  Beispiellösung: `"Festplatte klickt, Rechner startet nicht": ["Rechner ausschalten, um weitere Schäden zu vermeiden", "Daten sichern, falls möglich (Festplatte ausbauen, an anderes System anschließen)", "Kabel und Stromanschluss der Festplatte prüfen", "Festplatte in einem anderen Rechner testen", "Bei Defekt Festplatte ersetzen und aus dem Backup wiederherstellen"]`. Die Reihenfolge schützt zuerst die Daten, weil jeder weitere Betrieb eines mechanisch beschädigten Laufwerks den Schaden vergrößern kann; die Reparatur der Hardware lässt sich später nachholen, verlorene Daten nicht.
