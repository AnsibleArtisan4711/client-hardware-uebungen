# Modul 11 - Governance, Datenschutz, Compliance und Standards

> **Hinweis zu diesem Kapitel:** Das ist das Kapitel des Skripts „CompTIA Tech+ / ITF+ (FC0-U71): Lernskript in Modulen“, aus der LaTeX-Quelle in Markdown umgewandelt (Text und Listings unverändert, Boxen als Zitatblöcke, Aufgaben und Lösungen als nummerierte Listen). Laut Skript wurden die Python-Beispiele bei der Erstellung im Arbeitsbereich ausgeführt, die gezeigten Ausgaben stammen aus diesen Läufen; Windows- und PowerShell-Befehle wurden nicht ausgeführt. Für dieses Repository wurden die Listings **nicht erneut ausgeführt**. Prüfungsdetails, Produktnamen und Versionen ändern sich; maßgeblich sind die aktuellen Prüfungsziele (Exam Objectives) von CompTIA. Übersicht zum Modul: [README](README.md).

**Dauer:** 6,5 h

**Priorität:** 2 (Lerneinheit 11.6: Priorität 3)

|  Nr. | Lerneinheit                           | Dauer (h) | Prio |
|-----:|:--------------------------------------|----------:|-----:|
| 11.1 | Governance-Grundlagen                 |      0,75 |    2 |
| 11.2 | Policies, Standards und Verfahren     |      0,75 |    1 |
| 11.3 | Datenschutz-Grundprinzipien           |         1 |    1 |
| 11.4 | Datenklassifizierung und Aufbewahrung |      0,75 |    1 |
| 11.5 | Asset- und Konfigurationsmanagement   |      0,75 |    2 |
| 11.6 | Lieferanten- und Lizenzbasis          |      0,75 |    3 |
| 11.7 | Auditierbarkeit und Nachweise         |      0,75 |    2 |
| 11.8 | Governance-Troubleshooting            |         1 |    2 |
|      | **Summe**                             |   **6,5** |      |

Technik allein macht eine IT-Organisation nicht verlässlich. Es braucht Regeln, Verantwortliche, Nachweise und die Fähigkeit, sich an beides zu halten. Dieses Modul behandelt die Grundlagen davon: Wie steuert und kontrolliert ein Unternehmen seine IT (Governance), wie sind Regeln gestuft aufgebaut (Richtlinie, Standard, Verfahren), welche Grundsätze gelten für personenbezogene Daten, wie ordnet man Daten nach Schutzbedarf und Aufbewahrung, wie behält man den Überblick über Geräte, Software und Konfigurationen, wie geht man mit Lieferanten und Lizenzen um, und wie weist man nach, dass man sich an die Regeln hält. Den Abschluss bildet die Fehlersuche bei Regelverstößen. Rechtliche Hinweise in diesem Modul sind allgemeine Information und *keine Rechtsberatung*; im Zweifel entscheiden Datenschutzbeauftragte oder juristische Fachleute. Die Beispiele sind Python-Programme, die im Arbeitsbereich ausgeführt wurden; alle Namen, Daten und Preise sind erfunden. Grundlagen zum Datenumgang stehen in Abschnitt 6.7 und 6.2, zu Sicherheitsmaßnahmen in Modul 10, zu Protokollen in Abschnitt 9.3.

## 11.1 Governance-Grundlagen

*Governance* (Steuerung und Überwachung) bezeichnet die Gesamtheit der Regeln, Rollen und Prozesse, mit denen eine Organisation sicherstellt, dass ihre IT die Geschäftsziele unterstützt, Risiken beherrscht und Vorschriften einhält. Man spricht oft von *GRC*: Governance, Risk, Compliance. *Governance* legt fest, wer entscheidet und wofür verantwortlich ist. *Risikomanagement* fragt, was schiefgehen kann, wie wahrscheinlich und wie schlimm das wäre und was man dagegen tut (vermeiden, verringern, übertragen, etwa durch Versicherung, oder bewusst akzeptieren). *Compliance* bedeutet, die geltenden Vorschriften (Gesetze, Verträge, Normen, interne Regeln) einzuhalten und das belegen zu können.

Governance unterscheidet strikt zwischen Entscheiden und Ausführen. Die Geschäftsleitung trägt die Gesamtverantwortung und setzt Ziele und Grundsätze, die IT-Leitung setzt sie um, Fachabteilungen sind *Eigentümer* ihrer Daten und Anwendungen (sie wissen, was wichtig ist), die IT betreibt, und unabhängige Stellen prüfen (interne Revision, externe Auditoren). Wichtig ist das Prinzip der *Funktionstrennung*: Wer etwas beantragt, soll es nicht allein genehmigen und umsetzen können. Daneben stehen Rollen wie der *Informationssicherheitsbeauftragte* und der *Datenschutzbeauftragte*, die beraten und kontrollieren und nicht weisungsgebunden an der Umsetzung beteiligt sind. Zur Orientierung dienen *Rahmenwerke* und Normen: ITIL beschreibt Prozesse des IT-Betriebs (Abschnitt 9.5), die Normenreihe ISO/IEC 27000 beschreibt Managementsysteme für Informationssicherheit, das NIST Cybersecurity Framework gliedert Sicherheitsaufgaben in Funktionen wie Erkennen, Schützen, Reagieren. Für die Prüfung genügt, die Ziele und die Grundidee zu kennen; die Normen sind keine Gesetze, sondern bewährte Praxis, die man bewusst übernimmt.

Ein anschauliches Hilfsmittel ist die *RACI-Matrix*, die für jede Aufgabe festlegt, wer *responsible* (durchführend), *accountable* (letztverantwortlich, genau eine Person), *consulted* (beratend) und *informed* (informiert) ist. Das Programm prüft eine solche Matrix auf die häufigsten Fehler: keine Letztverantwortung, mehrere Letztverantwortliche oder niemand, der die Arbeit tut.

```python
raci = {
    "Benutzerkonto anlegen":   {"HR": "C", "IT-Support": "R", "IT-Leitung": "A", "Fachabteilung": "I"},
    "Firewall-Regel aendern":  {"IT-Support": "R", "Netzwerk": "R", "IT-Leitung": "A", "Sicherheit": "C"},
    "Datensicherung pruefen":  {"IT-Support": "R", "IT-Leitung": "A", "Geschaeftsleitung": "A"},
    "Notfallplan testen":      {"Geschaeftsleitung": "I", "Sicherheit": "C"},
}
for aufgabe, rollen in raci.items():
    zaehler = {}
    for rolle, art in rollen.items():
        zaehler[art] = zaehler.get(art, 0) + 1
    probleme = []
    if zaehler.get("A", 0) == 0:
        probleme.append("keine letztverantwortliche Stelle (A)")
    if zaehler.get("A", 0) > 1:
        probleme.append("mehrere A")
    if zaehler.get("R", 0) == 0:
        probleme.append("niemand fuehrt aus (R)")
    print(f"{aufgabe:26} -> {'; '.join(probleme) or 'ok'}")
```

Das Wörterbuch ordnet jeder Aufgabe die beteiligten Stellen und deren Rolle zu. Die Schleife zählt, wie oft jede Rolle vorkommt, und meldet Auffälligkeiten. Das Anlegen eines Kontos ist in Ordnung: HR berät, der Support führt aus, die IT-Leitung ist letztverantwortlich, die Fachabteilung wird informiert. Die Firewall-Regel ist ebenfalls vollständig, zwei Stellen führen aus (zulässig). Bei der Datensicherung gibt es zwei Stellen mit `A`, die Meldung “mehrere A” zeigt das typische Problem: Wenn zwei verantwortlich sind, ist keiner verantwortlich. Der Notfallplan hat weder `A` noch `R`: Niemand testet ihn, und niemand muss dafür geradestehen. Genau solche Lücken sind die Ursache dafür, dass Notfallpläne im Ernstfall nicht funktionieren (Abschnitt 12.7).

### Typische Fehler.

