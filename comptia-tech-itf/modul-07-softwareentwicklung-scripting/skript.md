# Modul 7 - Softwareentwicklung, Logik und Scripting-Grundlagen

> **Hinweis zu diesem Kapitel:** Das ist das Kapitel des Skripts „CompTIA Tech+ / ITF+ (FC0-U71): Lernskript in Modulen“, aus der LaTeX-Quelle in Markdown umgewandelt (Text und Listings unverändert, Boxen als Zitatblöcke, Aufgaben und Lösungen als nummerierte Listen). Laut Skript wurden die Python-Beispiele bei der Erstellung im Arbeitsbereich ausgeführt, die gezeigten Ausgaben stammen aus diesen Läufen; Windows- und PowerShell-Befehle wurden nicht ausgeführt. Für dieses Repository wurden die Listings **nicht erneut ausgeführt**. Prüfungsdetails, Produktnamen und Versionen ändern sich; maßgeblich sind die aktuellen Prüfungsziele (Exam Objectives) von CompTIA. Übersicht zum Modul: [README](README.md).

**Dauer:** 7,5 h

**Priorität:** 2

| Nr. | Lerneinheit                             | Dauer (h) | Prio |
|----:|:----------------------------------------|----------:|-----:|
| 7.1 | Von Problem zu Algorithmus              |         1 |    1 |
| 7.2 | Grundbausteine von Code                 |         1 |    1 |
| 7.3 | Kontrollstrukturen                      |         1 |    1 |
| 7.4 | Funktionen und Modularisierung          |      0,75 |    2 |
| 7.5 | Fehlerarten und Debugging               |         1 |    1 |
| 7.6 | Scripting im IT-Alltag                  |      0,75 |    2 |
| 7.7 | Versionskontrolle und Zusammenarbeit    |      0,75 |    2 |
| 7.8 | Sichere und verantwortliche Entwicklung |      1,25 |    1 |
|     | **Summe**                               |   **7,5** |      |

Die Prüfung verlangt kein Programmieren im Sinne von Softwareentwicklung, wohl aber Verständnis für das Denken dahinter: Wie zerlegt man ein Problem in Schritte? Was sind Variablen, Datentypen, Bedingungen und Schleifen? Was tut eine Funktion? Wie findet man Fehler? Wozu dient Versionsverwaltung, und was heißt “sicher entwickeln”? Wer das versteht, kann Skripte lesen, kleine Automatisierungen schreiben und mit Entwicklern sinnvoll reden. Alle Beispiele sind in Python geschrieben, weil die Sprache gut lesbar ist und im IT-Betrieb weit verbreitet. Sie wurden im Arbeitsbereich ausgeführt; die gezeigten Ausgaben stammen aus diesen Läufen. Die Beispiele sind Lehrbeispiele und keine fertigen Produktionswerkzeuge. SQL-Injection wurde in Abschnitt 10.8 behandelt, das systematische Eingrenzen von Störungen in Abschnitt 9.8; hier wird beides auf die Entwicklung bezogen.

## 7.1 Von Problem zu Algorithmus

Ein *Algorithmus* ist eine eindeutige, endliche Folge von Schritten, die ein Problem löst. Das klingt abstrakt, ist aber vertraut: Ein Kochrezept, eine Wegbeschreibung oder die Anleitung zum Zurücksetzen eines Kennworts sind Algorithmen. Programmieren heißt, einen Algorithmus so genau aufzuschreiben, dass ein Computer ihn ausführen kann, der anders als ein Mensch nichts “mitdenkt”, sondern exakt tut, was dasteht. Deshalb beginnt gutes Programmieren nicht am Rechner, sondern mit dem Verstehen der Aufgabe.

Der Weg vom Problem zum Algorithmus folgt meist vier Schritten. Zuerst wird das Problem *präzisiert*: Was kommt hinein (Eingabe), was soll herauskommen (Ausgabe), welche Sonderfälle gibt es (leere Liste, negative Zahl, nichts gefunden)? Dann wird es in *Teilprobleme zerlegt*, bis jedes Stück überschaubar ist (*Dekomposition*). Danach sucht man ein *Muster*, das sich wiederholt (aus “prüfe Laufwerk C, prüfe Laufwerk D, …” wird “für jedes Laufwerk”), und *abstrahiert* von den Einzelheiten. Schließlich formuliert man die Schritte, zunächst in Alltagssprache oder als *Pseudocode*, einer programmiersprachenähnlichen, aber nicht ausführbaren Beschreibung, oder als *Flussdiagramm*, das Abläufe mit Kästchen und Pfeilen zeigt: Ovale für Start und Ende, Rechtecke für Aktionen, Rauten für Entscheidungen. Erst dann wird codiert und getestet.

Beispiel: “Finde die kleinste von mehreren Zahlen.” Als Pseudocode: Wenn die Liste leer ist, gibt es kein Ergebnis. Merke dir die erste Zahl als bisher kleinste. Gehe die übrigen Zahlen der Reihe nach durch; ist eine kleiner als die gemerkte, merke dir stattdessen diese. Am Ende ist die gemerkte Zahl die kleinste. Die Umsetzung in Python folgt Zeile für Zeile; das Programm prüft zusätzlich vier Fälle, darunter die Randfälle eines einzelnen Elements, einer leeren Liste und negativer Zahlen.

```python
def kleinste_zahl(zahlen):
    if not zahlen:
        return None
    kleinste = zahlen[0]
    for z in zahlen[1:]:
        if z < kleinste:
            kleinste = z
    return kleinste

print(kleinste_zahl([7, 3, 9, 3, 12]))
print(kleinste_zahl([5]))
print(kleinste_zahl([]))
print(kleinste_zahl([-2, -8, 0]))
```

Die Funktion `kleinste_zahl` erhält eine Liste. Die erste Bedingung fängt den Sonderfall ab: `not zahlen` ist wahr, wenn die Liste leer ist, dann wird `None` (“nichts”) zurückgegeben. Andernfalls merkt sich die Variable `kleinste` das erste Element (`zahlen[0]`, gezählt wird ab null). Die Schleife `for z in zahlen[1:]` geht die restlichen Elemente durch (`[1:]` bedeutet: ab dem zweiten); ist eines kleiner, ersetzt es den gemerkten Wert. Die vier Aufrufe liefern 3, 5, `None` und $-8$. Man sieht, dass der Algorithmus nach dem Muster “merken und vergleichen” arbeitet und mit Sonderfällen umgehen muss. Die Standardfunktion `min()` leistet dasselbe; es geht hier um das Verstehen des Vorgehens.

