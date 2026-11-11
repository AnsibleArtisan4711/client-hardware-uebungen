# Modul 12 - Automation, Kosten, Migration und BCDR-Grundlagen

> **Hinweis zu diesem Kapitel:** Das ist das Kapitel des Skripts „CompTIA Tech+ / ITF+ (FC0-U71): Lernskript in Modulen“, aus der LaTeX-Quelle in Markdown umgewandelt (Text und Listings unverändert, Boxen als Zitatblöcke, Aufgaben und Lösungen als nummerierte Listen). Laut Skript wurden die Python-Beispiele bei der Erstellung im Arbeitsbereich ausgeführt, die gezeigten Ausgaben stammen aus diesen Läufen; Windows- und PowerShell-Befehle wurden nicht ausgeführt. Für dieses Repository wurden die Listings **nicht erneut ausgeführt**. Prüfungsdetails, Produktnamen und Versionen ändern sich; maßgeblich sind die aktuellen Prüfungsziele (Exam Objectives) von CompTIA. Übersicht zum Modul: [README](README.md).

**Dauer:** 8 h

**Priorität:** 1 (höchste)

|  Nr. | Lerneinheit                               | Dauer (h) | Prio |
|-----:|:------------------------------------------|----------:|-----:|
| 12.1 | Automatisierungsgrundlagen                |         1 |    1 |
| 12.2 | IaC- und Konfigurationsdenken             |         1 |    2 |
| 12.3 | Kostenmodelle und TCO-Basis               |         1 |    1 |
| 12.4 | Kapazität und Wirtschaftlichkeit          |      0,75 |    2 |
| 12.5 | Migrationsgrundlagen                      |         1 |    1 |
| 12.6 | Backup-Strategien                         |         1 |    1 |
| 12.7 | Disaster Recovery und Business Continuity |         1 |    1 |
| 12.8 | Abschlussfall und Verbesserungsplan       |      1,25 |    1 |
|      | **Summe**                                 |     **8** |      |

Dieses Modul bündelt vier Themen, die im Berufsalltag zusammengehören: Wie macht man wiederkehrende Arbeit zuverlässig und wiederholbar (Automatisierung und “Infrastruktur als Code”)? Was kostet ein System tatsächlich, und wann lohnt sich eine Anschaffung oder ein Umzug (Kosten und Wirtschaftlichkeit)? Wie zieht man Systeme um, ohne den Betrieb zu gefährden (Migration)? Und wie bleibt man handlungsfähig, wenn etwas Schwerwiegendes ausfällt (Backup, Disaster Recovery und Business Continuity)? Am Schluss führt ein Abschlussfall alles zusammen. Das Modul baut auf den Grundlagen früherer Kapitel auf: Die Datensicherung wurde in Abschnitt 6.6 eingeführt und wird hier vertieft; der Betrieb mit Monitoring und Changes steht in Modul 9, die Sicherheitsmaßnahmen in Modul 10, Cloud-Modelle in Modul 8. Alle Beispiele laufen mit Python und der Standardbibliothek; sämtliche Preise und Zahlen in den Beispielen sind erfunden und dienen nur der Rechenübung.

## 12.1 Automatisierungsgrundlagen

*Automatisierung* bedeutet, Aufgaben, die ein Mensch von Hand erledigt, von einem Programm ausführen zu lassen. Sie lohnt sich bei Tätigkeiten, die *häufig wiederkehren*, *regelhaft* ablaufen und bei denen *Flüchtigkeitsfehler* teuer sind: Konten anlegen, Updates verteilen, Speicherplatz aufräumen, Berichte erzeugen, Sicherungen prüfen. Die Vorteile sind Zeitersparnis, Gleichförmigkeit (jeder Lauf ist gleich), Nachvollziehbarkeit (das Skript ist die Dokumentation) und Skalierbarkeit (zehn oder tausend Rechner sind kaum ein Unterschied). Die Kehrseite: Ein fehlerhafter Automat macht denselben Fehler sehr schnell sehr oft. Automatisierung braucht deshalb Sicherheitsvorkehrungen.

Der erste Schritt ist, *Kandidaten zu erkennen*: Welche Aufgaben tue ich öfter als ein paarmal im Monat, und was kostet mich jede Ausführung an Zeit und Fehlerrisiko? Der zweite Schritt ist, die Aufgabe zu *standardisieren*: Ein Prozess, der jedes Mal anders abläuft, lässt sich nicht automatisieren; zuerst legt man Schritte, Reihenfolge und Ergebnis fest, dann überträgt man sie in ein Skript. Drei Werkzeugstufen sind im Betrieb üblich: *Vorlagen* (Checklisten, Mustertexte, Standard-Images für neue Rechner), *Skripte* (Programme in Sprachen wie PowerShell, Bash oder Python) und *Workflows* (verkettete Schritte mit Freigaben, etwa ein automatisierter Eintrittsprozess: Konto anlegen, Postfach einrichten, Gerät bestellen, Ticket schließen). Ausgelöst wird Automatisierung entweder zeitgesteuert (der *Taskplaner* unter Windows, *cron* unter Linux, zum Beispiel jeden Sonntag um zwei Uhr nachts), ereignisgesteuert (eine neue Datei erscheint, ein Ticket wird angelegt) oder auf Knopfdruck.

Gute Automatisierung hat einige Eigenschaften, die man sich als feste Gewohnheit aneignet. Sie ist *idempotent*: Läuft das Skript ein zweites Mal, ändert es nichts mehr, wenn bereits alles im Sollzustand ist; ein Skript, das bei jedem Lauf neue Konten oder doppelte Einträge erzeugt, ist gefährlich. Sie bietet einen *Trockenlauf* (*Dry Run*), der nur anzeigt, was geschähe, ohne es zu tun, sodass man vor der echten Ausführung prüfen kann. Sie *protokolliert*, was sie getan hat (Abschnitt 9.3), sie *behandelt Fehler* (bei einem Fehler anhalten, melden, nicht weitermachen), sie läuft mit *möglichst geringen Rechten* (Abschnitt 10.3), sie enthält *keine Kennwörter im Klartext* und liegt in einer *Versionsverwaltung*, damit man Änderungen nachverfolgen und zurücknehmen kann (Modul 7). Schließlich gilt: Wer automatisiert, muss auch den Notfall ohne Automat beherrschen; das Skript ersetzt das Verständnis nicht.

Das folgende Programm räumt einen Ordner auf: Es löscht temporäre Dateien (Endung `.tmp`), die älter als 30 Tage sind. Es hat einen Trockenlauf-Schalter und ist idempotent. Zum Testen legt es in einem Wegwerf-Ordner vier Dateien an und verändert deren Zeitstempel so, dass sie 2, 45, 90 und 400 Tage alt erscheinen.

```python
import os, tempfile, time
from pathlib import Path

def aufraeumen(ordner, max_alter_tage, trockenlauf=True, jetzt=None):
    jetzt = jetzt or time.time()
    grenze = jetzt - max_alter_tage * 86400
    ergebnis = []
    for datei in sorted(Path(ordner).glob("*.tmp")):
        if datei.stat().st_mtime < grenze:
            ergebnis.append(datei.name)
            if not trockenlauf:
                datei.unlink()
    return ergebnis

with tempfile.TemporaryDirectory() as tmp:
    jetzt = time.time()
    for name, alter in [("a.tmp", 2), ("b.tmp", 45), ("c.tmp", 90), ("wichtig.docx", 400)]:
        p = Path(tmp) / name
        p.write_text("x")
        os.utime(p, (jetzt - alter * 86400, jetzt - alter * 86400))
    print("Trockenlauf:", aufraeumen(tmp, 30, trockenlauf=True, jetzt=jetzt))
    print("Noch da    :", sorted(p.name for p in Path(tmp).iterdir()))
    print("Echt       :", aufraeumen(tmp, 30, trockenlauf=False, jetzt=jetzt))
    print("Danach     :", sorted(p.name for p in Path(tmp).iterdir()))
    print("Zweiter Lauf:", aufraeumen(tmp, 30, trockenlauf=False, jetzt=jetzt))
```

Die Funktion `aufraeumen` berechnet aus `max_alter_tage` einen Grenzzeitpunkt (eine Tagesdauer hat 86 400 Sekunden) und durchsucht den Ordner nach Dateien mit der Endung `.tmp` (`glob("*.tmp")`); nur diese Endung wird betrachtet, deshalb bleibt die 400 Tage alte Datei `wichtig.docx` unangetastet. Ist der Änderungszeitpunkt (`st_mtime`) älter als die Grenze, kommt die Datei in die Ergebnisliste; *gelöscht* wird nur, wenn der Trockenlauf ausgeschaltet ist (`datei.unlink()`). Die Ausgabe zeigt: Im Trockenlauf werden `b.tmp` und `c.tmp` als löschbar gemeldet, aber alle vier Dateien sind noch vorhanden. Im echten Lauf werden dieselben zwei gelöscht, es bleiben `a.tmp` und `wichtig.docx`. Der zweite echte Lauf findet nichts mehr und liefert eine leere Liste, das Skript ist also idempotent. Der Parameter `jetzt` macht den Test deterministisch. In einem Betriebsskript käme noch die Protokollierung hinzu und die Beschränkung auf ausdrücklich freigegebene Ordner, denn ein Löschskript mit falschem Pfad ist ein klassischer Unfall.