Falsch ist, Verantwortung vage zu lassen (“die IT kümmert sich darum”). Falsch ist, Sicherheit als reine Technikaufgabe zu verstehen, die die Geschäftsleitung nichts angeht: Sie trägt die Verantwortung und bestimmt die Risikobereitschaft. Falsch ist, Regeln einzuführen, die niemand kontrolliert. Falsch ist, Compliance mit Sicherheit gleichzusetzen: Man kann alle Vorschriften formal erfüllen und trotzdem unsicher sein, und umgekehrt.

### Praxisbezug.

Im Alltag zeigt sich Governance in unscheinbaren Fragen: Wer genehmigt den Zugriff auf diesen Ordner? Wer entscheidet, ob wir den Dienst abschalten? Wer wird bei einem Datenschutzvorfall angerufen? Wo das nicht beantwortbar ist, fehlt Governance.

> **Merke**
>
> GRC = Governance (wer entscheidet), Risk (was kann schiefgehen), Compliance (Vorschriften einhalten und belegen). Eine Letztverantwortliche Stelle pro Aufgabe (RACI: genau ein A). Funktionstrennung. Normen und Rahmenwerke sind Orientierung, keine Gesetze.

## 11.2 Policies, Standards und Verfahren

Regeln in Organisationen sind gestuft. Die *Richtlinie* (*Policy*) steht oben: ein kurzes, von der Leitung freigegebenes Dokument, das Ziel und Grundsatz festlegt (“Informationen werden vor unbefugtem Zugriff geschützt”). Sie beantwortet, *was* gilt und *warum*, ist technikneutral und ändert sich selten. Der *Standard* konkretisiert verbindlich, *welche Vorgaben* gelten (“Kennwörter haben mindestens zwölf Zeichen”), und darf technische Einzelheiten nennen. Die *Richtschnur* (*Guideline*) gibt Empfehlungen, die man begründet unterschreiten darf. Das *Verfahren* oder die *Arbeitsanweisung* (*Procedure*) beschreibt Schritt für Schritt, *wie* etwas getan wird (die Schritte, ein Konto zu sperren). Dazu kommen Formulare und Checklisten als Nachweis. Typische Richtlinien in der IT sind die Informationssicherheitsrichtlinie, die Richtlinie zur akzeptablen Nutzung (*Acceptable Use Policy*, AUP: was dürfen Mitarbeitende mit Firmengeräten tun), Passwort-, Zugriffs-, Datensicherungs-, Datenschutz-, Mobilgeräte- und Fernarbeitsrichtlinien.

Ein Regelwerk wirkt nur, wenn es drei Eigenschaften hat. Es ist *bekannt*: Mitarbeitende müssen es kennen, dafür gibt es Schulung und Bestätigung (“gelesen und verstanden”). Es ist *durchsetzbar*: Es gibt technische Kontrollen und Folgen bei Verstößen. Und es ist *aktuell*: Ein Dokument hat einen Eigentümer, ein Freigabedatum und einen Prüfzyklus (meist jährlich). Das erste Programm prüft eine kleine Dokumentenliste auf die letzten beiden Punkte, das heutige Datum ist als 24. 10. 2026 festgelegt.

```python
from datetime import date

heute = date(2026, 10, 24)
dokumente = [
    {"titel": "Informationssicherheitsrichtlinie", "ebene": "Policy",
     "freigabe": date(2025, 3, 1), "intervall_monate": 12, "eigentuemer": "Geschaeftsleitung"},
    {"titel": "Passwortstandard", "ebene": "Standard",
     "freigabe": date(2026, 2, 1), "intervall_monate": 12, "eigentuemer": "IT-Leitung"},
    {"titel": "Verfahren Konto sperren", "ebene": "Verfahren",
     "freigabe": date(2024, 11, 15), "intervall_monate": 12, "eigentuemer": None},
]

def faellig(d):
    summe = d["freigabe"].month - 1 + d["intervall_monate"]
    return date(d["freigabe"].year + summe // 12, summe % 12 + 1, d["freigabe"].day)

for d in dokumente:
    f = faellig(d)
    probleme = []
    if f < heute:
        probleme.append(f"Pruefung ueberfaellig seit {f.isoformat()} ({(heute - f).days} Tage)")
    if not d["eigentuemer"]:
        probleme.append("kein Eigentuemer")
    print(f"{d['ebene']:10} {d['titel']:36} -> {'; '.join(probleme) or 'ok'}")
```

Jedes Dokument ist ein Wörterbuch mit Titel, Ebene, Freigabedatum, Prüfintervall und Eigentümer. Die Funktion `faellig` berechnet das nächste Prüfdatum: Sie addiert das Intervall zu den Monaten des Freigabedatums und verteilt den Überlauf mit Ganzzahldivision und Rest auf Jahr und Monat (Monate werden dabei ab null gezählt, daher das `- 1` und `+ 1`). Die Schleife meldet für die Informationssicherheitsrichtlinie, dass die Prüfung seit dem 01.03.2026 überfällig ist, 237 Tage. Der Passwortstandard ist aktuell. Das Verfahren zum Sperren eines Kontos ist seit 15.11.2025 (343 Tage) überfällig und hat keinen Eigentümer, die schlechteste Kombination: Niemand fühlt sich zuständig, und das Dokument veraltet. Solche Listen führt man als Dokumentenregister; die Prüfung kann man monatlich automatisch laufen lassen.

Ein zweites Beispiel zeigt, wie ein Standard in eine technische Kontrolle übersetzt wird (*Policy as Code*). Der Passwortstandard verlangt Mindestlänge, mehrere Zeichenklassen, keine bestimmten Bestandteile und ein Höchstalter. Die Werte sind für das Beispiel gewählt; aktuelle Empfehlungen zu Kennwörtern (Länge vor Komplexität, Abschnitt 10.3) können davon abweichen, und ein Höchstalter wird heute meist nicht mehr empfohlen.

```python
import re

RICHTLINIE = {"min_laenge": 12, "klassen_noetig": 3,
              "verbotene_teile": ["passwort", "firma", "2026"], "max_alter_tage": 365}

def pruefe(passwort, alter_tage, benutzer):
    funde = []
    if len(passwort) < RICHTLINIE["min_laenge"]:
        funde.append(f"zu kurz ({len(passwort)} < {RICHTLINIE['min_laenge']})")
    klassen = sum(bool(re.search(p, passwort)) for p in (r"[a-z]", r"[A-Z]", r"\d", r"[^A-Za-z0-9]"))
    if klassen < RICHTLINIE["klassen_noetig"]:
        funde.append(f"nur {klassen} Zeichenklassen")
    for teil in RICHTLINIE["verbotene_teile"] + [benutzer.lower()]:
        if teil in passwort.lower():
            funde.append(f"enthaelt '{teil}'")
    if alter_tage > RICHTLINIE["max_alter_tage"]:
        funde.append("Hoechstalter ueberschritten")
    return funde

for pw, alter, user in [("Passwort2026!", 100, "anna"), ("kurz1A", 10, "bernd"),
                        ("blau-Wolke-7-Tisch", 400, "carla"), ("annaIstToll99", 5, "anna")]:
    print(f"{user:6} {pw:20} -> {pruefe(pw, alter, user) or 'konform'}")
```

Die Richtlinie steht als Wörterbuch an einer Stelle, sodass eine Änderung des Standards nur dort erfolgen muss. Die Funktion prüft die vier Bedingungen: Länge, Anzahl der vorkommenden Zeichenklassen (Kleinbuchstaben, Großbuchstaben, Ziffern, Sonderzeichen, gezählt mit regulären Ausdrücken), verbotene Bestandteile einschließlich des Benutzernamens und das Alter. Die Ausgabe: `Passwort2026!` ist lang genug und hat vier Klassen, enthält aber die verbotenen Teile “passwort” und “2026”. `kurz1A` ist zu kurz. `blau-Wolke-7-Tisch` erfüllt alle Anforderungen bis auf das Alter von 400 Tagen. `annaIstToll99` verstößt, weil es den Benutzernamen enthält. In echten Systemen wertet man dafür Prüfungen im Anmeldedienst aus; ein Programm, das Kennwörter im Klartext sieht, wäre selbst ein Sicherheitsproblem, daher dient dieses Beispiel nur dem Verständnis.

### Typische Fehler.