Ein weiterer Gesichtspunkt ist die *Effizienz*. Zwei Algorithmen können dasselbe Ergebnis liefern und doch unterschiedlich lang brauchen. Das Suchen in einer ungeordneten Liste muss im schlechtesten Fall alle Elemente ansehen; eine sortierte Liste lässt sich mit *Halbieren* durchsuchen und braucht nur wenige Schritte. In der Prüfung geht es nicht um die Berechnung, aber um die Einsicht, dass die Wahl des Verfahrens Zeit und Ressourcen beeinflusst.

### Typische Fehler.

Falsch ist, sofort zu programmieren, ohne die Aufgabe zu verstehen: Dann löst man oft das falsche Problem. Falsch ist, Sonderfälle zu übersehen: `kleinste = 0` als Startwert wäre falsch, weil bei einer Liste positiver Zahlen nie etwas Kleineres gefunden würde. Richtig ist, mit dem ersten Element zu beginnen. Falsch ist, einen Algorithmus nur mit einem Beispiel zu testen, das zufällig funktioniert.

### Praxisbezug.

Auch ohne Entwickler zu sein, schreibt man im Support laufend Algorithmen: Checklisten, Entscheidungsbäume, Eskalationsabläufe. Wer sie als “wenn …dann …sonst” klar formuliert, kann sie später automatisieren (Abschnitt 12.1).

> **Merke**
>
> Algorithmus = eindeutige, endliche Schrittfolge. Vorgehen: Problem präzisieren, zerlegen, Muster finden, Schritte aufschreiben (Pseudocode, Flussdiagramm), codieren, mit Sonderfällen testen.

## 7.2 Grundbausteine von Code

Jedes Programm arbeitet mit Daten. Eine *Variable* ist ein benannter Platz im Arbeitsspeicher (Modul 2), an dem ein Wert liegt; man kann sie lesen und überschreiben. Der Name soll sagen, was drinsteckt (`anzahl_nutzer` statt `x`). Eine *Konstante* ist ein Wert, der sich nicht ändern soll (der Steuersatz, ein Grenzwert); nach Konvention schreibt man ihren Namen in Großbuchstaben. Jeder Wert hat einen *Datentyp*, der festlegt, was er darstellt und was man damit tun darf: ganze Zahlen (`int`), Dezimalzahlen (`float`), Text (`str`, englisch *string*), Wahrheitswerte (`bool`: `True` oder `False`). Mehrere Werte fasst man zusammen in einer *Liste* (geordnet, über die Position erreichbar) oder in einem *Wörterbuch* (englisch *dictionary*, Zuordnung von Schlüsseln zu Werten, wie bei Modul 6 die Zeile einer Tabelle). Dazu kommen *Operatoren*: rechnen (`+`, `-`, `*`, `/`), Reste (`%`), vergleichen (`==`, `!=`, `<`, `>=`) und logisch verknüpfen (`and`, `or`, `not`).

Das Programm zeigt Typen und einige Stolpersteine, die Anfänger regelmäßig treffen: Text und Zahl sind nicht dasselbe, Dezimalzahlen sind im Rechner ungenau, und die Division liefert eine Dezimalzahl.

```python
name = "Anna"
alter = 34
groesse = 1.68
aktiv = True
modelle = ["Laptop", "Monitor", "Dock"]
preise = {"Laptop": 899.0, "Monitor": 249.5, "Dock": 129.0}
for x in (name, alter, groesse, aktiv, modelle, preise):
    print(type(x).__name__, repr(x))
eingabe = "42"
print(eingabe + eingabe)
print(int(eingabe) + int(eingabe))
print(0.1 + 0.2, round(0.1 + 0.2, 2), 0.1 + 0.2 == 0.3)
print(7 / 2, 7 // 2, 7 % 2)
print(f"{name} ist {alter} Jahre alt")
```

Die ersten sechs Zeilen legen Variablen verschiedener Typen an; die Schleife gibt für jede den Typnamen und den Wert aus (`repr` zeigt Text mit Anführungszeichen). Die Ausgabe lautet `str 'Anna'`, `int 34`, `float 1.68`, `bool True`, `list [...]` und `dict {...}`. Dann folgt der erste Stolperstein: Eine Eingabe von der Tastatur oder aus einer Datei ist immer Text. Für den Text `"42"` ergibt `+` deshalb `4242` (Aneinanderhängen), erst nach `int(...)` ergibt es 84. Der zweite Stolperstein: `0.1 + 0.2` ergibt `0.30000000000000004`, und der Vergleich mit `0.3` ist `False`. Der Grund: Der Rechner speichert Dezimalzahlen binär, und manche Werte (wie 0,1) lassen sich dort nicht exakt darstellen. Man rundet deshalb für die Anzeige (`round`) und vergleicht Dezimalzahlen nie mit `==`; bei Geldbeträgen rechnet man in der kleinsten Einheit (Cent) mit ganzen Zahlen. Die Division `/` liefert immer eine Dezimalzahl (3,5), `//` das ganzzahlige Ergebnis (3), `%` den Rest (1). Zuletzt zeigt der *f-String* (`f"..."`), wie man Werte in Text einsetzt: Alles in geschweiften Klammern wird berechnet und eingefügt.

### Typische Fehler.

Falsch ist, einen Text mit einer Zahl zu addieren (`"Alter: " + 34` ergibt einen Fehler); richtig ist `f"Alter: {alter}"` oder `str(alter)`. Falsch ist ein einzelnes `=` in einem Vergleich: `=` weist zu, `==` vergleicht. Falsch sind nichtssagende Namen und Zahlen, die ohne Erklärung im Code stehen (“magische Zahlen”); besser ist `STEUERSATZ = 0.2`. Falsch ist, Großschreibung zu vernachlässigen: `Name` und `name` sind in Python verschiedene Variablen.

### Praxisbezug.

Konfigurationsdateien (JSON, YAML; Abschnitt 12.2) bestehen aus genau diesen Bausteinen: Wörterbüchern, Listen, Texten, Zahlen und Wahrheitswerten. Wer sie lesen kann, versteht Konfigurationen, Skripte und Protokolle.

## 7.3 Kontrollstrukturen