### Typische Fehler.

Falsch ist, ein Skript zum ersten Mal “scharf” auf Produktivdaten laufen zu lassen: Zuerst Trockenlauf, dann kleiner Testbereich, dann Umfang erweitern. Falsch ist auch, ein Skript ohne Fehlerbehandlung weiterlaufen zu lassen, wenn der erste Schritt scheiterte: Dann kann der zweite Schritt auf einem halben Zustand arbeiten. Falsch ist, Automatisierung nur in den Köpfen weniger Personen zu halten: Das Skript, das nur ein Kollege versteht, ist ein Betriebsrisiko. Und falsch ist, zu automatisieren, was selten vorkommt und sich ständig ändert; der Aufwand für Entwicklung und Pflege übersteigt dann den Nutzen.

### Praxisbezug.

Beim Eintritt einer neuen Mitarbeiterin legen viele Firmen mit einem Skript oder Workflow Benutzerkonto, Postfach, Gruppenmitgliedschaften und Ticket für die Hardware an; bei Austritt läuft der umgekehrte Weg, und genau dort schützt die Automatisierung vor vergessenen Zugängen (Abschnitt 10.3). Wer im Support regelmäßig dieselben fünf Befehle eintippt, ist ein Kandidat für ein kleines Skript, das mit einem Doppelklick läuft.

> **Merke**
>
> Automatisieren, was wiederkehrt, regelhaft ist und bei dem Fehler weh tun. Erst standardisieren, dann automatisieren. Idempotent, Trockenlauf, Protokoll, Fehlerbehandlung, geringe Rechte, keine Klartext-Kennwörter, Versionsverwaltung. Auslöser: zeitgesteuert, ereignisgesteuert, manuell.

## 12.2 IaC- und Konfigurationsdenken

Wer Server oder Cloud-Ressourcen von Hand einrichtet (klicken, eintippen, anpassen), schafft “Schneeflocken”: Systeme, die nur ihr Erbauer versteht und die sich nicht exakt wiederholen lassen. *Infrastruktur als Code* (*Infrastructure as Code*, IaC) beschreibt Server, Netze, Speicher und ihre Einstellungen stattdessen in Textdateien, die ein Werkzeug ausführt. Bekannte Werkzeuge sind zum Beispiel Terraform und die Vorlagen der Cloud-Anbieter für das Anlegen von Ressourcen, Ansible, Puppet oder Chef für die Konfiguration von Rechnern, sowie die Beschreibungsdateien für Container (Modul 8). Die Namen sind für die Prüfung weniger wichtig als der Gedanke: Die gewünschte Umgebung ist *lesbarer, versionierbarer Text*, kein Gedächtnisprotokoll.

Zwei Ansätze werden unterschieden. Der *imperative* Ansatz beschreibt *Schritte* (“installiere Paket X, dann starte Dienst Y, dann ändere Datei Z”); der *deklarative* Ansatz beschreibt den *Sollzustand* (“Paket X in Version 1.24 ist installiert, Dienst Y läuft, Datei Z hat diesen Inhalt”), und das Werkzeug ermittelt selbst, was zu tun ist, um dorthin zu gelangen. Der deklarative Weg ist robuster, weil er unabhängig vom Ausgangszustand zum selben Ergebnis führt und beim wiederholten Ausführen nichts mehr ändert (Idempotenz, wie in Abschnitt 12.1). Die Vorteile von IaC sind *Reproduzierbarkeit* (dieselbe Beschreibung erzeugt dieselbe Umgebung, etwa für Test und Produktion), *Geschwindigkeit* (eine neue Umgebung entsteht in Minuten), *Nachvollziehbarkeit* (die Versionsverwaltung zeigt, wer wann was geändert hat) und *Wiederherstellbarkeit* (nach einem Totalausfall baut man die Umgebung aus dem Code neu auf).

Das größte Betriebsrisiko, das IaC bekämpft, heißt *Konfigurationsdrift* (*Configuration Drift*). Gemeint ist, dass sich ein System im Lauf der Zeit durch kleine, ungeplante Eingriffe vom Sollzustand entfernt: Jemand öffnet “nur kurz” einen Port, ein Update wird auf einem Server vergessen, ein Dienst wird manuell umkonfiguriert. Jede Abweichung ist einzeln harmlos, aber zusammen entstehen Systeme, die nicht mehr zueinander passen, Fehler, die nur auf einem Rechner auftreten, und Sicherheitslücken, die niemand kennt. Man erkennt Drift, indem man regelmäßig Ist- mit Sollzustand vergleicht (so, wie es Abschnitt 10.4 für die Baseline getan hat), und behebt sie, indem man entweder das System zum Soll zurückführt oder die Beschreibung bewusst anpasst, wenn die Abweichung gewollt war. Wichtig ist, dass jede Änderung *zuerst im Code* und dann im System geschieht, nicht umgekehrt (Abschnitt 9.6).

Das folgende Programm zeigt das Prinzip in Miniatur. Der Sollzustand ist ein Wörterbuch; die Funktion `vergleiche` ermittelt die nötigen Änderungen, die Funktion `angleichen` führt sie aus. Ein Server mit einer veralteten Version, einer unsicheren Einstellung, einem fehlenden Agenten und einem zusätzlichen offenen Port dient als Beispiel.

```python
SOLL = {"nginx": "1.24", "ntp": "aktiv", "ssh_root_login": "nein", "backup_agent": "2.1"}

def vergleiche(ist, soll):
    aenderungen = []
    for schluessel, sollwert in soll.items():
        if schluessel not in ist:
            aenderungen.append(("anlegen", schluessel, sollwert))
        elif ist[schluessel] != sollwert:
            aenderungen.append(("aendern", schluessel, f"{ist[schluessel]} -> {sollwert}"))
    for schluessel in ist:
        if schluessel not in soll:
            aenderungen.append(("abweichend (nicht im Soll)", schluessel, ist[schluessel]))
    return aenderungen

def angleichen(ist, soll):
    for schluessel, sollwert in soll.items():
        ist[schluessel] = sollwert
    return ist

server = {"nginx": "1.22", "ntp": "aktiv", "ssh_root_login": "ja", "debug_port": "offen"}
print("Drift:")
for a in vergleiche(server, SOLL):
    print("  ", a)
angleichen(server, SOLL)
print("Nach Angleichung:", vergleiche(server, SOLL))
angleichen(server, SOLL)
print("Zweiter Lauf aendert nichts mehr:", server == {**SOLL, "debug_port": "offen"})
```

Die Funktion `vergleiche` geht zuerst alle Sollwerte durch: Fehlt ein Schlüssel im Ist, ist er “anzulegen”; unterscheidet sich der Wert, ist er “zu ändern”. Danach werden Schlüssel gesucht, die im Ist vorkommen, aber im Soll nicht vorgesehen sind. Der Beispielserver liefert vier Befunde: Die Webserver-Version 1.22 soll 1.24 werden, der root-Login per SSH steht auf “ja” statt “nein”, der Backup-Agent fehlt und der Debug-Port ist offen, obwohl er im Soll nicht existiert. `angleichen` setzt alle Sollwerte. Danach bleibt als einziger Befund der Debug-Port: Das Programm entfernt *unbekannte* Einstellungen absichtlich nicht, weil dies im Betrieb eine bewusste Entscheidung ist (ein Mensch prüft, ob der Port gebraucht wird). Der zweite Lauf ändert nichts, was die letzte Zeile mit `True` bestätigt: Das Verfahren ist idempotent. Echte Werkzeuge arbeiten mit demselben Prinzip, nur mit vielen Ressourcentypen und einem Plan, der vorab anzeigt, was geschehen würde.

Zur Veranschaulichung, wie eine solche Beschreibung in der Praxis aussieht, folgt ein erfundenes Beispiel im Stil gängiger YAML-Dateien. Es wurde nicht mit einem bestimmten Werkzeug ausgeführt und zeigt nur die Denkweise: Man beschreibt, was da sein soll, nicht, wie man es erzeugt.

```yaml
server:
  name: web-01
  betriebssystem: linux
  pakete:
    nginx: "1.24"
  dienste:
    nginx: aktiv
  firewall:
    erlaubt: [443, 22]
    standard: blockiere
```

Die Datei benennt einen Server, sein Betriebssystem, das benötigte Paket in genauer Version, den Dienstzustand und die Firewall-Regeln mit Standardverbot (Default Deny, Abschnitt 10.5). Ein Werkzeug würde diese Beschreibung lesen, mit dem tatsächlichen Zustand vergleichen und nur die Unterschiede umsetzen. Weil die Datei in einer Versionsverwaltung liegt, ist jede Änderung nachvollziehbar, und eine falsche Änderung lässt sich rückgängig machen.

### Typische Fehler.

Falsch ist, “kurz per Hand” an einem von Code verwalteten System zu ändern: Die nächste Ausführung überschreibt die Änderung oder, schlimmer, niemand weiß mehr, warum das System anders ist. Falsch ist, Kennwörter und Schlüssel in die Beschreibungsdateien zu schreiben; sie gehören in einen Tresor für Geheimnisse (Abschnitt 10.8). Falsch ist, IaC für eine einmalige, kleine Umgebung mit unverhältnismäßigem Aufwand einzuführen; der Nutzen wächst mit der Zahl und Wiederholung der Umgebungen. Und falsch ist zu glauben, IaC mache Fehler unmöglich: Sie vervielfacht auch Fehler, wenn man sie ungeprüft anwendet; deshalb gehören Tests und Freigabe dazu.

