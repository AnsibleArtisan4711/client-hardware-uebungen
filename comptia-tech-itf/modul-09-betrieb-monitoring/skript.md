# Modul 9 - Betrieb, Monitoring, Logging und Supportprozesse

> **Hinweis zu diesem Kapitel:** Das ist das Kapitel des Skripts „CompTIA Tech+ / ITF+ (FC0-U71): Lernskript in Modulen“, aus der LaTeX-Quelle in Markdown umgewandelt (Text und Listings unverändert, Boxen als Zitatblöcke, Aufgaben und Lösungen als nummerierte Listen). Laut Skript wurden die Python-Beispiele bei der Erstellung im Arbeitsbereich ausgeführt, die gezeigten Ausgaben stammen aus diesen Läufen; Windows- und PowerShell-Befehle wurden nicht ausgeführt. Für dieses Repository wurden die Listings **nicht erneut ausgeführt**. Prüfungsdetails, Produktnamen und Versionen ändern sich; maßgeblich sind die aktuellen Prüfungsziele (Exam Objectives) von CompTIA. Übersicht zum Modul: [README](README.md).

**Dauer:** 7,5 h

**Priorität:** 1 (höchste)

| Nr. | Lerneinheit                          | Dauer (h) | Prio |
|----:|:-------------------------------------|----------:|-----:|
| 9.1 | IT-Servicebetrieb                    |      0,75 |    1 |
| 9.2 | Monitoring-Grundlagen                |         1 |    1 |
| 9.3 | Logging und Ereignisse               |         1 |    1 |
| 9.4 | Alerting und Eskalation              |      0,75 |    2 |
| 9.5 | Ticketing und Dokumentation          |      0,75 |    1 |
| 9.6 | Patch-, Release- und Change-Basis    |         1 |    2 |
| 9.7 | Kapazitäts- und Leistungsbetrachtung |      0,75 |    2 |
| 9.8 | Troubleshooting-Methodik             |       1,5 |    1 |
|     | **Summe**                            |   **7,5** |      |

Ein IT-System zu bauen ist die eine Aufgabe, es jahrelang zuverlässig zu betreiben die andere. Dieses Modul beschreibt den Alltag im Betrieb: wie Anfragen und Störungen geordnet werden, wie man erkennt, dass etwas nicht stimmt, bevor Anwender anrufen, wie man aus Protokolldateien die Ursache liest, wie man Alarme sinnvoll gestaltet, wie ein gutes Ticket aussieht, wie man Änderungen sicher einführt, wie man den Bedarf der Zukunft abschätzt und wie man Fehler systematisch statt durch Raten findet. Alle Beispiele laufen mit Python und der Standardbibliothek; die Ausgaben stammen aus tatsächlich ausgeführten Läufen. Die Prüfung greift dieses Thema vor allem in den Domänen Infrastruktur und Sicherheit sowie in der Fehlerbehebung auf.

## 9.1 IT-Servicebetrieb

Im *IT-Servicebetrieb* (englisch *IT Service Management*, kurz ITSM) betrachtet man IT nicht als Ansammlung von Geräten, sondern als *Dienstleistung*: Anwender brauchen ein funktionierendes E-Mail-System, einen Drucker, Zugriff auf die Buchhaltung, und es ist egal, wie viele Server dahinterstehen. Ein verbreitetes Rahmenwerk dafür ist *ITIL* (Information Technology Infrastructure Library), eine Sammlung bewährter Vorgehensweisen; ITIL ist kein Gesetz und keine Norm, sondern eine Orientierungshilfe, aus der viele Firmen ihre eigenen Abläufe ableiten. Für die Prüfung ist vor allem wichtig, die Grundbegriffe sauber zu unterscheiden.

Ein *Incident* (Störung) ist eine ungeplante Unterbrechung oder Qualitätsminderung eines Dienstes, zum Beispiel “Das Mailprogramm stürzt ab”. Ziel ist, den Dienst so schnell wie möglich wiederherzustellen, auch mit einer Übergangslösung (englisch *Workaround*). Ein *Service Request* (Serviceanfrage) ist dagegen keine Störung, sondern eine Bitte um etwas Vorgesehenes: ein neues Benutzerkonto, ein zusätzlicher Monitor, Zugriff auf einen Ordner. Solche Anfragen laufen meist als standardisierte Abläufe mit Formular und Freigabe. Ein *Problem* ist die zugrundeliegende Ursache eines oder mehrerer Incidents; während der Incident-Prozess die Störung beseitigt, sucht der Problem-Prozess nach der Wurzel, damit sie nicht wiederkehrt. Eine *Änderung* (*Change*) ist das Hinzufügen, Ändern oder Entfernen von etwas, das den Betrieb beeinflussen kann, etwa ein Software-Update oder eine neue Firewall-Regel; sie wird geplant, bewertet und freigegeben (Abschnitt 9.6). Die Unterscheidung ist praktisch: Fällt dreimal in einer Woche derselbe Drucker aus, sind das drei Incidents, aber ein Problem (etwa ein defekter Treiber), und die Reparatur des Treibers ist eine Änderung.

> **Ergänzung aus der Nachrecherche**
>
> Nach einer Zusammenfassung der ITIL-4-Praktiken auf open-exam-prep.com (abgerufen, Drittquelle, nicht von Axelos/PeopleCert) lautet der Zweck des *Incident Managements*, die negativen Auswirkungen von Incidents zu minimieren, indem der normale Betrieb so schnell wie möglich wiederhergestellt wird; das *Problem Management* senkt Wahrscheinlichkeit und Auswirkung von Incidents, indem es tatsächliche und mögliche Ursachen identifiziert und Workarounds sowie bekannte Fehler verwaltet; die *Change Enablement* erhöht die Zahl erfolgreicher Änderungen durch Risikobewertung, Autorisierung und Pflege des Änderungsplans; das *Service Level Management* setzt geschäftsbezogene Ziele für Servicequalität und überwacht ihre Einhaltung. Die Quelle definiert Service Requests nicht als eigene Praktik; die Beschreibung oben beruht daher auf allgemeinem Fachwissen. Die genauen Definitionen stehen in den offiziellen ITIL-Publikationen.

Betriebsziele drücken aus, was “gut betrieben” heißt. Die *Verfügbarkeit* (*Availability*) gibt an, welcher Anteil der vereinbarten Zeit ein Dienst nutzbar ist. Die *Stabilität* beschreibt, wie selten und wie kurz Störungen auftreten, und die *Leistung* (*Performance*), wie schnell der Dienst antwortet. Diese Ziele werden in einer Vereinbarung festgehalten, dem *Service Level Agreement* (SLA): Es nennt zum Beispiel die Verfügbarkeit (99,9 Prozent im Monat), die Reaktionszeit des Supports und die Wiederherstellungszeit nach Priorität. Intern gibt es dazu *Operational Level Agreements* (zwischen Abteilungen) und *Underpinning Contracts* (mit Lieferanten); alle drei hängen zusammen: Verspricht die IT den Fachabteilungen 99,9 Prozent, darf der Cloud-Lieferant nicht nur 99 Prozent zusagen.

Zwei Größen helfen beim Einordnen. Die *Auswirkung* (*Impact*) beschreibt, wie viele Personen oder wie wichtige Geschäftsprozesse betroffen sind, die *Dringlichkeit* (*Urgency*), wie schnell eine Lösung nötig ist. Aus beiden ergibt sich die *Priorität*. Das folgende Programm setzt eine solche Prioritätsmatrix um, weist jeder Priorität eine Reaktionszeit zu und berechnet außerdem, wie viel Ausfall pro Jahr bei einer bestimmten Verfügbarkeitszusage erlaubt ist.

```python
from datetime import datetime, timedelta

MATRIX = {("hoch", "hoch"): 1, ("hoch", "mittel"): 2, ("hoch", "niedrig"): 3,
          ("mittel", "hoch"): 2, ("mittel", "mittel"): 3, ("mittel", "niedrig"): 4,
          ("niedrig", "hoch"): 3, ("niedrig", "mittel"): 4, ("niedrig", "niedrig"): 4}
REAKTION_STD = {1: 1, 2: 4, 3: 8, 4: 24}

def priorisiere(auswirkung, dringlichkeit, eingang):
    prio = MATRIX[(auswirkung, dringlichkeit)]
    return prio, eingang + timedelta(hours=REAKTION_STD[prio])

eingang = datetime(2026, 10, 26, 9, 0)
faelle = [("Mailserver down, alle betroffen", "hoch", "hoch"),
          ("Drucker im Lager defekt", "niedrig", "mittel"),
          ("Ein VIP kann nicht anmelden", "niedrig", "hoch")]
for text, ausw, dring in faelle:
    prio, frist = priorisiere(ausw, dring, eingang)
    print(f"P{prio} | Reaktion bis {frist:%d.%m. %H:%M} | {text}")

JAHR_MIN = 365 * 24 * 60
for ziel in (99.0, 99.9, 99.99):
    erlaubt = JAHR_MIN * (1 - ziel / 100)
    print(f"{ziel:6}% Verfuegbarkeit -> {erlaubt / 60:6.1f} h = {erlaubt:7.1f} min Ausfall pro Jahr")
```