Ein Programm wäre nutzlos, würde es nur Zeile für Zeile dasselbe tun. *Kontrollstrukturen* steuern den Ablauf. Die *Sequenz* führt Anweisungen nacheinander aus. Die *Verzweigung* (Auswahl) führt je nach Bedingung unterschiedliche Teile aus: `if` (falls), `elif` (andernfalls falls), `else` (sonst). Die *Schleife* wiederholt Anweisungen: `for` durchläuft eine Folge von Elementen (jedes Laufwerk, jede Zeile, jede Zahl von 1 bis 10), `while` wiederholt, solange eine Bedingung gilt. Mit `break` verlässt man eine Schleife vorzeitig, mit `continue` springt man zum nächsten Durchlauf. In Python gehört alles zusammen, was gleich eingerückt ist; die Einrückung ist Teil der Sprache.

Das Programm klassifiziert den Füllstand von Laufwerken und zeigt eine `while`-Schleife sowie eine `for`-Schleife mit `continue`.

```python
def kategorie(prozent):
    if prozent >= 90:
        return "kritisch"
    elif prozent >= 75:
        return "Warnung"
    else:
        return "ok"

laufwerke = {"C:": 91.5, "D:": 40.0, "E:": 75.0}
for name, p in laufwerke.items():
    print(f"{name} {p:5.1f} % -> {kategorie(p)}")

versuche = 0
while versuche < 3:
    versuche += 1
    print("Versuch", versuche)

summe = 0
for i in range(1, 11):
    if i % 2 == 0:
        continue
    summe += i
print("Summe der ungeraden Zahlen 1..10:", summe)
```

Die Funktion `kategorie` prüft die Bedingungen von oben nach unten und gibt beim ersten Treffer das Ergebnis zurück. Deshalb ist die Reihenfolge wichtig: Würde man zuerst auf `>= 75` prüfen, wäre 91,5 Prozent nur “Warnung”. In der Schleife über `laufwerke.items()` erhält man Schlüssel und Wert; `{p:5.1f}` formatiert die Zahl mit einer Nachkommastelle und fünf Zeichen Breite. Ausgabe: C: 91,5 Prozent kritisch, D: 40,0 ok, E: 75,0 Warnung. Das genaue Grenzverhalten (75,0 ist bereits “Warnung”, weil `>=`) ist typisch für Sonderfälle: Ob “ab” oder “über” gelten soll, muss man bewusst festlegen. Die `while`-Schleife zählt `versuche` hoch und endet, wenn die Bedingung nicht mehr stimmt; die Ausgabe zeigt Versuch 1 bis 3. Die letzte Schleife überspringt gerade Zahlen mit `continue`, summiert also 1+3+5+7+9 = 25.

Für Bedingungen sind die logischen Operatoren wichtig. `and` verlangt, dass beide Seiten wahr sind, `or`, dass mindestens eine wahr ist, `not` kehrt um. Die Wahrheitstafeln zu diesen Verknüpfungen bilden die Grundlage der Digitaltechnik und lassen sich durch Ausprobieren verstehen. Beachten muss man außerdem, dass Vergleiche von Bereichen in Python elegant geschrieben werden können (`0 <= wert <= 120`).

### Typische Fehler.

Die gefährlichste Falle ist die *Endlosschleife*: Wer in der `while`-Schleife vergisst, `versuche` zu erhöhen, bekommt ein Programm, das nie endet und die CPU auslastet. Falsch ist ein falsch eingerückter Block, der nur teilweise zur Schleife gehört. Falsch ist auch der Off-by-one-Fehler (“um eins daneben”): `range(1, 10)` reicht nur bis 9, nicht bis 10, weil die obere Grenze nicht dazugehört. Falsch ist, Bedingungen so zu schreiben, dass sie sich überschneiden und der Reihenfolge nach das Falsche gewinnt.

### Praxisbezug.

Ein Überwachungsskript, das jedes Laufwerk prüft und ab 90 Prozent alarmiert, besteht genau aus Schleife und Verzweigung (Abschnitt 9.2). Wenn ein Skript “manchmal hängt”, ist oft eine Schleife ohne Abbruchbedingung die Ursache.

## 7.4 Funktionen und Modularisierung

Eine *Funktion* ist ein benannter Block von Anweisungen, den man mit Eingabewerten (*Parametern*) aufrufen kann und der ein Ergebnis zurückgibt. Funktionen vermeiden Wiederholungen (*DRY*: Don’t Repeat Yourself), machen Programme lesbarer, weil der Name sagt, was geschieht, und lassen sich einzeln testen. Die *Modularisierung* geht einen Schritt weiter: Zusammengehörige Funktionen werden in Dateien (*Module*) und Sammlungen (*Bibliotheken*, *Pakete*) gebündelt, die man in anderen Programmen wiederverwendet. Python bringt eine große Standardbibliothek mit; weitere Pakete installiert man mit dem Paketverwalter `pip`. Hier liegt auch ein Risiko: Fremder Code läuft mit den Rechten des eigenen Programms (Abschnitt 7.8).

Wichtige Begriffe sind *Parameter* (die Platzhalter in der Definition) und *Argumente* (die tatsächlichen Werte beim Aufruf), *Standardwerte* für Parameter, die man weglassen darf, der *Rückgabewert* und der *Gültigkeitsbereich* (*Scope*): Variablen, die innerhalb einer Funktion angelegt werden, existieren nur dort (lokal). Ein *Docstring*, ein Text in dreifachen Anführungszeichen am Beginn der Funktion, dokumentiert ihren Zweck. Das Programm zeigt zwei kleine Funktionen und den Gültigkeitsbereich.

```python
def netto_zu_brutto(netto, steuer=0.20):
    """Rechnet einen Nettobetrag in Brutto um."""
    return round(netto * (1 + steuer), 2)

def formatiere_dauer(sekunden):
    h, rest = divmod(sekunden, 3600)
    m, s = divmod(rest, 60)
    return f"{h:02d}:{m:02d}:{s:02d}"

print(netto_zu_brutto(100))
print(netto_zu_brutto(100, 0.10))
print(formatiere_dauer(3725))
print(formatiere_dauer(59))

x = 10
def aendere():
    x = 99
    return x
print(aendere(), x)
```

`netto_zu_brutto` hat den Parameter `steuer` mit dem Standardwert 0,20; der erste Aufruf nutzt ihn (Ergebnis 120,0), der zweite überschreibt ihn mit 0,10 (Ergebnis 110,0). `formatiere_dauer` zerlegt Sekunden mit `divmod`, das Ganzzahl und Rest zugleich liefert, in Stunden, Minuten und Sekunden; `:02d` füllt auf zwei Stellen mit Nullen auf. 3725 Sekunden ergeben `01:02:05`, 59 Sekunden `00:00:59`. Die letzten Zeilen zeigen den Gültigkeitsbereich: Das `x = 99` in der Funktion legt eine *neue lokale* Variable an und ändert das äußere `x` nicht; die Ausgabe ist `99 10`. Das schützt vor Nebenwirkungen: Eine Funktion soll ihr Ergebnis zurückgeben, nicht heimlich Werte außerhalb verändern.

