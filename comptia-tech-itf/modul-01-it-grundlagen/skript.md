# Modul 1 - IT-Grundlagen, Terminologie und Pruefungslandkarte

> **Hinweis zu diesem Kapitel:** Das ist das Kapitel des Skripts „CompTIA Tech+ / ITF+ (FC0-U71): Lernskript in Modulen“, aus der LaTeX-Quelle in Markdown umgewandelt (Text und Listings unverändert, Boxen als Zitatblöcke, Aufgaben und Lösungen als nummerierte Listen). Laut Skript wurden die Python-Beispiele bei der Erstellung im Arbeitsbereich ausgeführt, die gezeigten Ausgaben stammen aus diesen Läufen; Windows- und PowerShell-Befehle wurden nicht ausgeführt. Für dieses Repository wurden die Listings **nicht erneut ausgeführt**. Prüfungsdetails, Produktnamen und Versionen ändern sich; maßgeblich sind die aktuellen Prüfungsziele (Exam Objectives) von CompTIA. Übersicht zum Modul: [README](README.md).

**Dauer:** 6 h

**Priorität:** 1 (höchste)

| Nr. | Lerneinheit                          | Dauer (h) | Prio |
|----:|:-------------------------------------|----------:|-----:|
| 1.1 | Was ist IT?                          |      0,75 |    1 |
| 1.2 | Digitale Geräte und Formfaktoren     |      0,75 |    1 |
| 1.3 | Daten, Information und Wissen        |      0,75 |    1 |
| 1.4 | Analoge und digitale Signale         |      0,75 |    2 |
| 1.5 | IT-Rollen und Arbeitsfelder          |      0,75 |    2 |
| 1.6 | Architekturüberblick                 |      0,75 |    1 |
| 1.7 | Prüfungsdomänen CompTIA Tech+ / ITF+ |      0,75 |    2 |
| 1.8 | Lernmethodik und Glossar             |      0,75 |    3 |
|     | **Summe**                            |     **6** |      |

Das erste Modul legt das Fundament für den gesamten Kurs. Es klärt, womit sich Informationstechnik überhaupt beschäftigt, welche Arten von Geräten es gibt, wie aus Zeichen und Signalen nützliche Information wird, wer in einer IT-Organisation welche Aufgabe übernimmt und wie die Bausteine grundsätzlich zusammenspielen. Zusätzlich verschafft es eine Landkarte der Prüfung, damit jede spätere Lerneinheit einem Prüfungsbereich zugeordnet werden kann. Die Beispiele sind bewusst klein und in Python geschrieben, weil man damit jede Idee in wenigen Zeilen ausprobieren kann. Wer Python noch nicht kennt, muss nichts vorab lernen: Jedes Beispiel wird zeilenweise erklärt, und die Sprache selbst wird erst in Modul 07 systematisch eingeführt.

## 1.1 Was ist IT?

Die Abkürzung IT steht für Informationstechnik, im Englischen *Information Technology*. Gemeint ist die Gesamtheit aller Mittel, mit denen Informationen erfasst, gespeichert, verarbeitet, übertragen und dargestellt werden. Dazu gehören die Geräte selbst (Hardware), die Programme, die auf ihnen laufen (Software), die Netzwerke, die sie verbinden, und die Daten, die dabei entstehen. Im Alltag begegnet man dem Begriff meist in der Form “Die IT ist schuld”, was bereits zeigt, dass IT als Dienstleistung wahrgenommen wird: Sie ist nur dann sichtbar, wenn sie nicht funktioniert.

Für den fachlichen Gebrauch lohnt es sich, IT als Zusammenspiel von drei Säulen zu verstehen: Menschen, Prozesse und Technik. Die Technik allein löst kein Problem, solange niemand weiß, wie man sie bedient, und solange es keinen geregelten Ablauf gibt, wer sie wann einsetzt und wer bei Störungen zuständig ist. Ein neues Buchhaltungsprogramm ist ein gutes Beispiel: Die Software kann hervorragend sein, doch ohne Schulung der Mitarbeitenden (Menschen) und ohne definierten Ablauf für Rechnungsfreigaben (Prozess) bleibt der Nutzen aus. Dieses Dreieck taucht in der gesamten Prüfungsliteratur immer wieder auf und ist auch in Modul 09 (Servicebetrieb) und Modul 11 (Governance) wichtig.

Damit man sich verständigen kann, braucht es einige Grundbegriffe, die oft vermischt werden. Ein *System* ist eine Menge zusammenwirkender Bestandteile, die gemeinsam eine Aufgabe erfüllen, etwa ein Computersystem aus Hardware und Betriebssystem. Eine *Anwendung* (englisch *Application*) ist ein Programm, mit dem ein Benutzer eine konkrete Aufgabe erledigt, zum Beispiel ein Textverarbeitungsprogramm. Ein *Dienst* (*Service*) ist eine Funktion, die im Hintergrund oder über ein Netzwerk angeboten wird, etwa ein Druckdienst oder ein Namensdienst, und den andere Programme oder Geräte nutzen. Eine *Plattform* schließlich ist eine Grundlage, auf der andere Software aufbaut, beispielsweise ein Betriebssystem oder ein Cloud-Anbieter, der Entwicklern Laufzeitumgebungen bereitstellt. Die Grenzen sind fließend: Dasselbe Produkt kann je nach Blickwinkel Anwendung, Dienst oder Plattform sein, ein Browser etwa ist für den Nutzer eine Anwendung und für eine Webseite die Plattform, auf der sie läuft.

Hardware und Software lassen sich am einfachsten über das Anfassen unterscheiden: Hardware sind die greifbaren Teile wie Prozessor, Arbeitsspeicher, Festplatte, Bildschirm. Software sind die Anweisungen und Daten, die auf dieser Hardware gespeichert und ausgeführt werden. Dazwischen liegt die *Firmware*, fest mit einem Gerät verbundene Software, etwa das UEFI/BIOS eines Mainboards oder das Programm in einem Router. Die Software wird wiederum in System-, Anwendungs- und Programmiersoftware gegliedert; das Betriebssystem als wichtigste Systemsoftware ist Thema von Modul 03.

Wie sich diese Begriffe in der Praxis überprüfen lassen, zeigt das folgende Beispiel. Das Python-Programm fragt den Computer, auf dem es läuft, nach seinen wichtigsten Eigenschaften und gibt eine kleine Bestandsaufnahme aus. Genau so beginnt in vielen Firmen die Arbeit der IT: mit einer Inventarisierung, also der Frage “Was haben wir eigentlich?”.

```python
import platform, os, shutil

print("Betriebssystem :", platform.system(), platform.release())
print("Architektur    :", platform.machine())
print("Python-Version :", platform.python_version())
print("CPU-Kerne      :", os.cpu_count())
gesamt, belegt, frei = shutil.disk_usage("/")
print(f"Speicherplatz  : {gesamt / 10**9:.1f} GB gesamt, {frei / 10**9:.1f} GB frei")
```

Die erste Zeile lädt drei Module der Python-Standardbibliothek: `platform` liefert Informationen über das System, `os` über das Betriebssystem und `shutil` Werkzeuge für Dateien und Laufwerke. `platform.system()` gibt den Namen des Betriebssystems zurück (etwa `Windows`, `Linux` oder `Darwin` für macOS), `platform.machine()` die Prozessorarchitektur wie `AMD64` oder `x86_64`. `os.cpu_count()` nennt die Anzahl der logischen Prozessorkerne. `shutil.disk_usage` liefert drei Zahlen in Byte, die hier den Variablen zugewiesen werden; die letzte Zeile rechnet sie in Gigabyte um und formatiert sie mit einer Nachkommastelle. Auf einem Windows-Rechner wäre der Pfad `"C:\\"` statt `"/"` anzugeben. Auf dem Testsystem für dieses Skript lieferte das Programm unter anderem `Linux`, `x86_64` und zwei Kerne; auf dem eigenen Gerät werden die Werte anders aussehen.