Falsch sind Richtlinien, die niemand kennt oder die mit zwanzig Seiten Fachsprache unlesbar sind. Falsch ist, Regeln ohne Ausnahmeprozess zu erlassen: Dann entstehen heimliche Ausnahmen (“Schatten-IT”). Falsch ist, Verfahren nicht auszuprobieren: Eine Anleitung, die nie jemand befolgt hat, enthält Fehler. Falsch ist, Technik und Richtlinie zu vermischen: Wer Produktnamen in die Policy schreibt, muss sie bei jedem Wechsel ändern.

### Praxisbezug.

Neue Mitarbeitende unterschreiben die Nutzungsrichtlinie; bei einem Vorfall (Abschnitt 10.7) prüft man, ob das Verfahren eingehalten wurde. Fragt ein Kunde im Audit nach einem Nachweis, ist das Dokumentenregister der erste Anlaufpunkt.

## 11.3 Datenschutz-Grundprinzipien

Der *Datenschutz* schützt Menschen vor den Folgen der Verarbeitung ihrer Daten; er ist von der *Datensicherheit* (Schutz von Daten vor Verlust und Missbrauch) zu unterscheiden, die ein Mittel dafür ist. In der Europäischen Union gilt die Datenschutz-Grundverordnung (DSGVO), ergänzt durch nationale Gesetze, in Österreich das Datenschutzgesetz (DSG). Die Aufsichtsbehörde in Österreich ist die Datenschutzbehörde (allgemeines Fachwissen, nicht abgerufen). Die zentralen Begriffe und die sieben Grundsätze nach Art. 5 DSGVO (Rechtmäßigkeit, Zweckbindung, Datenminimierung, Richtigkeit, Speicherbegrenzung, Integrität und Vertraulichkeit, Rechenschaftspflicht) wurden in Abschnitt 6.7 eingeführt. Dieser Abschnitt vertieft sie und ergänzt die Rechtsgrundlagen, die Rechte der Betroffenen und die Pflichten des Verantwortlichen.

Personenbezogene Daten sind alle Informationen, die sich auf eine identifizierte oder identifizierbare Person beziehen: Name, Adresse, E-Mail, Kennnummern, aber auch IP-Adressen, Standortdaten, Fotos oder Kundennummern, wenn sich daraus eine Person bestimmen lässt. *Besondere Kategorien* (zum Beispiel Gesundheit, Religion, Gewerkschaftszugehörigkeit, biometrische Daten) sind besonders geschützt. *Verarbeitung* ist jeder Vorgang mit Daten: Erheben, Speichern, Ändern, Abfragen, Übermitteln, Löschen. *Verantwortlicher* ist, wer über Zweck und Mittel entscheidet (das Unternehmen), *Auftragsverarbeiter*, wer im Auftrag verarbeitet (etwa der Cloud-Anbieter oder ein Wartungsdienstleister); mit ihm ist ein *Auftragsverarbeitungsvertrag* abzuschließen.

> **Ergänzung aus der Nachrecherche**
>
> **Rechtsgrundlagen.** Jede Verarbeitung braucht eine Rechtsgrundlage. Art. 6 Abs. 1 DSGVO nennt nach einer Zusammenstellung auf e-recht24.de (abgerufen, Drittquelle) sechs: a) Einwilligung der betroffenen Person für festgelegte Zwecke, b) Erfüllung eines Vertrags oder vorvertraglicher Maßnahmen, c) Erfüllung einer rechtlichen Pflicht, d) Schutz lebenswichtiger Interessen, e) Aufgabe im öffentlichen Interesse oder Ausübung öffentlicher Gewalt, f) berechtigte Interessen des Verantwortlichen oder eines Dritten, soweit nicht die Interessen oder Grundrechte der betroffenen Person überwiegen, insbesondere wenn es sich um ein Kind handelt; Behörden können sich bei ihren Aufgaben darauf nicht stützen. Eine Einwilligung ist demnach nur eine von mehreren Möglichkeiten und oft gar nicht die passende: Die Lohnabrechnung stützt sich auf Vertrag und rechtliche Pflicht.
>
> **Rechte der Betroffenen.** Nach einem Merkblatt der IHK Arnsberg (abgerufen, Stand August 2017, daher mit Vorsicht zu lesen) haben Betroffene Rechte auf Auskunft (Art. 15), Berichtigung (Art. 16), Löschung (Art. 17), Einschränkung der Verarbeitung (Art. 18), Datenübertragbarkeit (Art. 20), Widerspruch (Art. 21) und Schutz vor ausschließlich automatisierten Einzelentscheidungen einschließlich Profiling (Art. 22). Der Verantwortliche muss grundsätzlich innerhalb eines Monats nach Eingang des Antrags reagieren; die Frist kann um zwei Monate verlängert werden, wenn Komplexität oder Zahl der Anträge dies erfordern, und die Verlängerung samt Gründen ist innerhalb des ersten Monats mitzuteilen. Das ist eine Orientierung, keine Rechtsberatung; der aktuelle Gesetzestext (EUR-Lex) ist maßgeblich.

Aus den Rechten ergibt sich der Alltag der IT: Wer eine Auskunft erteilen oder Daten löschen soll, muss wissen, *wo* die Daten einer Person überhaupt liegen. Deshalb verlangt die DSGVO ein *Verzeichnis von Verarbeitungstätigkeiten* (Art. 30), in dem je Verarbeitung Verantwortlicher, Zweck, Kategorien betroffener Personen und Daten, Empfänger, Übermittlungen in Drittländer, Löschfristen und technisch-organisatorische Maßnahmen (TOMs) stehen (die Aufzählung der Inhalte stammt aus allgemeinem Fachwissen, den Gesetzestext habe ich nicht abgerufen). Zu den Maßnahmen gehören nach Art. 32 unter anderem Pseudonymisierung, Verschlüsselung, die Sicherstellung von Vertraulichkeit, Integrität und Verfügbarkeit sowie ein Verfahren zur regelmäßigen Überprüfung (ebenfalls allgemeines Fachwissen). Bei neuen Verfahren mit hohem Risiko ist eine Datenschutz-Folgenabschätzung nötig, und Datenschutz soll bereits im Entwurf und durch Voreinstellungen berücksichtigt werden (*Privacy by Design* und *by Default*). Bei Vorfällen gelten Meldepflichten (Abschnitt 10.7).

Das Programm zeigt zwei praktische Techniken: das Minimieren und Pseudonymisieren von Kundendaten für eine Statistik und die Prüfung eines Verzeichniseintrags auf Vollständigkeit. Die Pseudonymisierung ersetzt die E-Mail-Adresse durch einen mit einem geheimen Schlüssel berechneten Kurzwert (HMAC, wie in Abschnitt 10.2); derselbe Schlüssel führt immer zum selben Pseudonym, ohne Schlüssel lässt sich die Adresse nicht zurückrechnen. Der Schlüssel muss getrennt aufbewahrt werden, sonst ist der Schutz wirkungslos.

```python
import hmac, hashlib

SALZ = b"geheimer-schluessel-getrennt-aufbewahren"

def pseudonym(wert):
    return hmac.new(SALZ, wert.encode(), hashlib.sha256).hexdigest()[:10]

kunden = [
    {"name": "Anna Huber", "email": "anna@example.at", "geburtsdatum": "1990-05-17", "plz": "1010", "kauf": 129.0},
    {"name": "Bernd Moser", "email": "bernd@example.at", "geburtsdatum": "1985-11-02", "plz": "8010", "kauf": 59.0},
]

def minimiert_fuer_statistik(k):
    jahr = int(k["geburtsdatum"][:4])
    return {"id": pseudonym(k["email"]),
            "alter_gruppe": f"{(2026 - jahr) // 10 * 10}er",
            "region": k["plz"][0] + "xxx",
            "kauf": k["kauf"]}

for k in kunden:
    print(minimiert_fuer_statistik(k))
print(pseudonym("anna@example.at") == pseudonym("anna@example.at"))

PFLICHT = ["verantwortlicher", "zweck", "rechtsgrundlage", "betroffene", "datenkategorien",
           "empfaenger", "drittland", "loeschfrist", "massnahmen"]
eintrag = {"verantwortlicher": "Muster GmbH", "zweck": "Lohnabrechnung",
           "rechtsgrundlage": "Vertrag / rechtliche Pflicht", "betroffene": "Mitarbeitende",
           "datenkategorien": "Name, IBAN, Gehalt", "empfaenger": "Steuerberater",
           "drittland": "", "loeschfrist": "7 Jahre"}
print("Fehlend:", [p for p in PFLICHT if not eintrag.get(p)])
```