### Praxisbezug.

Ein Unternehmen, das für jede Filiale einen identischen Router einrichten muss, beschreibt die Konfiguration einmal als Vorlage und erzeugt daraus die einzelnen Dateien. Ein Cloud-Team baut Test- und Produktionsumgebung aus demselben Code mit unterschiedlichen Parametern, damit Tests aussagekräftig sind. Nach einem Ausfall eines Rechenzentrums wird die Umgebung aus dem Code an anderer Stelle neu aufgebaut (Abschnitt 12.7).

## 12.3 Kostenmodelle und TCO-Basis

Wirtschaftliches Denken gehört zum IT-Betrieb: Jede Entscheidung für Geräte, Software oder Dienste kostet Geld, und die Rechnung ist selten so einfach wie der Kaufpreis. Man unterscheidet zwei Kostenarten. *CapEx* (*Capital Expenditure*, Investitionsausgaben) sind einmalige Ausgaben für Anlagen, die über mehrere Jahre genutzt werden: Server, Netzwerkgeräte, Notebooks. Sie werden bilanziell *abgeschrieben*, also über die Nutzungsdauer verteilt. *OpEx* (*Operational Expenditure*, laufende Betriebsausgaben) fallen regelmäßig an: Mieten, Abonnements, Strom, Wartung, Personal, Cloud-Gebühren. Cloud-Dienste verschieben Ausgaben tendenziell von CapEx zu OpEx: Statt einen Server zu kaufen, zahlt man monatlich für die Nutzung. Das senkt die Einstiegshürde und erhöht die Flexibilität, kann aber auf Dauer teurer sein, wenn die Last gleichmäßig hoch bleibt. Ein Mietmodell ist keine Geldersparnis an sich.

Die Kosten eines Systems über seine ganze Lebensdauer fasst die *Gesamtbetriebskosten* (*Total Cost of Ownership*, TCO) zusammen. Sie umfassen die Anschaffung (Hardware, Einrichtung, Migration), die laufenden Kosten (Lizenzen und Abonnements, Energie und Kühlung, Wartung und Support, Personal für Betrieb und Administration, Schulung, Speicherplatz und Datenübertragung) und die Entsorgung, abzüglich eines eventuellen Restwerts. Typische *versteckte Kosten* sind Ausfälle (Produktivitätsverlust), Sicherheitsvorfälle, Datensicherung, Updates, Anpassung von Schnittstellen und Schulungen. Wer nur den Kaufpreis vergleicht, entscheidet falsch: Ein günstiges Gerät mit hohem Strombedarf, teurem Support und kurzer Lebensdauer kann über fünf Jahre deutlich mehr kosten als ein teureres. Deshalb betrachtet man einen Zeitraum, der der Nutzungsdauer entspricht (oft drei bis fünf Jahre), und rechnet die Kosten pro Jahr oder pro Nutzer.

> **Ergänzung aus der Nachrecherche**
>
> Die Lizenzkosten sind ein eigenes Thema, weil Modelle sich stark unterscheiden: Kauflizenz (einmalig, oft mit zusätzlichem Wartungsvertrag), Abonnement (pro Nutzer und Monat), nutzungsabhängige Abrechnung (pro Stunde, pro Anfrage, pro Gigabyte) und freie Software (kein Lizenzpreis, aber Kosten für Betrieb und Support). In der Cloud kommen Posten hinzu, die man leicht übersieht: Gebühren für Datenabfluss aus dem Rechenzentrum, für Speicher von Sicherungen, für zusätzliche Dienste und Support-Stufen. Diese Einordnung beruht auf allgemeinem Fachwissen und wurde nicht an einer Quelle geprüft; die tatsächlichen Preismodelle ändern sich und sind bei den Anbietern nachzulesen.

Das folgende Programm rechnet ein fiktives Beispiel: ein eigener Server im Haus gegen einen vergleichbaren Cloud-Dienst über fünf Jahre. Der eigene Server kostet in der Anschaffung 24 000 (CapEx), im Betrieb jährlich 1 200 Energie, 1 500 Lizenzen, 900 Support und 3 000 anteilig Personal und hat nach fünf Jahren einen Restwert von 2 000. Der Cloud-Dienst kostet 650 pro Monat plus einmalig 2 500 für Einrichtung und Migration. Alle Beträge sind erfunden.

```python
def tco(anschaffung, jahre, energie_jahr, lizenz_jahr, support_jahr, personal_jahr, restwert=0):
    laufend = (energie_jahr + lizenz_jahr + support_jahr + personal_jahr) * jahre
    return anschaffung + laufend - restwert, laufend

eigen, laufend_eigen = tco(anschaffung=24000, jahre=5, energie_jahr=1200, lizenz_jahr=1500,
                           support_jahr=900, personal_jahr=3000, restwert=2000)
cloud_monat = 650
cloud = cloud_monat * 12 * 5 + 2500
print(f"Eigenbetrieb: Anschaffung 24000 (CapEx), laufend {laufend_eigen} (OpEx), TCO 5 Jahre = {eigen}")
print(f"Cloud       : {cloud_monat}/Monat, Einrichtung 2500, TCO 5 Jahre = {cloud}")
print(f"Differenz   : {cloud - eigen:+} zugunsten {'Eigenbetrieb' if cloud > eigen else 'Cloud'}")
for jahr in range(1, 6):
    e = 24000 + (1200 + 1500 + 900 + 3000) * jahr - (2000 if jahr == 5 else 0)
    c = 2500 + cloud_monat * 12 * jahr
    print(f"Jahr {jahr}: Eigenbetrieb {e:6}  Cloud {c:6}")
```

Die Funktion `tco` addiert die Anschaffung und die über die Jahre aufsummierten laufenden Kosten und zieht den Restwert ab; sie gibt zusätzlich die laufenden Kosten allein zurück. Für den Eigenbetrieb ergeben sich 6 600 pro Jahr, also 33 000 über fünf Jahre, und damit eine TCO von $24\,000 + 33\,000 - 2\,000 = 55\,000$. Der Cloud-Dienst kostet $650 \cdot 12 \cdot 5 + 2\,500 = 41\,500$. Der Cloud-Dienst ist in diesem erfundenen Beispiel um 13 500 günstiger. Die Jahresübersicht zeigt, wie die Kurven verlaufen: Im ersten Jahr stehen 30 600 (Eigenbetrieb, wegen der Anschaffung) gegen 10 300 (Cloud); der Abstand schrumpft jährlich, weil der Eigenbetrieb nach dem Kauf mit 6 600 pro Jahr billiger läuft als die Cloud mit 7 800. Erst bei einem Zeitraum von rund 18 Jahren (21 500 Unterschied bei der Anschaffung geteilt durch 1 200 Differenz der Jahreskosten) würde sich das Verhältnis umdrehen, doch so lange hält die Hardware nicht. Wichtig ist die Einschränkung der Rechnung: Sie vergleicht nur die erfassten Posten. Wer zusätzliche Kosten (Datenabfluss, Sicherung, Ausfallzeiten) oder zusätzlichen Nutzen (Flexibilität, schnellere Bereitstellung) nicht berücksichtigt, kommt zu einer anderen Entscheidung. Jede TCO-Rechnung ist daher nur so gut wie ihre Annahmen, und diese gehören offengelegt.

### Typische Fehler.

Falsch ist, nur den Anschaffungspreis zu vergleichen. Falsch ist, Personalkosten wegzulassen, weil “wir das sowieso machen”: Ihre Arbeitszeit hat einen Preis. Falsch ist, Kosten für Sicherung, Sicherheit und Ausfall zu ignorieren. Falsch ist auch, Cloud pauschal für billiger oder teurer zu halten; es hängt von Last, Nutzungsdauer, Größe und Fachwissen ab. Ein weiterer Fehler: in der Rechnung unterschiedliche Leistungen zu vergleichen (Eigenbetrieb ohne Hochverfügbarkeit gegen Cloud mit Hochverfügbarkeit).

### Praxisbezug.

Wenn die Leitung fragt, ob man die Notebooks leasen oder kaufen soll, ist die Antwort eine TCO-Übersicht mit Anschaffung, Garantie, Austauschzyklus, Support und Restwert. Bei der Entscheidung für ein neues Ticketsystem entscheiden häufig nicht die Lizenzkosten, sondern die Aufwände für Einführung, Anpassung und Schulung.

## 12.4 Kapazität und Wirtschaftlichkeit

Wer Kapazität plant, steht zwischen zwei Fehlern. *Unterprovisionierung* (zu wenig Ressourcen) führt zu langsamen oder ausfallenden Diensten und verärgerten Nutzern; *Überprovisionierung* (zu viel) kostet Geld, ohne Nutzen zu stiften. Dass Verschwendung durch Überprovisionierung häufig ist, hat einen menschlichen Grund: Aus Vorsicht wählt man bei der Einrichtung eine großzügige Größe (“lieber zu viel als zu wenig”), und weil es läuft, ändert sich nie etwas. In der Cloud, wo jede Stunde berechnet wird, ist das besonders teuer, und es gibt Klassiker: vergessene Testsysteme, die nach einem Projekt weiterlaufen, “verwaiste” Datenträger ohne Server, riesige Instanzen für kleine Dienste und Entwicklungssysteme, die nachts und am Wochenende unnötig laufen.