Das Wörterbuch `MATRIX` ordnet jeder Kombination aus Auswirkung und Dringlichkeit eine Priorität von 1 (höchste) bis 4 zu; die zweite Tabelle `REAKTION_STD` legt fest, binnen wie vieler Stunden reagiert werden muss. Die Funktion `priorisiere` schlägt die Priorität nach und addiert die Reaktionszeit zum Eingang. Das Ergebnis: Der Mailserver-Ausfall (hohe Auswirkung, hohe Dringlichkeit) ist P1 mit Frist 10:00, der defekte Lagerdrucker P4 mit Frist am Folgetag 09:00, und der VIP-Fall P3 mit Frist 17:00. Der zweite Teil rechnet aus, was “Neunen” bedeuten: 99,0 Prozent erlauben 87,6 Stunden Ausfall im Jahr, 99,9 Prozent 8,8 Stunden, 99,99 Prozent nur noch 52,6 Minuten. Jede zusätzliche Neun macht den Betrieb deutlich teurer. Die Beispielwerte der Reaktionszeiten sind erfunden; reale Werte stehen im SLA.

### Typische Fehler.

Falsch ist, alles als Incident zu behandeln: Ein Wunsch nach Software ist ein Service Request, und wer ihn als Störung einträgt, verfälscht die Statistik. Falsch ist auch, die Priorität nach der Lautstärke des Anrufers zu bestimmen, statt nach Auswirkung und Dringlichkeit; die Geschäftsführung bekommt nicht automatisch P1. Und falsch ist, nach der Wiederherstellung den Fall zu schließen, ohne zu fragen, warum es passiert ist: Das ist die Aufgabe des Problem-Managements.

### Praxisbezug.

Wer im First-Level-Support arbeitet, ordnet jeden Anruf zuerst ein: Incident, Anfrage oder Änderung? Danach legt er die Priorität fest und trägt das Ticket mit den richtigen Daten ein. Die Zahlen daraus (wie viele Incidents, wie viele Service Requests, wie schnell gelöst) gehen später in Berichte an die Leitung.

> **Merke**
>
> Incident = Störung beheben. Service Request = Standardwunsch erfüllen. Problem = Ursache beseitigen. Change = geplante Änderung. Priorität = Auswirkung $\times$ Dringlichkeit. SLA = vereinbarte Ziele für Verfügbarkeit und Reaktion.

## 9.2 Monitoring-Grundlagen

*Monitoring* heißt, Systeme laufend zu beobachten, um Probleme früh zu erkennen, im besten Fall bevor Anwender sie bemerken. Es beruht auf drei Bausteinen. *Metriken* sind Zahlen, die den Zustand beschreiben und im Zeitverlauf gemessen werden, zum Beispiel die CPU-Auslastung in Prozent, der freie Speicherplatz in Gigabyte, die Antwortzeit einer Webseite in Millisekunden. *Checks* (Prüfungen) fragen aktiv nach einem Zustand: Antwortet der Server auf einen Ping? Ist der Port 443 offen? Ist der Webdienst gestartet? *Schwellenwerte* (*Thresholds*) legen fest, ab wann ein Messwert als auffällig gilt: Ein Datenträger ist bei 80 Prozent Füllung *Warnung*, bei 95 Prozent *kritisch*.

Man unterscheidet das *Black-Box-Monitoring*, das von außen prüft, ob ein Dienst funktioniert (kann man sich anmelden?), vom *White-Box-Monitoring*, das interne Werte erfasst (Warteschlangenlänge, Speicherverbrauch). Beides ergänzt sich: Der Nutzer interessiert sich nur dafür, dass es geht; der Betrieb will wissen, warum es bald nicht mehr gehen könnte. Die Daten werden entweder vom überwachten System an eine zentrale Stelle gesendet (*Push*) oder von dieser abgefragt (*Pull*); häufig läuft auf dem Zielsystem ein kleines Hilfsprogramm, der *Agent*. Die einfachste Form des Beobachtens ist der Ping (Modul 4, Abschnitt 4.7), dessen Ergebnis nur sagt, dass ein Gerät erreichbar ist, nicht, dass der Dienst darauf funktioniert.

Welche Ressourcen sind sinnvoll zu beobachten? Die *CPU* zeigt, wie ausgelastet der Prozessor ist; kurze Spitzen sind normal, dauerhaft hohe Werte (über 80 bis 90 Prozent) deuten auf Überlastung. Der *Arbeitsspeicher* (RAM) ist weniger über die absolute Belegung zu beurteilen, weil Betriebssysteme freien Speicher als Zwischenspeicher nutzen, sondern an Anzeichen von *Auslagerung* (Swapping): Wenn das System Daten auf den langsamen Datenträger schiebt, wird es zäh. Beim *Datenträger* beobachtet man den freien Platz, aber auch die Zugriffszeiten; ein volles Laufwerk ist ein klassischer Ausfallgrund, weil Protokolle und Datenbanken nicht mehr schreiben können. Im *Netzwerk* sind Durchsatz, Paketverlust und Latenz maßgeblich. Dazu kommen anwendungsnahe Prüfungen: Antwortzeit und Fehlerquote eines Dienstes. Ein *Dashboard* fasst die wichtigsten Werte auf einer Seite zusammen; gut ist ein Dashboard, das auf einen Blick den Zustand zeigt (grün, gelb, rot) und nicht vierzig Diagramme ohne Aussage enthält.

> **Ergänzung aus der Nachrecherche**
>
> Viele Überwachungssysteme folgen einer Konvention, die vom Werkzeug Nagios geprägt wurde: Ein Check liefert einen Statustext und einen *Exit-Code* (Rückgabewert des Programms): 0 = OK, 1 = WARNING, 2 = CRITICAL, 3 = UNKNOWN. Das Beispiel unten verwendet diese Konvention. Die Richtlinien der Nagios-Plugins konnte ich in dieser Sitzung nicht abrufen (die Seite war nicht freigegeben); die Zuordnung der Codes beruht deshalb auf allgemeinem Fachwissen und ist in den offiziellen Plugin-Richtlinien nachzuprüfen. Für die Prüfung selbst ist diese Konvention nicht verlangt, sie zeigt aber, wie Checks maschinenlesbar werden.

Das folgende Programm setzt einen solchen Check in einem kleinen Rahmen um. Die Funktion bewertet einen Messwert gegen Warn- und Kritisch-Schwelle und liefert Status und Text. Fehlt der Messwert (der Check selbst ist gescheitert), ist das Ergebnis “UNKNOWN”, und das ist etwas anderes als “OK”.

```python
OK, WARNING, CRITICAL, UNKNOWN = 0, 1, 2, 3
NAMEN = {OK: "OK", WARNING: "WARNING", CRITICAL: "CRITICAL", UNKNOWN: "UNKNOWN"}

def pruefe(name, wert, warn, krit):
    if wert is None:
        return UNKNOWN, f"{name} UNKNOWN - kein Messwert"
    if wert >= krit:
        status = CRITICAL
    elif wert >= warn:
        status = WARNING
    else:
        status = OK
    return status, f"{name} {NAMEN[status]} - {wert:.1f} % (warn {warn}, krit {krit})"

messwerte = [("CPU", 42.0, 80, 95), ("RAM", 86.5, 80, 95),
             ("DISK /", 97.2, 85, 95), ("DISK /backup", None, 85, 95)]
RANG = {OK: 0, UNKNOWN: 1, WARNING: 2, CRITICAL: 3}
gesamt = OK
for name, wert, warn, krit in messwerte:
    status, text = pruefe(name, wert, warn, krit)
    print(status, text)
    if RANG[status] > RANG[gesamt]:
        gesamt = status
print("Gesamtstatus (Exit-Code):", gesamt, NAMEN[gesamt])
```

Die Konstanten geben den vier Zuständen Namen. In `pruefe` wird zuerst der Sonderfall “kein Messwert” behandelt, dann mit `>=` gegen die kritische und die Warn-Schwelle verglichen; die Reihenfolge ist wichtig, denn ein Wert von 97 Prozent ist zugleich über beiden Schwellen und muss als kritisch gelten. Die Ausgabe zeigt die vier Fälle: CPU 42 Prozent ist OK, RAM 86,5 Prozent eine Warnung, die Wurzelpartition mit 97,2 Prozent kritisch, und das Backup-Laufwerk liefert keinen Wert und ergibt UNKNOWN. Der Gesamtstatus ist der schlimmste Einzelstatus; dafür dient die Rangtabelle `RANG`, in der UNKNOWN zwischen OK und WARNING eingeordnet ist, denn “unbekannt” ist beunruhigender als “in Ordnung”, aber weniger dringend als ein bestätigtes Problem. Das Ergebnis lautet daher 2 (CRITICAL). In einem echten System würde das Programm mit `sys.exit(gesamt)` enden und das Überwachungssystem würde den Code auswerten.

### Typische Fehler.