Gute Funktionen tun *eine* Sache, haben einen aussagekräftigen Namen und wenige Parameter. Daraus ergibt sich auch, wie man Programme gliedert: Eine Funktion liest Daten, eine prüft sie, eine berechnet, eine gibt aus. So kann man jede einzeln testen und austauschen.

### Typische Fehler.

Falsch ist, dieselbe Berechnung an zehn Stellen zu kopieren: Bei einer Änderung vergisst man garantiert eine. Falsch ist, einen veränderbaren Standardwert zu verwenden (zum Beispiel eine leere Liste als Standardargument in Python), weil er zwischen Aufrufen erhalten bleibt. Falsch sind Funktionen, die zugleich lesen, rechnen, ausgeben und Dateien schreiben: Sie lassen sich nicht testen. Falsch ist, ein Paket ungeprüft zu installieren, nur weil der Name passt (*Typosquatting*: Pakete mit absichtlich ähnlichen Namen verbreiten Schadcode).

### Praxisbezug.

Skripte der IT wachsen schnell: Was als Zehnzeiler beginnt, ist nach einem Jahr ein Werkzeug, das alle nutzen. Wer von Anfang an in Funktionen denkt, kann es später pflegen.

## 7.5 Fehlerarten und Debugging

Programme enthalten Fehler (*Bugs*); sie zu finden und zu beheben heißt *Debugging*. Man unterscheidet drei Arten. Ein *Syntaxfehler* verletzt die Schreibregeln der Sprache (fehlende Klammer, falsche Einrückung); das Programm startet gar nicht, und die Fehlermeldung nennt Zeile und Stelle. Ein *Laufzeitfehler* tritt beim Ausführen auf, weil etwas Unmögliches verlangt wird (Division durch null, Datei nicht vorhanden, Text in Zahl umwandeln); das Programm bricht mit einer *Ausnahme* (*Exception*) ab. Ein *logischer Fehler* ist der tückischste: Das Programm läuft ohne Meldung, liefert aber ein falsches Ergebnis, weil der Algorithmus falsch ist. Hier hilft nur Prüfen gegen bekannte Erwartungen.

Das Programm zeigt zunächst eine korrekte und eine logisch fehlerhafte Mittelwertfunktion, dann typische Laufzeitfehler, die abgefangen werden, und schließlich einen einfachen automatischen Test.

```python
def mittelwert(werte):
    return sum(werte) / len(werte)

def mittelwert_fehlerhaft(werte):
    return sum(werte) / (len(werte) + 1)

print(mittelwert([2, 4, 6]))
print(mittelwert_fehlerhaft([2, 4, 6]))
for f in (lambda: int("abc"), lambda: [1, 2][5], lambda: {"a": 1}["b"],
          lambda: 1 / 0, lambda: mittelwert([])):
    try:
        f()
    except Exception as e:
        print(type(e).__name__, "-", e)

def teste(zeilen):
    ok = True
    for eingabe, soll in zeilen:
        ist = mittelwert(eingabe)
        if abs(ist - soll) > 1e-9:
            print("FEHLER", eingabe, "soll", soll, "ist", ist)
            ok = False
    return ok
print(teste([([2, 4, 6], 4), ([10], 10), ([1, 2], 1.5)]))
```

Die richtige Funktion liefert 4,0, die fehlerhafte 3,0 ohne jede Fehlermeldung, ein typischer logischer Fehler (der Nenner ist um eins zu groß). Man erkennt ihn nur, weil man das richtige Ergebnis kennt. Die Schleife führt fünf kleine Funktionen aus, die jeweils einen Laufzeitfehler auslösen, und fängt ihn mit `try/except` ab: Der Versuch, `"abc"` in eine Zahl zu wandeln, löst `ValueError` aus; der Zugriff auf Position 5 einer Liste mit zwei Elementen `IndexError`; ein nicht vorhandener Schlüssel `KeyError`; die Division durch null `ZeroDivisionError`; und der Mittelwert einer leeren Liste ebenfalls `ZeroDivisionError`, weil `len` dort 0 ist. Die Meldung nennt jeweils die Art und eine Erklärung; diese gilt es zu lesen, sie ist der erste Hinweis. Die Testfunktion vergleicht Soll und Ist für drei Fälle (mit einer kleinen Toleranz wegen der Dezimalproblematik aus 7.2) und meldet `True`, wenn alles stimmt. Solche automatischen Tests (*Unit-Tests*) sichern nach jeder Änderung ab, dass nichts kaputtgegangen ist.

Die Vorgehensweise beim Debuggen entspricht der Fehlersuche im Betrieb (Abschnitt 9.8): Fehler reproduzieren, Fehlermeldung genau lesen (von unten nach oben; unten steht die Ursache, darüber der Weg dorthin, der *Stacktrace*), Hypothese bilden, prüfen, jeweils nur eines ändern. Werkzeuge sind Ausgaben mit `print` an kritischen Stellen, ein *Debugger*, der das Programm Schritt für Schritt ausführt und Variablen zeigt, und die *Protokollierung* (Logging; Abschnitt 9.3). Eine beliebte Methode ist das *Rubber-Duck-Debugging*: Man erklärt den Code Zeile für Zeile einer Gummiente, und beim Erklären fällt der Fehler auf.

### Typische Fehler.

Falsch ist, Fehlermeldungen zu ignorieren oder mit einem allgemeinen `except:` alles zu verschlucken: Dann läuft das Programm scheinbar weiter und liefert Unsinn. Falsch ist, mehrere Dinge gleichzeitig zu ändern, weil man danach nicht weiß, was geholfen hat. Falsch ist, nur den “Normalfall” zu testen. Falsch ist, einen Fehler mit einem Trick zu überdecken, statt die Ursache zu beheben.

### Praxisbezug.

“Das Skript hat gestern funktioniert” führt zur Frage: Was hat sich geändert (Eingabedaten, Berechtigungen, Version, Datum)? Die Antwort steht oft im Log oder in der letzten Zeile des Stacktrace.

## 7.6 Scripting im IT-Alltag