### Typische Fehler.

Ein verbreiteter Irrtum ist die Gleichsetzung von IT mit “Computer reparieren”. Falsch ist die Vorstellung, die IT bestehe nur aus Technik; richtig ist, dass Menschen und Prozesse gleichberechtigt dazugehören. Ebenso falsch ist, Hardware und Software für austauschbare Begriffe zu halten: Ein Treiber, der nicht funktioniert, ist ein Softwareproblem, auch wenn das Gerät, das er steuert, einwandfrei läuft. Gegenbeispiel aus der Praxis: “Der Drucker ist kaputt” stellt sich häufig als fehlender oder veralteter Treiber heraus, also als Softwareproblem, und wird dann nicht durch einen neuen Drucker, sondern durch eine Treiberinstallation gelöst.

### Praxisbezug.

In jedem Unternehmen wird IT sichtbar, wenn ein neuer Mitarbeiter anfängt: Er benötigt ein Gerät (Hardware), ein Benutzerkonto und Programme (Software), Zugriff auf das Netzwerk und auf Dienste wie E-Mail sowie eine Einweisung (Mensch) nach einem festgelegten Ablauf (Prozess). Wer dieses Beispiel erklären kann, hat die Grundbegriffe verstanden.

> **Merke**
>
> IT = Menschen + Prozesse + Technik. Hardware ist greifbar, Software besteht aus Anweisungen, Firmware liegt dazwischen. Anwendung, Dienst und Plattform bezeichnen verschiedene Rollen, die dasselbe Produkt je nach Blickwinkel einnehmen kann.

## 1.2 Digitale Geräte und Formfaktoren

Ein *Formfaktor* beschreibt die äußere Bauform und Größe eines Geräts und damit auch, wo und wie es eingesetzt werden kann. Die Wahl des Formfaktors ist nie Selbstzweck, sondern folgt dem Einsatzzweck: Wer ein Gerät trägt, braucht Akku und geringes Gewicht, wer rechnen lässt, braucht Kühlung und Leistung, wer es tief in eine Maschine einbaut, braucht Robustheit und Sparsamkeit.

Der *Desktop-Rechner* ist stationär, besteht oft aus Gehäuse (Tower), Monitor, Tastatur und Maus und bietet für denselben Preis die meiste Leistung, weil Platz für Kühlung und austauschbare Komponenten vorhanden ist. Er lässt sich leicht aufrüsten und reparieren, ist aber nicht mobil. Varianten sind der kompakte Mini-PC und der All-in-One, bei dem der Rechner im Monitorgehäuse sitzt. Das *Notebook* (Laptop) vereint Rechner, Bildschirm, Tastatur und Akku in einem klappbaren Gehäuse. Es ist mobil, aber teurer für gleiche Leistung, schwerer zu reparieren und thermisch begrenzt. *Tablets* und *Smartphones* sind berührungsempfindliche Geräte ohne klassische Tastatur. Sie sind sehr mobil, stromsparend und meist mit Mobilfunk ausgestattet, bieten aber weniger Anschlüsse, begrenzten Speicher und eingeschränkte Möglichkeiten, Software frei zu installieren. *Wearables* wie Smartwatches sind am Körper getragene Kleingeräte, die meist mit einem Smartphone zusammenarbeiten.

Eine ganz eigene Klasse bilden *Embedded-Systeme*, eingebettete Rechner, die als Bestandteil eines größeren Geräts eine feste Aufgabe erfüllen, etwa die Steuerung einer Waschmaschine, eines Autos, eines Thermostats oder eines Druckers. Sie haben oft keine Bildschirm- oder Tastaturschnittstelle, laufen ohne Benutzer und sind auf geringe Kosten, niedrigen Stromverbrauch und Zuverlässigkeit optimiert. Mikrocontroller wie in Arduino-Boards und Einplatinencomputer wie der Raspberry Pi sind bekannte Vertreter, wobei Letzterer auch als vollwertiger Kleinrechner genutzt werden kann. Wenn viele solcher Geräte vernetzt sind, spricht man vom *Internet der Dinge* (*Internet of Things*, IoT). Auf der anderen Seite des Spektrums stehen *Server*: leistungsfähige Rechner, die rund um die Uhr Dienste für andere Geräte bereitstellen. Sie gibt es als Tower, als flache Einschubgeräte für Schränke (*Rack-Server*) oder als noch dichter gepackte *Blade-Server*.

Wichtig für das Verständnis ist, dass sich die Geräteklassen in vier Dimensionen unterscheiden: Mobilität, Leistung, Erweiterbarkeit und Bedienung. Ein sinnvoller Auswahlprozess beginnt immer mit Anforderungen und leitet daraus die Geräteklasse ab. Das folgende Beispiel bildet diese Denkweise nach: Es speichert die Geräteklassen mit ihren Eigenschaften in einer Datenstruktur und filtert sie nach Anforderungen.

```python
geraete = {
    "Desktop":    {"mobil": False, "akku": False, "eingabe": "Tastatur/Maus"},
    "Notebook":   {"mobil": True,  "akku": True,  "eingabe": "Tastatur/Touchpad"},
    "Tablet":     {"mobil": True,  "akku": True,  "eingabe": "Touchscreen"},
    "Smartphone": {"mobil": True,  "akku": True,  "eingabe": "Touchscreen"},
    "Embedded":   {"mobil": False, "akku": False, "eingabe": "keine/Sensoren"},
}

def passende_geraete(mobil_noetig, akku_noetig):
    treffer = []
    for name, eigenschaften in geraete.items():
        if mobil_noetig and not eigenschaften["mobil"]:
            continue
        if akku_noetig and not eigenschaften["akku"]:
            continue
        treffer.append(name)
    return treffer

print("Mobil mit Akku:", passende_geraete(True, True))
print("Ohne Vorgaben :", passende_geraete(False, False))
```

Das *Dictionary* `geraete` ordnet jedem Namen wieder ein Dictionary mit Eigenschaften zu; geschweifte Klammern und Doppelpunkte bilden dabei Schlüssel-Wert-Paare. Die Funktion `passende_geraete` durchläuft alle Einträge in einer Schleife. Die erste `if`-Abfrage überspringt mit `continue` jedes Gerät, das nicht mobil ist, falls Mobilität verlangt wird; die zweite tut dasselbe für den Akku. Was übrig bleibt, wird in die Liste `treffer` aufgenommen und zurückgegeben. Der erste Aufruf liefert `['Notebook', 'Tablet', 'Smartphone']`, der zweite alle fünf Geräte, weil ohne Anforderungen nichts ausgefiltert wird. Der Wert des Beispiels liegt weniger im Code als in der Methode: Erst Anforderungen formulieren, dann Kandidaten filtern.

### Typische Fehler.

Falsch ist, ein Tablet oder Smartphone für “einen kleinen Computer” ohne Besonderheiten zu halten. Richtig ist, dass diese Geräte mit abgeschottetem Betriebssystem und App-Stores arbeiten, was Sicherheit erhöht und Freiheit einschränkt. Ebenfalls falsch ist die Annahme “mehr Leistung ist immer besser”: Ein Embedded-System für einen Temperaturfühler muss nicht schnell sein, sondern jahrelang mit einer Batterie auskommen. Ein Klassiker bei Einkaufsentscheidungen ist es, Notebooks für feste Arbeitsplätze zu kaufen, obwohl ein Desktop bei gleichen Kosten mehr Leistung und längere Lebensdauer bietet.

### Praxisbezug.

Beim Ausstatten einer Firma entscheidet die Tätigkeit: Außendienstmitarbeiter bekommen Notebooks oder Tablets, Konstrukteure leistungsstarke Desktops, das Lager robuste Handscanner (Embedded mit Touchdisplay), die Haustechnik vernetzte Sensoren. Das Rechenzentrum besteht aus Servern im Rack.