Der Grundgedanke der Kapazitätsanpassung heißt *Right-Sizing*: Die Größe eines Systems wird an die tatsächliche Last angepasst, mit angemessener Reserve. Dafür braucht man Messdaten (Abschnitt 9.2 und 9.7): durchschnittliche Auslastung, Spitzen, Verlauf über Tage, Wochen und Monate. Eine Instanz mit durchschnittlich 5 Prozent und Spitzen von 30 Prozent kann kleiner werden; eine mit durchschnittlich 60 und Spitzen von 95 Prozent braucht eher Reserve. Die Skalierung wird unterschieden: *vertikal* (ein größeres System, mehr Prozessor und Speicher) und *horizontal* (mehr gleichartige Systeme, über die sich die Last verteilt). Die Cloud erlaubt *automatische Skalierung*: Bei steigender Last werden Instanzen hinzugefügt, bei sinkender wieder entfernt; man zahlt nur, was man nutzt. Das setzt aber voraus, dass die Anwendung dafür gebaut ist. Weitere Hebel sind das zeitgesteuerte Abschalten von Test- und Entwicklungssystemen außerhalb der Arbeitszeit, langfristige Bindungen (Reservierungen) für dauerhaft laufende Systeme, die deutlich günstiger sind als die flexible Abrechnung, sowie Speicherklassen (selten genutzte Daten auf billigeren, langsameren Speicher: Abschnitt 6.2, Archivierung).

Eine Rechnung, die man kennen sollte, ist der *Break-even* (Gewinnschwelle): Ab welcher Auslastung lohnt sich ein Festpreis gegenüber der stundenweisen Abrechnung? Kostet ein System flexibel $p$ pro Stunde und reserviert fix $F$ pro Monat, lohnt sich die Reservierung, wenn das System mehr als $F / p$ Stunden pro Monat läuft. Ein Monat hat im Mittel rund 730 Stunden. Das folgende Programm kombiniert beides: Es bewertet vier fiktive Instanzen nach Auslastung und gibt Empfehlungen samt Ersparnis, und es berechnet für ein fiktives Preispaar die Break-even-Laufzeit.

```python
instanzen = [
    {"name": "web-1", "vcpu": 4, "kosten_monat": 120, "cpu_durchschnitt": 8, "cpu_spitze": 35},
    {"name": "db-1", "vcpu": 8, "kosten_monat": 480, "cpu_durchschnitt": 62, "cpu_spitze": 91},
    {"name": "test-7", "vcpu": 4, "kosten_monat": 120, "cpu_durchschnitt": 1, "cpu_spitze": 4},
    {"name": "app-2", "vcpu": 4, "kosten_monat": 120, "cpu_durchschnitt": 22, "cpu_spitze": 48},
]

def empfehlung(i):
    if i["cpu_spitze"] < 10:
        return "abschalten oder zeitgesteuert betreiben", i["kosten_monat"]
    if i["cpu_spitze"] < 50 and i["vcpu"] > 2:
        return "halbieren (Right-Sizing)", i["kosten_monat"] / 2
    if i["cpu_spitze"] > 85:
        return "Reserve pruefen (Spitze hoch)", 0
    return "beibehalten", 0

summe = 0
for i in instanzen:
    text, ersparnis = empfehlung(i)
    summe += ersparnis
    print(f"{i['name']:7} Spitze {i['cpu_spitze']:3}% -> {text} (spart {ersparnis:.0f}/Monat)")
print(f"Gesamt: {summe:.0f} pro Monat, {summe * 12:.0f} pro Jahr")

on_demand_stunde, reserviert_monat = 0.12, 45
stunden_monat = 730
print("Break-even Auslastung:",
      round(reserviert_monat / (on_demand_stunde * stunden_monat) * 100), "% der Monatsstunden")
```

Die Funktion `empfehlung` wendet einfache Regeln auf die *Spitzenlast* an, nicht auf den Durchschnitt, denn bemessen wird nach dem höchsten Bedarf: Eine Instanz, deren Prozessor nie über 10 Prozent kommt, ist ein Abschaltkandidat; bleibt die Spitze unter 50 Prozent und hat die Instanz mehr als zwei virtuelle Prozessoren, kann sie halbiert werden (die halbe Größe kostet in diesem Beispiel die Hälfte); steigt die Spitze über 85 Prozent, besteht eher das Risiko der Unterversorgung. Für die vier Instanzen ergibt das: `web-1` (Spitze 35 Prozent) kann halbiert werden, spart 60 pro Monat; `db-1` (Spitze 91 Prozent) hat keine Ersparnis, sondern verdient Aufmerksamkeit wegen der hohen Spitze; `test-7` (Spitze 4 Prozent) kann abgeschaltet werden, spart 120; `app-2` (Spitze 48 Prozent) kann halbiert werden, spart 60. Das Gesamtpotenzial beträgt 240 pro Monat oder 2 880 pro Jahr. Der letzte Teil rechnet $45 / (0{,}12 \cdot 730) \approx 0{,}51$: Läuft das System mehr als gut die Hälfte des Monats, ist die reservierte Variante günstiger. Alle Preise sind erfunden. Wichtig: Die Regeln sind eine Hilfe zur Vorauswahl; ob ein System tatsächlich verkleinert wird, entscheidet ein Mensch mit Blick auf Spitzenzeiten (Monatsabschluss, Aktionen), Abhängigkeiten und Reserven für Ausfälle.

### Typische Fehler.

Falsch ist, nur den Durchschnitt zu betrachten: Ein System mit 20 Prozent im Mittel kann zur Monatsmitte regelmäßig an der Grenze liegen. Falsch ist, aus kurzer Beobachtung zu schließen; saisonale Spitzen werden übersehen. Falsch ist, Ressourcen ohne Verantwortlichen zu betreiben: Ohne Eigentümer räumt niemand auf (Kennzeichnung mit Verantwortlichem und Zweck hilft). Falsch ist auch, die Einsparung über die Sicherheit zu stellen: Reserve und Redundanz sind keine Verschwendung, sondern bezahlte Versicherung; sie sollten bewusst und begründet sein.

### Praxisbezug.

Viele Firmen führen monatliche Kostenberichte ihrer Cloud-Konten ein, in denen die zehn teuersten Ressourcen mit Verantwortlichem aufgelistet sind. Dabei werden nicht selten Systeme gefunden, die seit Jahren niemand mehr nutzt. Im lokalen Rechenzentrum entspricht das Aufräumen verwaister virtueller Maschinen demselben Prinzip.

## 12.5 Migrationsgrundlagen

Eine *Migration* ist der Umzug von Daten, Anwendungen oder ganzen Systemen von einer Umgebung in eine andere: vom alten auf den neuen Server, vom eigenen Rechenzentrum in die Cloud, von einer Software-Version zur nächsten, von einem Anbieter zum anderen. Sie ist riskant, weil sie in laufende Betriebsabläufe eingreift und weil Altsysteme Eigenheiten haben, die niemand mehr kennt. Erfolgreiche Migrationen folgen deshalb einem Vorgehen, das sich in fünf Phasen gliedern lässt.

Die erste Phase ist die *Bestandsaufnahme* (*Inventory*): Was gibt es? Welche Server, Anwendungen, Datenmengen, Benutzer, Schnittstellen, Lizenzen und Zertifikate gehören dazu? Wer ist verantwortlich? Wie wichtig ist das System? Viele Probleme entstehen, weil ein vergessenes Skript oder eine Schnittstelle nirgends dokumentiert war. Die zweite Phase ist die *Abhängigkeitsanalyse*: Welches System braucht welches andere? Ein Webshop benötigt eine Datenbank, die wiederum einen Dateiserver; wird die Datenbank zuerst umgezogen, findet der Webshop sie nicht mehr. Aus den Abhängigkeiten ergibt sich die *Reihenfolge* des Umzugs: erst die Grundlagen, dann das, was darauf aufbaut. Die dritte Phase ist die *Planung und Pilotierung*: Man wählt eine Strategie (alles auf einmal, dem sogenannten *Big Bang*, oder schrittweise in Wellen), plant Wartungsfenster (Abschnitt 9.6), bestimmt einen Rückweg (Rollback) und testet den Umzug zuerst mit einem unkritischen System oder einer Kopie (*Pilot*). Die vierte Phase ist die *Durchführung* mit dem *Cutover*, also dem Moment der Umschaltung, an dem der Betrieb vom alten aufs neue System übergeht. Die fünfte Phase ist *Prüfung und Nachbereitung*: Funktioniert alles, sind die Daten vollständig und unverändert, wird das Altsystem nach einer Schonfrist abgeschaltet und sicher entsorgt (Daten löschen: Abschnitt 6.2). Bekannte Strategien in der Cloud-Migration sind *Lift-and-Shift* (unverändert umziehen), *Anpassen* (kleine Änderungen für den neuen Betrieb) und *Neu bauen* (Anwendung für die neue Umgebung neu entwickeln); die Namen unterscheiden sich je nach Anbieter.