Ein *Skript* ist ein kurzes Programm, das wiederkehrende Aufgaben automatisiert; es wird von einem *Interpreter* Zeile für Zeile ausgeführt, ohne vorher übersetzt (kompiliert) zu werden. Im IT-Betrieb sind PowerShell (Windows), Bash (Linux/macOS) und Python verbreitet. Typische Aufgaben: Dateien umbenennen oder aufräumen, Berichte aus Protokollen erzeugen, Benutzer anlegen, Konfigurationen prüfen, Sicherungen starten. Die Grundidee der Automation (Abschnitt 12.1) lautet: Was man dreimal von Hand getan hat, schreibt man als Skript. Ein Skript tut jedes Mal dasselbe und lässt sich überprüfen, dokumentieren und teilen.

Typische Bausteine sind das Lesen und Schreiben von Dateien, das Durchsuchen von Ordnern, die Arbeit mit Textformaten wie CSV (Tabelle als Text), JSON (Wörterbuch als Text) oder Protokollzeilen und der Aufruf anderer Programme. Das Programm erzeugt einen Ordner mit Beispieldateien, sucht alle Protokolldateien (`.log`), sortiert sie nach Größe und schreibt einen CSV-Bericht, den es danach liest.

```python
import csv, pathlib, shutil, tempfile

basis = pathlib.Path(tempfile.mkdtemp())
(basis / "log").mkdir()
for n, g in (("a.log", 120), ("b.log", 4000), ("c.txt", 50), ("d.log", 70000)):
    (basis / "log" / n).write_bytes(b"x" * g)

zeilen = []
for p in sorted((basis / "log").glob("*.log")):
    zeilen.append((p.name, p.stat().st_size))
zeilen.sort(key=lambda z: -z[1])

ziel = basis / "bericht.csv"
with open(ziel, "w", newline="", encoding="utf-8") as f:
    w = csv.writer(f, delimiter=";")
    w.writerow(["datei", "bytes"])
    w.writerows(zeilen)
print(ziel.read_text(encoding="utf-8"))
gross = [n for n, g in zeilen if g > 1000]
print("Groesser als 1000 Byte:", gross)
shutil.rmtree(basis)
```

Zuerst legt das Programm mit `tempfile.mkdtemp()` einen temporären Ordner an, damit nichts Echtes verändert wird, und erzeugt vier Dateien unterschiedlicher Größe. `pathlib.Path` ist der moderne Weg, mit Pfaden umzugehen; der Operator `/` setzt Pfadteile zusammen und funktioniert auf Windows und Linux gleich. `glob("*.log")` liefert alle passenden Dateien (die Textdatei `c.txt` fällt heraus), `stat().st_size` die Größe. Die Sortierung mit `key` und dem Minus ordnet absteigend nach Größe. Der `with`-Block öffnet die Datei und schließt sie sicher wieder, auch bei Fehlern; `newline=""` und die Angabe der Kodierung verhindern Probleme mit Zeilenenden und Umlauten. Die CSV-Datei hat Semikolon als Trennzeichen (in deutschsprachigen Excel-Versionen üblich, weil das Komma dort Dezimalzeichen ist). Die Ausgabe zeigt die Kopfzeile und die Zeilen `d.log;70000`, `b.log;4000`, `a.log;120`, danach die Liste der Dateien über 1000 Byte (`d.log`, `b.log`). Am Ende wird der Testordner entfernt. Vor dem Löschen realer Daten sollte jedes Skript einen Probelauf (*Dry Run*) anbieten, der nur anzeigt, was geschehen würde.

Ein gutes Skript ist *idempotent*: Zweimaliges Ausführen führt zum gleichen Ergebnis wie einmaliges (Abschnitt 12.2). Es prüft Eingaben, gibt verständliche Meldungen aus, schreibt Protokolle, verwendet keine fest einprogrammierten Kennwörter und läuft mit den geringstmöglichen Rechten. Es wird dokumentiert (Zweck, Parameter, Beispiel) und ist versioniert (7.7).

### Typische Fehler.

Falsch ist, Skripte mit Administratorrechten laufen zu lassen, die nur lesen sollen. Falsch ist, Pfade fest einzutragen (`C:\Users\Anna`), sodass das Skript nur auf einem Rechner läuft. Falsch ist, Löschbefehle ohne Probelauf zu testen. Falsch ist, Skripte aus dem Internet ohne Lesen auszuführen: “Kopieren und Ausführen” ist ein Standardweg für Schadsoftware. Falsch ist auch, Kennwörter in den Skripttext zu schreiben (7.8).

### Praxisbezug.

Typische Skripte im Support: Konten aus einer Liste anlegen, Speicherplatz melden, Zertifikate auf Ablauf prüfen, Berichte erzeugen. Ein Skript, das nur einer versteht, ist ein Risiko; deshalb gehören Kommentare und Ablage in die Versionsverwaltung.

## 7.7 Versionskontrolle und Zusammenarbeit

Eine *Versionsverwaltung* (englisch *Version Control System*, VCS) speichert jede Änderung an Dateien samt Autor, Zeitpunkt und Begründung. Dadurch kann man frühere Stände wiederherstellen, Änderungen nachvollziehen (“Wer hat das wann warum geändert?”) und gemeinsam arbeiten, ohne einander zu überschreiben. Das mit Abstand verbreitetste System ist *Git*. Es arbeitet *verteilt*: Jeder Beteiligte hat eine vollständige Kopie der Geschichte (ein *Repository*), und ein gemeinsamer Server (zum Beispiel GitHub, GitLab oder ein Firmenserver) dient dem Austausch. Versionsverwaltung ist nicht nur für Programmcode nützlich, sondern für alle Textdateien: Skripte, Konfigurationen, Dokumentation, Infrastruktur als Code (Abschnitt 12.2).

Die wichtigsten Begriffe: Ein *Commit* ist ein gespeicherter Stand mit einer Beschreibung (*Commit-Nachricht*); er ist die kleinste Einheit der Geschichte. Ein *Branch* (Zweig) ist eine parallele Entwicklungslinie, auf der man Neues ausprobiert, ohne den Hauptzweig (meist `main`) zu stören. Ein *Merge* führt Zweige wieder zusammen. Ein *Konflikt* entsteht, wenn beide Zweige dieselbe Stelle unterschiedlich geändert haben; dann entscheidet ein Mensch. Ein *Pull Request* (oder Merge Request) bittet darum, einen Zweig in den Hauptzweig zu übernehmen, und ermöglicht Prüfung durch andere (*Code Review*). `push` sendet eigene Commits zum Server, `pull` holt fremde, `clone` kopiert ein Repository erstmals.