## 1.3 Daten, Information und Wissen

Die drei Begriffe Daten, Information und Wissen werden im Alltag gleichgesetzt, haben aber in der IT unterschiedliche Bedeutungen. *Daten* sind Zeichen oder Messwerte ohne Zusammenhang und ohne Bedeutung: die Zahl 38,5 ist ein Datum. *Information* entsteht, wenn Daten in einen Zusammenhang gestellt werden: “Die Körpertemperatur des Patienten beträgt 38,5 Grad Celsius” lässt sich verstehen und prüfen. *Wissen* entsteht, wenn jemand Informationen mit Erfahrung verknüpft und daraus eine Handlungsregel ableitet: “Über 38 Grad liegt Fieber vor; der Patient sollte beobachtet und gegebenenfalls behandelt werden.” Dieser Dreischritt wird häufig als Wissenspyramide (englisch DIKW: Data, Information, Knowledge, Wisdom) dargestellt, wobei *Weisheit* die kluge Anwendung von Wissen in neuen Situationen meint.

Für die IT folgt daraus ein Gedanke, der sich durch den ganzen Kurs zieht: Computer speichern und verarbeiten Daten, aber nur der Zusammenhang macht daraus etwas Nützliches. Ein Datenbankeintrag “4711” bedeutet nichts, solange nicht bekannt ist, dass es sich um eine Kundennummer handelt. Deshalb sind *Metadaten*, also Daten über Daten, so wichtig: Die Spaltenüberschrift, der Datentyp, das Erstelldatum oder der Autor einer Datei geben den Rohdaten ihren Kontext.

Daten lassen sich nach ihrer Ordnung unterscheiden. *Strukturierte Daten* folgen einem festen Schema mit definierten Feldern und Typen. Sie lassen sich in Tabellen ablegen und einfach abfragen, typisch sind Kundenlisten in einer Datenbank oder eine CSV-Datei (*Comma-Separated Values*, Werte mit Trennzeichen). *Semistrukturierte Daten* besitzen eine erkennbare Struktur, aber kein starres Schema, zum Beispiel JSON (*JavaScript Object Notation*) oder XML. *Unstrukturierte Daten* haben keine einheitliche Gliederung: Freitext, E-Mails, Bilder, Audio, Video. Man schätzt, dass der größte Teil der in Unternehmen anfallenden Daten unstrukturiert ist, weshalb Suche und Auswertung hier deutlich schwieriger sind. Die Verarbeitung und Speicherung der drei Arten ist Gegenstand von Modul 06.

Der Weg von Daten zu Wissen lässt sich im Programm nachvollziehen. Das folgende Beispiel beginnt mit rohen Messwerten, errechnet daraus Kennzahlen (Information) und leitet eine Handlungsregel ab (Wissen). Anschließend liest es strukturierte Daten aus einer CSV-Zeichenkette und semistrukturierte Daten aus JSON und zählt die Wörter eines unstrukturierten Textes.

```python
import csv, io, json

messwerte = [21.5, 22.0, 23.1, 30.4, 22.8]      # Daten

mittel = sum(messwerte) / len(messwerte)         # Information
maximum = max(messwerte)
print(f"Mittelwert {mittel:.1f} Grad, Maximum {maximum} Grad")

if maximum > mittel + 5:                         # Wissen: Regel
    print("Ausreisser erkannt: Sensor pruefen oder Lueftung kontrollieren")

csv_text = "id,name,abteilung\n1,Anna,Support\n2,Bernd,Entwicklung\n"
for zeile in csv.DictReader(io.StringIO(csv_text)):
    print(zeile["name"], "arbeitet in", zeile["abteilung"])

json_text = '{"id": 3, "name": "Clara", "rollen": ["Admin", "Security"]}'
person = json.loads(json_text)
print(person["name"], "hat", len(person["rollen"]), "Rollen")

freitext = "Drucker im 2. Stock macht seit heute Morgen komische Geraeusche."
print("Woerter im Freitext:", len(freitext.split()))
```

Die Liste `messwerte` sind reine Daten. Aus ihr berechnen `sum`, `len` und `max` Mittelwert und Maximum, die Information liefern: Das Maximum von 30,4 liegt deutlich über dem Mittelwert von 24,0. Erst die `if`-Regel macht daraus Wissen, indem sie eine Handlung auslöst, wenn das Maximum mehr als fünf Grad über dem Mittel liegt. Der Schwellwert von fünf Grad ist eine Annahme und stammt aus Erfahrung, nicht aus den Daten. Die CSV-Zeichenkette hat eine Kopfzeile, die den Spalten Namen gibt; `csv.DictReader` liest jede weitere Zeile als Dictionary, sodass man über den Spaltennamen zugreifen kann. Beim JSON-Text wandelt `json.loads` die Zeichenkette in Python-Objekte um, wobei die verschachtelte Liste `rollen` erhalten bleibt. Beim Freitext bleibt nur das primitive Zerlegen in Wörter; eine inhaltliche Auswertung wäre ungleich aufwendiger.

### Typische Fehler.

Falsch ist die Aussage “Viele Daten sind gleich viel Wissen”. Richtig ist, dass große Datenmengen ohne Kontext oder mit schlechter Qualität zu falschen Entscheidungen führen können (Modul 06 behandelt Datenqualität). Ein zweites Missverständnis betrifft den Begriff “unstrukturiert”: Eine E-Mail hat Absender, Betreff und Datum und ist daher teilstrukturiert; der Nachrichtentext darin ist unstrukturiert. Auch Dateiendungen werden gern überschätzt: Eine Datei mit der Endung `.csv` ist nicht automatisch korrekt strukturiert, wenn sie Kommas im Text enthält, die nicht in Anführungszeichen stehen.

### Praxisbezug.

Ein Online-Shop speichert Bestellungen strukturiert in einer Datenbank (Daten), erzeugt daraus Umsatzberichte (Information) und entscheidet auf Basis von Erfahrung, welche Produkte vor Weihnachten nachbestellt werden (Wissen). Support-Mails und Kundenbewertungen bleiben unstrukturiert, werden aber zunehmend automatisch ausgewertet.

> **Merke**
>
> Daten sind Rohwerte, Information ist Daten mit Kontext, Wissen ist Information mit Erfahrung und Handlungsregel. Strukturiert = festes Schema (Tabelle, CSV), semistrukturiert = flexible Struktur (JSON, XML), unstrukturiert = keine Ordnung (Text, Bild, Audio).

## 1.4 Analoge und digitale Signale

Ein *Signal* ist die physikalische Darstellung einer Information, zum Beispiel Schalldruck, Lichtstärke oder elektrische Spannung. *Analoge Signale* sind kontinuierlich: Sie können jeden beliebigen Wert in einem Bereich annehmen, und zwischen zwei Werten liegen unendlich viele weitere. Das Quecksilber im klassischen Thermometer, die Rille einer Schallplatte und die Spannung eines Mikrofons sind analog. *Digitale Signale* sind dagegen diskret: Sie nehmen nur eine begrenzte Menge fester Werte an, im Rechner genau zwei, die man als 0 und 1 schreibt. Diese kleinste Informationseinheit heißt *Bit* (*binary digit*). Acht Bit ergeben ein *Byte*, in dem 256 verschiedene Werte (von 0 bis 255) Platz haben.

Warum arbeiten Computer digital? Zwei Zustände lassen sich elektrisch sehr zuverlässig unterscheiden, etwa hohe und niedrige Spannung. Störungen wie Rauschen verfälschen ein analoges Signal unwiederbringlich, ein digitales Signal kann dagegen so lange korrekt wiederhergestellt werden, wie die Störung die Unterscheidung von 0 und 1 nicht unmöglich macht. Digitale Daten lassen sich außerdem verlustfrei kopieren, komprimieren, verschlüsseln und über beliebige Entfernungen übertragen.