Die Funktion `pseudonym` berechnet über den Wert und den geheimen Schlüssel einen Hash und kürzt ihn auf zehn Zeichen. Die Funktion `minimiert_fuer_statistik` gibt für die Auswertung nur noch das Nötigste weiter: ein Pseudonym statt der Adresse, eine Altersgruppe (Dekade) statt des Geburtsdatums, nur die erste Ziffer der Postleitzahl als Region und den Kaufbetrag. Name und Adresse verschwinden vollständig (*Datenminimierung*). Die Ausgabe zeigt für Anna die Gruppe “30er” und die Region “1xxx”, für Bernd “40er” und “8xxx”; das Pseudonym ist bei jedem Aufruf gleich (`True`), man kann also Käufe derselben Person zusammenführen, ohne sie zu kennen. Zu beachten: Pseudonymisierte Daten gelten weiterhin als personenbezogen, solange der Schlüssel existiert; erst echte Anonymisierung, bei der niemand mehr identifizierbar ist, nimmt die Daten aus der DSGVO. Auch Kombinationen grober Merkmale können bei kleinen Gruppen Personen verraten. Der Verzeichniseintrag zeigt am Ende, dass die Angaben “Drittland” (Übermittlung außerhalb der EU) und “Maßnahmen” fehlen; ein leeres Feld bedeutet nicht “keine”, sondern “nicht geprüft”, und das gehört vermerkt.

### Typische Fehler.

Falsch ist, Daten “auf Vorrat” zu sammeln. Falsch ist, eine Einwilligung zu verlangen, wo eine andere Rechtsgrundlage besteht, und sie dann nicht widerrufbar zu gestalten. Falsch ist, Mitarbeiterdaten oder Kundendaten für andere Zwecke zu nutzen als jene, für die sie erhoben wurden. Falsch ist, personenbezogene Daten in Testsystemen unverändert zu verwenden. Falsch ist, Auskunftsanfragen zu ignorieren oder weiterzuleiten, ohne die Frist zu beachten. Falsch ist, Cloud-Dienste ohne Auftragsverarbeitungsvertrag zu nutzen.

### Praxisbezug.

Der Support bekommt Anfragen wie “Welche Daten haben Sie über mich?” oder “Bitte löschen Sie mein Konto”. Die richtige Reaktion ist nicht, selbst zu entscheiden, sondern den Vorgang an die zuständige Stelle (Datenschutzbeauftragte) weiterzugeben und die Frist zu notieren. Dieser Abschnitt ist keine Rechtsberatung.

> **Merke**
>
> Personenbezogene Daten brauchen eine Rechtsgrundlage (nicht nur Einwilligung), Zweckbindung, Minimierung und Löschfristen. Betroffene haben Rechte (Auskunft, Berichtigung, Löschung, …) mit Frist von grundsätzlich einem Monat. Verzeichnis der Verarbeitungstätigkeiten, TOMs, Auftragsverarbeitungsvertrag. Pseudonymisiert bleibt personenbezogen. Keine Rechtsberatung.

## 11.4 Datenklassifizierung und Aufbewahrung

Nicht alle Daten sind gleich wichtig, und nicht alle brauchen denselben Schutz. Die *Datenklassifizierung* ordnet Informationen nach ihrem Schutzbedarf in Stufen ein; daraus folgen Regeln für Speicherung, Zugriff, Weitergabe, Verschlüsselung und Entsorgung. Übliche Stufen sind *öffentlich* (darf jeder sehen, etwa Pressemitteilungen), *intern* (für Mitarbeitende, Schaden bei Veröffentlichung gering), *vertraulich* (nur für bestimmte Gruppen, Schaden erheblich, etwa Verträge, Kundendaten) und *streng vertraulich* (kleiner Personenkreis, Schaden schwerwiegend, etwa Gehaltslisten, Entwicklungsgeheimnisse). Die Namen und Zahl der Stufen sind frei wählbar; wichtig ist, dass wenige Stufen klar definiert sind, damit sie im Alltag angewendet werden. Hinter der Einstufung stehen die drei Schutzziele aus Abschnitt 10.2: Vertraulichkeit, Integrität und Verfügbarkeit. Der *Dateneigentümer* (meist die Fachabteilung) stuft ein, die IT setzt die Schutzmaßnahmen um; wer nicht eingestuft ist, gilt im Zweifel als mindestens intern.

Zur Klassifizierung gehören die *Kennzeichnung* (Vermerk im Dokument, Etikett, Dateiname) und der *Umgang*: Vertrauliche Daten werden nur verschlüsselt per E-Mail verschickt, nicht auf privaten Geräten gespeichert und bei der Entsorgung sicher gelöscht oder vernichtet (Abschnitt 6.2). Die zweite Dimension ist die *Aufbewahrung* (*Retention*). Es gibt zwei gegenläufige Anforderungen: Manche Daten müssen *mindestens* so lange aufbewahrt werden (Aufbewahrungspflichten nach Handels- und Steuerrecht; in Österreich nennt die WKO für Bücher, Aufzeichnungen und Belege grundsätzlich sieben Jahre, siehe Abschnitt 6.2, abgerufen), andere *höchstens* so lange, wie es für den Zweck nötig ist (Speicherbegrenzung nach DSGVO). Das Ergebnis ist eine Aufbewahrungstabelle je Datenart, Fristbeginn und Frist, mit einem Löschverfahren. Läuft ein Verfahren oder eine Untersuchung, gilt eine *Aufbewahrungssperre* (*Legal Hold*): Betroffene Daten dürfen nicht gelöscht werden, auch wenn die Frist abläuft.

Das Programm prüft für fünf Datensätze, ob die Frist nach Klasse abgelaufen ist. Die Fristen je Klasse sind Beispielwerte; echte Fristen ergeben sich aus der Datenart und den Vorschriften. Das Programm berücksichtigt zudem einen Sonderfall bei Schaltjahren (29. Februar).

```python
from datetime import date

heute = date(2026, 10, 24)
REGELN = {"oeffentlich": None, "intern": 3, "vertraulich": 7, "streng vertraulich": 10}
daten = [
    ("Pressemitteilung", "oeffentlich", date(2020, 1, 10)),
    ("Protokoll Teamsitzung", "intern", date(2022, 5, 3)),
    ("Rechnung Lieferant", "vertraulich", date(2019, 6, 30)),
    ("Gehaltsliste", "streng vertraulich", date(2015, 12, 31)),
    ("Lohnkonto", "vertraulich", date(2021, 3, 1)),
]

def ende(d, jahre):
    try:
        return d.replace(year=d.year + jahre)
    except ValueError:
        return d.replace(year=d.year + jahre, day=28)

for name, klasse, erstellt in daten:
    jahre = REGELN[klasse]
    if jahre is None:
        print(f"{name:24} {klasse:19} keine feste Frist")
        continue
    e = ende(erstellt, jahre)
    status = "LOESCHEN/PRUEFEN" if e < heute else "aufbewahren"
    print(f"{name:24} {klasse:19} Frist bis {e.isoformat()} -> {status}")
```

Das Wörterbuch `REGELN` ordnet jeder Klasse eine Frist in Jahren zu (`None` heißt: keine feste Frist). Die Funktion `ende` addiert Jahre zum Datum; schlägt `replace` fehl, weil der Zieltag nicht existiert (29. Februar in einem Nichtschaltjahr), wird auf den 28. ausgewichen. Die Ausgabe: Die Pressemitteilung hat keine feste Frist. Das Protokoll von 2022 (intern, drei Jahre) lief am 03.05.2025 ab, die Lieferantenrechnung (sieben Jahre) am 30.06.2026, die Gehaltsliste (zehn Jahre) am 31.12.2025; alle drei sind zum Löschen oder Prüfen vorzumerken. Das Lohnkonto von 2021 bleibt bis 01.03.2028 aufzubewahren. “Löschen/Prüfen” ist bewusst keine Löschanweisung: Vor dem Löschen muss man prüfen, ob eine längere gesetzliche Frist oder eine Sperre gilt. Dass Fristen oft nach Jahresende rechnen (die Frist beginnt mit dem Ende des Kalenderjahres), vereinfacht das Beispiel; die Regel in Abschnitt 6.2 ist genauer.