Das Programm spielt einen Konfliktfall mit echtem Git durch: Es legt ein Repository an, schreibt eine erste Version, ändert die Datei in einem Zweig `feature` und im Hauptzweig unterschiedlich und führt beide zusammen. Der Aufruf von Git erfolgt über die Standardbibliothek; wer Git nicht installiert hat, kann die Befehle einzeln im Terminal eingeben.

```python
import subprocess, tempfile, pathlib

def git(*a, cwd):
    return subprocess.run(["git", *a], cwd=cwd, capture_output=True, text=True)

d = tempfile.mkdtemp()
git("init", "-q", "-b", "main", cwd=d)
git("config", "user.email", "a@example.at", cwd=d)
git("config", "user.name", "Anna", cwd=d)
p = pathlib.Path(d) / "skript.py"
p.write_text("print('v1')\n")
git("add", "skript.py", cwd=d)
git("commit", "-qm", "Erste Version", cwd=d)
git("checkout", "-qb", "feature", cwd=d)
p.write_text("print('v1')\nprint('neu im Feature')\n")
git("commit", "-qam", "Feature ergaenzt", cwd=d)
git("checkout", "-q", "main", cwd=d)
p.write_text("print('v1 geaendert')\n")
git("commit", "-qam", "Hauptzweig geaendert", cwd=d)
print(git("log", "--oneline", "--all", "--graph", cwd=d).stdout)
r = git("merge", "feature", cwd=d)
print(r.stdout.strip().splitlines()[-1])
print(p.read_text())
print(git("status", "--short", cwd=d).stdout)
```

Die Hilfsfunktion `git` ruft das Programm `git` mit den übergebenen Argumenten im Ordner `cwd` auf und sammelt die Ausgabe. Die Befehle entsprechen dem typischen Ablauf: `init` legt das Repository an, `add` merkt eine Datei für den nächsten Commit vor (die *Staging Area*), `commit` speichert den Stand, `checkout -b` erzeugt einen neuen Zweig und wechselt hin. Im Zweig `feature` kommt eine Zeile dazu, im Hauptzweig wird die erste Zeile geändert. Die Ausgabe des Verlaufs zeigt als Grafik die Verzweigung: Von der “Ersten Version” gehen zwei Linien aus, je mit einem eigenen Commit. Beim Zusammenführen meldet Git `Automatic merge failed; fix conflicts and then commit the result.` Die Datei enthält nun Konfliktmarkierungen: Zwischen `<<<<<<< HEAD` und `=======` steht die Fassung des aktuellen Zweigs (`print('v1 geaendert')`), zwischen `=======` und `>>>>>>> feature` die des anderen (`print('v1')` und die neue Zeile). Der Status `UU` bedeutet “beide Seiten geändert, nicht aufgelöst”. Aufgelöst wird, indem man die Datei so bearbeitet, wie sie sein soll, die Markierungen entfernt, die Datei mit `add` vormerkt und mit `commit` abschließt. Das ist dasselbe Prinzip wie der Konflikt im gemeinsamen Dokument in Abschnitt 5.4, nur mit mehr Kontrolle.

Gute Gewohnheiten sind: kleine, thematisch abgeschlossene Commits; aussagekräftige Nachrichten (“Grenzwert für Laufwerke von 85 auf 90 Prozent erhöht” statt “Änderung”); Hauptzweig nur über geprüfte Pull Requests ändern; keine Geheimnisse und keine großen Binärdateien einchecken. Eine Datei `.gitignore` legt fest, was nicht erfasst wird (temporäre Dateien, lokale Einstellungen, Schlüssel).

### Typische Fehler.

Falsch ist, ein Kennwort oder einen Schlüssel einzuchecken: Er bleibt in der Geschichte, auch wenn man die Datei später löscht, und muss als kompromittiert gelten und erneuert werden. Falsch sind riesige Commits mit zwanzig Themen und der Nachricht “Änderungen”. Falsch ist, Konflikte “irgendwie” aufzulösen, ohne zu verstehen, was die andere Seite wollte. Falsch ist, direkt im Hauptzweig zu arbeiten, wenn mehrere beteiligt sind.

### Praxisbezug.

Auch Administratoren legen Skripte und Konfigurationen in Git ab: Man sieht, wer die Firewallregel geändert hat, und kann im Notfall zum letzten funktionierenden Stand zurück (Abschnitt 9.6 Change-Management). Bei der Fehlersuche ist die Frage “Was wurde zuletzt geändert?” damit in Sekunden beantwortbar.

## 7.8 Sichere und verantwortliche Entwicklung

Sicherheit lässt sich nicht nachträglich auftragen; sie muss von Anfang an im Entwurf stehen (*Secure by Design*, Abschnitt 10.8). Die meisten Schwachstellen entstehen nicht durch raffinierte Angriffe, sondern durch Standardfehler: Eingaben werden ungeprüft verwendet, Zugriffsrechte nicht kontrolliert, Geheimnisse im Code gelassen, Fehler ignoriert, Fremdbibliotheken nicht aktuell gehalten. Dagegen helfen einige Grundregeln. Alle Eingaben (aus Formularen, Dateien, Netzwerk, Kommandozeile) gelten als nicht vertrauenswürdig und werden auf Typ, Länge und Wertebereich geprüft (*Eingabevalidierung*); man erlaubt, was gültig ist, statt zu verbieten, was bekannt gefährlich ist (*Positivliste*). Datenbankabfragen verwenden Parameter statt Textverkettung (Abschnitt 10.8). Geheimnisse (Kennwörter, Schlüssel, Token) stehen nicht im Quelltext, sondern in der Umgebung oder einem Geheimnisspeicher. Jeder Teil läuft mit den geringsten nötigen Rechten. Fehlermeldungen verraten dem Benutzer nichts über das Innenleben, das Protokoll dagegen schon. Abhängigkeiten werden bekannt, aktuell und aus vertrauenswürdiger Quelle gehalten.

> **Ergänzung aus der Nachrecherche**
>
> Die gemeinnützige Organisation OWASP veröffentlicht mit den “Top 10” eine Liste der kritischsten Risiken für Webanwendungen. Die Ausgabe 2025 (abgerufen auf owasp.org) nennt in dieser Reihenfolge: A01 Broken Access Control (fehlerhafte Zugriffskontrolle), A02 Security Misconfiguration, A03 Software Supply Chain Failures (Schwachstellen in der Lieferkette), A04 Cryptographic Failures, A05 Injection, A06 Insecure Design, A07 Authentication Failures, A08 Software or Data Integrity Failures, A09 Security Logging & Alerting Failures und A10 Mishandling of Exceptional Conditions (falscher Umgang mit Ausnahmesituationen). Das Dokument ist ein Bewusstseinsinstrument auf Basis von Daten aus über 2,8 Millionen Anwendungen, kein Prüfstandard. Neu in dieser Ausgabe gegenüber früheren sind nach den Angaben der Seite die Einträge zur Lieferkette und zum Umgang mit Ausnahmesituationen. Für die Prüfung genügt, die Idee zu kennen; die Liste ändert sich alle paar Jahre.