Zwei Erfolgsfaktoren werden in der Prüfung betont, weil sie in der Praxis oft zu kurz kommen. *Kommunikation*: Betroffene müssen früh wissen, wann sie mit Einschränkungen rechnen müssen, was sich für sie ändert (neue Adresse, neue Anmeldung) und an wen sie sich wenden; schlechte Kommunikation macht aus einem technisch gelungenen Umzug eine Beschwerdewelle. *Test*: Vorher (Funktioniert der Umzug an einer Kopie?), währenddessen (Prüfsummen, Mengenvergleich) und nachher (Anwenderabnahme: Prüfen die Fachabteilungen, dass ihre Abläufe laufen?). Dazu gehört die Datenqualität (Abschnitt 6.5): Wer Fehler im Altsystem nicht bereinigt, nimmt sie mit.

Das folgende Programm zeigt zwei technische Bausteine einer Migration. Der erste ermittelt die Umzugsreihenfolge aus den Abhängigkeiten, mit dem Modul `graphlib` der Standardbibliothek (*topologische Sortierung*). Der zweite vergleicht nach dem Kopieren Dateien von Quelle und Ziel mit Prüfsummen und meldet fehlende und abweichende Dateien.

```python
import hashlib, tempfile
from graphlib import TopologicalSorter
from pathlib import Path

abhaengig_von = {
    "Webshop": {"Datenbank", "Zahlungsdienst"},
    "Datenbank": {"Dateiserver"},
    "Zahlungsdienst": set(),
    "Dateiserver": set(),
    "Reporting": {"Datenbank"},
}
reihenfolge = list(TopologicalSorter(abhaengig_von).static_order())
print("Umzugsreihenfolge (Abhaengigkeiten zuerst):", reihenfolge)

def summe(pfad):
    return hashlib.sha256(Path(pfad).read_bytes()).hexdigest()

with tempfile.TemporaryDirectory() as tmp:
    alt, neu = Path(tmp, "alt"), Path(tmp, "neu")
    alt.mkdir(); neu.mkdir()
    for n in ("a.txt", "b.txt", "c.txt"):
        (alt / n).write_text(f"Inhalt von {n}")
        (neu / n).write_text(f"Inhalt von {n}")
    (neu / "b.txt").write_text("beschaedigt")
    (neu / "c.txt").unlink()
    for n in sorted(p.name for p in alt.iterdir()):
        if not (neu / n).exists():
            print(n, "FEHLT im Ziel")
        elif summe(alt / n) != summe(neu / n):
            print(n, "ABWEICHENDE Pruefsumme")
        else:
            print(n, "ok")
```

Das Wörterbuch `abhaengig_von` ordnet jedem System die Menge der Systeme zu, die es braucht; `TopologicalSorter` liefert mit `static_order()` eine Reihenfolge, in der jedes System erst nach seinen Voraussetzungen vorkommt. Die Ausgabe lautet: Zahlungsdienst, Dateiserver, Datenbank, Webshop, Reporting. Der Webshop folgt auf Datenbank und Zahlungsdienst, die Datenbank auf den Dateiserver; “Reporting” kann erst nach der Datenbank. Bei mehreren möglichen Reihenfolgen liefert das Verfahren eine davon (Zahlungsdienst und Dateiserver sind voneinander unabhängig und könnten auch parallel umziehen). Enthielte die Abhängigkeitsliste einen Kreis (A braucht B, B braucht A), meldet das Modul einen Fehler; das ist selbst ein wichtiger Befund der Analyse. Der zweite Teil legt eine “alte” und eine “neue” Ablage mit drei Dateien an, verändert absichtlich eine Datei im Ziel und löscht eine zweite. Die Prüfung meldet `a.txt ok`, `b.txt ABWEICHENDE Pruefsumme` und `c.txt FEHLT im Ziel`. Solche Vergleiche sind der Beweis, dass die Daten vollständig und unverändert angekommen sind, und gehören vor jede Abschaltung des Altsystems.

### Typische Fehler.

Falsch ist, die Bestandsaufnahme zu überspringen “weil wir das System kennen”; die Überraschungen kommen erst beim Cutover. Falsch ist, den Rückweg erst zu planen, wenn etwas schiefgeht, oder das Altsystem sofort nach dem Umzug abzuschalten. Falsch ist, am Freitagabend umzuschalten. Falsch ist, Anwender nicht einzubeziehen, und Tests nur technisch zu verstehen: Die Fachabteilung weiß, welche Abläufe wirklich funktionieren müssen. Und falsch ist es, die Migration als reines IT-Projekt zu betrachten; sie berührt Fachbereiche, Datenschutz (Modul 11) und häufig Verträge.

### Praxisbezug.

Der Wechsel des E-Mail-Systems einer Firma ist ein typischer Fall: Bestandsaufnahme der Postfächer, Verteiler und Regeln, Pilotgruppe, Wartungsfenster am Wochenende, Hinweis an alle, Prüfung der Postfachgrößen nach dem Umzug und eine Schonfrist, in der das alte System noch lesbar bleibt. Der Support erlebt die Folgen mit Anfragen “Mein Kalender ist leer” und muss die Antworten dank der Kommunikation parat haben.

## 12.6 Backup-Strategien

Abschnitt 6.6 hat erklärt, was eine Datensicherung ist und warum Spiegelung oder Archivierung sie nicht ersetzen. Hier geht es um die Strategie: Welche Art der Sicherung wählt man, wie viele Kopien braucht man und wie stellt man sicher, dass die Wiederherstellung im Ernstfall funktioniert? Die Prüfung verlangt vor allem, die drei Sicherungsarten zu vergleichen und die 3-2-1-Regel zu kennen.

Eine *Vollsicherung* (*Full Backup*) kopiert alle ausgewählten Daten. Sie ist am einfachsten wiederherzustellen (ein einziger Satz), braucht aber am meisten Speicher und Zeit. Eine *differenzielle Sicherung* (*Differential*) kopiert alles, was sich seit der letzten *Vollsicherung* geändert hat. Die Wiederherstellung braucht zwei Teile, die letzte Vollsicherung und die letzte Differenz; der Nachteil ist, dass die Differenzen mit jedem Tag seit der Vollsicherung wachsen. Eine *inkrementelle Sicherung* (*Incremental*) kopiert alles, was sich seit der letzten Sicherung *irgendeiner Art* geändert hat. Sie ist schnell und klein, aber die Wiederherstellung braucht die Vollsicherung und *alle* Inkremente bis zum gewünschten Tag in der richtigen Reihenfolge; fehlt eines, ist die Kette gebrochen. Üblich ist eine Kombination: zum Beispiel sonntags voll, an den anderen Tagen differenziell oder inkrementell, und regelmäßig wieder eine neue Vollsicherung.

> **Ergänzung aus der Nachrecherche**
>
> Die bekannte *3-2-1-Regel* verlangt nach der Beschreibung im Blog eines Backup-Herstellers (NAKIVO, abgerufen; Herstellerquelle): drei Kopien der Daten insgesamt (die Produktivdaten plus zwei Sicherungen), auf zwei verschiedenen Arten von Speichermedien, davon eine Kopie an einem anderen Standort (extern oder in der Cloud). Dieselbe Quelle beschreibt eine erweiterte Variante “3-2-1-1-0” mit einer zusätzlichen *unveränderlichen* oder *vom Netz getrennten* Kopie (Schutz gegen Erpressungstrojaner) und dem Ziel, bei Wiederherstellungstests null Fehler zu haben. Die Regel ist eine Faustregel, kein Gesetz; die genaue Ausgestaltung hängt von Wert der Daten, RPO und RTO (Abschnitt 12.7) und Budget ab.

Die Sicherungsarten lassen sich in einer Simulation vergleichen. Das folgende Programm geht von 100 Gigabyte Daten aus, die täglich um 5 Gigabyte neue oder geänderte Daten wachsen (die Änderungen überlappen sich nicht, was die Rechnung vereinfacht). Tag 0 ist die Vollsicherung. Es berechnet den Speicherbedarf einer Woche und die Zahl der Teile, die man zur Wiederherstellung am Tag 6 braucht.

```python
def simuliere(modus, tage=7, vollsicherung_tag=0, daten_gb=100, aenderung_gb=5):
    belegt = 0
    letzter_voll = None
    liste = []
    for tag in range(tage):
        if tag == vollsicherung_tag:
            groesse, art = daten_gb, "voll"
            letzter_voll = tag
        elif modus == "differenziell":
            groesse, art = aenderung_gb * (tag - letzter_voll), "diff"
        else:
            groesse, art = aenderung_gb, "inkr"
        belegt += groesse
        liste.append((tag, art, groesse))
    return belegt, liste

for modus in ("differenziell", "inkrementell"):
    belegt, liste = simuliere(modus)
    print(modus, "gesamt", belegt, "GB:", [f"{t}:{a}{g}" for t, a, g in liste])

def wiederherstellung(modus, tag):
    if modus == "differenziell":
        return ["Vollsicherung Tag 0"] + ([f"Differenz Tag {tag}"] if tag > 0 else [])
    return ["Vollsicherung Tag 0"] + [f"Inkrement Tag {t}" for t in range(1, tag + 1)]

for modus in ("differenziell", "inkrementell"):
    print("Restore Tag 6 mit", modus, "->", len(wiederherstellung(modus, 6)), "Teile")
```