### Typische Fehler.

Falsch ist, alles als “streng vertraulich” einzustufen: Dann nimmt niemand die Einstufung ernst, und der Aufwand explodiert. Falsch ist, nichts einzustufen. Falsch ist, Daten nie zu löschen “für alle Fälle”: Das verstößt gegen die Speicherbegrenzung und vergrößert den Schaden bei einem Vorfall. Falsch ist, zu löschen, ohne Aufbewahrungspflichten zu kennen. Falsch ist, Sicherungskopien zu vergessen, in denen gelöschte Daten weiterleben (Abschnitt 6.6, 12.6).

### Praxisbezug.

Eine Ablageordnung mit Einstufung, ein Löschkonzept und ein jährlicher Aufräumlauf gehören zu den wirksamsten Maßnahmen: Was nicht mehr da ist, kann nicht gestohlen werden. Für Auskünfte an Betroffene ist die Kenntnis, wo welche Daten liegen, Voraussetzung.

## 11.5 Asset- und Konfigurationsmanagement

Man kann nur schützen und verwalten, was man kennt. Das *Asset-Management* führt ein Verzeichnis aller Werte der IT: Geräte (Arbeitsplätze, Server, Netzwerkgeräte, Mobilgeräte), Software und Lizenzen, Daten, Dienste und Zugangsdaten. Zu jedem Asset gehören Kennung (Inventarnummer, Seriennummer), Eigentümer, Standort, Status (im Lager, im Einsatz, defekt, ausgemustert), Anschaffungsdatum, Garantie und Ende der Herstellerunterstützung. Das *Konfigurationsmanagement* geht weiter: Es verwaltet die Einstellungen und Beziehungen der Bestandteile in einer *Konfigurationsdatenbank* (englisch *CMDB*): Welcher Server hat welches Betriebssystem in welcher Version, welche Anwendung läuft darauf, von welchem anderen Dienst hängt sie ab? Diese Beziehungen sind bei Störungen und Änderungen Gold wert, weil man sofort sieht, was betroffen ist (Abschnitte 9.5 und 9.6). Der *Lebenszyklus* eines Assets reicht von der Beschaffung über Inbetriebnahme, Betrieb und Wartung bis zur Ausmusterung, die eine sichere Löschung der Daten und die ordnungsgemäße Entsorgung (Elektroschrott) umfasst.

Das Verzeichnis ist nie von selbst richtig: Geräte werden angeschafft, vergessen, privat mitgebracht oder abgeschaltet. Deshalb gleicht man den Soll-Bestand (die Datenbank) regelmäßig mit dem Ist-Bestand (was ein Netzwerkscan tatsächlich findet) ab. Abweichungen sind Hinweise auf Lücken: Unbekannte Geräte im Netz können ein Sicherheitsrisiko sein, erfasste Geräte, die nicht auftauchen, sind eventuell verloren oder gestohlen. Zusätzlich prüft man, ob die Herstellerunterstützung für Betriebssysteme noch läuft. Das Programm vergleicht beides.

```python
soll = {
    "PC-001": {"os": "Windows 11", "eigentuemer": "anna"},
    "PC-002": {"os": "Windows 10", "eigentuemer": "bernd"},
    "SRV-01": {"os": "Windows Server 2016", "eigentuemer": "it"},
    "PC-004": {"os": "Windows 11", "eigentuemer": "carla"},
}
gefunden = {"PC-001", "PC-002", "SRV-01", "PC-099"}
ENDE_SUPPORT = {"Windows 10": "2025-10-14", "Windows Server 2016": "2027-01-12"}

print("Nicht im Bestand erfasst (unbekannt):", sorted(gefunden - set(soll)))
print("Im Bestand, aber nicht gefunden (verloren/abgeschaltet?):", sorted(set(soll) - gefunden))
heute = "2026-10-24"
for n, d in sorted(soll.items()):
    e = ENDE_SUPPORT.get(d["os"])
    if e and e < heute:
        print(n, d["os"], "Support beendet am", e)
    elif e:
        print(n, d["os"], "Support endet am", e)
```

Der Soll-Bestand ist ein Wörterbuch mit vier Geräten, der Ist-Bestand eine Menge der bei einem Scan gefundenen Kennungen. Die Mengendifferenz `gefunden - set(soll)` liefert alles, was gefunden, aber nicht erfasst ist: `PC-099`, ein unbekanntes Gerät, das nachzuverfolgen ist (Mitarbeitergerät? Fremdgerät im Netz?). Umgekehrt ist `PC-004` erfasst, wurde aber nicht gefunden: ausgeschaltet, defekt oder verschwunden. Die Support-Daten sind Beispielwerte nach allgemeinem Fachwissen (Windows 10 Ende des regulären Supports 14.10.2025, Windows Server 2016 Ende des erweiterten Supports 12.01.2027; die Angaben wurden hier nicht abgerufen und sind beim Hersteller zu prüfen). Das Programm meldet für `PC-002`, dass der Support bereits beendet ist: ein Sicherheitsrisiko, weil keine Updates mehr erscheinen (Abschnitt 9.6). Für den Server endet er in absehbarer Zeit; das ist der Anlass, rechtzeitig die Ablösung zu planen (Abschnitt 12.4). Das Datumsvergleichen als Text funktioniert nur, weil das ISO-Format (JJJJ-MM-TT) alphabetisch dieselbe Reihenfolge wie zeitlich hat.

### Typische Fehler.

Falsch ist, das Inventar einmal anzulegen und nie zu pflegen: Ein falsches Verzeichnis ist gefährlicher als keines, weil man ihm vertraut. Falsch ist, Geräte ohne Eigentümer zu führen. Falsch ist, Software und Cloud-Konten zu vergessen, die nicht physisch sichtbar sind (Schatten-IT, Abschnitt 5.1). Falsch ist, ausgemusterte Geräte mit Daten zu verkaufen oder zu entsorgen. Falsch ist, die Beziehungen zwischen Systemen nicht zu dokumentieren, sodass niemand weiß, was ein Neustart des Servers noch trifft.

### Praxisbezug.

Vor einer Änderung fragt man die Konfigurationsdatenbank: Was hängt davon ab? Bei einer Sicherheitslücke beantwortet sie in Minuten, welche Systeme betroffen sind. Beim Austritt eines Mitarbeiters zeigt sie, welche Geräte zurückzugeben sind.

## 11.6 Lieferanten- und Lizenzbasis

Kaum eine Organisation betreibt ihre IT allein. Sie kauft Hardware, Software, Cloud-Dienste und Beratung von *Lieferanten* und ist damit von ihnen abhängig. Das *Lieferantenmanagement* stellt sicher, dass diese Abhängigkeiten bewusst gewählt und beherrscht werden. Vor der Auswahl prüft man Eignung, Referenzen, Sicherheit und Datenschutz (Auftragsverarbeitungsvertrag, Standort der Daten, Unterauftragnehmer). Im Vertrag stehen Leistungsumfang, Verfügbarkeit und Reaktionszeiten (*Service Level Agreement*, SLA, Abschnitt 9.1), Haftung, Kündigung und Datenrückgabe beim Ende der Beziehung. Im Betrieb überwacht man die Leistung und bewertet das Risiko, das von einem Lieferanten ausgeht: Was passiert, wenn er ausfällt, gehackt wird oder die Preise erhöht? Dabei ist die Lieferkette zu beachten: Fremde Software und Bibliotheken sind Teil der eigenen Sicherheit (Abschnitt 7.8).