Zwei der häufigsten Fehler lassen sich im Kleinen zeigen: ein *Pfadzugriff außerhalb des erlaubten Ordners* (*Path Traversal*), bei dem ein Angreifer mit `../` aus dem vorgesehenen Ordner ausbricht, und fehlende Eingabevalidierung. Das Programm legt einen Berichtsordner und eine geheime Datei daneben an, liest einmal unsicher und einmal gesichert und prüft Altersangaben.

```python
import os, pathlib, re, tempfile

BASIS = pathlib.Path(tempfile.mkdtemp()).resolve()
(BASIS / "berichte").mkdir()
(BASIS / "berichte" / "q1.txt").write_text("Quartalsbericht")
(BASIS / "geheim.txt").write_text("Zugangsdaten")

def lies_unsicher(name):
    return (BASIS / "berichte" / name).read_text()

def lies_sicher(name):
    ziel = (BASIS / "berichte" / name).resolve()
    if not ziel.is_relative_to(BASIS / "berichte"):
        raise PermissionError("Zugriff ausserhalb des Berichtsordners")
    return ziel.read_text()

for name in ("q1.txt", "../geheim.txt"):
    for fkt in (lies_unsicher, lies_sicher):
        try:
            print(fkt.__name__, name, "->", fkt(name))
        except Exception as e:
            print(fkt.__name__, name, "->", type(e).__name__, e)

def pruefe_alter(text):
    if not re.fullmatch(r"\d{1,3}", text):
        raise ValueError("kein gueltiges Alter")
    wert = int(text)
    if not 0 <= wert <= 120:
        raise ValueError("ausserhalb 0..120")
    return wert

for t in ("34", "abc", "-5", "999", "34; DROP"):
    try:
        print(t, "->", pruefe_alter(t))
    except ValueError as e:
        print(t, "->", e)

schluessel = os.environ.get("API_SCHLUESSEL")
print("Schluessel gesetzt:", schluessel is not None)
```

Die unsichere Funktion hängt den übergebenen Namen einfach an den Ordner an. Mit dem Namen `../geheim.txt` verlässt sie den Berichtsordner und liest die geheime Datei: Die Ausgabe zeigt `Zugangsdaten`. Die sichere Funktion löst den Pfad zuerst vollständig auf (`resolve()` entfernt `..` und folgt Verknüpfungen) und prüft dann mit `is_relative_to`, ob das Ergebnis noch im Berichtsordner liegt; wenn nicht, löst sie einen `PermissionError` aus. Für den harmlosen Namen `q1.txt` verhalten sich beide Funktionen gleich. Die Prüfung bezieht sich auf das *Ergebnis*, nicht auf den Text der Eingabe; das Verbot des Textes “..” allein wäre umgehbar. Die Altersprüfung verwendet einen regulären Ausdruck mit `fullmatch` (der gesamte Text muss passen) und einen Wertebereich: `34` wird akzeptiert, `abc`, `-5` und `34; DROP` sind kein gültiges Alter, `999` liegt außerhalb. Der letzte Teil liest einen Schlüssel aus der Umgebungsvariable `API_SCHLUESSEL` statt aus dem Quelltext; im Test ist sie nicht gesetzt, das Programm meldet `False`. Die Methode `is_relative_to` gibt es ab Python 3.9. Die Ausgaben stammen aus einem Lauf im Arbeitsbereich.

Verantwortliche Entwicklung umfasst mehr als Technik. Dazu gehören Datensparsamkeit (nur erheben, was nötig ist; Abschnitt 11.3), Barrierefreiheit, ehrliche Dokumentation von Grenzen, die Beachtung von Lizenzen verwendeter Bibliotheken (Abschnitt 11.6) und die Frage, welche Folgen ein Fehler für Menschen hat. Ein *Code Review* durch eine zweite Person findet viele Fehler, bevor sie Schaden anrichten; automatisierte Prüfwerkzeuge suchen nach bekannten Mustern und veralteten Bibliotheken. Bei Sicherheitslücken in fremder Software gilt die verantwortungsvolle Meldung an den Hersteller (*Responsible Disclosure*), nicht die Veröffentlichung oder gar Ausnutzung.

### Typische Fehler.

Falsch ist, Kennwörter, API-Schlüssel oder Zugangsdaten im Quelltext oder in Git zu speichern. Falsch ist, Eingaben “nur im Browser” zu prüfen, denn ein Angreifer umgeht den Browser; geprüft wird immer auf dem Server. Falsch ist, bei Fehlern dem Benutzer den vollständigen Stacktrace mit Pfaden und Datenbankdetails anzuzeigen. Falsch ist, Bibliotheken nie zu aktualisieren, weil “es läuft ja”. Falsch ist, eigene Verschlüsselungsverfahren zu erfinden; man verwendet erprobte Bibliotheken.

### Praxisbezug.

Auch ohne Entwicklerrolle begegnet man dem im Alltag: Ein Skript mit eingebautem Administrator-Kennwort, das im Teamordner liegt, ist ein Sicherheitsvorfall (Abschnitt 10.7). Wer Skripte schreibt, prüft Eingaben, trennt Geheimnisse vom Code und hält Rechte klein.

> **Merke**
>
> Eingaben nie vertrauen: validieren (Positivliste), Pfade auflösen und prüfen, Abfragen parametrisieren. Geheimnisse nicht im Code. Geringste Rechte, Abhängigkeiten aktuell halten, Review. Fehlermeldungen nach außen knapp, im Log ausführlich.

## Übungsaufgaben Modul 07

1.  Erklären Sie in eigenen Worten, was ein Algorithmus ist, und beschreiben Sie die Schritte, mit denen man von einer Aufgabe zu einem Programm kommt. Nennen Sie zwei Darstellungsformen für Algorithmen.

2.  Welche Datentypen haben die Werte `"42"`, `42`, `4.2`, `True` und `[4, 2]`? Was ergibt `"42" + "42"`, was `int("42") + int("42")`, und warum ist `0.1 + 0.2 == 0.3` falsch?