Um die analoge Welt in den Rechner zu bringen, wird ein Signal in zwei Schritten digitalisiert. Beim *Abtasten* (*Sampling*) wird der Signalwert in regelmäßigen Zeitabständen gemessen; die Anzahl der Messungen pro Sekunde heißt *Abtastrate*. Beim *Quantisieren* wird jeder Messwert auf die nächste von endlich vielen Stufen gerundet; die Zahl der Stufen ergibt sich aus der Zahl der Bit pro Messwert, bei 8 Bit sind es 256, bei 16 Bit 65 536. Eine Audio-CD verwendet beispielsweise 44 100 Messungen pro Sekunde mit 16 Bit je Messwert. Nach dem Abtasttheorem von Nyquist und Shannon muss die Abtastrate mehr als doppelt so hoch sein wie die höchste Frequenz im Signal, damit sie sich rekonstruieren lässt; da das menschliche Gehör bis etwa 20 kHz reicht, genügen gut 40 kHz.

Das folgende Beispiel führt die Quantisierung mit nur drei Bit vor, damit die Rundungsfehler sichtbar werden. Es tastet eine Sinusschwingung an acht Zeitpunkten ab und rundet jeden Wert auf eine von acht Stufen. Danach rechnet es noch aus, wie lange die Übertragung einer Datei mindestens dauert.

```python
import math

def quantisieren(wert, bits):
    stufen = 2 ** bits
    index = round((wert + 1) / 2 * (stufen - 1))
    return index, index / (stufen - 1) * 2 - 1

bits = 3
print(f"{bits} Bit = {2**bits} Stufen")
for t in range(8):
    analog = math.sin(2 * math.pi * t / 8)
    index, digital = quantisieren(analog, bits)
    print(f"t={t} analog={analog:+.3f} Stufe={index} ({index:0{bits}b}) digital={digital:+.3f}")

datei_mb = 250
leitung_mbit = 100
sekunden = datei_mb * 8 / leitung_mbit
print(f"{datei_mb} MB bei {leitung_mbit} Mbit/s dauern mindestens {sekunden:.0f} s")
```

Die Funktion `quantisieren` erwartet einen Wert zwischen $-1$ und $+1$. Sie verschiebt ihn auf den Bereich 0 bis 1, skaliert ihn auf die Anzahl der Stufen minus eins, rundet mit `round` auf eine ganze Zahl (den Stufenindex) und rechnet diesen zurück in einen Wert zwischen $-1$ und $+1$. In der Schleife wird eine Sinusschwingung mit acht Messpunkten erzeugt. Die Ausgabe zeigt zum Beispiel, dass der analoge Wert 0,000 zu Stufe 4 (binär `100`) wird und als 0,143 wiederkommt: Mit drei Bit gibt es keinen Stufenwert genau bei null, die Abweichung heißt *Quantisierungsfehler*. Mit mehr Bit werden die Stufen feiner und der Fehler kleiner. Die formatierte Ausgabe `index:0{bits}b` gibt den Index mit führenden Nullen binär aus. Im zweiten Teil wird die Dateigröße von Megabyte in Megabit umgerechnet (mal acht) und durch die Leitungsgeschwindigkeit geteilt: 250 MB entsprechen 2 000 Mbit, geteilt durch 100 Mbit/s ergibt 20 Sekunden.

Für den Alltag in der IT sind zwei Kenngrößen entscheidend, die oft verwechselt werden. Die *Bandbreite* (genauer: Datenrate) gibt an, wie viele Bit pro Sekunde über eine Verbindung übertragen werden können, vergleichbar mit der Breite einer Straße. Die *Latenz* ist die Verzögerung, bis ein einzelnes Datenpaket ankommt, vergleichbar mit der Fahrzeit auf dieser Straße; sie wird in Millisekunden angegeben und ist durch Entfernung, Signalgeschwindigkeit und Geräte auf dem Weg begrenzt. Eine Satellitenverbindung kann eine hohe Bandbreite haben und trotzdem eine hohe Latenz von mehreren hundert Millisekunden, weil das Signal Zehntausende Kilometer ins All und zurück laufen muss. Für Dateidownloads zählt die Bandbreite, für Videotelefonie und Online-Spiele ebenso die Latenz.

> **Ergänzung aus der Nachrecherche**
>
> Vorsilben bei Größenangaben werden zweifach benutzt: Nach dem internationalen Einheitensystem (SI) bedeutet Kilo 1 000, Mega 1 000 000 und Giga eine Milliarde. Binäre Vielfache wie $2^{10}=1\,024$ heißen nach der Norm IEC offiziell Kibi (KiB), Mebi (MiB) und Gibi (GiB). Hersteller von Datenträgern rechnen mit 1 000er-Schritten, manche Betriebssysteme zeigen Binärwerte an. Deshalb zeigt eine “500-GB-Festplatte” im System etwa 465 GiB an. Das ist kein Mangel, sondern ein Einheitenunterschied. Dieser Hinweis beruht auf allgemeinem Fachwissen und wurde nicht an einer Normquelle geprüft.

### Typische Fehler.

Der häufigste Fehler ist die Verwechslung von Bit und Byte: Providerangaben erfolgen in Megabit pro Sekunde, Dateigrößen in Megabyte. Falsch: “Bei 100 Mbit/s lade ich 100 MB pro Sekunde herunter.” Richtig: Es sind höchstens 12,5 MB pro Sekunde, weil ein Byte acht Bit hat, und praktisch etwas weniger wegen des Protokoll-Overheads. Ebenso falsch ist es, Latenz mit Geschwindigkeit gleichzusetzen: Eine Leitung mit 1 Gbit/s kann dennoch eine hohe Latenz haben.

### Praxisbezug.

Wenn ein Videoanruf stockt, obwohl der Speedtest eine hohe Bandbreite zeigt, liegt die Ursache oft in Latenz oder Paketverlust, etwa durch ein überlastetes WLAN. Mit dem Befehl `ping` kann man die Latenz direkt messen; mehr dazu in Modul 04.

## 1.5 IT-Rollen und Arbeitsfelder

IT-Aufgaben verteilen sich in Organisationen auf unterschiedliche Rollen. Je kleiner die Firma, desto mehr davon vereint eine einzelne Person; in großen Unternehmen sind sie in spezialisierten Teams organisiert. Für die Prüfung genügt eine Grobkenntnis, im Berufsleben ist es entscheidend, den richtigen Ansprechpartner zu kennen.

Der *Support* (auch Service Desk oder Helpdesk) ist die erste Anlaufstelle für Anwender. Er nimmt Störungen und Anfragen entgegen, löst einfache Probleme direkt (Passwort zurücksetzen, Drucker neu installieren) und gibt komplexere Fälle weiter. Üblich ist eine gestaffelte Organisation: Der *First-Level-Support* bearbeitet Standardfälle anhand von Anleitungen, der *Second-Level-Support* übernimmt tiefergehende Analysen, der *Third-Level-Support* besteht aus Spezialisten oder Herstellern. Die *Administration* betreibt und wartet die Systeme: Systemadministratoren pflegen Server, Benutzerkonten und Updates, Netzwerkadministratoren die Verbindungen, Datenbankadministratoren die Datenbanken. Die *Entwicklung* (Softwareentwicklung) schreibt und pflegt Programme. Dazu zählen Frontend-Entwickler (Benutzeroberfläche), Backend-Entwickler (Logik und Datenhaltung) und Tester. Im Bereich *DevOps* wachsen Entwicklung und Betrieb zusammen, damit Software schneller und zuverlässiger ausgeliefert wird. Die *IT-Sicherheit* (Security) schützt Systeme und Daten, plant Schutzmaßnahmen und untersucht Sicherheitsvorfälle. Daneben gibt es Rollen wie Datenanalyst, IT-Architekt, Projektleiter oder Datenschutzbeauftragte, die an der Schnittstelle zu anderen Bereichen arbeiten.