Eng damit verbunden ist die *Lizenzierung*. Software wird nicht gekauft, sondern es werden Nutzungsrechte erworben, festgelegt in einer *Lizenz*. Lizenzmodelle unterscheiden sich: pro Gerät, pro Benutzer, gleichzeitige Nutzer (*Floating*), nach Kernen oder Servern, als Abonnement oder als einmalige Dauerlizenz. *Freie Software* (Open Source) darf unter bestimmten Bedingungen genutzt, verändert und weitergegeben werden; die Bedingungen unterscheiden sich je nach Lizenz stark (manche verlangen, Änderungen ebenfalls freizugeben), und auch freie Software ist lizenziert und zu dokumentieren. *Compliance* bedeutet hier, nicht mehr Software zu nutzen, als man lizenziert hat (Unterlizenzierung kann teuer werden, mit Nachzahlungen und Strafen), aber auch nicht mehr zu bezahlen, als man braucht (Überlizenzierung, “Lizenzleichen”). Das Programm gleicht gekaufte und installierte Lizenzen ab und rechnet die Folgen mit erfundenen Preisen.

```python
gekauft = {"Textverarbeitung": 40, "CAD-Software": 5, "Backup-Agent": 20}
installiert = {"Textverarbeitung": 46, "CAD-Software": 3, "Backup-Agent": 20, "PDF-Tool": 12}
preis = {"Textverarbeitung": 90.0, "CAD-Software": 1200.0, "Backup-Agent": 60.0}

for p in sorted(set(gekauft) | set(installiert)):
    k, i = gekauft.get(p, 0), installiert.get(p, 0)
    diff = i - k
    status = "ok" if diff == 0 else ("UNTERLIZENZIERT" if diff > 0 else "Ueberschuss")
    kosten = ""
    if diff > 0:
        kosten = (f"Nachlizenzierung ca. {diff * preis[p]:.0f} EUR" if p in preis
                  else "keine Lizenz vorhanden - pruefen")
    elif diff < 0:
        kosten = f"ungenutzt: {-diff} Lizenzen ({-diff * preis[p]:.0f} EUR)"
    print(f"{p:18} gekauft {k:3} installiert {i:3} -> {status:16} {kosten}")
```

Der Operator `|` bildet die Vereinigung beider Programmlisten, damit auch installierte Programme ohne Kaufeintrag erscheinen. Für jedes Programm wird die Differenz aus installierten und gekauften Lizenzen berechnet. Das Ergebnis: Der Backup-Agent ist in Ordnung. Bei der Textverarbeitung sind sechs Installationen mehr vorhanden als Lizenzen; die Nachlizenzierung käme auf rund 540 Euro. Von der CAD-Software sind zwei Lizenzen ungenutzt, das sind 2 400 Euro, die man bei der Verlängerung einsparen könnte. Das PDF-Programm ist zwölfmal installiert, es gibt aber keine Lizenz: Entweder ist es freie Software (dann ist die Lizenzbedingung zu dokumentieren) oder eine unlizenzierte Nutzung. Genau diese Prüfung führt man vor Audits der Hersteller durch, weil Hersteller das Recht haben, die Einhaltung zu überprüfen. Preise und Zahlen sind erfunden.

### Typische Fehler.

Falsch ist, Software von privaten Konten oder aus unklarer Quelle zu nutzen. Falsch ist, einen Lieferanten ohne Ausstiegsplan zu wählen (Abschnitt 8.4 Lock-in). Falsch ist, Verträge automatisch verlängern zu lassen, ohne Bedarf zu prüfen. Falsch ist, Lizenzbedingungen nur dem Einkauf zu überlassen, ohne die technische Nutzung zu kennen. Falsch ist, bei Open Source zu glauben, es gebe keine Bedingungen.

### Praxisbezug.

Im Support landet die Frage “Darf ich das Programm auch auf meinem privaten Laptop installieren?”: Das hängt von der Lizenz ab, nicht von der technischen Möglichkeit. Lizenzverwaltung und Lieferantenbewertung sind in kleinen Betrieben oft nebenbei erledigt; ein jährlicher Abgleich wie im Beispiel deckt den größten Teil der Risiken ab.

## 11.7 Auditierbarkeit und Nachweise

Ein *Audit* ist eine systematische, unabhängige Überprüfung, ob Regeln, Normen oder Verträge eingehalten werden. Es kann *intern* (eigene Revision), *extern* (Zertifizierer, Kunde, Behörde) oder durch den Hersteller (Lizenzaudit) erfolgen. Der Prüfer fragt nicht nur “haben Sie eine Regel?”, sondern “wie weisen Sie nach, dass sie gelebt wird?”. Als Nachweise (*Evidenz*) dienen Dokumente (Richtlinien, Verfahren, Verträge), Protokolle und Berichte (Anmeldeprotokolle, Änderungsanträge, Sicherungsprotokolle, Wiederherstellungstests), Genehmigungen und Zugriffslisten, Schulungsnachweise und Konfigurationsstände. Der Grundsatz lautet: *Was nicht dokumentiert ist, gilt als nicht geschehen.* Eine Auditierbarkeit setzt voraus, dass Nachweise vollständig, zeitlich eingeordnet, einer Person zuordenbar, unverändert und auffindbar sind.

Für die Unveränderbarkeit gibt es einfache technische Mittel. Besonders anschaulich ist die *Verkettung*: Jeder Protokolleintrag enthält den Hash des vorherigen Eintrags. Verändert jemand nachträglich einen Eintrag, ändert sich dessen Hash, und die Kette bricht an dieser Stelle. Das Prinzip ähnelt den Prüfsummen aus Abschnitt 10.2 und wird in manipulationssicheren Protokollen eingesetzt. Das Programm baut ein kleines Änderungsprotokoll auf und prüft es vor und nach einer Fälschung.

```python
import hashlib, json

def eintrag_bauen(kette, wer, was, zeit):
    vor = kette[-1]["hash"] if kette else "0" * 64
    inhalt = {"wer": wer, "was": was, "zeit": zeit, "vorher": vor}
    h = hashlib.sha256(json.dumps(inhalt, sort_keys=True).encode()).hexdigest()
    kette.append({**inhalt, "hash": h})

def pruefen(kette):
    vor = "0" * 64
    for i, e in enumerate(kette):
        inhalt = {k: e[k] for k in ("wer", "was", "zeit", "vorher")}
        if e["vorher"] != vor:
            return f"Kette gebrochen bei Eintrag {i}"
        if hashlib.sha256(json.dumps(inhalt, sort_keys=True).encode()).hexdigest() != e["hash"]:
            return f"Eintrag {i} veraendert"
        vor = e["hash"]
    return "Kette intakt"

k = []
eintrag_bauen(k, "anna", "Konto bernd angelegt", "2026-10-20T09:00")
eintrag_bauen(k, "admin", "Rolle Buchhaltung vergeben", "2026-10-20T09:05")
eintrag_bauen(k, "admin", "Konto bernd gesperrt", "2026-10-21T17:30")
print(pruefen(k))
k[1]["was"] = "nichts passiert"
print(pruefen(k))
```

`eintrag_bauen` nimmt den Hash des letzten Eintrags (beim ersten Eintrag 64 Nullen als Startwert), fasst Person, Handlung, Zeit und diesen Vorgänger-Hash zu einem Text zusammen (JSON, mit sortierten Schlüsseln, damit die Reihenfolge immer gleich ist) und berechnet daraus den neuen Hash, der mit gespeichert wird. `pruefen` geht die Kette durch, vergleicht bei jedem Eintrag den gespeicherten Vorgänger mit dem tatsächlichen und berechnet den Hash neu. Im ersten Lauf ist alles in Ordnung (“Kette intakt”). Dann wird im zweiten Eintrag der Text geändert; die Prüfung meldet “Eintrag 1 verändert”, weil der gespeicherte Hash nicht mehr zum Inhalt passt. Wer den Hash des Eintrags ebenfalls neu berechnet, müsste alle folgenden Einträge neu schreiben, was auffällt, wenn der letzte Hash zusätzlich an anderer Stelle gesichert ist. Diese Technik ersetzt keine Zugriffsbeschränkung auf Protokolle, macht aber Manipulation sichtbar. Weitere Maßnahmen für Protokolle sind getrennte Ablage, zentrale Sammlung und eingeschränkte Schreibrechte (Abschnitt 9.3).