Die Funktion `simuliere` durchläuft die Tage. Am Tag der Vollsicherung wird die gesamte Datenmenge (100 GB) gesichert. An den anderen Tagen ist die Sicherungsgröße im differenziellen Modus das Produkt aus Tagesänderung und Tagen seit der Vollsicherung (5, 10, 15, …, 30 GB), im inkrementellen Modus nur die Änderung seit gestern (jeweils 5 GB). Die Ausgabe: differenziell insgesamt 205 GB (100 + 5 + 10 + 15 + 20 + 25 + 30), inkrementell insgesamt 130 GB (100 + 6 $\cdot$ 5). Das zeigt die Stärke der inkrementellen Sicherung: kleiner und schneller. Die zweite Funktion zeigt den Preis: Eine Wiederherstellung am Tag 6 braucht beim differenziellen Verfahren nur zwei Teile (Voll und Differenz Tag 6), beim inkrementellen sieben Teile (Voll und sechs Inkremente). Sicherungen sind nur so gut wie ihre schwächsten Glieder; die Zahl der Teile in der Kette ist ein Risiko. Moderne Sicherungsprogramme verwalten Ketten, prüfen sie mit Prüfsummen und fassen alte Inkremente zu neuen Vollsicherungen zusammen; das Prinzip bleibt.

Über die Art hinaus gehören zur Strategie: ein *Zeitplan* (wie oft, wann), eine *Aufbewahrungsdauer* (wie viele Stände behält man, vergleiche die Versionierung in Abschnitt 6.6), die *Verschlüsselung* der Sicherungen (Abschnitt 10.4) und *getrennte Zugriffsrechte* (wer Sicherungen löschen darf, ist nicht der, der die Produktivdaten verwaltet, damit ein Angreifer sie nicht mitlöscht). Vor allem aber der *Wiederherstellungstest*: regelmäßig eine zufällige Datei und gelegentlich ein komplettes System aus der Sicherung zurückspielen und messen, wie lange es dauert (das ergibt die tatsächliche Zeit, die man mit dem RTO vergleicht). Ein Backup, dessen Wiederherstellung nie probiert wurde, ist eine Annahme, keine Sicherheit.

### Typische Fehler.

Falsch ist, ein einziges Backup für ausreichend zu halten, oder alle Kopien am selben Ort aufzubewahren (Brand, Wasser, Diebstahl). Falsch ist, die Sicherung ständig mit dem System verbunden zu lassen, wo Schadsoftware sie mitverschlüsselt. Falsch ist, nur Daten zu sichern und nicht die Konfiguration, die Lizenzschlüssel und die Wiederherstellungsanleitung. Falsch ist, einen Fehlerhinweis des Backup-Programms zu ignorieren (“läuft schon seit Wochen so”). Und falsch ist, Cloud-Synchronisierung (zum Beispiel OneDrive oder Dropbox) mit Backup gleichzusetzen: Wird eine Datei gelöscht oder verschlüsselt, wird dies synchronisiert; die Papierkörbe und Versionsverläufe helfen nur begrenzt.

### Praxisbezug.

Ein kleines Büro sichert den Dateiserver nachts inkrementell auf ein Netzlaufwerk, sonntags voll auf ein Wechselmedium, das wöchentlich außer Haus gebracht wird, und lässt eine Kopie verschlüsselt in die Cloud laufen: damit sind drei Kopien auf zwei Medientypen mit einer Kopie an anderem Ort erfüllt. Einmal im Quartal wird eine Datei testweise wiederhergestellt.

## 12.7 Disaster Recovery und Business Continuity

Zwei Begriffe werden oft vermischt, haben aber unterschiedliche Aufgaben. *Business Continuity* (Geschäftsfortführung, *BC*) betrifft das *gesamte Unternehmen* und fragt: Wie halten wir wichtige Geschäftsprozesse auch bei Störungen am Laufen? Der *Business Continuity Plan* (*BCP*) beschreibt dazu Personal, Räume, Lieferanten, Kommunikation und Ausweichverfahren, zum Beispiel Arbeit im Homeoffice, wenn das Büro nicht nutzbar ist, oder manuelle Notverfahren bei Ausfall der Kasse. *Disaster Recovery* (Notfallwiederherstellung, *DR*) betrifft die *IT*: Wie stellen wir Systeme und Daten nach einem schweren Ausfall wieder her? Der *Disaster Recovery Plan* (*DRP*) beschreibt Reihenfolge, Zuständigkeiten, Ausweichstandorte und Schritte der Wiederherstellung. Der DRP ist also ein Teil dessen, was der BCP voraussetzt: Ohne funktionierende IT kann der Prozess nicht laufen, aber auch ein wiederhergestelltes System nützt nichts, wenn keine Mitarbeiter, keine Räume oder keine Kommunikation vorhanden sind.

Zwei Kennzahlen steuern die Planung. Das *Recovery Time Objective* (*RTO*) ist die höchste hinnehmbare *Ausfalldauer*: Innerhalb welcher Zeit muss der Dienst wieder laufen? Das *Recovery Point Objective* (*RPO*) ist der höchste hinnehmbare *Datenverlust*, ausgedrückt als Zeitspanne: Wie weit darf der wiederhergestellte Datenstand hinter dem Ausfall zurückliegen? Eine Faustregel: RTO fragt “Wie lange?”, RPO fragt “Wie viel?” (zeitlich gemessen). Beide werden *vom Geschäft* festgelegt, nicht von der IT, weil nur der Fachbereich weiß, was Ausfall und Datenverlust kosten.

> **Ergänzung aus der Nachrecherche**
>
> Nach der Darstellung eines Beratungsunternehmens für Informationssicherheit (Advisera, abgerufen; Drittquelle) ist das RTO die Zeitspanne nach einem Notfall, innerhalb der Geschäftsprozesse und Ressourcen wieder nutzbar sein müssen (Beispiel: zwei Stunden), das RPO der Datenverlust, den ein Unternehmen als Folge eines Notfalls akzeptieren kann, gemessen in Zeit oder Datenmenge. Beide Werte werden in der *Business-Impact-Analyse* (BIA) ermittelt, aus der die Strategie zur Fortführung des Geschäfts folgt. Die genaue Begriffsverwendung kann sich in einzelnen Normen und Anbieterdokumenten unterscheiden.

Die *Business-Impact-Analyse* ist der Weg zu diesen Werten und zur Rangfolge der Wiederherstellung. Sie fragt für jeden Geschäftsprozess: Wie hoch ist der Schaden pro Stunde Ausfall (entgangener Umsatz, Vertragsstrafen, Imageverlust, gesetzliche Folgen)? Welche Systeme und Personen braucht der Prozess? Wann wird der Schaden unerträglich? Daraus entsteht eine Rangfolge: Systeme mit hoher Kritikalität und kurzer RTO werden zuerst wiederhergestellt. Dabei gelten Abhängigkeiten (Abschnitt 12.5): Ein Dienst, der ein anderes System voraussetzt, kann erst danach starten. Das RPO bestimmt die Sicherungsstrategie: Wer höchstens eine Stunde Daten verlieren darf, kann nicht nur nachts sichern, sondern braucht Sicherung im Stundentakt oder laufende Replikation. Das RTO bestimmt die Technik der Wiederherstellung: Wer binnen einer Stunde zurück sein muss, braucht vorbereitete Ersatzsysteme (*Hot Standby*, laufendes Zweitsystem, das sofort übernimmt), wer einen Tag Zeit hat, kommt mit einem *Cold Standby* (Ersatzhardware oder Cloud-Ressourcen, die erst im Notfall bereitgestellt und mit Sicherungen befüllt werden) aus; dazwischen liegt der *Warm Standby*. Je kürzer RTO und RPO, desto höher die Kosten (Abschnitt 12.3).

Das folgende Programm prüft für vier fiktive Dienste, ob der Sicherungsrhythmus zum RPO passt, und ordnet die Dienste nach RTO in eine Wiederanlauf-Reihenfolge.

```python
dienste = [
    {"name": "Telefonie", "rto_h": 1, "rpo_h": 0.25, "backup_alle_h": 24, "kritik": "hoch"},
    {"name": "Webshop", "rto_h": 4, "rpo_h": 1, "backup_alle_h": 1, "kritik": "hoch"},
    {"name": "Buchhaltung", "rto_h": 24, "rpo_h": 24, "backup_alle_h": 24, "kritik": "mittel"},
    {"name": "Intranet-Wiki", "rto_h": 72, "rpo_h": 24, "backup_alle_h": 24, "kritik": "niedrig"},
]
for d in dienste:
    ok_rpo = d["backup_alle_h"] <= d["rpo_h"]
    print(f"{d['name']:14} RPO {d['rpo_h']:>5} h, Sicherung alle {d['backup_alle_h']:>2} h -> "
          f"{'ok' if ok_rpo else 'LUECKE'}")
print("Reihenfolge Wiederanlauf:",
      [d["name"] for d in sorted(dienste, key=lambda d: (d["rto_h"], d["name"]))])
```