Entscheidend ist die *Schnittstelle zwischen Fachbereich und IT*. Der Fachbereich (zum Beispiel Buchhaltung, Vertrieb oder Produktion) kennt seine Fachaufgabe, aber nicht unbedingt die Technik; die IT kennt die Technik, aber nicht unbedingt die Fachaufgabe. Missverständnisse entstehen, wenn beide dieselben Wörter anders verwenden. Gute Zusammenarbeit beginnt mit einer klaren Beschreibung des Bedarfs aus Sicht des Anwenders (“Wir müssen Rechnungen digital freigeben”) statt einer vorschnell vorgegebenen Lösung (“Wir brauchen Programm X”). Vereinbarungen über Reaktions- und Lösungszeiten heißen *Service Level Agreements* (SLA).

Wie die Zuordnung funktioniert, soll ein kleines Beispiel demonstrieren: Meldungen werden anhand von Stichworten automatisch an die zuständige Rolle weitergeleitet, wie es viele Ticketsysteme mit Regeln tun. Das Programm ist vereinfacht, zeigt aber den Gedanken der Zuständigkeit.

```python
ROUTING = {
    "Support":        ["passwort", "drucker", "outlook", "bildschirm"],
    "Administration": ["server", "backup", "netzwerk", "berechtigung"],
    "Entwicklung":    ["fehler in der app", "neue funktion", "schnittstelle"],
    "Security":       ["phishing", "virus", "verdaechtig", "datenleck"],
}

def zustaendig(meldung):
    text = meldung.lower()
    for rolle, stichworte in ROUTING.items():
        if any(wort in text for wort in stichworte):
            return rolle
    return "Support"

tickets = [
    "Ich habe mein Passwort vergessen",
    "Verdaechtige Mail mit Anhang erhalten",
    "Neue Funktion fuer das Kundenportal gewuenscht",
    "Backup von gestern Nacht ist fehlgeschlagen",
]
for t in tickets:
    print(f"{zustaendig(t):15} <- {t}")
```

Das Dictionary `ROUTING` ordnet jeder Rolle eine Liste von Stichworten zu. Die Funktion `zustaendig` wandelt die Meldung zuerst mit `lower()` in Kleinbuchstaben um, damit Groß- und Kleinschreibung keine Rolle spielen. Dann prüft sie für jede Rolle mit `any(...)`, ob mindestens ein Stichwort im Text vorkommt, und gibt die erste passende Rolle zurück. Findet sich nichts, landet die Meldung beim Support, der bewusst als Standard-Anlaufstelle definiert ist. Die Ausgabe ordnet das Passwort-Ticket dem Support zu, die verdächtige Mail der Security, den Funktionswunsch der Entwicklung und das fehlgeschlagene Backup der Administration. Auffällig ist die Reihenfolge der Prüfung: Enthielte ein Ticket Stichworte mehrerer Rollen, gewönne die erste im Dictionary; echte Systeme gewichten solche Regeln, was bereits zeigt, dass Zuständigkeit nicht immer eindeutig ist.

### Typische Fehler.

Falsch ist es, jede Störung am Benutzer vorbei sofort an die Administration zu geben; richtig ist, zuerst die Standardfälle am Service Desk zu lösen und nur bei Bedarf zu eskalieren (weiterzureichen). Falsch ist auch, dass Sicherheit “nur Sache der Security-Abteilung” sei: Jeder Benutzer, der einen Phishing-Link anklickt, ist Teil der Sicherheitskette. Ein typischer Fehler bei Eskalationen besteht darin, ein Ticket ohne ausreichende Beschreibung weiterzureichen, sodass die nächste Ebene dieselben Fragen noch einmal stellen muss.

### Praxisbezug.

In kleinen Firmen ist “der IT-Mensch” oft Support, Administrator und Einkäufer in einer Person. Wer sich auf Stellen im IT-Support bewirbt, wird am Anfang meist im First-Level eingesetzt und lernt dort die Systeme der Firma kennen. Von dort führt der Weg in Administration, Security oder Entwicklung.

## 1.6 Architekturüberblick

Eine *IT-Architektur* beschreibt, aus welchen Bausteinen ein System besteht und wie diese zusammenwirken. Auf der einfachsten Ebene gibt es nur zwei Rollen: Ein *Client* fordert eine Leistung an, ein *Server* erbringt sie. Dieses Prinzip heißt *Client-Server-Modell* und ist die Grundlage des Webs, von E-Mail, Dateifreigaben und Datenbanken. Der Browser ist der Client, der Webserver liefert die Seite. Wichtig ist, dass “Server” hier eine Rolle in der Kommunikation bezeichnet, nicht zwingend ein besonders großes Gerät: Auch ein Notebook kann Server sein, wenn es einen Dienst anbietet.

Beim *Peer-to-Peer-Modell* (P2P) gibt es diese feste Rollenverteilung nicht. Alle Teilnehmer sind gleichberechtigt und bieten gleichzeitig Leistungen an und nutzen sie. Beispiele sind Tauschbörsen und manche Blockchain-Netze, außerdem die einfache Dateifreigabe zwischen zwei Arbeitsplatzrechnern. P2P ist bei wenigen Teilnehmern einfach einzurichten, lässt sich aber schlechter zentral verwalten und absichern. In Unternehmen dominiert deshalb das Client-Server-Modell mit zentraler Benutzerverwaltung.

Größere Anwendungen werden meist in Schichten gegliedert. Die klassische *Drei-Schichten-Architektur* (*Three-Tier*) trennt die *Präsentationsschicht* (Oberfläche, die der Benutzer sieht), die *Anwendungsschicht* (Geschäftslogik, also die Regeln) und die *Datenschicht* (Datenbank). Der Datenfluss einer Anfrage läuft von oben nach unten und zurück: Der Benutzer klickt im Browser auf “Bestellen”, die Oberfläche schickt eine Anfrage an die Anwendung, die Anwendung prüft die Regeln, fragt oder schreibt in der Datenbank und schickt das Ergebnis zurück, das als Bestätigung angezeigt wird. Der Vorteil der Trennung liegt darin, dass sich jede Schicht für sich ändern, absichern und skalieren lässt.

Der Ort, an dem die Bausteine laufen, ist die zweite Dimension. Beim klassischen *On-Premises*-Betrieb stehen die Server im eigenen Rechenzentrum. Bei der *Cloud* mieten Unternehmen Rechenleistung, Speicher oder fertige Anwendungen bei einem Anbieter und zahlen nach Nutzung. Je nach Umfang unterscheidet man *IaaS* (Infrastruktur als Dienst: virtuelle Server und Netz), *PaaS* (Plattform als Dienst: Laufzeitumgebung für eigenen Code) und *SaaS* (Software als Dienst: fertige Anwendung wie Webmail). Nach Eigentümer und Nutzerkreis gibt es *Public*, *Private* und *Hybrid Cloud*. Details dazu behandelt Modul 08.

Das folgende Beispiel baut Client und Server in einem einzigen Python-Programm nach. Der Server hört auf eine Adresse, der Client schickt eine Anfrage nach dem HTTP-Protokoll, und der Server antwortet.

```python
import threading, urllib.request
from http.server import BaseHTTPRequestHandler, HTTPServer

class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        antwort = f"Hallo vom Server, du hast {self.path} angefragt\n".encode("utf-8")
        self.send_response(200)
        self.send_header("Content-Type", "text/plain; charset=utf-8")
        self.send_header("Content-Length", str(len(antwort)))
        self.end_headers()
        self.wfile.write(antwort)
    def log_message(self, *args):
        pass

server = HTTPServer(("127.0.0.1", 8080), Handler)
threading.Thread(target=server.serve_forever, daemon=True).start()

with urllib.request.urlopen("http://127.0.0.1:8080/produkte") as r:
    print("Status:", r.status)
    print("Inhalt:", r.read().decode("utf-8").strip())

server.shutdown()
```