Falsch ist, nur zu prüfen, ob der Server pingbar ist: Der Rechner kann antworten, während der Datenbankdienst längst steht. Falsch sind auch Schwellenwerte, die sich nie an der Wirklichkeit orientieren: Ein Warnwert von 50 Prozent Festplattenfüllung erzeugt ständig Meldungen, die niemand mehr beachtet. Richtig ist, Schwellen nach Erfahrungswerten und nach der verbleibenden Reaktionszeit zu setzen. Ein weiteres Versäumnis: “keine Meldung” als “alles gut” zu deuten, obwohl der Monitoring-Dienst selbst ausgefallen sein kann; deshalb überwacht man auch das Überwachungssystem (zum Beispiel durch einen regelmäßigen “Lebenszeichen”-Test).

### Praxisbezug.

In einer kleinen Firma genügt oft ein Werkzeug, das Server, Drucker und Internetanschluss prüft und bei Ausfall eine E-Mail schickt. Windows bietet den Task-Manager und den Ressourcenmonitor für den Blick auf eine einzelne Maschine; auf Linux zeigen `top` oder `df -h` dasselbe. Für viele Systeme setzt man zentrale Werkzeuge ein, die Metriken sammeln und Dashboards darstellen.

## 9.3 Logging und Ereignisse

Ein *Log* (Protokolldatei, Ereignisprotokoll) ist eine zeitlich geordnete Aufzeichnung dessen, was ein System oder eine Anwendung getan hat oder was ihm widerfahren ist. Während das Monitoring fragt, *ob* etwas in Ordnung ist, beantwortet das Log, *was passiert ist* und *warum*. Ein Logeintrag enthält meist einen Zeitstempel, eine Quelle (Programm oder Komponente), eine Schwere und eine Beschreibung, oft mit Benutzer, IP-Adresse oder Fehlernummer. Ohne Logs sind Fehler im Nachhinein kaum zu klären, und ohne Zeitstempel sind Logs nur halb so viel wert. Deshalb ist eine einheitliche Uhrzeit (Zeitsynchronisation, zum Beispiel über NTP) auf allen Systemen wichtig, sonst lassen sich Ereignisse mehrerer Geräte nicht in eine Reihenfolge bringen.

Man unterscheidet drei Arten. *Systemlogs* stammen vom Betriebssystem: Start und Herunterfahren, Treiberfehler, Dienste, die starten oder abstürzen. Unter Windows sind das die Ereignisanzeige (*Event Viewer*) mit den Protokollen System, Anwendung und Sicherheit; unter Linux liegen sie als Dateien in `/var/log` oder im Journal (`journalctl`). *Anwendungslogs* schreiben die Programme selbst, etwa ein Webserver (jede Anfrage) oder eine Fachanwendung (Rechenfehler, Datenbankverbindung). *Sicherheitslogs* halten fest, wer sich angemeldet hat, wer Rechte änderte, welche Anmeldungen fehlschlugen und was die Firewall blockierte; sie sind wichtig für Nachvollziehbarkeit und Beweissicherung (Modul 10 und 11).

Die *Schweregrade* (*Log Levels*) ordnen Meldungen nach Wichtigkeit. Gängig sind *DEBUG* (Details für die Fehlersuche), *INFO* (normale Ereignisse), *WARNING* (etwas Ungewöhnliches, aber der Betrieb läuft weiter), *ERROR* (ein Vorgang ist fehlgeschlagen) und *CRITICAL* (der Dienst ist gefährdet). Man stellt ein Mindestlevel ein: Im Normalbetrieb genügt INFO, bei der Fehlersuche schaltet man vorübergehend auf DEBUG. Weil Logs sonst ohne Grenze wachsen und den Datenträger füllen, gibt es die *Log-Rotation*: Ist die Datei zu groß oder zu alt, wird sie umbenannt, eine neue begonnen und die älteste gelöscht. Die Aufbewahrungsdauer richtet sich nach Zweck und Rechtslage; Logs mit Personenbezug (IP-Adressen, Benutzernamen) unterliegen dem Datenschutz (Abschnitt 6.7).

Das folgende Programm zeigt beide Seiten: Zuerst richtet es mit dem Python-Modul `logging` einen Logger mit Rotation ein und schreibt Meldungen verschiedener Stufen. Danach wertet es ein Beispiel-Log mit einem regulären Ausdruck aus, zählt die Meldungen je Stufe und erkennt auffällig viele fehlgeschlagene Anmeldungen derselben Adresse.

```python
import logging, tempfile, re
from logging.handlers import RotatingFileHandler
from pathlib import Path
from collections import Counter

with tempfile.TemporaryDirectory() as tmp:
    logdatei = Path(tmp) / "app.log"
    logger = logging.getLogger("shop")
    logger.setLevel(logging.INFO)
    handler = RotatingFileHandler(logdatei, maxBytes=600, backupCount=2, encoding="utf-8")
    handler.setFormatter(logging.Formatter("%(asctime)s %(levelname)-8s %(name)s: %(message)s"))
    logger.addHandler(handler)
    logger.debug("wird nicht geschrieben (Level DEBUG < INFO)")
    for i in range(12):
        logger.info("Bestellung %d verarbeitet", 100 + i)
    logger.warning("Zahlungsdienst antwortet langsam (%d ms)", 2300)
    try:
        1 / 0
    except ZeroDivisionError:
        logger.exception("Fehler bei Rabattberechnung")
    handler.close()
    print(sorted(p.name for p in Path(tmp).iterdir()))

LOG = """2026-10-26 08:01:12 INFO     auth: Login ok user=anna ip=10.0.0.5
2026-10-26 08:03:40 WARNING  auth: Login fehlgeschlagen user=admin ip=203.0.113.9
2026-10-26 08:03:42 WARNING  auth: Login fehlgeschlagen user=admin ip=203.0.113.9
2026-10-26 08:03:44 WARNING  auth: Login fehlgeschlagen user=root ip=203.0.113.9
2026-10-26 08:10:00 ERROR    db: Verbindung verloren
2026-10-26 08:10:05 INFO     db: Verbindung wiederhergestellt
"""
muster = re.compile(r"^(\S+ \S+) (\w+)\s+(\w+): (.*)$")
stufen = Counter()
fehlversuche = Counter()
for zeile in LOG.splitlines():
    zeit, stufe, quelle, text = muster.match(zeile).groups()
    stufen[stufe] += 1
    if "fehlgeschlagen" in text:
        fehlversuche[re.search(r"ip=(\S+)", text).group(1)] += 1
print(dict(stufen))
print(fehlversuche.most_common())
```

Im ersten Teil legt `getLogger("shop")` einen benannten Logger an und `setLevel(logging.INFO)` legt das Mindestlevel fest. Der `RotatingFileHandler` schreibt in die Datei und wechselt bei 600 Byte zu einer neuen; es werden höchstens zwei alte Dateien aufbewahrt (`backupCount=2`). Das Format enthält Zeitstempel, Level, Loggername und Text. Die `debug`-Meldung erscheint nicht, weil ihr Level unter dem eingestellten liegt. Zwölf INFO-Meldungen, eine Warnung und eine Fehlermeldung samt Rückverfolgung (`logger.exception` schreibt automatisch den Stacktrace mit) füllen die Datei schnell; das Ergebnis der Ausgabe ist `['app.log', 'app.log.1']`: Die aktuelle Datei und eine rotierte Vorgängerin. Die Platzhalter `%d` im Text sorgen dafür, dass die Werte erst eingesetzt werden, wenn die Meldung tatsächlich geschrieben wird.

Der zweite Teil analysiert ein Textlog. Der reguläre Ausdruck zerlegt jede Zeile in Zeit, Stufe, Quelle und Text; das Zählwerkzeug `Counter` zählt Häufigkeiten. Das Ergebnis lautet `{'INFO': 2, 'WARNING': 3, 'ERROR': 1}` und, noch interessanter, `[('203.0.113.9', 3)]`: Dieselbe Adresse hat in nur vier Sekunden dreimal mit verschiedenen Konten (admin, root) vergeblich versucht, sich anzumelden. Das ist ein Hinweis auf einen Angriff durch Ausprobieren (*Brute Force*) und ein Beispiel dafür, wie ein Log erst durch Auswertung wertvoll wird. Die Adresse stammt aus einem für Dokumentation reservierten Bereich (203.0.113.0/24) und ist erfunden.

### Typische Fehler.

Falsch ist, auf Produktivsystemen dauerhaft im DEBUG-Level zu loggen: Die Dateien wachsen riesig, das System wird langsamer und es landen sensible Daten im Log. Ebenso falsch: Kennwörter, Kreditkartennummern oder Tokens ins Log zu schreiben. Ein weiterer Fehler ist, Logs nur lokal auf dem betroffenen System zu halten; nach einem Einbruch löscht ein Angreifer die Spuren. Besser ist die Weiterleitung an einen zentralen Logserver. Und ein typischer Anfängerfehler beim Lesen: nur die letzte Fehlermeldung zu betrachten, statt zu schauen, was *davor* passiert ist.

### Praxisbezug.

Meldet ein Anwender “Das Programm ist gestern um 14 Uhr abgestürzt”, öffnet der Support die Ereignisanzeige, filtert nach dem Zeitraum und der Stufe Fehler und findet oft die Fehlermeldung samt Programmpfad und Fehlercode, womit die Suche im Internet oder in der Wissensdatenbank beginnt.