Für jeden Dienst wird verglichen, ob das Sicherungsintervall höchstens so lang ist wie das RPO: Bei täglicher Sicherung kann bis zu 24 Stunden Arbeit verloren gehen. Die Ausgabe zeigt, dass bei der Telefonie eine *Lücke* besteht: Das RPO beträgt eine Viertelstunde, gesichert wird aber nur alle 24 Stunden; hier braucht es laufende Replikation oder ein kürzeres Intervall, oder das RPO ist unrealistisch und muss mit dem Fachbereich neu besprochen werden. Webshop (stündlich bei RPO eine Stunde), Buchhaltung und Wiki erfüllen die Vorgabe. Die Wiederanlauf-Reihenfolge nach RTO lautet Telefonie, Webshop, Buchhaltung, Wiki. In der Praxis berücksichtigt man zusätzlich Abhängigkeiten (der Webshop braucht Datenbank und Netzwerk) und Personal (wer stellt was wieder her, und wer vertritt). Das Beispiel verzichtet darauf; die Reihenfolge ist deshalb nur ein erster Entwurf.

### Typische Fehler.

Falsch ist, DR und BC gleichzusetzen oder DR als reine Technikfrage zu sehen. Falsch ist ein Plan, der nur im Kopf eines Mitarbeiters existiert oder nur auf dem System liegt, das ausgefallen ist (Plan auch ausgedruckt und an anderem Ort aufbewahren, samt Kontaktliste und Zugangsdaten für den Notfall). Falsch ist ein Plan, der nie geübt wird: Notfallübungen decken Lücken auf, und die gemessene Zeit zeigt, ob das RTO realistisch ist. Falsch ist, für alle Systeme dieselben Ziele festzulegen; das ist entweder zu teuer oder zu schwach. Und falsch ist, die Wiederherstellung ohne Prüfung der Ursache zu beginnen: Wer ein befallenes System unverändert zurückspielt, holt den Angreifer wieder ins Haus.

### Praxisbezug.

Nach einem Brand im Serverraum zeigt sich, ob es einen Plan gab: Wer entscheidet? Wer ruft die Mitarbeiter an? Wo liegen die Sicherungen? Welche Systeme laufen zuerst wieder? Unternehmen üben das mit “Tischübungen”: Die Beteiligten gehen ein Szenario durch und finden Lücken, ohne dass etwas ausfällt.

> **Merke**
>
> BCP = Geschäft am Laufen halten (gesamt), DRP = IT wiederherstellen. RTO = wie lange darf der Ausfall dauern. RPO = wie viel Datenverlust ist tragbar (in Zeit). Beide aus der BIA, vom Geschäft bestimmt. Backup: voll, differenziell (seit letzter Voll), inkrementell (seit letzter Sicherung); 3-2-1; Wiederherstellung testen.

## 12.8 Abschlussfall und Verbesserungsplan

Die bisherigen Abschnitte haben Einzelthemen behandelt; in der Wirklichkeit kommen sie gemeinsam und mit begrenzten Mitteln. Der Abschlussfall übt, ein Gesamtbild zu erfassen, Maßnahmen zu sammeln, zu bewerten und realistisch zu kommunizieren. Er verbindet Technik (Modul 2 bis 4), Betrieb (Modul 9), Sicherheit (Modul 10), Daten (Modul 6) und Kosten (Abschnitte 12.3 und 12.4).

Das Szenario (erfunden): Die “Berger Haustechnik GmbH” hat 25 Beschäftigte, einen Dateiserver im Keller, ein Cloud-Postfach und eine Buchhaltungssoftware. Eine Nachfrage von Kunden und der Steuerberaterin hat gezeigt: Die Datensicherung läuft nur auf eine USB-Festplatte, die am Server steckt, und wurde nie getestet. Es gibt keine MFA, alle Büro-Mitarbeiter arbeiten mit Administratorrechten, mehrere Testsysteme laufen seit Monaten in der Cloud, und die Firewall stammt aus dem Jahr 2014. Vor drei Monaten wurde ein Dienstleister-Zugang erpresst; seitdem ist die Geschäftsführung nervös. Das Budget ist knapp. Ihre Aufgabe als Berater: eine priorisierte Liste von Verbesserungen erarbeiten und der Geschäftsführung verständlich erklären.

Das Vorgehen: Zuerst *Bestandsaufnahme* (Abschnitt 12.5): Welche Systeme und Daten existieren, wie wichtig sind sie (BIA, Abschnitt 12.7), wer ist verantwortlich? Danach werden Mängel gesammelt und je Mangel eine Maßnahme formuliert. Zu jeder Maßnahme bewertet man den *Nutzen* (wie sehr senkt sie das Risiko, Abschnitt 10.2), den *Aufwand* (Zeit, Geld, Störung) und das *Risiko des Nichtstuns*. Daraus ergibt sich eine *Priorität*: Was sofort (Wochen), was bald (Monate), was später (Jahr)? Maßnahmen mit großem Nutzen und kleinem Aufwand (*Quick Wins*) kommen zuerst. Bei der Kommunikation gilt: Die Geschäftsführung braucht keine technischen Details, sondern Risiko, Kosten, Nutzen und eine klare Empfehlung; Beschäftigte brauchen Verständliches zu ihren Änderungen (neue Anmeldung, neue Abläufe). Man benennt Annahmen und Unsicherheiten offen: “Diese Schätzung beruht auf…” ist glaubwürdiger als falsche Genauigkeit.

Das folgende Programm bewertet fünf Maßnahmen mit einem einfachen Punktesystem. Jede Maßnahme hat Nutzen, Aufwand und Risiko des Nichtstuns, jeweils auf einer Skala von 1 (gering) bis 5 (hoch). Die Priorität ergibt sich aus $(2 \cdot \text{Nutzen} + 3 \cdot \text{Risiko}) / \text{Aufwand}$. Die Gewichte sind eine Annahme; man kann sie an die eigene Lage anpassen, solange man sie offenlegt.

```python
massnahmen = [
    ("MFA fuer alle aktivieren", 5, 2, 5),
    ("Restore-Test quartalsweise", 4, 1, 5),
    ("Test-VMs abschalten", 3, 1, 1),
    ("Neue Firewall kaufen", 3, 5, 3),
    ("Wiki aktualisieren", 2, 2, 1),
]

def score(nutzen, aufwand, risiko):
    return (nutzen * 2 + risiko * 3) / aufwand

for name, n, a, r in sorted(massnahmen, key=lambda m: -score(*m[1:])):
    print(f"{score(n, a, r):5.1f}  {name}")
```

Jede Maßnahme ist ein Tupel aus Name, Nutzen, Aufwand und Risiko. Die Funktion `score` gewichtet das Risiko des Nichtstuns höher als den Nutzen (Faktor 3 gegen 2) und teilt durch den Aufwand, sodass Maßnahmen mit wenig Aufwand höher stehen. Sortiert wird absteigend nach der Punktzahl. Die Ausgabe lautet: “Restore-Test quartalsweise” mit 23,0 Punkten (hoher Nutzen, geringer Aufwand, großes Risiko ohne Test), “MFA für alle aktivieren” mit 12,5, “Test-VMs abschalten” mit 9,0 (ein Quick Win, weil es Geld spart), “Wiki aktualisieren” mit 3,5 und “Neue Firewall kaufen” mit 3,0 (großer Aufwand). Man sieht, dass die teuerste Maßnahme nicht automatisch die wichtigste ist; die Firewall ist wegen ihres Alters ein Risiko, aber hier kosten MFA und Restore-Test deutlich weniger und bringen mehr. Das Ergebnis ist ein Gesprächseinstieg, kein Befehl: Eine Firewall aus dem Jahr 2014 kann Sicherheitsupdates verloren haben, und ein Mensch muss entscheiden, ob dies die Reihenfolge ändert.

Ein Verbesserungsplan für die Geschäftsführung könnte so aussehen: In den ersten vier Wochen werden die Sicherung auf drei Kopien erweitert (eine extern und vom Netz getrennt), der erste Wiederherstellungstest durchgeführt und MFA für alle Konten aktiviert, dazu werden die Test-VMs abgeschaltet und die Administratorrechte der Büro-Konten entzogen. In den folgenden drei Monaten folgen die Patch-Routine mit Wartungsfenster (Abschnitt 9.6), ein Monitoring des Speichers und der Sicherung (Abschnitt 9.2), eine Schulung zu Phishing (Abschnitt 10.8) und ein Notfallplan mit RTO und RPO für die drei wichtigsten Systeme. Innerhalb eines Jahres wird die Firewall erneuert und ein Dokument zur Verantwortung bei Vorfällen erstellt. Zu jedem Schritt gehören ein Verantwortlicher, ein Termin und ein Kriterium, woran man den Erfolg erkennt (“Wiederherstellungstest dokumentiert, Dauer 3 Stunden”).

### Typische Fehler.