Die Klasse `Handler` beschreibt, wie der Server auf eine `GET`-Anfrage reagiert: Er baut eine Antwort aus dem angefragten Pfad (`self.path`) auf, sendet den Statuscode 200 (“in Ordnung”), die Kopfzeilen (Typ und Länge des Inhalts) und schließlich den Inhalt selbst. Die Methode `log_message` wird überschrieben, damit der Server keine Protokollzeilen in die Konsole schreibt. `HTTPServer` öffnet an der Adresse `127.0.0.1` (die eigene Maschine, *localhost*) den Port 8080. Der Server wird in einem eigenen Thread gestartet, damit das Programm gleichzeitig als Client auftreten kann. `urllib.request.urlopen` schickt die Anfrage, und die Ausgabe zeigt Status `200` und den Text mit dem Pfad `/produkte`. Am Ende beendet `server.shutdown()` den Dienst. Wer das Programm im Browser nachvollziehen möchte, kann die Zeile `server.shutdown()` entfernen und `http://127.0.0.1:8080/` aufrufen.

### Typische Fehler.

Falsch ist die Vorstellung “Server = großer Rechner im Keller”. Richtig: Server ist eine Rolle, die auch ein virtueller Rechner oder ein kleiner Raspberry Pi übernehmen kann. Ebenfalls falsch ist “Cloud = Internet”: Das Internet ist das Netzwerk, die Cloud ist ein Betriebsmodell für Dienste, das über dieses Netzwerk erreicht wird. Eine typische Stolperfalle im Beispiel ist ein belegter Port: Läuft bereits ein Programm auf Port 8080, endet der Start mit der Fehlermeldung `Address already in use`. Man wählt dann einen anderen Port.

### Praxisbezug.

Wenn eine Webseite nicht lädt, hilft das Schichtenmodell bei der Fehlersuche: Antwortet der Server überhaupt (Netzwerk, Webserver)? Läuft die Anwendung (Logik)? Ist die Datenbank erreichbar (Daten)? So lässt sich der Fehler Schicht für Schicht eingrenzen, ein Vorgehen, das in Modul 09 als Troubleshooting-Methodik vertieft wird.

> **Merke**
>
> Client fordert an, Server erbringt die Leistung. P2P: alle Teilnehmer gleichberechtigt. Drei Schichten: Präsentation, Logik, Daten. Cloud-Dienste: IaaS (Infrastruktur), PaaS (Plattform), SaaS (Software).

## 1.7 Prüfungsdomänen CompTIA Tech+ / ITF+

Die Zertifizierung, auf die dieses Skript vorbereitet, wird von CompTIA angeboten. Der frühere Name lautete *IT Fundamentals+* (ITF+, Prüfungscode FC0-U61); die aktuelle Version heißt *Tech+* (Prüfungscode FC0-U71). Sie richtet sich an Einsteiger ohne Vorerfahrung und prüft, ob jemand die grundlegenden Begriffe, Komponenten und Zusammenhänge der IT kennt, die in jedem Beruf mit Technik-Berührung vorkommen. Sie ist keine Voraussetzung für höhere Zertifizierungen, wird aber oft als Einstieg und Orientierung genutzt.

Die Prüfung ist in sechs Wissensbereiche, die *Domänen*, gegliedert. Jede Domäne hat ein prozentuales Gewicht, das ihren Anteil an den Prüfungsfragen angibt. Die Gewichte sind die wichtigste Information für die Lernplanung: Je höher der Anteil, desto mehr Zeit sollte ein Bereich bekommen, wobei auch kleine Bereiche bestanden werden müssen, um insgesamt eine hohe Punktzahl zu erreichen. Die folgende Tabelle ordnet die Domänen den Modulen dieses Skripts zu. Die Zuordnung ist eine Einschätzung des Skripts und keine offizielle Vorgabe, weil sich der Lehrplan thematisch, nicht eins zu eins nach den Prüfungsdomänen gliedert.

> **Ergänzung aus der Nachrecherche**
>
> Laut der CompTIA-Zertifizierungsseite (abgerufen) hat die Prüfung Tech+ (V6) den Code FC0-U71, wurde am 16.07.2024 veröffentlicht, umfasst höchstens 70 Multiple-Choice-Fragen und dauert 60 Minuten. Bestanden ist sie ab 650 von 900 Punkten. Prüfungssprachen sind Englisch und Japanisch; deshalb sollten die englischen Fachbegriffe parallel gelernt werden. Gewichte der Domänen: Tech-Konzepte und Terminologie 13 %, Infrastruktur 24 %, Anwendungen und Software 18 %, Softwareentwicklungskonzepte 13 %, Daten- und Datenbankgrundlagen 13 %, Sicherheit 19 %. Zur Prüfungsgebühr, zu den exakten Prüfungszielen (Exam Objectives) und zur Ausmusterung der Vorgängerversion stand auf der abgerufenen Seite nichts; dies ist bei CompTIA nachzulesen. Eine Drittanbieter-Seite (Global Knowledge) nennt dieselben Prüfungsdaten.

| Domäne (Prüfung)               | Anteil | Schwerpunkt in diesem Skript |
|:-------------------------------|-------:|:-----------------------------|
| Tech-Konzepte und Terminologie |   13 % | Modul 01                     |
| Infrastruktur                  |   24 % | Module 02, 03, 04, 08, 09    |
| Anwendungen und Software       |   18 % | Module 03, 05                |
| Softwareentwicklungskonzepte   |   13 % | Modul 07                     |
| Daten- und Datenbankgrundlagen |   13 % | Modul 06                     |
| Sicherheit                     |   19 % | Module 10, 11, 12            |

Aus den Gewichten lässt sich ein Lernplan ableiten. Das folgende Beispiel verteilt eine vorgegebene Lernzeit proportional auf die Domänen. Die Zahl der verfügbaren Stunden ist ein Parameter, den jeder selbst einsetzt.

```python
DOMAENEN = {
    "Tech-Konzepte und Terminologie": 13,
    "Infrastruktur": 24,
    "Anwendungen und Software": 18,
    "Softwareentwicklung": 13,
    "Daten und Datenbanken": 13,
    "Sicherheit": 19,
}
assert sum(DOMAENEN.values()) == 100

lernstunden = 40
print(f"Lernplan fuer {lernstunden} Stunden")
for name, prozent in sorted(DOMAENEN.items(), key=lambda x: -x[1]):
    print(f"{name:32} {prozent:3d} %  ->  {lernstunden * prozent / 100:5.1f} h")
```

Das Dictionary enthält die sechs Domänen mit ihren Prozentwerten. Die `assert`-Zeile ist eine Schutzprüfung: Sie bricht das Programm mit einer Fehlermeldung ab, wenn die Summe nicht 100 ergibt, was Tippfehler sofort aufdeckt. In der Schleife sortiert `sorted` die Einträge absteigend nach Prozentwert (`key=lambda x: -x[1]` sortiert nach dem negativen Wert), und die formatierte Ausgabe rechnet für jede Domäne den Anteil an den Lernstunden aus. Bei 40 Stunden erhält die Infrastruktur 9,6 Stunden, die Sicherheit 7,6 und jede der drei Domänen mit 13 Prozent 5,2 Stunden. Die rechte Spalte der Ausgabe richtet das Format `5.1f` an der Dezimalstelle aus.