Für die Praxis wichtig ist, dass sich Audit-Vorbereitung nicht auf die Woche vor dem Termin beschränkt. Dazu gehören ein Verzeichnis, welche Nachweise für welche Anforderung gelten (“Kontrollmatrix”), regelmäßige Stichproben und interne Prüfungen, ein Umgang mit Feststellungen (Abweichung, Ursache, Maßnahme, Verantwortlicher, Termin, Nachprüfung) und ein Ablageort mit Zugriffsschutz. Prüfer treffen Stichproben: Sie wählen aus der Liste der Änderungen drei zufällige aus und verlangen zu jeder Antrag, Genehmigung, Test und Umsetzungsnachweis. Wer das einmal durchlaufen hat, dokumentiert künftig anders.

### Typische Fehler.

Falsch ist, Nachweise nachträglich zu erstellen (“rückdatiert”): Das ist eine Fälschung und bei Aufdeckung schlimmer als die ursprüngliche Lücke. Falsch ist, bei einem Audit Dinge zu verschweigen oder zu beschönigen. Falsch ist, nur auf die Zertifikatsurkunde zu schauen und die gelebte Praxis zu vernachlässigen. Falsch ist, Nachweise nur im Kopf einer Person zu haben. Falsch ist, Feststellungen ohne Frist und Verantwortlichen aufzunehmen.

### Praxisbezug.

Wer Tickets sauber führt (Abschnitt 9.5), Änderungen genehmigt (9.6), Wiederherstellungen testet und protokolliert (12.6), hat den größten Teil der Nachweise ohne Zusatzaufwand. Kunden verlangen zunehmend Nachweise, bevor sie Aufträge vergeben.

## 11.8 Governance-Troubleshooting

Auch Governance lässt sich “debuggen”. Wenn Regeln nicht eingehalten werden, Audits Mängel finden oder Vorfälle auf Regelverstöße zurückgehen, hilft dieselbe Methode wie bei technischen Störungen (Abschnitt 9.8): Problem eingrenzen, Ursache suchen, Maßnahme ableiten, prüfen, dokumentieren. Typische Fehlerbilder sind: *Die Regel existiert nicht* (Lücke: Zuständigkeit klären, Dokument erstellen). *Die Regel ist unbekannt* (Schulung, Kommunikation). *Die Regel ist unpraktikabel* (Mitarbeitende umgehen sie; Regel überarbeiten, nicht nur durchsetzen). *Die Regel wird nicht kontrolliert* (technische Kontrollen, Stichproben einführen). *Die Regel hat keinen Eigentümer* (veraltet, widersprüchlich). Bei Vorfällen fragt man ohne Schuldzuweisung: Welche Regel hätte den Vorfall verhindert? Gab es sie? War sie bekannt? Wurde sie kontrolliert? Dieses Vorgehen entspricht dem Lernen aus Vorfällen (Abschnitt 10.7) und führt zu Maßnahmen, die wirken, statt zu Sündenböcken.

Ein besonders ergiebiges Feld sind Zugriffsrechte. Hier prüft man regelmäßig (*Access Review*), ob die vorhandenen Konten und Rollen zum Personalstand und zu den Genehmigungen passen. Das Programm gleicht Konten mit der Personalliste ab und sucht ausgetretene Personen mit aktivem Konto, Konten ohne Zuordnung und Administratorrechte ohne Genehmigung. Dienstkonten (Konten für Programme) sind mit einem Präfix gekennzeichnet und werden gesondert behandelt.

```python
konten = {
    "anna": {"rollen": ["buchhaltung"]},
    "bernd": {"rollen": ["admin", "buchhaltung"]},
    "carla": {"rollen": ["admin"]},
    "dienst-backup": {"rollen": ["backup"]},
    "gast42": {"rollen": ["lesen"]},
}
hr = {"anna": "aktiv", "bernd": "ausgetreten", "carla": "aktiv"}
GENEHMIGTE_ADMINS = ["carla"]

funde = []
for k, d in konten.items():
    ist_dienst = k.startswith("dienst-")
    if k not in hr and not ist_dienst:
        funde.append((k, "Konto ohne Eintrag in der Personalliste"))
    if hr.get(k) == "ausgetreten":
        funde.append((k, "ausgetretene Person hat noch ein aktives Konto"))
    if "admin" in d["rollen"] and k not in GENEHMIGTE_ADMINS:
        funde.append((k, "Admin-Rolle ohne Genehmigung"))
for k, t in funde:
    print(f"{k:14} {t}")
print(len(funde), "Feststellungen")
```

Die Schleife durchläuft alle Konten. Ein Dienstkonto erkennt sie am Präfix. Prüfung eins: Konten, die weder zu einer Person noch zu einem Dienst gehören. Prüfung zwei: Personen, die laut Personalliste ausgetreten sind, aber noch ein Konto haben. Prüfung drei: Administratorrollen für Personen, die nicht auf der Liste genehmigter Administratoren stehen. Das Programm liefert drei Feststellungen. Das Konto `bernd` gehört einer ausgetretenen Person und trägt obendrein die Administratorrolle ohne Genehmigung (zwei Meldungen). Das Konto `gast42` kann niemandem zugeordnet werden (eine Meldung). Die Konten von `anna` und `carla` sind unauffällig, weil Carla als Administratorin genehmigt ist, und das Dienstkonto `dienst-backup` wird bewusst von der Personenprüfung ausgenommen (für Dienstkonten braucht es eine eigene Prüfung auf Eigentümer und Zweck). Jede Feststellung ist mit Verantwortlichem und Frist zu bearbeiten: Konto sperren, Rolle entziehen, Besitzer klären. Dass ausgetretene Mitarbeitende noch Zugänge haben, gehört zu den häufigsten Audit-Feststellungen und zu den gefährlichsten Lücken.

### Typische Fehler.

Falsch ist, bei einem Verstoß nur die Person zu bestrafen und die Ursache im System zu ignorieren. Falsch ist, Regeln immer weiter zu verschärfen, wenn sie bereits umgangen werden. Falsch ist, Feststellungen abzuhaken, ohne zu prüfen, ob die Maßnahme wirkt. Falsch ist, Ausnahmen ohne Befristung und Genehmigung zu dulden. Falsch ist, bei Personalwechseln keine Abstimmung zwischen Personalabteilung und IT zu haben.

### Praxisbezug.

Ein regelmäßiger Abgleich von Personalliste und Konten (monatlich oder bei jedem Austritt), ein Ausnahmeregister mit Ablaufdatum und eine kurze Nachbesprechung nach Vorfällen sind einfache, wirksame Maßnahmen. Sie erzeugen zugleich die Nachweise, die Audits verlangen.

## Übungsaufgaben Modul 11

1.  Erklären Sie GRC in eigenen Worten. Warum ist die Geschäftsleitung für Informationssicherheit verantwortlich, obwohl die IT sie umsetzt? Was besagt das Prinzip der Funktionstrennung?

2.  Unterscheiden Sie Richtlinie, Standard, Richtschnur und Verfahren. Ordnen Sie zu: (a) “Informationen sind vor unbefugtem Zugriff zu schützen.” (b) “Kennwörter haben mindestens zwölf Zeichen.” (c) “So sperren Sie ein Konto: 1. …” (d) “Wir empfehlen, den Bildschirm beim Verlassen zu sperren.”

3.  Nennen Sie die sechs Rechtsgrundlagen nach Art. 6 DSGVO in eigenen Worten und begründen Sie, welche für die Lohnabrechnung, für einen Newsletter und für die Videoüberwachung eines Eingangsbereichs (berechtigtes Interesse) in Betracht kommen. Hinweis: allgemeine Orientierung, keine Rechtsberatung.

4.  Eine Kundin verlangt Auskunft über ihre gespeicherten Daten. Welche Rechte hat sie noch, bis wann ist grundsätzlich zu antworten, und wie verhalten Sie sich als Support-Mitarbeiter?

5.  Was unterscheidet Pseudonymisierung von Anonymisierung, und warum fallen pseudonymisierte Daten weiter unter die DSGVO?

6.  **Praxis:** Erweitern Sie die Aufbewahrungsprüfung aus Abschnitt 11.4 so, dass ein Datensatz mit dem Merker `sperre=True` (Legal Hold) nie als löschbar gemeldet wird. Testen Sie mit zwei Datensätzen, die dieselbe Frist überschritten haben, einmal mit und einmal ohne Sperre.