> **Merke**
>
> Metriken sagen “wie viel”, Logs sagen “was geschah”. Drei Logarten: System, Anwendung, Sicherheit. Levels: DEBUG, INFO, WARNING, ERROR, CRITICAL. Rotation verhindert volle Datenträger. Keine Geheimnisse ins Log, Uhren synchronisieren.

## 9.4 Alerting und Eskalation

Monitoring sammelt Zustände, *Alerting* entscheidet, wer wann benachrichtigt wird. Hier trennt man drei Begriffe, die im Alltag oft vermischt werden. Eine *Warnung* (*Warning*) weist auf einen sich anbahnenden Zustand hin, der noch keine Auswirkung hat und innerhalb der Arbeitszeit bearbeitet werden kann, etwa ein zu 85 Prozent gefüllter Datenträger. Ein *Alarm* (*Alert*, kritischer Alarm) bedeutet, dass ein Dienst ausgefallen oder unmittelbar gefährdet ist und sofort jemand handeln muss. Eine *Eskalation* ist die Weitergabe an die nächste Stufe, wenn niemand reagiert oder die Lage schwerer wird: erst die Bereitschaft, nach einer vereinbarten Zeit die Teamleitung, danach die IT-Leitung. Die Zuständigkeiten und Zeiten stehen in einem *Eskalationsplan* und werden mit einem Bereitschaftsdienstplan (*On-Call*) verknüpft. Eine Meldung wird vom Empfänger *quittiert* (*Acknowledge*), damit andere wissen, dass sich jemand kümmert.

Die größte Gefahr im Alerting ist die *Alarmmüdigkeit* (*Alert Fatigue*): Wenn täglich dutzende Meldungen kommen, von denen die meisten nichts bedeuten, werden die wichtigen überlesen. Gegenmittel sind einfache Regeln. Erstens: *nur alarmieren, was Handlung erfordert*. Eine Meldung, bei der man nichts tun kann oder muss, gehört ins Dashboard oder ins Log. Zweitens: *Flackern (Flapping) abfangen*: Ein einzelner verlorener Ping ist kein Ausfall; man alarmiert erst, wenn zum Beispiel drei Prüfungen in Folge scheitern. Drittens: *Dubletten zusammenfassen*: Fällt ein Switch aus, melden zwanzig dahinterliegende Server gleichzeitig “nicht erreichbar”; eine Abhängigkeit (“Server hängen vom Switch ab”) unterdrückt die Folgemeldungen. Viertens: *Wartungsfenster* berücksichtigen, denn während geplanter Arbeiten sind Meldungen erwartet. Fünftens: *Meldungen mit Kontext* versehen (welches System, welcher Wert, welche Anleitung): Ein Alarm sollte erklären, was zu tun ist (Verweis auf ein Runbook, Abschnitt 9.5). Und jeder Alarm, der sich als unnötig herausstellt, führt zur Anpassung der Regel.

Das folgende Programm zeigt zwei Ideen. Zuerst entscheidet es anhand einer Folge von Prüfergebnissen im Fünf-Minuten-Takt, wann ein Alarm und wann eine Entwarnung ausgelöst wird, nämlich erst nach drei Fehlern in Folge. Danach bestimmt es, welche Eskalationsstufe nach einer gegebenen Zeit ohne Quittierung gilt.

```python
from datetime import datetime, timedelta

def bewerte(ergebnisse, min_fehler=3):
    fehler_in_folge = 0
    meldungen = []
    for zeit, ok in ergebnisse:
        fehler_in_folge = 0 if ok else fehler_in_folge + 1
        if fehler_in_folge == min_fehler:
            meldungen.append((zeit, "ALARM", f"{min_fehler} Fehler in Folge"))
        elif fehler_in_folge == 0 and meldungen and meldungen[-1][1] == "ALARM":
            meldungen.append((zeit, "ENTWARNUNG", "Check wieder ok"))
    return meldungen

start = datetime(2026, 10, 26, 8, 0)
muster = [True, False, True, False, False, False, False, False, True, True]
ergebnisse = [(start + timedelta(minutes=5 * i), ok) for i, ok in enumerate(muster)]
for zeit, art, text in bewerte(ergebnisse):
    print(f"{zeit:%H:%M} {art}: {text}")

STUFEN = [(0, "Stufe 1: Bereitschaft (Chat)"), (15, "Stufe 2: Teamleitung (Anruf)"),
          (45, "Stufe 3: IT-Leitung (Anruf)")]
def eskalation(minuten_unquittiert):
    aktuelle = STUFEN[0][1]
    for ab, text in STUFEN:
        if minuten_unquittiert >= ab:
            aktuelle = text
    return aktuelle
for m in (0, 10, 15, 30, 50):
    print(m, "min unquittiert ->", eskalation(m))
```

Die Funktion `bewerte` geht die Messungen in zeitlicher Reihenfolge durch und führt einen Zähler: Bei Erfolg wird er auf null gesetzt, bei Misserfolg um eins erhöht. Erst wenn der Zähler genau den Wert `min_fehler` erreicht, entsteht ein Alarm; weitere Fehler lösen keinen zweiten Alarm aus, weil der Vergleich nur bei Gleichheit anschlägt. Sobald der Check wieder gelingt und zuvor ein Alarm bestand, folgt eine Entwarnung. Das Eingabemuster enthält zuerst einen einzelnen Fehler (um 08:05), der absichtlich folgenlos bleibt, dann fünf Fehler hintereinander ab 08:15. Das Ergebnis sind genau zwei Meldungen: `08:25 ALARM` (der dritte Fehler in Folge) und `08:40 ENTWARNUNG`. Der Preis dieser Regel ist eine Verzögerung: Der Ausfall begann um 08:15 und wurde um 08:25 gemeldet; wer schneller sein will, nimmt weniger Fehler in Folge oder kürzere Intervalle und nimmt dafür mehr Fehlalarme in Kauf. Der zweite Teil ordnet der Zeit ohne Quittierung eine Stufe zu: Nach 0 und 10 Minuten bleibt es bei der Bereitschaft, ab 15 Minuten ist die Teamleitung zuständig, ab 45 Minuten die IT-Leitung. Die Stufenzeiten sind Beispielwerte.

### Typische Fehler.

Falsch ist, jeden Messwert über der Schwelle sofort per Telefon zu melden; das erzeugt Alarmmüdigkeit. Falsch ist auch der Gegenpol: Meldungen nur per E-Mail an eine Sammeladresse zu senden, die niemand außerhalb der Bürozeiten liest, obwohl der Dienst rund um die Uhr laufen muss. Typisch ist außerdem, dass der Eskalationsplan nach Personalwechseln veraltet: Dann klingelt es bei jemandem, der längst nicht mehr im Unternehmen ist. Der Plan ist regelmäßig zu prüfen und zu üben.

### Praxisbezug.

Ein Bereitschaftsdienst erhält die Meldung “Webshop: 5 Fehlversuche in Folge”, quittiert sie, öffnet das zugehörige Runbook und folgt den Schritten. Reagiert er nicht, wird nach der vereinbarten Zeit automatisch die nächste Person angerufen.

## 9.5 Ticketing und Dokumentation

Ein *Ticket* ist der Datensatz, in dem ein Anliegen im Support von der Meldung bis zum Abschluss festgehalten wird. Es hat eine eindeutige Nummer, einen Melder, einen Bearbeiter, einen Status (zum Beispiel neu, in Bearbeitung, wartet auf Rückmeldung, gelöst, geschlossen), eine Priorität und eine Historie aller Schritte. Ein *Ticketsystem* (*Service Desk Tool*) sorgt dafür, dass nichts verloren geht, dass Fristen aus dem SLA überwacht werden, dass Arbeit verteilt und übergeben werden kann und dass Statistiken entstehen. Der Support ist meist in Stufen organisiert: Der *First Level* nimmt auf, löst Standardfälle und leitet alles andere weiter, der *Second Level* bearbeitet fachlich tiefer, der *Third Level* sind Spezialisten oder die Hersteller.

Die Qualität eines Tickets entscheidet über die Dauer der Lösung. Ein gutes Ticket beantwortet die Fragen, die der Bearbeiter sonst erst stellen müsste. Es hat einen *aussagekräftigen Titel* (“Drucker 2.OG druckt PDF aus Outlook nicht”, nicht “Drucker geht nicht”), nennt den *Betroffenen* und den *Ort*, beschreibt *erwartetes* und *tatsächliches* Verhalten, enthält die *Schritte zur Reproduktion* (mit welchen Handgriffen tritt der Fehler auf?), die *Umgebung* (Gerät, Betriebssystem, Version), den *Zeitpunkt* (seit wann, was hat sich geändert?), die *Auswirkung* (wie viele Personen, welcher Prozess?) sowie Fehlermeldungen im Wortlaut oder als Screenshot. Wer ein Ticket schreibt, schreibt für einen Menschen, der die Situation nicht kennt und das Gerät nicht vor sich hat.