Eine Lernstrategie ergibt sich aus Gewichtung und Vorwissen: Bereiche mit hohem Gewicht und wenig Vorwissen zuerst, Bereiche mit Vorwissen später und kürzer. Wichtig ist außerdem, dass die Prüfung nicht nur Begriffe abfragt, sondern oft kurze Szenarien beschreibt, in denen die richtige Maßnahme oder der passende Begriff gewählt werden muss. Deshalb genügt reines Vokabellernen nicht; die Lerneinheiten dieses Skripts enthalten daher Beispiele und Fehlerbilder.

### Typische Fehler.

Falsch ist es, nur die Lieblingsthemen zu lernen: Bei einer Gewichtung von 24 Prozent für Infrastruktur und 19 Prozent für Sicherheit rächt sich ein Auslassen dieser Bereiche besonders. Ebenso falsch ist, sich ausschließlich auf deutsche Begriffe zu verlassen, obwohl die Prüfung auf Englisch (oder Japanisch) angeboten wird. Ein dritter Fehler ist, Prüfungsangaben aus Foren oder älteren Skripten zu übernehmen: Gewichte, Fragezahlen und Bestehensgrenzen ändern sich mit den Versionen, daher stets die aktuellen Exam Objectives von CompTIA heranziehen.

### Praxisbezug.

Ein Auszubildender im ersten Lehrjahr nutzt die Prüfung als Selbsttest: Wo liegen die Lücken? Ein Quereinsteiger nutzt sie, um seine Kenntnisse gegenüber Arbeitgebern nachzuweisen. In beiden Fällen ist der Wert größer, wenn der Lernplan an den Gewichten ausgerichtet wird.

## 1.8 Lernmethodik und Glossar

Wer ein Fachgebiet mit vielen neuen Begriffen lernt, braucht eine Methode, die Wissen dauerhaft verankert. Die Lernforschung hat mehrere Verfahren gut belegt. Das wichtigste ist das *aktive Abrufen* (*Active Recall*): Man liest nicht nur nach, sondern versucht, sich ohne Hilfe zu erinnern, und prüft danach, ob die Antwort stimmt. Das Abrufen selbst festigt das Gedächtnis stärker als erneutes Lesen. Das zweite Verfahren ist das *verteilte Wiederholen* (*Spaced Repetition*): Statt alles an einem Abend zu wiederholen, werden Inhalte in wachsenden Abständen wiederholt, kurz bevor man sie vergessen würde. Grundlage ist die von Hermann Ebbinghaus beschriebene Vergessenskurve, nach der Gelerntes zuerst schnell verblasst und dann langsamer.

Praktisch umgesetzt werden beide Verfahren mit *Karteikarten* (*Flashcards*). Im *Leitner-System* liegen die Karten in mehreren Fächern: Neue Karten starten in Fach 1 und werden oft abgefragt. Wird eine Karte richtig beantwortet, rutscht sie ein Fach weiter und wird seltener abgefragt; wird sie falsch beantwortet, wandert sie zurück in Fach 1. Dadurch verbringt man Zeit vor allem mit dem, was noch nicht sitzt. Ergänzend hilft die *Feynman-Methode*: einen Begriff so erklären, als sollte ihn eine Person ohne Vorwissen verstehen, und an den Stellen nachbessern, an denen die Erklärung stockt.

In der IT gehört dazu das *Glossar*. Die Fachsprache ist voll von Akronymen und englischen Begriffen, die man beim Hören wie beim Lesen sicher zuordnen muss. Ein gutes Glossar erfasst den Begriff, die ausgeschriebene Form, die deutsche Erklärung und, wo es hilft, die Aussprache. Die korrekte Aussprache ist kein Detail: Wer im Gespräch oder im Prüfungsvideo “SQL” als “Ess-Kju-Ell” oder “Sequel” hört, muss beides zuordnen können. Einige Beispiele sind *GUI* (“Gui”, Grafische Benutzeroberfläche), *SaaS* (“Saas”), *WAN* (“Wän”), *NAS* (“Nass”), *SCSI* (“Skasi”) und *IEEE* (“I-Triple-E”). Am Ende dieses Moduls steht eine kleine Startliste für das Glossar.

Neben dem Glossar helfen *Lab-Protokolle*. Ein Lab ist eine praktische Übung, etwa das Anlegen eines Benutzers, das Prüfen einer Netzwerkverbindung oder der Aufbau einer virtuellen Maschine. Das Protokoll hält fest: Datum und Ziel, die verwendeten Systeme, die ausgeführten Schritte (mit Befehlen), das Ergebnis, aufgetretene Fehler und deren Lösung. Es dient später als Nachschlagewerk und trainiert genau die Dokumentationsdisziplin, die im Beruf gefordert ist (Modul 09). Ein einfaches Muster ist eine Textdatei oder ein Notizbuch pro Übung mit festen Überschriften.

Das folgende Programm bildet das Leitner-System nach. Es hält für jeden Begriff das aktuelle Fach fest, verändert es je nach Antwort und listet am Ende die Karten, sortiert nach Fach, sodass die am wenigsten gefestigten zuerst erscheinen.

```python
glossar = {
    "RAM": "fluechtiger Arbeitsspeicher",
    "DNS": "uebersetzt Namen in IP-Adressen",
    "MFA": "Anmeldung mit mindestens zwei Faktoren",
    "SSD": "Massenspeicher ohne bewegliche Teile",
}
faecher = {begriff: 1 for begriff in glossar}

def antworten(begriff, richtig):
    if richtig:
        faecher[begriff] = min(faecher[begriff] + 1, 3)
    else:
        faecher[begriff] = 1

antworten("RAM", True); antworten("RAM", True)
antworten("DNS", True); antworten("DNS", False)
antworten("MFA", True)

for begriff, fach in sorted(faecher.items(), key=lambda x: x[1]):
    print(f"Fach {fach}: {begriff:4} - {glossar[begriff]}")
```

Das Dictionary `glossar` ist die Wissensbasis. Die Zeile `faecher = {begriff: 1 for begriff in glossar}` ist eine sogenannte Dictionary-Abkürzung und setzt jede Karte zu Beginn in Fach 1. Die Funktion `antworten` erhöht bei einer richtigen Antwort das Fach um eins, höchstens aber bis 3, und setzt bei einer falschen Antwort zurück auf 1. Die Aufrufe darunter simulieren Antworten: RAM zweimal richtig (Fach 3), DNS einmal richtig und dann falsch (zurück auf Fach 1), MFA einmal richtig (Fach 2). Die Ausgabe zeigt zuerst DNS und SSD in Fach 1, dann MFA in Fach 2 und RAM in Fach 3. Wer das Programm zu einem echten Lerntool ausbaut, ersetzt die simulierten Antworten durch Eingaben mit `input()` und speichert den Zustand in einer Datei.

### Typische Fehler.

Falsch ist, einen Text dreimal zu lesen und für gelernt zu halten; die Vertrautheit beim Lesen täuscht Wissen vor. Richtig ist, nach jeder Lerneinheit ohne Vorlage aufzuschreiben, was man behalten hat. Falsch ist auch, das Glossar erst kurz vor der Prüfung anzulegen: Dann fehlt der Zeitraum für die Wiederholung in wachsenden Abständen. Ein häufiger Fehler bei Lab-Protokollen ist, nur Erfolge festzuhalten; gerade die Fehler mit ihrer Lösung sind später am wertvollsten.

### Praxisbezug.

Im Beruf übernimmt das Wissensmanagement derselbe Gedanke: Eine Wissensdatenbank im Support (Modul 09) sammelt Lösungen aus gelösten Tickets. Wer privat ein Lab-Protokoll führt, übt also schon die Arbeitsweise im Service Desk.