3.  Nennen Sie die drei Grundformen von Kontrollstrukturen mit je einem Beispiel aus dem IT-Alltag. Was ist eine Endlosschleife, und wie entsteht sie?

4.  Erklären Sie den Unterschied zwischen Parameter und Argument, zwischen lokaler und äußerer Variable und warum Funktionen nur eine Aufgabe haben sollten.

5.  Ordnen Sie zu: Syntaxfehler, Laufzeitfehler, logischer Fehler. (a) Das Programm startet nicht und meldet “unexpected indent”. (b) Es bricht mit `ZeroDivisionError` ab. (c) Es läuft, aber die berechnete Mehrwertsteuer ist um 10 Prozent zu niedrig. Welcher Fehler ist am schwersten zu finden, und warum?

6.  **Praxis:** Schreiben Sie eine Funktion `groesste_zahl(zahlen)`, die ohne `max()` die größte Zahl einer Liste liefert und bei einer leeren Liste `None`. Testen Sie sie mit `[3, 9, 2]`, `[-5, -1, -9]` und `[]`.

7.  **Praxis:** Schreiben Sie eine Funktion `ampel(prozent)`, die für Arbeitsspeicher-Auslastung “gruen” (unter 70), “gelb” (70 bis unter 90) oder “rot” (ab 90) zurückgibt, und eine Schleife, die die Werte 12, 70, 89,9 und 95 prüft.

8.  **Praxis:** Schreiben Sie ein Skript, das in einem Ordner (zum Testen ein temporärer) alle Dateien mit der Endung `.tmp` findet und deren Namen ausgibt, *ohne* sie zu löschen. Ergänzen Sie einen Schalter `trocken`, bei dem `False` die Dateien tatsächlich löscht.

9.  Ein Kollege hat im Skript die Zeile `passwort = "Sommer2026!"` und legt es in das Git-Repository des Teams. Welche Probleme entstehen, wie behebt man sie richtig, und warum genügt es nicht, die Zeile im nächsten Commit zu löschen?

## Lösungen Modul 07

1.  Ein Algorithmus ist eine eindeutige, endliche Folge von Schritten zur Lösung eines Problems. Vorgehen: Aufgabe präzisieren (Eingabe, Ausgabe, Sonderfälle), in Teilprobleme zerlegen, Muster erkennen und abstrahieren, Schritte aufschreiben, codieren und testen. Darstellungsformen: Pseudocode und Flussdiagramm (auch Struktogramm oder Text in Alltagssprache).

2.  Typen: `str`, `int`, `float`, `bool`, `list`. `"42" + "42"` ergibt den Text `"4242"`, `int("42") + int("42")` die Zahl 84. `0.1 + 0.2` ergibt `0.30000000000000004`, weil der Rechner Dezimalzahlen binär speichert und 0,1 darin nicht exakt darstellbar ist; man rundet für die Anzeige und vergleicht mit Toleranz.

3.  Sequenz (Schritte nacheinander, zum Beispiel Konto anlegen, Rechte setzen, Mail senden), Verzweigung (wenn Speicher über 90 Prozent, dann Alarm), Schleife (für jedes Laufwerk prüfen). Eine Endlosschleife endet nie, etwa wenn bei `while` die Variable, die in der Bedingung geprüft wird, nie verändert wird.

4.  Parameter sind die Platzhalter in der Funktionsdefinition, Argumente die tatsächlichen Werte beim Aufruf. Lokale Variablen existieren nur in der Funktion; eine Zuweisung an denselben Namen verändert die äußere Variable nicht. Eine Aufgabe pro Funktion macht sie verständlich, wiederverwendbar und einzeln testbar.

5.  \(a\) Syntaxfehler, (b) Laufzeitfehler, (c) logischer Fehler. Der logische Fehler ist am schwersten zu finden, weil keine Fehlermeldung kommt; man bemerkt ihn nur durch Vergleich mit einem erwarteten Ergebnis, daher sind Tests mit bekannten Werten wichtig.

6.  Beispiellösung:

    ```python
    def groesste_zahl(zahlen):
        if not zahlen:
            return None
        groesste = zahlen[0]
        for z in zahlen[1:]:
            if z > groesste:
                groesste = z
        return groesste

    print(groesste_zahl([3, 9, 2]), groesste_zahl([-5, -1, -9]), groesste_zahl([]))
    ```

    Ausgabe: `9 -1 None`. Wichtig ist, mit dem ersten Element zu beginnen und nicht mit 0, sonst wäre das Ergebnis für lauter negative Zahlen falsch (0).

7.  Beispiellösung:

    ```python
    def ampel(prozent):
        if prozent >= 90:
            return "rot"
        elif prozent >= 70:
            return "gelb"
        return "gruen"

    for wert in (12, 70, 89.9, 95):
        print(wert, ampel(wert))
    ```

    Ergebnis: 12 gruen, 70 gelb, 89,9 gelb, 95 rot. Die Grenzen (ab 70, ab 90) entsprechen den Texten “70 bis unter 90” und “ab 90”.

8.  Beispiellösung:

    ```python
    import pathlib, tempfile

    def aufraeumen(ordner, trocken=True):
        for p in sorted(pathlib.Path(ordner).glob("*.tmp")):
            print(("WUERDE LOESCHEN: " if trocken else "LOESCHE: ") + p.name)
            if not trocken:
                p.unlink()

    d = tempfile.mkdtemp()
    for n in ("a.tmp", "b.tmp", "c.txt"):
        (pathlib.Path(d) / n).write_text("x")
    aufraeumen(d)
    aufraeumen(d, trocken=False)
    ```

    Der erste Aufruf nennt `a.tmp` und `b.tmp`, ohne etwas zu löschen; der zweite löscht sie. `c.txt` bleibt in beiden Fällen unberührt. Der Standardwert `trocken=True` ist die sichere Voreinstellung.

9.  Das Kennwort liegt nun für alle Teammitglieder und alle, die später Zugriff auf das Repository erhalten, im Klartext vor und bleibt in der Versionsgeschichte erhalten; ein späterer Commit entfernt es nur aus dem aktuellen Stand, nicht aus der Geschichte. Richtig: Das Kennwort sofort ändern (es gilt als kompromittiert), im Skript aus der Umgebung oder einem Geheimnisspeicher lesen, die Geschichte nur bei Bedarf mit speziellen Werkzeugen bereinigen und Maßnahmen wie eine `.gitignore` und Prüfungen vor dem Commit einführen. Den Vorfall nach dem Meldeprozess dokumentieren.