Zur Dokumentation gehören zwei weitere Hilfsmittel. Eine *Wissensdatenbank* (*Knowledge Base*) sammelt Lösungen bekannter Fehler, sodass dieselbe Frage nicht zehnmal neu gelöst wird; Artikel sollen kurz, auffindbar und aktuell sein. Ein *Runbook* (Betriebshandbuch) ist eine Schritt-für-Schritt-Anleitung für wiederkehrende Aufgaben oder bekannte Störungen, so konkret, dass auch jemand, der das System nicht gut kennt, sie in der Nacht abarbeiten kann: Voraussetzung, Befehle, erwartete Ergebnisse, was bei Abweichung zu tun ist, wen man anruft. Sensible Daten wie Kennwörter gehören weder in Tickets noch in allgemein lesbare Anleitungen; dafür gibt es Passwortverwaltungen (Modul 10).

Das folgende Programm formuliert die Qualitätsregeln als Code. Eine Datenklasse beschreibt ein Ticket, die Methode `luecken` nennt fehlende Angaben. Zwei Beispieltickets zeigen den Unterschied zwischen einer schlechten und einer guten Meldung.

```python
from dataclasses import dataclass, field

@dataclass
class Ticket:
    titel: str
    betroffener: str
    beschreibung: str
    schritte: list = field(default_factory=list)
    erwartet: str = ""
    tatsaechlich: str = ""
    umgebung: str = ""
    auswirkung: str = ""

    def luecken(self):
        fehlt = []
        if len(self.titel.split()) < 3:
            fehlt.append("Titel zu kurz (Was ist wo kaputt?)")
        if not self.schritte:
            fehlt.append("Schritte zur Reproduktion fehlen")
        for name in ("erwartet", "tatsaechlich", "umgebung", "auswirkung"):
            if not getattr(self, name).strip():
                fehlt.append(f"Feld '{name}' fehlt")
        return fehlt

schlecht = Ticket("Geht nicht", "Berger", "Drucker geht nicht!!!")
gut = Ticket(
    titel="Drucker 2.OG druckt PDF aus Outlook nicht",
    betroffener="A. Berger, Buchhaltung",
    beschreibung="Seit 08:30 bleibt der Druckauftrag in der Warteschlange.",
    schritte=["PDF in Outlook oeffnen", "Strg+P, Drucker 'OG2-Farbe' waehlen", "Drucken"],
    erwartet="Ausdruck nach wenigen Sekunden",
    tatsaechlich="Auftrag bleibt 'Wird gedruckt', kein Ausdruck",
    umgebung="Windows 11 23H2, Treiber v7.2, Notebook LAN-Dock",
    auswirkung="4 Personen koennen nicht drucken, Monatsabschluss heute")
for name, t in (("schlecht", schlecht), ("gut", gut)):
    print(name, "->", t.luecken() or "vollstaendig")
```

Der Dekorator `@dataclass` erzeugt für die Klasse automatisch den Konstruktor aus den aufgelisteten Feldern. Pflichtfelder sind Titel, Betroffener und Beschreibung; die anderen haben Standardwerte (leerer Text), die Liste der Schritte wird mit `field(default_factory=list)` angelegt, damit nicht alle Tickets dieselbe Liste teilen. Die Methode `luecken` sammelt Mängel: Ein Titel mit weniger als drei Wörtern ist zu knapp, Schritte müssen vorhanden sein, und die vier Textfelder dürfen nicht leer sein (`getattr` liest ein Feld über seinen Namen). Das schlechte Ticket “Geht nicht” liefert sechs Mängel: zu kurzer Titel, fehlende Schritte, und die vier leeren Felder. Das gute Ticket liefert “vollstaendig”. Wichtig: Das Programm kann nur Formales prüfen; ob der Inhalt stimmt und verständlich ist, bleibt Menschenarbeit.

### Typische Fehler.

Falsch ist, im Ticket nur den vermuteten Lösungsweg zu nennen (“Bitte Treiber neu installieren”), statt das Symptom zu beschreiben; die Annahme kann falsch sein. Falsch sind auch Sammeltickets mit mehreren unabhängigen Themen, weil sie sich nicht sauber abschließen lassen. Beim Abschluss ist ein häufiger Mangel, zu schreiben “erledigt” ohne Angabe der Lösung: Beim nächsten Mal weiß niemand, was geholfen hat. Besser ist ein kurzer Satz mit Ursache, Maßnahme und Prüfung. Dazu kommt Kommunikation: Wer lange nichts vom Support hört, ruft an; ein Statuskommentar mit dem nächsten Schritt spart Rückfragen.

### Praxisbezug.

Im Support schreibt man täglich Tickets und liest die anderer. Eine Wissensdatenbank mit Artikeln wie “WLAN-Passwort ändern” oder “VPN-Fehler 809” senkt die Zahl der Anrufe deutlich, und ein Runbook “Datenbank-Neustart nach Absturz” entscheidet nachts um 03:00 darüber, ob eine Störung in 10 Minuten oder in zwei Stunden behoben ist.

## 9.6 Patch-, Release- und Change-Basis

Software enthält Fehler und Sicherheitslücken, und deshalb veröffentlichen Hersteller laufend Verbesserungen. Ein *Patch* ist ein kleines Korrekturpaket für bekannte Fehler oder Sicherheitslücken, ein *Update* umfasst meist mehrere Korrekturen und kleine Verbesserungen, ein *Upgrade* bringt eine neue Hauptversion mit neuen Funktionen. Ein *Release* ist eine veröffentlichte, benannte Version einer Software, und *Release Management* plant, wie neue Versionen in den Betrieb kommen. Aus Sicherheitssicht ist Patchen eine der wirksamsten Maßnahmen, denn viele Angriffe nutzen bekannte, längst behebbare Lücken (Modul 10). Gleichzeitig kann jedes Update etwas kaputt machen; Betrieb heißt deshalb, zwischen dem Risiko des Nichtpatchens und dem des Patchens abzuwägen und beides kontrolliert zu steuern.

Dafür gibt es das *Change Management* (in ITIL 4: *Change Enablement*). Eine Änderung durchläuft typischerweise diese Schritte: Beschreiben (was, warum, wer ist betroffen), Risiko bewerten, genehmigen lassen, testen, ankündigen, durchführen, prüfen, dokumentieren. Man unterscheidet drei Typen. Eine *Standardänderung* ist risikoarm, wiederkehrend und bereits vorab freigegeben (zum Beispiel ein monatliches Update einer Testgruppe oder das Anlegen eines Benutzers). Eine *normale Änderung* wird einzeln bewertet und freigegeben, oft durch ein Änderungsgremium. Eine *Notfalländerung* behebt eine akute Störung oder Sicherheitslücke und läuft verkürzt, wird aber nachträglich dokumentiert und geprüft. Das Prinzip dahinter: Jede Änderung hat ein erkennbares Risiko, und je größer es ist, desto mehr Absicherung braucht sie.

Absicherung bedeutet drei Dinge. Erstens *Testen* in einer Umgebung, die der echten ähnlich ist (Testsystem, Pilotgruppe), bevor alle betroffen sind; man führt Updates in *Wellen* (Ringen) ein: erst die IT selbst, dann eine kleine Nutzergruppe, schließlich alle. Zweitens ein *Rollback-Plan*: Es muss vorab klar sein, wie man zum vorherigen Zustand zurückkehrt (Datensicherung, Snapshot, Installationspaket der alten Version), und wie lange das dauert; eine Änderung ohne Rückweg ist ein Glücksspiel. Drittens *Kommunikation*: Betroffene erfahren vorher, wann sie wegen der Arbeiten mit Einschränkungen rechnen müssen. Dafür dient das *Wartungsfenster*, ein vereinbarter Zeitraum, in dem geplante Arbeiten erlaubt sind, meist außerhalb der Hauptarbeitszeit, etwa Sonntag 02:00 bis 06:00 Uhr. Nach dem Eingriff prüft man, ob alles funktioniert, und meldet das Ende an.

Das folgende Programm bewertet Änderungen mit einem einfachen Punktesystem. Jede fehlende Absicherung erhöht die Punktzahl; daraus folgt die Einordnung als Standard, normale Änderung oder hohes Risiko. Die Gewichte sind ein didaktisches Beispiel, kein Branchenstandard.

```python
def risiko(aenderung):
    punkte = 0
    punkte += {"niedrig": 1, "mittel": 2, "hoch": 4}[aenderung["kritikalitaet"]]
    punkte += 0 if aenderung["getestet"] else 3
    punkte += 0 if aenderung["rollback"] else 3
    punkte += 0 if aenderung["im_wartungsfenster"] else 2
    punkte += 0 if aenderung["informiert"] else 1
    if punkte <= 2:
        art = "Standardaenderung (vorab freigegeben)"
    elif punkte <= 6:
        art = "Normale Aenderung (Freigabe durch Change-Verantwortliche)"
    else:
        art = "Hohes Risiko (nachbessern oder Notfallverfahren pruefen)"
    return punkte, art

faelle = {
    "Monatliches Windows-Update Testgruppe":
        dict(kritikalitaet="niedrig", getestet=True, rollback=True,
             im_wartungsfenster=True, informiert=True),
    "Firewall-Regel fuer neuen Dienst":
        dict(kritikalitaet="hoch", getestet=True, rollback=True,
             im_wartungsfenster=True, informiert=True),
    "Datenbank-Upgrade ohne Test, tagsueber":
        dict(kritikalitaet="hoch", getestet=False, rollback=False,
             im_wartungsfenster=False, informiert=False),
}
for name, a in faelle.items():
    punkte, art = risiko(a)
    print(f"{punkte:2} Punkte | {art} | {name}")
```