Falsch ist, alles gleichzeitig verbessern zu wollen: Das überfordert Personal und Budget, und am Ende ist nichts fertig. Falsch ist, nur Technik zu betrachten und die Menschen und Abläufe zu vergessen. Falsch ist, der Geschäftsführung eine Liste ohne Priorität zu schicken, oder Risiken durch Fachsprache zu verschleiern. Falsch ist, Zusagen zu machen, die man nicht halten kann (“Danach sind wir sicher”); ehrlicher ist, das Restrisiko zu benennen. Falsch ist es auch, den Plan nach der Vorstellung in der Schublade verschwinden zu lassen: Verbesserung ist ein Kreislauf aus Planen, Umsetzen, Prüfen und Anpassen.

### Praxisbezug.

Ob als externer Berater, interne IT oder als Support-Mitarbeiter, der im Gespräch mit der Teamleitung auf ein Risiko hinweist: Die Fähigkeit, ein technisches Problem in Risiko, Aufwand und Nutzen zu übersetzen und eine Reihenfolge vorzuschlagen, wird geschätzt. Das ist auch ein Ziel des Lehrplans: Technik, Sicherheit, Betrieb und Kosten in einem Szenario verbinden.

## Übungsaufgaben Modul 12

1.  Nennen Sie vier Eigenschaften, die ein Automatisierungsskript im Betrieb haben sollte, und erklären Sie *Idempotenz* und *Trockenlauf* an einem Beispiel.

2.  Erklären Sie den Unterschied zwischen imperativer und deklarativer Beschreibung und nennen Sie zwei Vorteile von Infrastruktur als Code. Was ist Konfigurationsdrift und woran erkennen Sie sie?

3.  Unterscheiden Sie CapEx und OpEx an je zwei Beispielen. Warum reicht der Vergleich der Anschaffungspreise für die Entscheidung zwischen zwei Systemen nicht aus? Nennen Sie fünf Posten der TCO.

4.  Ein Cloud-Konto enthält 30 virtuelle Maschinen. Beschreiben Sie, wie Sie Verschwendung durch Überprovisionierung erkennen und welche Maßnahmen Sie vorschlagen. Warum sind Reserve und Redundanz nicht automatisch Verschwendung?

5.  Skizzieren Sie die fünf Phasen einer Migration und nennen Sie zwei Erfolgsfaktoren. Warum wird das Altsystem nicht sofort nach dem Cutover abgeschaltet?

6.  **Praxis:** Schreiben Sie eine Python-Funktion `tco(...)`, die für zwei Geräte A (Anschaffung 800, 120 Energie und 80 Wartung pro Jahr, Nutzungsdauer 4 Jahre) und B (Anschaffung 600, 200 Energie und 150 Wartung pro Jahr, Nutzungsdauer 4 Jahre) die Gesamtkosten über vier Jahre berechnet und das günstigere nennt. Rechnen Sie auch die Kosten pro Jahr aus.

7.  **Praxis:** Gegeben ist die Abhängigkeit `{"App": {"DB", "Cache"}, "DB": {"Storage"}, "Cache": set(), "Storage": set()}`. Ermitteln Sie mit `graphlib.TopologicalSorter` eine Umzugsreihenfolge und ergänzen Sie danach die Abhängigkeit “Storage braucht App”. Was passiert, und was bedeutet das für die Planung?

8.  **Praxis:** Berechnen Sie für die Sicherung mit der Simulation aus Abschnitt 12.6 den Speicherbedarf und die Zahl der Teile bei einer Woche (7 Tage) mit täglich 8 GB Änderung, 200 GB Gesamtdaten und einer Vollsicherung am Tag 0, jeweils differenziell und inkrementell. Welches Verfahren würden Sie wählen, wenn das RTO sehr kurz ist?

9.  Ein Online-Händler verkauft rund um die Uhr, sichert seine Datenbank aber nur nachts. Er verlangt ein RPO von 15 Minuten und ein RTO von 2 Stunden. Beurteilen Sie die Lage, schlagen Sie zwei technische Maßnahmen vor und nennen Sie einen Test, mit dem Sie das RTO überprüfen.

## Lösungen Modul 12

1.  Eigenschaften: Trockenlauf, Idempotenz, Protokollierung, Fehlerbehandlung, geringe Rechte, keine Klartext-Kennwörter, Versionsverwaltung. Idempotenz: Ein zweiter Lauf ändert nichts, wenn der Sollzustand erreicht ist; beispielsweise legt ein Skript einen Benutzer nur an, wenn er noch nicht existiert. Trockenlauf: Das Skript zeigt an, welche Dateien es löschen *würde*, löscht aber nichts; erst nach Prüfung wird es scharf geschaltet.

2.  Imperativ: Schritte werden beschrieben; deklarativ: der Sollzustand wird beschrieben, das Werkzeug ermittelt die Schritte. Vorteile von IaC: Reproduzierbarkeit, Geschwindigkeit, Nachvollziehbarkeit durch Versionsverwaltung, Wiederherstellbarkeit. Drift ist die schleichende Abweichung vom Sollzustand durch ungeplante manuelle Eingriffe; man erkennt sie durch regelmäßigen Vergleich von Ist und Soll.

3.  CapEx: Kauf eines Servers, Kauf von Notebooks. OpEx: monatliche Cloud-Gebühren, Wartungsvertrag oder Energiekosten. Der Anschaffungspreis erfasst nur einen Teil der Kosten; laufende Kosten und versteckte Kosten können den Unterschied umkehren. TCO-Posten: Anschaffung, Energie und Kühlung, Lizenzen, Support und Wartung, Personal, Schulung, Entsorgung, abzüglich Restwert.

4.  Messdaten über längere Zeit auswerten (Durchschnitt und Spitze der Auslastung), Systeme ohne Last und ohne Verantwortlichen identifizieren, verwaiste Datenträger und Test-Systeme finden. Maßnahmen: Abschalten, zeitgesteuerter Betrieb, Verkleinern, Reservierungen für Dauerbetrieb, Speicherklassen. Reserve und Redundanz sind eine bewusste Versicherung gegen Spitzen und Ausfälle; sie sind keine Verschwendung, wenn sie begründet und dimensioniert sind.

5.  Phasen: Bestandsaufnahme, Abhängigkeitsanalyse und Reihenfolge, Planung und Pilot, Durchführung mit Cutover, Prüfung und Nachbereitung. Erfolgsfaktoren: Kommunikation und Test. Das Altsystem bleibt eine Schonfrist erhalten, damit man bei Problemen zurückkehren kann und fehlende Daten oder Abläufe noch auffinden kann.

6.  Beispiellösung:

    ```python
    def tco(anschaffung, energie, wartung, jahre):
        return anschaffung + (energie + wartung) * jahre

    a = tco(800, 120, 80, 4)
    b = tco(600, 200, 150, 4)
    print("A:", a, "pro Jahr", a / 4)
    print("B:", b, "pro Jahr", b / 4)
    print("Guenstiger:", "A" if a < b else "B")
    ```

    A kostet $800 + 200 \cdot 4 = 1\,600$ (400 pro Jahr), B kostet $600 + 350 \cdot 4 = 2\,000$ (500 pro Jahr). Obwohl B in der Anschaffung 200 billiger ist, ist A über vier Jahre um 400 günstiger.

7.  Beispiellösung:

    ```python
    from graphlib import TopologicalSorter, CycleError
    g = {"App": {"DB", "Cache"}, "DB": {"Storage"}, "Cache": set(), "Storage": set()}
    print(list(TopologicalSorter(g).static_order()))
    g["Storage"] = {"App"}
    try:
        print(list(TopologicalSorter(g).static_order()))
    except CycleError as e:
        print("Zirkulaere Abhaengigkeit:", e.args[1])
    ```

    Die erste Reihenfolge ist zum Beispiel Cache, Storage, DB, App (andere gültige Reihenfolgen sind möglich). Mit der neuen Abhängigkeit entsteht ein Kreis (App braucht DB, DB braucht Storage, Storage braucht App), und `CycleError` meldet ihn. Für die Planung bedeutet das: Die Abhängigkeiten müssen vor dem Umzug geklärt oder aufgelöst werden, etwa durch gemeinsames Umziehen der beteiligten Systeme in einem Wartungsfenster.

8.  Berechnung: Differenziell: $200 + 8 + 16 + 24 + 32 + 40 + 48 = 368$ GB, Wiederherstellung am Tag 6 mit 2 Teilen. Inkrementell: $200 + 6 \cdot 8 = 248$ GB, Wiederherstellung mit 7 Teilen. Bei sehr kurzem RTO ist das differenzielle Verfahren günstiger, weil weniger Teile nacheinander eingespielt werden müssen und die Kette weniger fehleranfällig ist; der Preis ist der höhere Speicherbedarf.

9.  Die Lage ist unzureichend: Mit nächtlichen Sicherungen können bis zu 24 Stunden Daten verloren gehen, das RPO von 15 Minuten ist nicht erfüllt; ob das RTO von 2 Stunden erreicht wird, ist unbekannt, weil es keine Messung gibt. Maßnahmen: laufende Replikation der Datenbank auf ein Zweitsystem oder Sicherung der Transaktionsprotokolle im Minutentakt; vorbereitete Ersatzumgebung (Warm oder Hot Standby), beschrieben als Code (Abschnitt 12.2). Test: Eine vollständige Wiederherstellungsübung in einer Testumgebung durchführen und die tatsächliche Dauer von der Entscheidung bis zum laufenden Betrieb messen und mit 2 Stunden vergleichen.