7.  **Praxis:** Schreiben Sie ein Programm, das eine Geräteliste (Kennung, Betriebssystem, letztes Update-Datum) einliest und alle Geräte meldet, deren letztes Update mehr als 90 Tage vor dem 24. 10. 2026 liegt, sortiert nach Alter.

8.  **Praxis:** Erweitern Sie das Programm zur Protokollkette aus Abschnitt 11.7 um eine Funktion, die den *letzten* Hash ausgibt (der extern gesichert werden soll), und zeigen Sie, dass eine Fälschung, bei der ein Angreifer die Hashes der Folgeeinträge neu berechnet, am abweichenden Endhash erkannt wird.

9.  Bei einem Audit wird festgestellt, dass drei ausgetretene Mitarbeitende noch aktive Konten haben. Beschreiben Sie, wie Sie die Ursache analysieren, welche Sofortmaßnahmen und welche dauerhaften Maßnahmen Sie vorschlagen und welche Nachweise Sie dem Auditor liefern.

## Lösungen Modul 11

1.  GRC steht für Governance (Entscheidungs- und Verantwortungsstruktur), Risk (Umgang mit Risiken) und Compliance (Einhaltung und Nachweis von Vorschriften). Die Geschäftsleitung trägt die Gesamtverantwortung für die Organisation, bestimmt Ziele und Risikobereitschaft und stellt Mittel bereit; die IT setzt um, kann aber nicht allein entscheiden, welches Risiko das Unternehmen tragen will. Funktionstrennung heißt, dass kritische Abläufe nicht von einer Person allein beantragt, genehmigt und umgesetzt werden können, damit Fehler und Missbrauch auffallen.

2.  Richtlinie: Ziel und Grundsatz, von der Leitung freigegeben. Standard: verbindliche konkrete Vorgabe. Richtschnur: Empfehlung, begründete Abweichung möglich. Verfahren: Schritt-für-Schritt-Anleitung. Zuordnung: (a) Richtlinie, (b) Standard, (c) Verfahren, (d) Richtschnur.

3.  a\) Einwilligung, b) Vertrag oder vorvertragliche Maßnahmen, c) rechtliche Pflicht, d) lebenswichtige Interessen, e) öffentliches Interesse oder öffentliche Gewalt, f) berechtigte Interessen, soweit nicht die Rechte der Betroffenen überwiegen. Lohnabrechnung: Vertrag (b) und rechtliche Pflicht (c). Newsletter: üblicherweise Einwilligung (a). Videoüberwachung eines Eingangsbereichs: gegebenenfalls berechtigtes Interesse (f), das gegen die Rechte der Betroffenen abgewogen werden muss und weitere Vorgaben auslöst; hier ist die Datenschutzbeauftragte einzubeziehen. Das ist eine allgemeine Orientierung, keine Rechtsberatung.

4.  Weitere Rechte: Berichtigung, Löschung, Einschränkung der Verarbeitung, Datenübertragbarkeit, Widerspruch, Schutz vor automatisierten Einzelentscheidungen. Frist: grundsätzlich innerhalb eines Monats nach Eingang, verlängerbar um zwei Monate bei Komplexität, die Verlängerung ist im ersten Monat mitzuteilen. Als Support-Mitarbeiter bestätigen Sie den Eingang, geben die Anfrage umgehend an die zuständige Stelle (Datenschutzbeauftragte) weiter, notieren Eingangsdatum und Frist, prüfen die Identität der Anfragenden über das vorgesehene Verfahren und erteilen nicht selbst Auskünfte.

5.  Pseudonymisierung ersetzt identifizierende Merkmale durch Kennungen; mit zusätzlichen, getrennt aufbewahrten Informationen (Schlüssel, Zuordnungstabelle) lässt sich der Personenbezug wiederherstellen. Anonymisierung entfernt den Personenbezug endgültig, sodass niemand mehr bestimmt werden kann. Pseudonymisierte Daten bleiben personenbezogen, solange eine Zuordnung möglich ist, und unterliegen daher weiter der DSGVO, auch wenn die Pseudonymisierung ein Schutz im Sinn der Sicherheit der Verarbeitung ist.

6.  Beispiellösung:

    ```python
    from datetime import date
    heute = date(2026, 10, 24)
    daten = [
        {"name": "Vertrag A", "frist": date(2025, 1, 1), "sperre": False},
        {"name": "Vertrag B", "frist": date(2025, 1, 1), "sperre": True},
    ]
    for d in daten:
        if d["sperre"]:
            print(d["name"], "-> gesperrt (Legal Hold), nicht loeschen")
        elif d["frist"] < heute:
            print(d["name"], "-> loeschen/pruefen")
        else:
            print(d["name"], "-> aufbewahren")
    ```

    Ergebnis: Vertrag A wird zur Prüfung auf Löschung gemeldet, Vertrag B bleibt trotz abgelaufener Frist gesperrt. Die Prüfung der Sperre steht *vor* der Fristprüfung, sonst würde die Sperre nie greifen.

7.  Beispiellösung:

    ```python
    from datetime import date
    heute = date(2026, 10, 24)
    geraete = [("PC-001", "Windows 11", date(2026, 10, 1)),
               ("PC-002", "Windows 11", date(2026, 5, 20)),
               ("PC-003", "Windows 10", date(2025, 12, 1)),
               ("SRV-01", "Server 2022", date(2026, 7, 1))]
    alt = [(n, os_, (heute - d).days) for n, os_, d in geraete if (heute - d).days > 90]
    for n, os_, tage in sorted(alt, key=lambda x: -x[2]):
        print(f"{n} {os_} letztes Update vor {tage} Tagen")
    ```

    Ausgabe: PC-003 (327 Tage), PC-002 (157 Tage), SRV-01 (115 Tage); PC-001 ist mit 23 Tagen unauffällig. Die Sortierung mit dem Minus ordnet absteigend nach Alter.

8.  Beispiellösung (Ergänzung zum Programm aus 11.7):

    ```python
    def endhash(kette):
        return kette[-1]["hash"]

    gesichert = endhash(k)           # extern ablegen, z. B. ausdrucken oder getrennt speichern
    # Angreifer aendert Eintrag 1 und baut alle Hashes ab dort neu:
    k[1]["was"] = "nichts passiert"
    vor = k[0]["hash"]
    for e in k[1:]:
        e["vorher"] = vor
        inhalt = {x: e[x] for x in ("wer", "was", "zeit", "vorher")}
        e["hash"] = hashlib.sha256(json.dumps(inhalt, sort_keys=True).encode()).hexdigest()
        vor = e["hash"]
    print(pruefen(k))                 # Kette erscheint intakt
    print(endhash(k) == gesichert)    # False -> Faelschung entdeckt
    ```

    Die neu berechnete Kette ist in sich stimmig, deshalb meldet `pruefen` “Kette intakt”; der Endhash weicht aber vom extern gesicherten ab (`False`). Der Schutz entsteht erst durch die externe Ablage des Endhashs, die der Angreifer nicht verändern kann. Der Test setzt voraus, dass der Code aus 11.7 im selben Programm steht, sodass `k`, `hashlib`, `json` und `pruefen` verfügbar sind.

9.  Ursachenanalyse: Wie läuft der Austrittsprozess, wer informiert die IT, gibt es einen Abgleich Personalliste/Konten, ist die Verantwortung klar? Sofortmaßnahmen: Konten sperren (nicht sofort löschen, wegen Aufbewahrung), Zugriffe der letzten Zeit in Protokollen prüfen, Rollen und Gruppen entziehen, Zugangsdaten und Schlüssel, die diese Personen kannten, erneuern, Vorfall dokumentieren. Dauerhaft: Austrittsprozess mit Checkliste und Frist, automatischer Abgleich mit der Personalliste, regelmäßige Rechteprüfung, Ausnahmeregister, Schulung der Beteiligten. Nachweise: Ticket oder Protokoll der Sperrung mit Zeitstempel, aktualisierte Prozessbeschreibung, Ergebnis des Abgleichs, Plan mit Verantwortlichen und Terminen, später ein Prüfergebnis, dass die Maßnahme wirkt.