Die Kritikalität des betroffenen Systems bildet die Grundlage: niedrig bringt einen Punkt, mittel zwei, hoch vier. Jede fehlende Schutzmaßnahme addiert Punkte, am meisten fehlende Tests und fehlender Rollback (je drei), danach die Durchführung außerhalb des Wartungsfensters (zwei) und fehlende Information der Betroffenen (einer). Das Update der Testgruppe kommt auf nur einen Punkt und gilt als Standardänderung. Die Firewall-Regel für einen wichtigen Dienst hat trotz vollständiger Absicherung vier Punkte, weil das System kritisch ist, und wird deshalb einzeln freigegeben. Das Datenbank-Upgrade ohne Test, ohne Rückweg, tagsüber und ohne Ankündigung erreicht 13 Punkte und wird als hohes Risiko eingestuft: Hier würde man die Änderung zurückweisen und nachbessern. Die Berechnung zeigt, dass Absicherung das Risiko tatsächlich senkt, auch wenn das System kritisch bleibt.

### Typische Fehler.

Falsch ist, auf Produktivsystemen zuerst zu patchen und danach zu testen, ebenso, am Freitagnachmittag größere Änderungen einzuspielen, wenn für Fehlerbehebung am Wochenende niemand bereitsteht. Falsch ist es, Änderungen “mal eben” ohne Ticket vorzunehmen; sie sind später nicht nachvollziehbar, und bei einer Störung weiß niemand, was geändert wurde. Und falsch ist, Updates dauerhaft aufzuschieben: Systeme ohne Patches sind das bevorzugte Ziel von Angriffen.

### Praxisbezug.

Microsoft veröffentlicht Sicherheitsupdates für Windows regelmäßig am zweiten Dienstag im Monat (“Patch Tuesday”, Modul 3). Viele Firmen testen sie in den Tagen danach an einer Pilotgruppe und verteilen sie dann in Wellen; ein Notfallpatch bei einer aktiv ausgenutzten Lücke läuft verkürzt.

> **Merke**
>
> Änderung = geplant, bewertet, getestet, rücksetzbar, angekündigt. Typen: Standard, normal, Notfall. Wartungsfenster = vereinbarte Zeit für geplante Arbeiten. Ohne Rollback keine Änderung. Patchen reduziert Sicherheitsrisiko, ungeprüftes Patchen schafft Betriebsrisiko.

## 9.7 Kapazitäts- und Leistungsbetrachtung

*Kapazitätsmanagement* stellt sicher, dass ausreichend Ressourcen (Speicher, Rechenleistung, Netz, Lizenzen) zur richtigen Zeit zur Verfügung stehen, ohne unnötig viel zu bezahlen. Es betrachtet zwei Seiten: die *aktuelle Auslastung* (wie viel wird gerade gebraucht?) und die *zukünftige Entwicklung* (wann wird es eng?). Ein Datenträger, der heute zu 50 Prozent gefüllt ist, kann in drei Monaten voll sein, wenn die Daten schnell wachsen, oder in drei Jahren, wenn sie langsam wachsen. Deshalb sind einzelne Messwerte wenig aussagekräftig; erst die Entwicklung über Wochen und Monate zeigt einen *Trend*.

Zwei Grundbegriffe sind wichtig. Das *Wachstum* beschreibt, wie sich eine Größe verändert, etwa “plus 9 Gigabyte pro Woche”, linear oder prozentual (Verdopplung alle zwei Jahre). Die *Spitzenlast* (*Peak*) ist der höchste Bedarf, den ein System tragen muss: Ein Onlineshop braucht am Black Friday ein Vielfaches des normalen Durchschnitts. Planen muss man nach der Spitze, nicht nach dem Mittel, mit einem Puffer, den man *Reserve* oder *Headroom* nennt. Zur *Leistungsbetrachtung* gehören Antwortzeiten, Durchsatz und Warteschlangen. Ein klassischer Zusammenhang: Steigt die Auslastung in die Nähe von 100 Prozent, steigen die Antwortzeiten überproportional, weil sich Anfragen stauen; ein System mit 95 Prozent CPU-Last ist deshalb meist schon deutlich langsamer als eines mit 70 Prozent.

Die einfachste Methode zur Vorhersage ist die *lineare Extrapolation*: Man legt durch die gemessenen Punkte eine Gerade (*lineare Regression*) und verlängert sie bis zur Grenze. Das ist keine Wahrsagerei, sondern eine begründete Schätzung, die nur gilt, solange das Wachstum so bleibt wie bisher; ein neues Projekt, eine Fusion oder ein Wechsel der Software kann den Verlauf schlagartig ändern. Deshalb ergänzt man die Rechnung durch Fachwissen und schaut regelmäßig neu hin.

Das folgende Programm nimmt zehn wöchentliche Messwerte der Belegung eines 1000-Gigabyte-Speichers und berechnet das Wachstum mit der Funktion `statistics.linear_regression`; daraus folgt, wann 80, 90 und 100 Prozent erreicht werden.

```python
import statistics

wochen = list(range(1, 11))
belegt_gb = [412, 420, 431, 437, 449, 455, 468, 474, 486, 493]
KAPAZITAET = 1000
steigung, achse = statistics.linear_regression(wochen, belegt_gb)
print(f"Wachstum: {steigung:.1f} GB pro Woche, Startwert {achse:.1f} GB")
aktuell = belegt_gb[-1]
for grenze in (0.8, 0.9, 1.0):
    ziel = KAPAZITAET * grenze
    wochen_bis = (ziel - achse) / steigung
    rest = wochen_bis - wochen[-1]
    print(f"{grenze:.0%} ({ziel:.0f} GB) erreicht in Woche {wochen_bis:.1f}, also in {rest:.1f} Wochen")
print("Aktuell:", aktuell, "GB =", f"{aktuell / KAPAZITAET:.1%}")
```

Die Funktion `linear_regression` (seit Python 3.10 in der Standardbibliothek) liefert Steigung und Achsenabschnitt der Geraden, die am besten zu den Messpunkten passt. Das Ergebnis: Der Speicher wächst um 9,1 Gigabyte pro Woche und startete rechnerisch bei 402,3 Gigabyte. Die Gerade “belegt = achse + steigung mal Woche” wird nach der Woche aufgelöst, in der eine Grenze erreicht wird: `(ziel - achse) / steigung`. Der Warnwert von 80 Prozent wird demnach in Woche 43,6 überschritten, also in rund 33,6 Wochen, 90 Prozent in rund 44,6 Wochen und die volle Kapazität in rund 55,5 Wochen. Jetzt sind 493 Gigabyte oder 49,3 Prozent belegt. Daraus folgt eine Planung: Beschaffung oder Aufräumen sollten so rechtzeitig erfolgen, dass vor Woche 43 eine Lösung vorliegt; wegen Lieferzeiten und Genehmigungen beginnt man deutlich früher.

### Typische Fehler.

Falsch ist, nur auf die aktuelle Auslastung zu schauen und das Wachstum zu ignorieren; “noch 50 Prozent frei” klingt gut, kann aber nur zwei Monate bedeuten. Falsch ist auch, nach Durchschnittswerten zu dimensionieren und Lastspitzen zu vergessen. Ein Fehler beim Extrapolieren: eine Gerade weit über den Messzeitraum hinaus fortzuschreiben, etwa aus zehn Wochen auf fünf Jahre zu schließen. Und häufig wird übersehen, dass mehr Hardware nicht immer hilft, wenn der Engpass an anderer Stelle liegt (Datenbank, Netzanbindung); vor dem Kauf ist der Flaschenhals zu ermitteln.

### Praxisbezug.

Im Betrieb einer Dateiablage erhält die IT jeden Monat einen Bericht über den Speicherverbrauch; zeigt er, dass in vier Monaten 90 Prozent erreicht sind, wird entweder aufgeräumt (Archivierung, Abschnitt 6.2) oder Speicher bestellt. Kosten und Wirtschaftlichkeit solcher Entscheidungen behandelt Modul 12.

## 9.8 Troubleshooting-Methodik

Fehlersuche wirkt oft wie Intuition, ist aber vor allem Methode. Wer planlos Einstellungen ändert, zerstört Spuren, verschlimmert Probleme und weiß am Ende nicht, was geholfen hat. Die Prüfung verlangt eine feste Abfolge, die auch im echten Support gilt. Sie lässt sich als Kreislauf lesen: beobachten, vermuten, prüfen, handeln, kontrollieren, festhalten.