> **Ergänzung aus der Nachrecherche**
>
> Die Prüfungssprache ist laut CompTIA Englisch (und Japanisch). Hilfreich ist deshalb ein zweisprachiges Glossar. Startliste mit den wichtigsten Begriffen aus diesem Modul: Hardware (Hardware), Software (Software), Firmware (Firmware), Client (Client), Server (Server), Peer-to-Peer (P2P), Bandwidth (Bandbreite), Latency (Latenz), Structured/Unstructured Data (strukturierte/unstrukturierte Daten), Metadata (Metadaten), Service Desk (Service-Desk), Escalation (Eskalation), Form Factor (Formfaktor). Diese Liste ist eine eigene Zusammenstellung und kein offizielles Prüfungsglossar.

## Übungsaufgaben Modul 01

1.  Erklären Sie in zwei bis drei Sätzen, warum IT mehr ist als Technik. Nennen Sie die drei Säulen und ein Beispiel dafür, was passiert, wenn eine davon fehlt.

2.  Ordnen Sie die folgenden Gegenstände den Kategorien Hardware, Software oder Firmware zu: Mainboard, Betriebssystem, UEFI/BIOS eines Mainboards, Textverarbeitung, Netzwerkkabel, das Programm in einem Router.

3.  Ein Außendienstmitarbeiter präsentiert unterwegs Kunden Angebote und füllt dabei Formulare aus. Welche Geräteklasse empfehlen Sie, und welche Eigenschaften der Klasse begründen die Empfehlung? Nennen Sie auch einen Grund, der gegen ein Smartphone als einziges Gerät spricht.

4.  Klassifizieren Sie als Daten, Information oder Wissen: (a) die Zahl 4711, (b) “Kundennummer 4711 hat im Oktober 3 Bestellungen aufgegeben”, (c) “Kunden mit mehr als zwei Bestellungen pro Monat erhalten einen Treuebonus.”

5.  Eine Providerleitung hat 200 Mbit/s. Wie viele Megabyte pro Sekunde sind das höchstens? Wie lange dauert der Download einer Datei mit 1,5 GB (1 GB = 1 000 MB) mindestens? Rechnen Sie ohne Protokoll-Overhead.

6.  **Praxis:** Schreiben Sie ein Python-Programm, das eine Dateigröße in Byte (als Zahl im Programm) einliest und sie in KB, MB und GB (SI, Faktor 1 000) ausgibt, jeweils mit zwei Nachkommastellen. Testen Sie mit 3 500 000 Byte.

7.  **Praxis:** Erweitern Sie das Routing-Beispiel aus Abschnitt 1.5 um eine fünfte Rolle “Datenbank” mit mindestens drei Stichworten und testen Sie es mit zwei neuen Tickets. Beschreiben Sie, was geschieht, wenn ein Ticket Stichworte aus zwei Rollen enthält.

8.  **Praxis:** Schreiben Sie ein Programm, das mit dem Modul `http.server` einen kleinen Webserver auf Port 8081 startet, der auf jede Anfrage mit dem Text “Willkommen” antwortet, und rufen Sie ihn mit `urllib.request` auf. Erklären Sie anschließend, welche Rolle Client und Server haben und auf welche Schicht der Drei-Schichten-Architektur das Beispiel nur zutrifft.

9.  Sie haben 30 Stunden Lernzeit. Berechnen Sie mit dem Lernplan-Programm aus Abschnitt 1.7 (Änderung: `lernstunden = 30`), wie viele Stunden auf Infrastruktur und auf Sicherheit entfallen, und erklären Sie, wie Sie die Zeit anpassen würden, wenn Sie in Netzwerken schon viel Vorwissen haben.

## Lösungen Modul 01

1.  IT besteht aus Menschen, Prozessen und Technik. Fehlt der Prozess, weiß niemand, wer wann was tun soll: Ein neues Programm zur Rechnungsfreigabe bleibt ungenutzt, weil nicht festgelegt ist, wer freigibt. Ebenso scheitert Technik ohne geschulte Menschen.

2.  Hardware: Mainboard, Netzwerkkabel. Software: Betriebssystem, Textverarbeitung. Firmware: UEFI/BIOS des Mainboards und das Programm im Router, weil sie fest im Gerät gespeichert sind und das Gerät grundlegend steuern.

3.  Ein Notebook oder Tablet: mobil, Akku, ausreichend Bildschirmgröße und bei Notebook eine Tastatur zum Ausfüllen von Formularen. Gegen das Smartphone als alleiniges Gerät spricht der kleine Bildschirm, der das Arbeiten mit Formularen und Präsentationen erschwert; außerdem fehlen häufig Anschlüsse für Beamer oder Peripherie.

4.  \(a\) Daten (Zahl ohne Kontext), (b) Information (Daten mit Kontext: Kundennummer, Monat, Anzahl), (c) Wissen (aus Information abgeleitete Handlungsregel).

5.  200 Mbit/s geteilt durch 8 sind 25 MB/s. 1,5 GB entsprechen 1 500 MB; geteilt durch 25 MB/s ergibt 60 Sekunden. In der Praxis dauert es etwas länger, weil Protokolle zusätzliche Daten und Verzögerungen erzeugen.

6.  Beispiellösung:

    ```python
    groesse = 3_500_000
    print(f"{groesse / 1000:.2f} KB")
    print(f"{groesse / 1000**2:.2f} MB")
    print(f"{groesse / 1000**3:.2f} GB")
    ```

    Ausgabe: 3500.00 KB, 3.50 MB, 0.00 GB. Der Unterstrich in `3_500_000` dient nur der Lesbarkeit der Zahl. Die Division ergibt einen Gleitkommawert; `:.2f` rundet auf zwei Nachkommastellen. Für 0,0035 GB zeigt die Ausgabe 0.00; ein Wert dieser Größe wird sinnvoller in MB angegeben.

7.  Beispiellösung: Im Dictionary wird ein neuer Eintrag ergänzt, etwa `"Datenbank": ["sql", "tabelle", "abfrage"]`. Tickets wie “Die SQL-Abfrage laeuft sehr langsam” werden dann der Rolle “Datenbank” zugewiesen. Enthält ein Ticket Stichworte aus zwei Rollen (zum Beispiel “Server” und “Passwort”), gewinnt die Rolle, die im Dictionary zuerst steht, weil die Funktion beim ersten Treffer abbricht. Die Reihenfolge ist also eine unsichtbare Priorität; echte Ticketsysteme lösen das mit Gewichtungen oder mit manueller Zuordnung durch den Service Desk.

8.  Beispiellösung:

    ```python
    import threading, urllib.request
    from http.server import BaseHTTPRequestHandler, HTTPServer

    class H(BaseHTTPRequestHandler):
        def do_GET(self):
            text = "Willkommen".encode("utf-8")
            self.send_response(200)
            self.send_header("Content-Length", str(len(text)))
            self.end_headers()
            self.wfile.write(text)

    s = HTTPServer(("127.0.0.1", 8081), H)
    threading.Thread(target=s.serve_forever, daemon=True).start()
    print(urllib.request.urlopen("http://127.0.0.1:8081/").read().decode())
    s.shutdown()
    ```

    Der Client ist `urlopen`, der Server die Klasse `H`. Das Beispiel kennt nur eine einzige Komponente, die Anfragen beantwortet; eine Datenbank oder eine getrennte Oberfläche fehlen. Es entspricht deshalb höchstens der Anwendungsschicht in vereinfachter Form.

9.  Bei 30 Stunden entfallen auf Infrastruktur 7,2 Stunden (24 %) und auf Sicherheit 5,7 Stunden (19 %). Mit gutem Netzwerk-Vorwissen verringert man den Anteil der Infrastruktur (Modul 04 ist Teil davon) und verschiebt die gesparte Zeit auf Domänen mit Wissenslücken, zum Beispiel Softwareentwicklung oder Daten. Das Gesamtgewicht darf nicht vernachlässigt werden: Auch bei Vorwissen sollten die Infrastruktur-Themen wenigstens in einem Testdurchlauf geprüft werden.