> **Ergänzung aus der Nachrecherche**
>
> Der CompTIA-Blog zur Troubleshooting-Methodik (abgerufen) nennt sieben Schritte: (1) das Problem identifizieren, bevor etwas geändert wird; (2) eine Theorie der wahrscheinlichen Ursache aufstellen; (3) die Theorie testen, um die Ursache zu bestimmen, und bei Widerlegung zu früheren Schritten zurückkehren; (4) einen Plan zur Behebung mit möglichen Auswirkungen aufstellen; (5) die Lösung umsetzen oder bei Bedarf eskalieren; (6) die vollständige Funktion des Systems prüfen und gegebenenfalls Vorbeugemaßnahmen einführen; (7) Erkenntnisse, Maßnahmen, Ergebnisse und gewonnene Erfahrungen dokumentieren. Die Schritte wurden dem Blogbeitrag entnommen, der nicht die offiziellen Prüfungsziele ist; die verbindliche Formulierung steht in den Exam Objectives von CompTIA.

Schritt eins verlangt, das Problem zu *identifizieren*. Man befragt die Betroffenen (Was genau geschieht? Seit wann? Was wurde zuletzt geändert? Betrifft es einen oder viele?), reproduziert den Fehler wenn möglich, liest Fehlermeldungen im Wortlaut und prüft Logs. Entscheidend ist, die Frage “Was hat sich geändert?” zu stellen, denn die meisten Störungen folgen auf eine Änderung. Hier sammelt man Fakten und verändert noch nichts. Im zweiten Schritt entsteht eine *Hypothese*: Aus den Symptomen leitet man die wahrscheinlichste Ursache ab, und zwar oft nach dem Prinzip “vom Einfachen zum Komplexen”: Ist das Kabel gesteckt? Ist der Dienst gestartet? Ist das Gerät eingeschaltet? Einfache Ursachen sind häufig und billig zu prüfen. Man kann dabei “von unten nach oben” vorgehen (zuerst Stromversorgung und Kabel, dann Netzwerk, dann Betriebssystem, dann Anwendung) oder “von oben nach unten”, oder das Problem durch “Teilen und Eingrenzen” verkleinern: Geht es auf einem anderen Gerät, in einem anderen Netz, mit einem anderen Konto?

Im dritten Schritt wird die Hypothese *getestet*, ohne dabei mehr zu ändern als nötig. Ein guter Test ist so gebaut, dass sein Ergebnis die Theorie entweder bestätigt oder verwirft. Ändert man mehrere Dinge gleichzeitig, weiß man hinterher nicht, welche Änderung gewirkt hat; deshalb gilt: *eine Änderung nach der anderen*, und jede Änderung wird notiert, damit man sie rückgängig machen kann. Ist die Hypothese widerlegt, geht man zurück zu Schritt zwei, bei Bedarf auch zu Schritt eins. Bestätigt sie sich, folgt der Plan: Wie behebt man das Problem, welche Nebenwirkungen drohen (Ausfall anderer Nutzer, Datenverlust), braucht man eine Genehmigung (Abschnitt 9.6), gibt es einen Rückweg? Reicht die eigene Berechtigung oder Kompetenz nicht, wird *eskaliert*; das ist kein Versagen, sondern Teil des Prozesses.

Nach der Umsetzung prüft man, ob das *gesamte* System wieder funktioniert, nicht nur der Teil, der gestört war: Wurde mit der Reparatur etwas anderes verschlechtert? Danach überlegt man *Vorbeugung*: Was verhindert, dass es wieder passiert (Überwachung, Updates, Schulung, Konfiguration)? Zum Schluss *dokumentiert* man die Ursache, die Lösung und die Erkenntnisse im Ticket und gegebenenfalls in der Wissensdatenbank. Zwei Sonderfälle verlangen besondere Sorgfalt. *No Fault Found* (kein Fehler gefunden) bedeutet, dass sich das gemeldete Problem nicht nachstellen lässt; man schließt das Ticket nicht einfach, sondern fragt nach den genauen Umständen, bittet um Beobachtung (Screenshot, Uhrzeit), prüft Logs des Zeitpunkts und hält den Stand fest, damit bei Wiederholung weitergeforscht werden kann. *Wiederholfehler* (der Fehler kehrt zurück) deuten darauf hin, dass nur das Symptom behandelt wurde; sie gehen als Problem in die Ursachenanalyse (Abschnitt 9.1). Dafür eignet sich die *Fünf-Warum-Methode*: Man fragt wiederholt “Warum?”, bis man von der sichtbaren Wirkung zu einer Ursache gelangt, die man beeinflussen kann, oft ein Prozess- und nicht ein Technikfehler.

Das folgende Programm bildet die sieben Schritte als Störungsprotokoll nach und zeigt zugleich eine Fünf-Warum-Kette. Das Beispiel ist erfunden, aber realistisch: Ein Anwender erreicht nur das Intranet nicht, während andere Seiten funktionieren.

```python
class Stoerungsprotokoll:
    def __init__(self, ticket):
        self.ticket = ticket
        self.eintraege = []

    def schritt(self, phase, text):
        self.eintraege.append((phase, text))

    def bericht(self):
        zeilen = [f"Stoerungsprotokoll {self.ticket}"]
        for nr, (phase, text) in enumerate(self.eintraege, start=1):
            zeilen.append(f"{nr}. [{phase}] {text}")
        return "\n".join(zeilen)

p = Stoerungsprotokoll("T-4711")
p.schritt("Problem erfassen", "Nutzerin erreicht Intranet nicht; andere Seiten gehen. Seit 09:10. Nichts geaendert.")
p.schritt("Theorie", "DNS-Eintrag fuer intranet.firma.local falsch (wahrscheinlichste Ursache, da nur ein Name betroffen)")
p.schritt("Test", "nslookup liefert 10.0.5.77, Kollege-PC liefert 10.0.5.20 -> Theorie bestaetigt (veralteter Cache)")
p.schritt("Plan", "DNS-Cache leeren (ipconfig /flushdns); Auswirkung: keine, Cache baut sich neu auf")
p.schritt("Umsetzung", "Cache geleert")
p.schritt("Pruefung", "Intranet laedt; weitere interne Namen getestet. Vorbeugung: TTL des Eintrags geprueft")
p.schritt("Dokumentation", "Ursache, Loesung und Pruefbefehle in Wissensdatenbank eingetragen")
print(p.bericht())

def fuenf_warum(antworten):
    for i, a in enumerate(antworten, start=1):
        print(f"Warum {i}? {a}")
    print("-> Ursache auf Prozessebene:", antworten[-1])

fuenf_warum(["Das Intranet war nicht erreichbar.",
             "Der PC fragte eine alte IP-Adresse ab.",
             "Der DNS-Eintrag war vor 3 Tagen geaendert worden.",
             "Der Cache auf Clients lief erst nach 7 Tagen ab.",
             "Bei Aenderungen an DNS-Eintraegen wird die TTL nicht vorher gesenkt."])
```

Die Klasse `Stoerungsprotokoll` sammelt Einträge aus Phase und Text und gibt sie nummeriert aus (`enumerate` mit `start=1` beginnt bei 1). Das Beispielprotokoll folgt den Schritten: Zuerst werden Symptom, Beginn und “Nichts geändert” festgehalten. Die Theorie “falscher DNS-Eintrag” ist plausibel, weil nur ein Name betroffen ist, während andere Webseiten funktionieren. Der Test vergleicht die Auskunft des Namensdienstes auf zwei Rechnern: Der Rechner der Nutzerin liefert eine andere (alte) Adresse als der des Kollegen, was die Theorie bestätigt (der Befehl `nslookup` ist ein Standardwerkzeug aus Modul 4). Der Plan benennt Maßnahme und Auswirkung; der Befehl `ipconfig /flushdns` gehört zu Windows und wurde hier nicht ausgeführt, denn das Beispiel ist eine Beschreibung und kein Systemzugriff. Zum Schluss erfolgen Prüfung und Dokumentation. Die Fünf-Warum-Kette führt vom sichtbaren Symptom (Intranet nicht erreichbar) zu einer Ursache auf Prozessebene: Bei Änderungen wird die Gültigkeitsdauer (*TTL*, *Time to Live*) des Eintrags nicht vorher gesenkt. Erst diese Erkenntnis verhindert die Wiederholung; das Leeren des Caches allein hätte nur das Symptom beseitigt.

### Typische Fehler.

Falsch ist der “Schrotflintenansatz”: gleichzeitig Treiber neu installieren, Gerät neu starten und Einstellungen zurücksetzen. Wenn es danach geht, weiß niemand, warum. Falsch ist auch, Nutzer nicht zu befragen (“Hat sich etwas geändert?”), oder Aussagen ungeprüft zu übernehmen: Der Satz “Das Netz ist kaputt” sagt wenig, ein Test (Ping, anderer Rechner) sagt viel. Gefährlich ist, Daten zu riskieren, bevor man eine Sicherung hat, und Fehler zu “beheben”, ohne zu dokumentieren: Beim nächsten Mal beginnt alles von vorn. Ein subtiler Fehler ist die Fixierung auf die erste Theorie: Bestätigung suchen statt Widerlegung.

### Praxisbezug.

Jeder Support-Fall folgt diesem Schema, bewusst oder nicht. Wer es bewusst anwendet, löst Fälle schneller und kann sie anderen nachvollziehbar übergeben. In der Prüfung erscheinen Fragen in der Form “Was ist der nächste Schritt?”; dann hilft die Reihenfolge der Methode, die Antwort einzugrenzen: Zuerst Fakten sammeln, dann Hypothese, dann testen, erst danach ändern.

> **Merke**
>
> Reihenfolge: Problem identifizieren → Theorie → testen → Plan (mit Auswirkungen) → umsetzen oder eskalieren → Funktion prüfen und vorbeugen → dokumentieren. Eine Änderung nach der anderen. Was hat sich geändert? ist die wichtigste Frage. No Fault Found nicht stillschweigend schließen; Wiederholfehler sind Problemfälle.

## Übungsaufgaben Modul 09

1.  Ordnen Sie die folgenden Fälle als Incident, Service Request, Problem oder Change ein und begründen Sie kurz: (a) “Bitte richten Sie für die neue Kollegin ein Konto ein.” (b) “Der Server ist seit 10 Minuten nicht erreichbar.” (c) “Dieser Server fällt jede Woche aus; wir müssen die Ursache finden.” (d) “Wir wollen die Firewall-Firmware aktualisieren.”

2.  Ein Dienst hat laut SLA 99,9 Prozent Verfügbarkeit pro Jahr. Wie viele Stunden Ausfall sind erlaubt? Wie ändert sich das bei 99,99 Prozent? Begründen Sie, warum zusätzliche “Neunen” den Betrieb verteuern.

3.  Nennen Sie je zwei sinnvolle Metriken für CPU, RAM, Datenträger und Netzwerk und je einen sinnvollen Warn- und Kritisch-Schwellenwert für den Datenträger. Begründen Sie die Wahl.

4.  Erklären Sie die Unterschiede zwischen System-, Anwendungs- und Sicherheitslogs und nennen Sie je ein Beispiel für einen Eintrag. Warum ist die Zeitsynchronisation wichtig?

5.  Ein Team erhält täglich 200 Alarme, von denen 190 folgenlos sind. Beschreiben Sie das Problem und nennen Sie vier Maßnahmen, die Abhilfe schaffen.

6.  **Praxis:** Schreiben Sie ein Python-Programm, das aus einem Log-Text mit Zeilen im Format `ZEIT STUFE QUELLE: TEXT` alle Zeilen der Stufe ERROR herausfiltert und die Anzahl je Quelle ausgibt. Testen Sie mit mindestens fünf selbst erfundenen Zeilen.

7.  **Praxis:** Erweitern Sie die Funktion `risiko` aus Abschnitt 9.6 um die Eigenschaft `anwender_betroffen` (Anzahl der betroffenen Personen): bis 10 Personen 0 Punkte, bis 100 Personen 1 Punkt, darüber 2 Punkte. Geben Sie das Ergebnis für eine Änderung mit 250 betroffenen Personen aus, sonst mit niedrigem Risiko und voller Absicherung.

8.  **Praxis:** Gegeben sind die wöchentlichen Belegungswerte eines Datenträgers in Gigabyte `[300, 312, 325, 340, 352, 366]` bei 600 Gigabyte Kapazität. Berechnen Sie mit `statistics.linear_regression`, in wie vielen Wochen nach Woche 6 die 90-Prozent-Grenze erreicht wird, und formulieren Sie eine Empfehlung.

9.  Ein Mitarbeiter meldet: “Mein Laptop hat gestern um 15 Uhr kurz geruckelt, jetzt geht es wieder.” Beschreiben Sie, wie Sie nach der Methodik aus Abschnitt 9.8 vorgehen und wie Sie das Ticket abschließen.

## Lösungen Modul 09

1.  \(a\) Service Request: ein vorgesehener Standardwunsch, keine Störung. (b) Incident: ungeplante Unterbrechung eines Dienstes. (c) Problem: Ursache mehrerer wiederkehrender Incidents. (d) Change: geplante Änderung mit Bewertung, Test, Rollback und Wartungsfenster.

2.  99,9 Prozent von 8 760 Stunden ergeben $8760 \cdot 0{,}001 = 8{,}76$ Stunden (rund 8,8 Stunden). Bei 99,99 Prozent sind es 0,876 Stunden, also rund 52,6 Minuten. Jede Neun zehnfach weniger Ausfall zu erlauben verlangt Redundanz (zweite Server, zweite Leitung), schnellere Reaktion, automatische Umschaltung und mehr Personal; die Kosten steigen daher stark.

3.  CPU: Auslastung in Prozent, Prozessorwarteschlange (Warn 80, Kritisch 95). RAM: belegter Speicher, Auslagerungsaktivität. Datenträger: freier Platz in Prozent, Schreib-/Lesezeit. Netzwerk: Durchsatz, Paketverlust, Latenz. Für den Datenträger beispielsweise Warnung bei 85 Prozent Füllung (genug Zeit zum Handeln) und kritisch bei 95 Prozent (ein Ausfall droht); große Datenträger vertragen höhere Prozentwerte, bei kleinen sind niedrigere sinnvoll.

4.  Systemlog: Start eines Dienstes oder Treiberfehler. Anwendungslog: “Datenbankverbindung verloren”. Sicherheitslog: “Anmeldung fehlgeschlagen für Benutzer admin von IP ...”. Ohne einheitliche Uhrzeit lassen sich Ereignisse mehrerer Systeme nicht in die richtige Reihenfolge bringen, und die Ursachenanalyse wird unzuverlässig.

5.  Es herrscht Alarmmüdigkeit: Die wichtigen Meldungen gehen unter. Maßnahmen: nur alarmieren, was Handlung erfordert; Flackern durch mehrere Fehlschläge in Folge abfangen; Folgemeldungen durch Abhängigkeiten unterdrücken; Wartungsfenster berücksichtigen; Schwellen anpassen; jede unnötige Meldung nachträglich auswerten und die Regel verbessern.

6.  Beispiellösung:

    ```python
    import re
    from collections import Counter

    LOG = """08:00 INFO app: Start
    08:05 ERROR db: Verbindung verloren
    08:06 ERROR db: Wiederholung fehlgeschlagen
    08:07 WARNING web: langsame Antwort
    08:09 ERROR web: 500 Interner Fehler
    08:10 INFO app: Weiter
    """
    muster = re.compile(r"^(\S+) (\w+)\s+(\w+): (.*)$")
    je_quelle = Counter()
    for zeile in LOG.splitlines():
        zeit, stufe, quelle, text = muster.match(zeile).groups()
        if stufe == "ERROR":
            je_quelle[quelle] += 1
    print(dict(je_quelle))
    ```

    Ausgabe: `{'db': 2, 'web': 1}`. Der reguläre Ausdruck zerlegt jede Zeile; der Zähler erhöht nur bei ERROR.

7.  Beispiellösung: Man ergänzt am Anfang der Funktion eine Berechnung der Punkte aus `aenderung["anwender_betroffen"]`, etwa

    ```python
    n = aenderung["anwender_betroffen"]
    punkte += 0 if n <= 10 else (1 if n <= 100 else 2)
    ```

    Für die Änderung mit niedriger Kritikalität (1 Punkt), voller Absicherung und 250 Betroffenen ergeben sich 3 Punkte: eine normale Änderung. Ohne die neue Eigenschaft wäre sie eine Standardänderung geblieben, obwohl viele Personen betroffen sind; das zeigt, warum die Reichweite in die Bewertung gehört.

8.  Beispiellösung:

    ```python
    import statistics
    wochen = [1, 2, 3, 4, 5, 6]
    belegt = [300, 312, 325, 340, 352, 366]
    steigung, achse = statistics.linear_regression(wochen, belegt)
    ziel = 0.9 * 600
    woche = (ziel - achse) / steigung
    print(round(steigung, 1), round(woche, 1), round(woche - 6, 1))
    ```

    Das Wachstum beträgt rund 13,3 Gigabyte pro Woche; die 540 Gigabyte der 90-Prozent-Grenze werden in Woche 19,1 erreicht, also rund 13,1 Wochen nach Woche 6. Empfehlung: Innerhalb von etwa acht Wochen aufräumen oder erweitern, damit noch Reserve für Lieferzeit und Umsetzung bleibt, und die Prognose laufend überprüfen.

9.  Problem erfassen: Wann genau, wie lange, welche Anwendung, ist es wieder aufgetreten, was war zu dieser Zeit los (Update, großer Download, Besprechung)? Theorie: kurzzeitige Auslastung, etwa durch ein Hintergrundupdate. Test: Ereignisanzeige für gestern 15 Uhr prüfen, Auslastungsverlauf ansehen, Zustand von Datenträger und Akku prüfen. Ist nichts Auffälliges zu finden, handelt es sich um *No Fault Found*: Das Ticket wird nicht stillschweigend geschlossen, sondern mit dem Prüfergebnis dokumentiert, und die Mitarbeiterin wird gebeten, bei Wiederholung Uhrzeit und Anwendung zu nennen und möglichst einen Screenshot der Auslastung zu senden; das Ticket kann auf “wartet auf Rückmeldung” gesetzt werden.
