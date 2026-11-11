# Modul 10 - Security, Hardening und Secure-by-Design

> **Hinweis zu diesem Kapitel:** Das ist das Kapitel des Skripts „CompTIA Tech+ / ITF+ (FC0-U71): Lernskript in Modulen“, aus der LaTeX-Quelle in Markdown umgewandelt (Text und Listings unverändert, Boxen als Zitatblöcke, Aufgaben und Lösungen als nummerierte Listen). Laut Skript wurden die Python-Beispiele bei der Erstellung im Arbeitsbereich ausgeführt, die gezeigten Ausgaben stammen aus diesen Läufen; Windows- und PowerShell-Befehle wurden nicht ausgeführt. Für dieses Repository wurden die Listings **nicht erneut ausgeführt**. Prüfungsdetails, Produktnamen und Versionen ändern sich; maßgeblich sind die aktuellen Prüfungsziele (Exam Objectives) von CompTIA. Übersicht zum Modul: [README](README.md).

**Dauer:** 8 h

**Priorität:** 1 (höchste)

|  Nr. | Lerneinheit                             | Dauer (h) | Prio |
|-----:|:----------------------------------------|----------:|-----:|
| 10.1 | Bedrohungslandschaft                    |         1 |    1 |
| 10.2 | Ziele der Informationssicherheit        |      0,75 |    1 |
| 10.3 | Authentisierung und Autorisierung       |         1 |    1 |
| 10.4 | Endpoint-Schutz und Hardening           |         1 |    1 |
| 10.5 | Netzwerksicherheit                      |      0,75 |    2 |
| 10.6 | Sichere Daten- und Cloud-Nutzung        |         1 |    1 |
| 10.7 | Security Monitoring und Incident-Basis  |         1 |    2 |
| 10.8 | Secure-by-Design und Security Awareness |       1,5 |    1 |
|      | **Summe**                               |     **8** |      |

Informationssicherheit ist kein einzelnes Produkt, sondern das Zusammenspiel aus Technik, Abläufen und Menschen. Dieses Modul geht vom Überblick über typische Bedrohungen über die Schutzziele und die Zugangskontrolle bis zur Härtung von Geräten, zur Netzwerk- und Datensicherheit, zum Erkennen von Vorfällen und zur Frage, wie man Sicherheit von Anfang an in Systeme und Gewohnheiten einbaut. Die Sicherheitsdomäne macht 19 Prozent der Prüfung aus und ist damit die zweitgrößte; viele Fragen verlangen, ein Szenario einem Schutzziel oder einer Maßnahme zuzuordnen. Die Beispiele sind bewusst *defensiv*: Sie zeigen, wie man Angriffe erkennt, Einstellungen prüft und sicher programmiert, nicht, wie man Systeme angreift. Die Adressen und Namen in den Beispielen sind erfunden oder stammen aus für Dokumentation reservierten Bereichen.

## 10.1 Bedrohungslandschaft

Eine *Bedrohung* (*Threat*) ist ein mögliches Ereignis, das einem Wert schaden kann; eine *Schwachstelle* (*Vulnerability*) ist eine Schwäche, die dieses Ereignis möglich macht; ein *Angriff* nutzt eine Schwachstelle aus. Zur Einordnung hilft die Unterscheidung dreier Dinge, die im Alltag oft vermischt werden: die *Ursache* (zum Beispiel eine nicht eingespielte Sicherheitsaktualisierung oder ein Mitarbeiter, der auf eine gefälschte Nachricht hereinfällt), der *Angriffspfad* (der Weg, den ein Angreifer nimmt: gefälschte E-Mail, Schadsoftware, Ausweitung der Rechte, Zugriff auf Daten) und die *Auswirkung* (verschlüsselte Daten, abgeflossene Kundendaten, Produktionsstillstand). Wer Vorfälle versteht, kann an jeder dieser drei Stellen ansetzen.

Schadsoftware (*Malware*) ist der Oberbegriff für Programme mit schädlicher Absicht. Ein *Virus* hängt sich an Dateien und braucht einen Auslöser, ein *Wurm* verbreitet sich selbstständig über Netze, ein *Trojaner* tarnt sich als nützliches Programm, *Ransomware* verschlüsselt Daten und fordert Lösegeld, *Spyware* spioniert aus, ein *Keylogger* zeichnet Tastatureingaben auf, ein *Rootkit* versteckt sich tief im System, und eine *Backdoor* (Hintertür) schafft einen heimlichen Zugang. Ein *Botnetz* ist ein Verbund gekaperter Geräte, den ein Angreifer fernsteuert, etwa für Überlastungsangriffe (*DDoS*, Distributed Denial of Service), bei denen ein Dienst durch eine Flut von Anfragen unerreichbar wird.

*Social Engineering* ist die Manipulation von Menschen, um an Informationen oder Zugänge zu kommen, und wirkt, weil es die Schwachstelle “Mensch” statt der Technik ausnutzt. *Phishing* ist der Versuch, über gefälschte Nachrichten Zugangsdaten oder Zahlungen zu erschleichen; *Spear-Phishing* ist auf bestimmte Personen zugeschnitten, *Whaling* zielt auf Führungskräfte, *Vishing* läuft per Telefon, *Smishing* per SMS. Beim *Pretexting* erfindet der Angreifer eine glaubwürdige Geschichte (“Hier ist die IT, wir brauchen Ihr Kennwort für ein Update”), beim *Tailgating* schlüpft jemand hinter einer berechtigten Person durch die Tür. Hinzu kommen *Insider-Risiken*: Mitarbeiter oder Dienstleister mit legitimem Zugang, die absichtlich schaden oder durch Unachtsamkeit (verlorener Datenträger, falsch adressierte E-Mail) Schaden verursachen. Auch Technik veraltet: Nicht aktualisierte Systeme, Standardkennwörter, offene Dienste und fehlerhafte Konfigurationen sind verbreitete Schwachstellen. Schließlich gibt es Angriffe über die *Lieferkette*: Wer eine häufig genutzte Software oder einen Dienstleister kompromittiert, erreicht viele Kunden auf einmal.

> **Ergänzung aus der Nachrecherche**
>
> Der Lagebericht der EU-Agentur für Cybersicherheit (ENISA Threat Landscape 2025) wertet nach der Meldung auf enisa.europa.eu (abgerufen) 4 875 Vorfälle aus dem Zeitraum 1. 7. 2024 bis 30. 6. 2025 aus. Demnach war Phishing (einschließlich Vishing, Malspam und Malvertising) in rund 60 Prozent der Fälle der erste Einstiegsweg, die Ausnutzung von Schwachstellen mit 21,3 Prozent der zweite. DDoS-Angriffe machten 77 Prozent der gemeldeten Vorfälle aus, überwiegend von Aktivisten, verursachten aber nur selten Ausfälle; als folgenreichste Bedrohung in der EU wird Ransomware bezeichnet. Die Zahlen beziehen sich auf die EU und auf gemeldete Vorfälle; sie sind eine Momentaufnahme und für die Prüfung nicht auswendig zu lernen. Sie belegen aber, warum Awareness (Abschnitt 10.8) und zeitnahes Patchen (Abschnitt 9.6) zu den wirksamsten Maßnahmen gehören.

Phishing lässt sich oft schon an der Adresse erkennen, wenn man weiß, worauf man achten muss. Entscheidend ist der Teil unmittelbar vor der ersten Pfadangabe, genauer: die *registrierbare Domain*, also die letzten zwei Namensteile des Rechnernamens. In `www.paypal.com` ist das `paypal.com`; in `paypal.com.konto-pruefen.example` dagegen `konto-pruefen.example`, auch wenn “paypal.com” am Anfang steht. Das folgende Programm prüft Adressen nach einigen solcher Regeln; es ist ein Lehrbeispiel und ersetzt weder einen Mailfilter noch Aufmerksamkeit.

```python
from urllib.parse import urlparse
import re

MARKEN = ("paypal", "microsoft", "sparkasse", "amazon")

def verdacht(url):
    teile = urlparse(url)
    host = teile.hostname or ""
    gruende = []
    if teile.scheme != "https":
        gruende.append("kein HTTPS")
    if re.fullmatch(r"\d{1,3}(\.\d{1,3}){3}", host):
        gruende.append("IP-Adresse statt Name")
    if "@" in teile.netloc:
        gruende.append("@ im Adressteil (Name vor dem @ ist nur Tarnung)")
    if host.startswith("xn--") or ".xn--" in host:
        gruende.append("Punycode (moegliche Lookalike-Zeichen)")
    labels = host.split(".")
    domain = ".".join(labels[-2:])
    for marke in MARKEN:
        if marke in host and not domain.startswith(marke + "."):
            gruende.append(f"Markenname '{marke}' ausserhalb der echten Domain")
    if len(labels) > 4:
        gruende.append("sehr viele Subdomains")
    return gruende

for url in ["https://www.paypal.com/signin",
            "http://paypal.com.konto-pruefen.example/login",
            "https://secure-microsoft.login.example.net/a",
            "http://192.0.2.45/bank",
            "https://sparkasse.de@evil.example/anmelden",
            "https://example.org/info"]:
    g = verdacht(url)
    print(("VERDACHT" if g else "unauffaellig"), "|", url)
    for x in g:
        print("    -", x)
```

Die Funktion `urlparse` zerlegt eine Adresse in Schema (`https`), Netzwerkteil und Pfad; `hostname` liefert den Rechnernamen ohne Zugangsdaten und Port. Der erste Test meldet fehlendes HTTPS, der zweite eine reine IP-Adresse (seriöse Anbieter verwenden Namen), der dritte ein At-Zeichen im Netzwerkteil: Bei `https://sparkasse.de@evil.example/` ist `sparkasse.de` nur ein vorgetäuschter Benutzername, der tatsächliche Rechner ist `evil.example`. Der vierte Test erkennt Punycode, eine Schreibweise, in der Namen mit Sonderzeichen kodiert sind und die für optisch ähnliche Fälschungen missbraucht wird. Der Markentest bestimmt die registrierbare Domain als letzte zwei Namensteile und prüft, ob sie mit dem Markennamen beginnt; dadurch ist `www.paypal.com` unauffällig, aber `paypal.com.konto-pruefen.example` und `secure-microsoft.login.example.net` sind es nicht. Die Ausgabe markiert vier der sechs Adressen als verdächtig. Das Verfahren ist absichtlich einfach und hat Grenzen: Länderendungen mit zwei Teilen (`.co.uk`) bräuchten eine Liste, und kluge Angreifer registrieren Domains, die keine dieser Regeln auslösen.

### Typische Fehler.

Falsch ist die Haltung “Mich trifft es nicht, wir sind zu klein”: Viele Angriffe laufen automatisiert und treffen wahllos. Falsch ist auch, nur auf das Schloss-Symbol im Browser zu achten: Es bedeutet nur, dass die Verbindung verschlüsselt ist, nicht, dass der Betreiber vertrauenswürdig ist; auch Betrüger nutzen HTTPS. Falsch ist, Absendernamen zu trauen: Angezeigter Name und tatsächliche Adresse sind zwei verschiedene Dinge. Ebenso gefährlich ist, bei Dringlichkeit und Drohung (“Ihr Konto wird in 24 Stunden gesperrt”) zu schnell zu klicken; Druck ist ein typisches Merkmal.

### Praxisbezug.

Im Büroalltag erreichen Mitarbeitende täglich Mails mit Links und Anhängen. Wer sie prüft, hält den Mauszeiger über den Link, liest die echte Adresse, ruft im Zweifel das Portal über das Lesezeichen und nicht über den Link auf und meldet Verdächtiges über den vorgesehenen Weg (Abschnitt 10.7). Im Support begegnet man außerdem Anrufen von “angeblichen Kollegen”, die Kennwörter erfragen; die Regel lautet: Kennwörter gibt niemand am Telefon heraus, auch nicht an die IT.

> **Merke**
>
> Ursache, Angriffspfad, Auswirkung trennen. Malware-Arten: Virus, Wurm, Trojaner, Ransomware, Spyware, Keylogger, Rootkit, Backdoor. Social Engineering: Phishing, Spear-Phishing, Vishing, Smishing, Pretexting, Tailgating. Auch Insider und Lieferkette sind Risiken. Das Schloss im Browser heißt nur “verschlüsselt”.

## 10.2 Ziele der Informationssicherheit

Das Grundgerüst der Informationssicherheit sind drei Schutzziele, die man im Englischen als *CIA-Triade* kennt (nicht zu verwechseln mit dem Geheimdienst). *Vertraulichkeit* (*Confidentiality*) bedeutet, dass nur Berechtigte Informationen einsehen können; Maßnahmen sind Zugriffsrechte, Verschlüsselung und Klassifizierung. *Integrität* (*Integrity*) bedeutet, dass Daten und Systeme korrekt und unverändert bleiben, oder dass Änderungen zumindest erkannt werden; Maßnahmen sind Prüfsummen, digitale Signaturen, Versionierung, Berechtigungen für Schreibzugriffe und Protokollierung. *Verfügbarkeit* (*Availability*) bedeutet, dass Informationen und Dienste dann nutzbar sind, wenn man sie braucht; Maßnahmen sind Redundanz, Datensicherung, Wartung und Schutz vor Überlastung. Oft kommen weitere Ziele hinzu: *Authentizität* (Echtheit der Herkunft), *Nachvollziehbarkeit* bzw. *Nichtabstreitbarkeit* (wer hat was getan) und *Zurechenbarkeit*.

Die Prüfung verlangt, ein Ereignis dem verletzten Ziel zuzuordnen. Ein gestohlener Laptop mit unverschlüsselten Kundendaten verletzt die *Vertraulichkeit*. Eine Mitarbeiterin, die versehentlich Preise in der Preisliste überschreibt, verletzt die *Integrität*. Ein Erpressungstrojaner, der den Dateiserver verschlüsselt, trifft die *Verfügbarkeit* (und je nach Fall auch die Vertraulichkeit, wenn er Daten vorher kopiert). Wichtig ist, dass Ziele in Konflikt geraten können: Sehr strenge Zugangskontrolle erhöht die Vertraulichkeit, kann aber die Verfügbarkeit senken, wenn im Notfall niemand an die Daten kommt. Sicherheit bedeutet deshalb Abwägen, und die Entscheidung richtet sich nach dem Wert der Information.

Das Wort *Risiko* fasst Bedrohung und Folgen zusammen. Üblich ist eine einfache Bewertung: Risiko ergibt sich aus der *Eintrittswahrscheinlichkeit* und der *Schwere der Auswirkung*. Je höher beide, desto höher das Risiko. Man kann mit Risiken auf vier Arten umgehen: *vermeiden* (auf die riskante Tätigkeit verzichten), *verringern* (Schutzmaßnahmen einführen), *übertragen* (versichern oder auslagern) oder *akzeptieren* (bewusst tragen, weil Aufwand und Nutzen nicht passen). Das Restrisiko nach den Maßnahmen bleibt immer; es gibt keine hundertprozentige Sicherheit.

Das folgende Programm zeigt beide Seiten. Im ersten Teil wird Integrität mit einer Prüfsumme (einem *Hash*) und einer geheimen Prüfmarke (*HMAC*) demonstriert: Ändert sich ein Zeichen, ändert sich die Prüfsumme völlig. Im zweiten Teil werden vier Risiken nach Wahrscheinlichkeit mal Auswirkung sortiert.

```python
import hashlib, hmac

def pruefsumme(daten):
    return hashlib.sha256(daten).hexdigest()

original = b"Gehaltsliste 2026: Anna 3000, Bernd 3200"
manipuliert = b"Gehaltsliste 2026: Anna 3000, Bernd 9200"
print(pruefsumme(original)[:16], pruefsumme(manipuliert)[:16])
print("unveraendert:", pruefsumme(original) == pruefsumme(original))

SCHLUESSEL = b"geheim"
marke = hmac.new(SCHLUESSEL, original, hashlib.sha256).hexdigest()
print("HMAC passt zu Original  :",
      hmac.compare_digest(marke, hmac.new(SCHLUESSEL, original, hashlib.sha256).hexdigest()))
print("HMAC passt zu Faelschung:",
      hmac.compare_digest(marke, hmac.new(SCHLUESSEL, manipuliert, hashlib.sha256).hexdigest()))

risiken = [("Laptop mit Kundendaten wird gestohlen", 3, 4, "Vertraulichkeit"),
           ("Erpressungstrojaner verschluesselt Fileserver", 2, 5, "Verfuegbarkeit"),
           ("Mitarbeiter ueberschreibt Preisliste", 4, 2, "Integritaet"),
           ("Drucker faellt aus", 4, 1, "Verfuegbarkeit")]
def stufe(w):
    return "hoch" if w >= 10 else "mittel" if w >= 5 else "niedrig"
for text, wahrsch, auswirkung, ziel in sorted(risiken, key=lambda r: -r[1] * r[2]):
    w = wahrsch * auswirkung
    print(f"{w:2} {stufe(w):8} {ziel:15} {text}")
```

Die Funktion `pruefsumme` berechnet einen SHA-256-Hash: eine Zahl fester Länge, die sich bei jeder noch so kleinen Änderung der Daten stark ändert. Die ersten 16 Zeichen beider Texte sind völlig verschieden (`048d264702517367` und `f753ac2d1ca39dde`), obwohl sich nur eine Ziffer unterscheidet (3200 gegen 9200). Wer die Prüfsumme des Originals an einem sicheren Ort aufbewahrt, kann jede Änderung erkennen. Ein einfacher Hash hat aber eine Schwäche: Ein Angreifer, der die Daten ändert, kann auch den Hash neu berechnen. Deshalb gibt es den *HMAC*, bei dem ein geheimer Schlüssel in die Berechnung eingeht; ohne den Schlüssel kann niemand eine passende Marke für die Fälschung erzeugen, und das Programm zeigt `True` für das Original und `False` für die Fälschung. Die Funktion `compare_digest` vergleicht in gleichbleibender Zeit, damit ein Angreifer aus der Antwortzeit nichts ableiten kann. Der zweite Teil multipliziert Wahrscheinlichkeit (1 bis 5) und Auswirkung (1 bis 5): Der Laptop-Diebstahl erreicht 12 (hoch), der Erpressungstrojaner 10 (hoch), die überschriebene Preisliste 8 (mittel) und der Druckerausfall 4 (niedrig). Man sieht, dass ein seltenes, aber folgenschweres Ereignis (Trojaner) mit einem häufigen, harmlosen (Drucker) verglichen werden kann. Die Skalen und Grenzen sind Beispielwerte; jede Organisation legt ihre eigenen fest.

### Typische Fehler.

Falsch ist, Sicherheit mit Geheimhaltung gleichzusetzen: Verfügbarkeit und Integrität sind genauso wichtig, und für ein Krankenhaus ist ein ausgefallenes System oft gefährlicher als ein bekanntgewordenes Dokument. Falsch ist, alles gleich stark schützen zu wollen: Das ist teuer und führt dazu, dass wichtige Dinge nicht besser geschützt sind als unwichtige. Falsch ist auch, ein Risiko “wegzurechnen”: Wer “geringe Wahrscheinlichkeit” sagt und die Auswirkung (Existenzbedrohung) ignoriert, bewertet einseitig. Bei der Zuordnung in der Prüfung ist ein häufiger Fehler, den Auslöser statt der Folge zu bewerten; entscheidend ist, *was* am Ende beeinträchtigt wurde.

### Praxisbezug.

Bei jeder neuen Software oder jedem neuen Prozess fragt man, was schiefgehen kann und welches Ziel betroffen ist. Eine Lohnbuchhaltung braucht hohe Vertraulichkeit und Integrität, ein Webshop hohe Verfügbarkeit, ein Zeiterfassungsterminal vor allem Integrität (richtige Zeiten). Prüfsummen begegnen einem beim Herunterladen von Installationsdateien: Der Anbieter nennt den Hash, und man vergleicht ihn mit dem der heruntergeladenen Datei.

> **Merke**
>
> CIA: Vertraulichkeit (nur Berechtigte), Integrität (unverändert), Verfügbarkeit (nutzbar). Risiko = Wahrscheinlichkeit $\times$ Auswirkung. Behandlung: vermeiden, verringern, übertragen, akzeptieren. Hash erkennt Änderung, HMAC schützt zusätzlich vor Neuberechnung durch Fremde.

## 10.3 Authentisierung und Autorisierung

Bevor ein System jemandem etwas erlaubt, muss es zwei Fragen klären. Die erste lautet: *Wer bist du?* Das ist die *Authentisierung* (die Person weist ihre Identität nach) beziehungsweise die *Authentifizierung* (das System prüft diesen Nachweis); im Englischen *Authentication*. Die zweite lautet: *Was darfst du?* Das ist die *Autorisierung* (*Authorization*), die Zuweisung und Prüfung von Rechten. Eine dritte Frage, die Nachvollziehbarkeit, wird in der Praxis oft dazugezählt: *Was hast du getan?* Dafür steht das englische Wort *Accounting* oder Auditing; zusammen heißt das Dreigespann *AAA*. Die Reihenfolge ist wichtig: Erst wird die Identität geklärt, dann werden Rechte vergeben; ohne verlässliche Authentisierung ist jede Autorisierung wertlos.

Zur Authentisierung gibt es drei klassische *Faktoren*. Etwas, das man *weiß* (Passwort, PIN), etwas, das man *hat* (Smartphone, Chipkarte, Sicherheitsschlüssel), und etwas, das man *ist* (Fingerabdruck, Gesicht, Iris: *Biometrie*). Die *Multi-Faktor-Authentifizierung* (MFA) verlangt mindestens zwei *verschiedene* Faktoren; zwei Passwörter sind keine MFA. Sie hilft vor allem gegen den häufigsten Angriff überhaupt, gestohlene oder erratene Passwörter, weil der Angreifer den zweiten Faktor nicht besitzt. Die Faktoren sind unterschiedlich stark: Ein per SMS gesendeter Code ist besser als nichts, kann aber durch Übernahme der Rufnummer oder gefälschte Anmeldeseiten abgegriffen werden; Codes aus einer Authentifizierungs-App (*TOTP*, zeitbasierte Einmalpasswörter) sind stärker, und Sicherheitsschlüssel nach FIDO2 (*Passkeys*) sind besonders widerstandsfähig gegen Phishing, weil sie nur gegenüber der echten Webseite funktionieren. Biometrie ist bequem, aber nicht änderbar: Ein kompromittierter Fingerabdruck lässt sich nicht “zurücksetzen”.

Passwörter bleiben der häufigste Faktor, und der Umgang mit ihnen hat sich gewandelt. Entscheidend ist die *Länge* und *Unvorhersehbarkeit*, nicht die Zahl von Sonderzeichen. Die Stärke lässt sich als *Entropie* in Bit schätzen: Bei zufälliger Wahl aus einem Zeichenvorrat der Größe $n$ ergibt ein Passwort der Länge $L$ ungefähr $L \cdot \log_2 n$ Bit. Jedes zusätzliche Bit verdoppelt den Aufwand beim Durchprobieren. Wichtig: Diese Rechnung gilt nur für wirklich zufällig gewählte Zeichen. Menschen wählen vorhersehbar (Namen, Jahreszahlen, “Passwort1!”), und Angreifer probieren zuerst Wörterbücher und bekannte Kombinationen. Systeme sollten Passwörter nie im Klartext speichern, sondern als *Hash mit Salz*: Das *Salz* (*Salt*) ist ein zufälliger Zusatz je Benutzer, der dafür sorgt, dass gleiche Passwörter verschiedene Hashes ergeben und vorberechnete Tabellen nutzlos sind; ein langsames Verfahren (*Key Derivation Function*) mit vielen Wiederholungen bremst das Raten.

> **Ergänzung aus der Nachrecherche**
>
> Moderne Empfehlungen weichen von älteren Gewohnheiten ab. Laut einer Zusammenfassung der NIST-Richtlinie SP 800-63B (aus der englischsprachigen Wikipedia-Seite “Password policy”, abgerufen; Drittquelle) sollen Dienste in der aktuellen Fassung (Revision 4) *keine* Zusammensetzungsregeln wie “ein Sonderzeichen, eine Ziffer” erzwingen, Passwörter *nicht willkürlich oder regelmäßig* ändern lassen, vom Nutzer gewählte Passwörter mit mindestens 64 Zeichen zulassen und schwache oder bekannt gewordene Passwörter ablehnen; die Mindestlänge wird dort mit 15 Zeichen angegeben. Der genaue Geltungsbereich (zum Beispiel, wenn das Passwort der einzige Faktor ist) ist im Original nachzulesen, das ich nicht abgerufen habe. Die Kernaussage für die Praxis: lange Passphrasen statt komplizierter Kürzel, ein Passwortmanager statt Wiederverwendung, MFA wo immer möglich, Wechsel nur bei Verdacht auf Kompromittierung.

Die Autorisierung folgt nach der Anmeldung. Das Prinzip der *geringsten Rechte* (*Least Privilege*) besagt, dass jede Person und jedes Programm nur die Rechte erhält, die für die Aufgabe nötig sind, und nicht mehr. Dazu kommt *Need-to-know*: Wer Informationen nicht braucht, bekommt sie nicht. Umsetzen lässt sich das mit *Rollen* (*Role-Based Access Control*, RBAC): Statt jedem Einzelnen Rechte zu geben, definiert man Rollen wie “Buchhaltung” oder “Support” und ordnet Personen zu. Beim Eintritt, bei Wechsel der Aufgabe und beim Austritt werden Rechte angepasst; ein häufiger Mangel sind Rechte, die sich bei jedem Wechsel ansammeln, das sogenannte *Privilege Creep*. Privilegierte Konten (Administratoren) trennt man vom Alltagskonto, setzt MFA ein und protokolliert ihre Aktionen. Ein weiteres Grundprinzip ist die *Aufgabentrennung*: Kritische Vorgänge (zum Beispiel Rechnung freigeben und Zahlung auslösen) soll nicht dieselbe Person allein ausführen.

Das folgende Programm zeigt in vier Teilen die Bausteine: die Entropie-Schätzung, das sichere Speichern eines Passworts mit Salz und dem Verfahren PBKDF2, die Wirkung des Salzes und die Erzeugung von Einmalcodes nach dem Standard für zeitbasierte Einmalpasswörter (RFC 6238). Den Einmalcode prüft das Programm mit einem Testwert aus dem Standard selbst: Mit dem Geheimnis `12345678901234567890` und der Zeit 59 Sekunden muss der achtstellige Code `94287082` entstehen.

```python
import hashlib, hmac, math, os, struct

def entropie_bit(laenge, zeichenvorrat):
    return laenge * math.log2(zeichenvorrat)
for name, laenge, vorrat in [("8 Kleinbuchstaben", 8, 26), ("8 Zeichen gemischt", 8, 94),
                              ("4 Zufallswoerter (Liste 7776)", 4, 7776),
                              ("16 Kleinbuchstaben", 16, 26)]:
    print(f"{name:32} ca. {entropie_bit(laenge, vorrat):5.1f} Bit")

def hashe(passwort, salz=None, runden=200_000):
    salz = salz or os.urandom(16)
    h = hashlib.pbkdf2_hmac("sha256", passwort.encode(), salz, runden)
    return salz, runden, h
def pruefe(passwort, salz, runden, h):
    return hmac.compare_digest(
        hashlib.pbkdf2_hmac("sha256", passwort.encode(), salz, runden), h)
salz, runden, h = hashe("Kaffee-Tasse-7-Wolke")
print(pruefe("Kaffee-Tasse-7-Wolke", salz, runden, h),
      pruefe("kaffee-tasse-7-wolke", salz, runden, h))
print("gleiches Passwort, gleicher Hash?", hashe("gleich")[2] == hashe("gleich")[2])

def totp(secret, zeit, stellen=6, schritt=30, algo=hashlib.sha1):
    zaehler = int(zeit) // schritt
    mac = hmac.new(secret, struct.pack(">Q", zaehler), algo).digest()
    offset = mac[-1] & 0x0F
    code = (struct.unpack(">I", mac[offset:offset + 4])[0] & 0x7FFFFFFF) % 10 ** stellen
    return str(code).zfill(stellen)
geheim = b"12345678901234567890"
print(totp(geheim, 59, 8), totp(geheim, 59, 6))
```

Die Entropie-Tabelle zeigt, dass die Länge die Hauptrolle spielt: Acht zufällige Kleinbuchstaben ergeben rund 37,6 Bit, acht zufällige Zeichen aus allen 94 druckbaren ASCII-Zeichen 52,4 Bit, vier zufällig gezogene Wörter aus einer Liste mit 7 776 Einträgen (Würfelverfahren) 51,7 Bit, und sechzehn zufällige Kleinbuchstaben sogar 75,2 Bit. Eine Passphrase aus vier Zufallswörtern ist also so stark wie ein achtstelliges Kauderwelsch, aber leicht zu merken. Der zweite Teil speichert ein Passwort: `os.urandom(16)` liefert 16 zufällige Bytes als Salz, und `pbkdf2_hmac` rechnet 200 000 Wiederholungen, damit jeder Rateversuch teuer wird. Die Prüfung vergleicht das Ergebnis mit dem gespeicherten Hash; das richtige Passwort liefert `True`, dieselbe Eingabe in anderer Schreibweise `False`. Das Salz bewirkt, dass “gleich” zweimal gehasht zu verschiedenen Ergebnissen führt (`False`); in der Datenbank speichert man Salz, Rundenzahl und Hash. Die Rundenzahl ist ein Beispielwert; Empfehlungen ändern sich mit der Rechenleistung, und neue Systeme verwenden häufig spezialisierte Verfahren wie Argon2 oder bcrypt. Der letzte Teil implementiert die Berechnung nach RFC 6238: Die Zeit wird durch 30 Sekunden geteilt (Zähler), mit dem Geheimnis per HMAC-SHA1 verrechnet, aus dem Ergebnis werden vier Byte an einer variablen Stelle (Offset) entnommen und auf die gewünschte Stellenzahl gekürzt. Das Programm gibt `94287082` und `287082` aus: Der achtstellige Wert stimmt mit dem Testvektor des Standards überein. Eine Authentifizierungs-App rechnet genauso, mit der aktuellen Uhrzeit; das gemeinsame Geheimnis wird einmal per QR-Code übertragen.

### Typische Fehler.

Falsch ist, dasselbe Passwort für mehrere Dienste zu verwenden: Wird einer gehackt, fallen alle. Falsch ist, Passwörter im Klartext oder mit einem schnellen, ungesalzenen Hash (etwa einfachem MD5) zu speichern; erbeutete Datenbanken werden dann in Minuten geknackt. Falsch ist, Administratorrechte dauerhaft für die tägliche Arbeit zu verwenden, oder Standardkonten wie `admin/admin` unverändert zu lassen. Falsch ist, Rechte beim Austritt oder Wechsel nicht zu entziehen. Und falsch ist, MFA-Codes weiterzugeben: Kein Mitarbeiter der IT fragt nach ihnen; wer nach einem Code fragt, ist mit großer Wahrscheinlichkeit ein Angreifer, der gerade Ihre Anmeldung nachspielt.

### Praxisbezug.

Beim Anlegen eines neuen Benutzers legt die IT das Konto nach einer Rollenvorlage an, aktiviert MFA und weist ein Startkennwort mit Zwang zur Änderung zu. Bei einer Rückfrage “Ich komme nicht in den Ordner der Buchhaltung” prüft der Support nicht nur Technik, sondern auch, ob die Person laut Rolle überhaupt berechtigt ist und wer die Freigabe erteilen darf. Passwortmanager (zum Beispiel in Unternehmen zentral bereitgestellt) lösen das Problem vieler langer Passwörter.

> **Merke**
>
> Authentisierung = Identität nachweisen, Autorisierung = Rechte prüfen, Accounting = Nachvollziehbarkeit. Faktoren: Wissen, Besitz, Sein. MFA = mindestens zwei *verschiedene* Faktoren. Passwörter: lang, einzigartig, gesalzen gehasht. Least Privilege, Rollen (RBAC), Aufgabentrennung.

## 10.4 Endpoint-Schutz und Hardening

Als *Endpoint* bezeichnet man jedes Endgerät, mit dem Menschen arbeiten: Notebooks, Desktop-PCs, Smartphones, Tablets. Sie sind das häufigste Einfallstor, weil dort E-Mails geöffnet, Webseiten besucht und Dateien heruntergeladen werden. Der *Endpoint-Schutz* besteht aus mehreren Schichten, die sich ergänzen (*Defense in Depth*, gestaffelte Verteidigung: Fällt eine Schicht aus, fängt die nächste auf). Ein *Virenschutz* (*Antivirus*, AV) erkennt bekannte Schadsoftware anhand von Signaturen und bestimmten Verhaltensmustern. *EDR* (*Endpoint Detection and Response*) geht weiter: Es beobachtet das Verhalten auf dem Gerät laufend, erkennt auffällige Abläufe (zum Beispiel ein Office-Programm, das plötzlich Skripte startet und Dateien massenhaft verschlüsselt), meldet sie zentral und erlaubt, das Gerät aus der Ferne zu isolieren. Die *Personal Firewall* filtert den Netzwerkverkehr des Geräts nach Regeln. Die *Laufwerksverschlüsselung* (unter Windows BitLocker, unter macOS FileVault, unter Linux LUKS) schützt Daten, wenn das Gerät verloren geht oder gestohlen wird; ohne Schlüssel sind die Daten unlesbar. Dazu kommen Updates (Abschnitt 9.6), eine automatische Bildschirmsperre und die Möglichkeit, verlorene Geräte aus der Ferne zu sperren oder zu löschen (*Mobile Device Management*).

*Hardening* (Härtung) bedeutet, ein System durch Verkleinern der Angriffsfläche widerstandsfähiger zu machen. Der Grundgedanke: Jeder laufende Dienst, jedes installierte Programm, jedes offene Netzwerkpaket und jedes Standardkonto ist eine mögliche Schwachstelle. Wer nicht Benötigtes entfernt oder abschaltet, hat weniger Fläche zu verteidigen und weniger zu aktualisieren. Typische Härtungsmaßnahmen sind: nicht benötigte Dienste und Funktionen deaktivieren (etwa das veraltete Dateifreigabe-Protokoll SMBv1, nicht benötigte Fernzugänge), Standardkonten und Standardkennwörter ändern oder entfernen, Gastkonto abschalten, starke Passwortregeln und Kontosperre bei Fehlversuchen einrichten, die Firewall aktivieren, Updates automatisieren, Laufwerke verschlüsseln, den Bildschirm nach kurzer Zeit sperren, Wechseldatenträger kontrollieren und Benutzer nicht mit Administratorrechten arbeiten lassen. Eine *Baseline* (Basiskonfiguration) legt für alle Geräte einer Klasse die Soll-Einstellungen fest; öffentlich verfügbare Vorgaben gibt es zum Beispiel vom Center for Internet Security (CIS Benchmarks) oder vom Bundesamt für Sicherheit in der Informationstechnik. Die Einhaltung wird regelmäßig geprüft, weil sich Systeme durch Eingriffe und Updates von der Baseline entfernen (*Konfigurationsdrift*, siehe Modul 12).

Das folgende Programm prüft zwei Geräte gegen eine Baseline. Die Baseline enthält acht Einstellungen mit Sollwerten; bei zwei davon (Sperrzeit und Passwortlänge) reicht es, wenn der Istwert besser als der Sollwert ist. Das Programm gibt je Gerät eine Konformitätsquote und die Abweichungen aus.

```python
BASELINE = {"firewall_aktiv": True, "laufwerk_verschluesselt": True,
            "bildschirmsperre_min": 10, "auto_updates": True, "gast_konto": False,
            "smb1": False, "rdp_offen_internet": False, "min_passwortlaenge": 12}

def erfuellt(name, ist, soll):
    if name == "bildschirmsperre_min":
        return ist <= soll
    if name == "min_passwortlaenge":
        return ist >= soll
    return ist == soll

geraete = {
    "NB-0815": {"firewall_aktiv": True, "laufwerk_verschluesselt": True,
                "bildschirmsperre_min": 5, "auto_updates": True, "gast_konto": False,
                "smb1": False, "rdp_offen_internet": False, "min_passwortlaenge": 14},
    "PC-Lager": {"firewall_aktiv": False, "laufwerk_verschluesselt": False,
                 "bildschirmsperre_min": 60, "auto_updates": True, "gast_konto": True,
                 "smb1": True, "rdp_offen_internet": False, "min_passwortlaenge": 6},
}
for geraet, ist in geraete.items():
    abweichungen = [n for n, soll in BASELINE.items() if not erfuellt(n, ist[n], soll)]
    quote = 100 * (len(BASELINE) - len(abweichungen)) / len(BASELINE)
    print(f"{geraet}: {quote:.0f} % konform", abweichungen or "")
```

Die Funktion `erfuellt` vergleicht je nach Einstellung auf Gleichheit oder auf “höchstens” (Sperrzeit: kürzer ist besser) beziehungsweise “mindestens” (Passwortlänge: länger ist besser). Für jedes Gerät wird eine Liste der abweichenden Einstellungen gebildet; die Quote ist der Anteil der erfüllten Einstellungen. Das Notebook `NB-0815` erfüllt alle acht (100 Prozent), obwohl seine Sperrzeit mit 5 Minuten kürzer und seine Passwortlänge mit 14 größer ist als gefordert. Der Lager-PC erfüllt nur zwei von acht (25 Prozent): Firewall aus, Laufwerk unverschlüsselt, Bildschirmsperre erst nach 60 Minuten, Gastkonto aktiv, SMBv1 an und eine Passwortlänge von nur 6. Das Beispiel zeigt, dass Hardening überprüfbar sein muss: Eine Liste erlaubt eine objektive Aussage statt eines Bauchgefühls. Echte Prüfungen lesen die Werte aus dem System aus (Registry, Gruppenrichtlinien, Verwaltungswerkzeuge); hier sind sie der Übersicht halber vorgegeben.

### Typische Fehler.

Falsch ist, sich auf eine einzige Schutzmaßnahme zu verlassen (“Wir haben ja Virenschutz”), und ebenso, Schutzprogramme aus Bequemlichkeit zu deaktivieren, weil sie ein Programm “stören”; die Ausnahme sollte gezielt und dokumentiert sein. Falsch ist, Hardening einmalig bei der Installation durchzuführen und danach nie zu prüfen. Falsch ist, Firewall-Regeln “zum Testen” zu öffnen und nie wieder zu schließen. Auch gern gemacht: Notebook-Verschlüsselung ohne Sicherung des Wiederherstellungsschlüssels; geht dann die Anmeldung verloren, sind die Daten für immer weg.

### Praxisbezug.

Beim Einrichten eines neuen Arbeitsplatzes folgt der Support einer Checkliste: Updates installieren, Verschlüsselung aktivieren und den Wiederherstellungsschlüssel zentral hinterlegen, Firewall und Virenschutz prüfen, Standardkonten entfernen, Standardbenutzer ohne Administratorrechte anlegen. Bei einem verlorenen Notebook ist die erste Frage: War es verschlüsselt? Wenn ja, ist der Vorfall deutlich weniger schlimm.

## 10.5 Netzwerksicherheit

Ein Netzwerk ist so sicher wie sein schwächster Zugang. Die Grundregel der Netzwerksicherheit lautet “nichts erlauben, was nicht gebraucht wird”. Zentrales Werkzeug ist die *Firewall*, die Datenverkehr nach Regeln zulässt oder blockiert. Die Regeln beschreiben, welche Quelle zu welchem Ziel auf welchem Port und mit welchem Protokoll sprechen darf; sie werden in der Reihenfolge geprüft, die *erste passende Regel* gewinnt, und am Ende steht eine Standardregel, idealerweise “alles andere verbieten” (*Default Deny*). Eine *Zustandsüberwachung* (*Stateful Inspection*) merkt sich bestehende Verbindungen, sodass Antworten auf erlaubte Anfragen automatisch durchgelassen werden. Dahinter stehen weitere Maßnahmen: *Segmentierung* teilt ein Netz in getrennte Bereiche (Büro, Server, Gäste, Produktion, Geräte des “Internets der Dinge”), sodass ein Einbruch nicht automatisch das ganze Unternehmen erfasst; technisch erfolgt das mit Teilnetzen und *VLANs* (Modul 4). Eine *DMZ* (demilitarisierte Zone) ist ein abgetrennter Bereich für Dienste, die aus dem Internet erreichbar sein müssen, etwa ein Webserver; er ist vom internen Netz getrennt, damit ein Angriff auf den Webserver nicht direkt ins Innere führt.

Der Schutz des Drahtlosnetzes beginnt bei der Verschlüsselung: WPA3 (oder WPA2 mit einem langen, zufälligen Kennwort) statt offener Netze oder des veralteten WEP; das Verwaltungskennwort des WLAN-Routers wird geändert, Funktionen wie WPS (Anmeldung per Tastendruck oder PIN) werden abgeschaltet, Gäste bekommen ein eigenes Netz (Modul 4, Abschnitt 4.6). Ein *VPN* (*Virtual Private Network*) baut über das Internet einen verschlüsselten Tunnel zwischen Gerät und Firmennetz auf und schützt so die Daten unterwegs, etwa im Homeoffice oder im Hotel-WLAN. Wichtig ist auch die Wahl sicherer Protokolle: HTTPS statt HTTP, SSH statt Telnet, SFTP oder FTPS statt FTP, SMTPS/IMAPS statt unverschlüsselter Mailprotokolle (Ports und Protokolle: Modul 4, Abschnitt 4.5). Unverschlüsselte Protokolle übertragen Zugangsdaten im Klartext, sodass jeder im Netz mitlesen kann.

Offene Netze, wie sie in Cafés, Hotels oder an Flughäfen üblich sind, bergen besondere Risiken. Der Datenverkehr kann mitgelesen werden (*Sniffing*), sofern er nicht durch HTTPS oder VPN geschützt ist; Angreifer können gefälschte Zugangspunkte mit bekanntem Namen aufstellen (*Evil Twin*) und den Verkehr dazwischenschalten (*Man-in-the-Middle*); andere Geräte im selben Netz können nach offenen Diensten suchen. Gegenmaßnahmen sind VPN, nur HTTPS-Seiten zu verwenden, die automatische Verbindung zu bekannten Netzen abzuschalten, Dateifreigaben zu deaktivieren und bei sensiblen Vorgängen das mobile Datennetz zu benutzen. Das Risiko hängt vom Zweck ab: Ein Blick in die Wetterkarte ist harmlos, die Anmeldung im Firmenportal ohne VPN nicht.

Das folgende Programm wertet eine Firewall-Regelliste nach dem Prinzip “erste passende Regel gewinnt, sonst Default Deny” aus. Es verwendet das Modul `ipaddress`, um zu prüfen, ob eine Quelladresse in einem Netzbereich liegt. Das Beispiel schützt einen Server (10.0.5.10): Aus dem Büronetz sind HTTPS und SSH erlaubt, aus dem Internet nur HTTPS.

```python
import ipaddress

REGELN = [
    ("erlaube",   "10.0.0.0/24", "10.0.5.10", 443, "tcp"),
    ("erlaube",   "10.0.0.0/24", "10.0.5.10", 22,  "tcp"),
    ("blockiere", "0.0.0.0/0",   "10.0.5.10", 22,  "tcp"),
    ("erlaube",   "0.0.0.0/0",   "10.0.5.10", 443, "tcp"),
]

def entscheide(quelle, ziel, port, proto):
    for aktion, qnetz, zielip, zport, zproto in REGELN:
        if (ipaddress.ip_address(quelle) in ipaddress.ip_network(qnetz)
                and ziel == zielip and port == zport and proto == zproto):
            return aktion, (aktion, qnetz, zielip, zport)
    return "blockiere", "Standardregel (alles andere verboten)"

for quelle, port in [("10.0.0.7", 22), ("203.0.113.9", 22),
                     ("203.0.113.9", 443), ("203.0.113.9", 3389)]:
    print(quelle, "->10.0.5.10:" + str(port), "=>", entscheide(quelle, "10.0.5.10", port, "tcp"))
```

Die Regelliste wird von oben nach unten durchsucht; jede Regel besteht aus Aktion, Quellnetz, Zieladresse, Zielport und Protokoll. `ipaddress.ip_address(quelle) in ipaddress.ip_network(qnetz)` prüft die Zugehörigkeit zu einem Netzbereich; `0.0.0.0/0` steht für “jede Adresse”. Die Ergebnisse: Der Büro-Rechner 10.0.0.7 darf per SSH (Port 22) zugreifen, weil die zweite Regel greift; der Internet-Rechner 203.0.113.9 wird auf Port 22 von der dritten Regel blockiert, darf aber auf Port 443 zugreifen (vierte Regel), und für Port 3389 (Remotedesktop) trifft keine Regel zu, sodass die Standardregel blockiert. Die Reihenfolge ist entscheidend: Stünde die Regel “blockiere 0.0.0.0/0 Port 22” an erster Stelle, würde sie auch den Büro-Rechner aussperren. Genau solche Fehler passieren in der Praxis, und deshalb legt man Ausnahmen (“erlaube”) vor allgemeine Verbote und testet Regeländerungen.

### Typische Fehler.

Falsch ist, Verwaltungszugänge (SSH, Remotedesktop, Webkonsole des Routers) offen ins Internet zu stellen; solche Dienste werden rund um die Uhr automatisch angegriffen (Abschnitt 10.7 zeigt die Erkennung). Falsch ist eine Firewall nach dem Prinzip “alles erlaubt, bestimmte Dinge verboten”: Man kann nie alle Gefahren aufzählen, deshalb gilt Default Deny. Falsch ist, das Gastnetz und das Firmennetz ungetrennt zu betreiben, oder IoT-Geräte (Kameras, Drucker, smarte Geräte) ins Hauptnetz zu stellen, denn sie werden selten aktualisiert. Falsch ist auch, einem VPN blind zu vertrauen: Es schützt den Weg, nicht das Ziel oder das Gerät selbst; und kostenlose VPN-Dienste unbekannter Anbieter verlagern das Vertrauen nur auf deren Betreiber.

### Praxisbezug.

Der Support richtet für Außendienstmitarbeiter einen VPN-Zugang ein, überprüft nach einem Umzug die Firewall-Regeln und erklärt Gästen im Besprechungsraum, dass es ein eigenes Gäste-WLAN gibt. Fragen der Art “Warum erreicht der Kollege vom Homeoffice den Server nicht?” führen oft auf eine VPN- oder Firewall-Regel zurück.

## 10.6 Sichere Daten- und Cloud-Nutzung

Nicht alle Daten sind gleich schützenswert, und deshalb beginnt der sichere Umgang mit *Klassifizierung*: Man ordnet Informationen Stufen zu, aus denen der nötige Schutz folgt. Gebräuchlich sind vier Stufen: *öffentlich* (darf jeder sehen, zum Beispiel die Speisekarte), *intern* (nur für Beschäftigte, etwa ein Projektplan), *vertraulich* (nur ein begrenzter Personenkreis, etwa Kundenverträge) und *streng vertraulich* (höchster Schutz, etwa Gehälter, Zugangsdaten, Gesundheitsdaten). Die Bezeichnungen variieren zwischen Organisationen; wichtig ist, dass jeder Mitarbeitende die Stufen kennt und weiß, was sie verlangen: Wer darf zugreifen, ob Verschlüsselung nötig ist, ob und wie die Daten weitergegeben werden dürfen, wie lange sie aufbewahrt werden. Daten mit Personenbezug haben zusätzlich die Anforderungen aus dem Datenschutz (Abschnitt 6.7 und Modul 11).

Für den Alltag in der Cloud (Modul 8) gilt das *Modell der geteilten Verantwortung*: Der Anbieter ist für die Sicherheit *der* Cloud zuständig (Rechenzentren, Grundinfrastruktur), der Kunde für die Sicherheit *in* der Cloud (Konfiguration, Zugriffsrechte, Daten, Konten); je nach Dienstmodell verschiebt sich die Grenze (bei reiner Software als Dienst trägt der Anbieter mehr, bei virtuellen Maschinen der Kunde mehr). Die meisten bekannten Datenpannen in der Cloud entstehen nicht durch einen Fehler des Anbieters, sondern durch *Fehlkonfiguration*: ein Speicherbereich ist öffentlich lesbar, ein Freigabelink gilt für “jeden im Internet”, ein Konto hat Administratorrechte, die nie jemand überprüft hat, die Mehr-Faktor-Anmeldung wurde nicht aktiviert.

Sichere Nutzung heißt deshalb: Freigaben nach dem Prinzip der geringsten Rechte erteilen (bestimmte Personen statt “jeder mit dem Link”), befristen (Ablaufdatum), regelmäßig prüfen und beim Wegfall des Zwecks entfernen. Daten werden bei der Speicherung (*at rest*) und bei der Übertragung (*in transit*) verschlüsselt; in der Cloud ist das häufig Standard, aber zu überprüfen. Die Sicherung (Backup) gehört zum Konzept: Cloud-Dienste ersetzen nicht ohne Weiteres eine eigene Datensicherung, denn gelöschte oder verschlüsselte Daten werden synchronisiert; das Prinzip “3-2-1” wird in Modul 12 behandelt. Auch private Clouddienste für Firmendaten (“Schatten-IT”) sind ein Risiko: Was die IT nicht kennt, kann sie nicht schützen. Bei Dienstleistern im Ausland sind zusätzlich datenschutzrechtliche Fragen zu klären (Modul 11).

Das folgende Programm prüft eine Liste von Freigaben gegen eine einfache Regel. Je Klasse ist festgelegt, welche Freigabearten erlaubt sind; vertrauliche Dateien sollen außerdem ein Ablaufdatum haben. Das Ergebnis ist eine Liste von Befunden, die ein Mensch bewerten muss.

```python
FREIGABEN = [
    {"name": "Speisekarte.pdf", "klasse": "oeffentlich", "link": "jeder mit Link", "ablauf_tage": None},
    {"name": "Kundenliste.xlsx", "klasse": "vertraulich", "link": "jeder mit Link", "ablauf_tage": None},
    {"name": "Gehaelter.xlsx", "klasse": "streng vertraulich", "link": "bestimmte Personen", "ablauf_tage": 30},
    {"name": "Projektplan.docx", "klasse": "intern", "link": "alle im Unternehmen", "ablauf_tage": None},
    {"name": "Vertrag_Meier.pdf", "klasse": "vertraulich", "link": "bestimmte Personen", "ablauf_tage": None},
]
ERLAUBT = {"oeffentlich": {"jeder mit Link", "alle im Unternehmen", "bestimmte Personen"},
           "intern": {"alle im Unternehmen", "bestimmte Personen"},
           "vertraulich": {"bestimmte Personen"},
           "streng vertraulich": {"bestimmte Personen"}}
for f in FREIGABEN:
    befunde = []
    if f["link"] not in ERLAUBT[f["klasse"]]:
        befunde.append(f"Freigabe '{f['link']}' zu weit fuer Klasse '{f['klasse']}'")
    if f["klasse"] in ("vertraulich", "streng vertraulich") and f["ablauf_tage"] is None:
        befunde.append("kein Ablaufdatum")
    print(("PRUEFEN" if befunde else "ok     "), f["name"], "; ".join(befunde))
```

Die Datenstruktur `FREIGABEN` beschreibt fünf Dateien mit Klasse, Freigabeart und optionalem Ablauf in Tagen (`None` bedeutet: kein Ablauf). Das Wörterbuch `ERLAUBT` legt je Klasse eine Menge zulässiger Freigabearten fest. Die Schleife sammelt Befunde: Zuerst wird geprüft, ob die Freigabeart für die Klasse zulässig ist, danach, ob vertrauliche Dateien ein Ablaufdatum haben. Das Ergebnis: Die Speisekarte und der Projektplan sind in Ordnung, die Gehaltsliste ebenso (nur bestimmte Personen, Ablauf in 30 Tagen). Bei der Kundenliste meldet das Programm zwei Befunde: Die Freigabe “jeder mit Link” ist für eine vertrauliche Datei zu weit, und es fehlt ein Ablaufdatum. Beim Vertrag fehlt nur das Ablaufdatum. Solche Prüfungen lassen sich mit den Verwaltungswerkzeugen der Cloud-Dienste automatisieren; hier sind sie einfach nachgebaut.

### Typische Fehler.

Falsch ist die Freigabe “Jeder mit dem Link” aus Bequemlichkeit: Links können weitergeleitet werden, in Suchmaschinen oder Browserverläufen landen und lassen sich oft erraten. Falsch ist, Passwörter, Schlüssel oder Zugangsdaten in Freigaben oder Quellcode-Archive zu legen. Falsch ist, dass private Konten für dienstliche Daten genutzt werden. Falsch ist auch, “Cloud” mit “automatisch sicher” gleichzusetzen. Ein Klassiker: Der Konto-Administrator hat die Mehr-Faktor-Anmeldung für sich selbst “vorübergehend” abgeschaltet und nie wieder aktiviert.

### Praxisbezug.

Beim Senden eines Angebots mit Preisen an einen Kunden verwendet man eine zeitlich begrenzte, passwortgeschützte Freigabe statt eines Anhangs, der monatelang abrufbar bleibt. Regelmäßige Freigabe-Berichte der Cloud-Dienste zeigen, welche Dateien extern geteilt sind. Der Support wird oft gefragt, wie man eine Datei “nur für den Kunden Meier” freigibt, und die richtige Antwort ist eine Freigabe an dessen Adresse, nicht der Link für alle.

> **Merke**
>
> Klassifizieren: öffentlich, intern, vertraulich, streng vertraulich. Cloud: geteilte Verantwortung; Fehlkonfiguration ist die häufigste Ursache von Pannen. Freigaben so eng wie möglich, mit Ablauf, regelmäßig prüfen. Verschlüsselung at rest und in transit. Cloud-Synchronisation ersetzt kein Backup.

## 10.7 Security Monitoring und Incident-Basis

Sicherheitsvorfälle lassen sich nicht vollständig verhindern; entscheidend ist, sie schnell zu bemerken und richtig zu behandeln. *Security Monitoring* wertet Protokolle (Abschnitt 9.3) und Meldungen von Schutzsystemen aus, um Auffälligkeiten zu erkennen. Ein *SIEM* (*Security Information and Event Management*) sammelt Logs aus vielen Quellen zentral, korreliert sie (verknüpft verschiedene Ereignisse) und löst Alarme aus, die ein *SOC* (*Security Operations Center*, die Überwachungsstelle) bearbeitet. In kleinen Unternehmen übernimmt diese Rolle eine Person oder ein Dienstleister, die Idee bleibt dieselbe. Ein *Ereignis* (*Event*) ist alles Beobachtbare, ein *Vorfall* (*Incident*) ein Ereignis mit tatsächlicher oder drohender Verletzung der Sicherheit.

Woran erkennt man einen Vorfall? Typische *Anzeichen* sind: ungewöhnliche Anmeldungen (nachts, aus fremden Ländern, viele Fehlversuche, gleichzeitig von zwei Orten), unerwartete Programme oder Prozesse, ein plötzlich langsames Gerät, Dateien, die sich nicht mehr öffnen lassen oder neue Endungen haben, ein Lösegeld-Hinweis, deaktivierte Schutzsoftware, unbekannte neue Konten oder Rechteänderungen, ungewöhnlich viel ausgehender Datenverkehr, Mails, die man nie versendet hat, oder Kunden, die von seltsamen Nachrichten in Ihrem Namen berichten. Ein einzelnes Zeichen ist oft harmlos; erst die Kombination macht es verdächtig. Wichtig ist deshalb eine niedrige Hemmschwelle, Verdacht zu melden: Lieber zehnmal falscher Alarm als ein einmal verschwiegener Vorfall.

Der Umgang mit einem Vorfall folgt einem Ablauf, der in vielen Rahmenwerken ähnlich beschrieben ist: *Vorbereitung* (Pläne, Kontaktlisten, Werkzeuge), *Erkennung und Meldung*, *Eindämmung* (weitere Ausbreitung stoppen), *Beseitigung* (Ursache entfernen), *Wiederherstellung* (Normalbetrieb herstellen), *Nachbereitung* (Lehren ziehen). Für Beschäftigte ohne Spezialausbildung kommt es auf die ersten Schritte an. Man meldet den Verdacht sofort über den festgelegten Weg (Servicedesk, Sicherheitsbeauftragter), beschreibt sachlich, was man gesehen hat, und notiert Uhrzeit und Umstände. Man trennt ein vermutlich infiziertes Gerät vom Netz (Netzwerkkabel ziehen, WLAN ausschalten), schaltet es aber *nicht aus* und löscht oder repariert nichts auf eigene Faust, denn Spuren im Arbeitsspeicher und in Protokollen können später zur Aufklärung nötig sein. Man verändert keine Beweise, ändert aber Kennwörter betroffener Konten *von einem sauberen Gerät aus*, wenn die IT es anweist. Die *Beweissicherung* (englisch *Chain of Custody*, lückenlose Nachweiskette) hält fest, wer wann auf welche Daten zugegriffen hat, sodass Ergebnisse später belastbar sind.

> **Ergänzung aus der Nachrecherche**
>
> Bei Vorfällen mit Personenbezug besteht nach der Datenschutz-Grundverordnung unter bestimmten Bedingungen eine *Meldepflicht* an die Aufsichtsbehörde, grundsätzlich unverzüglich und möglichst binnen 72 Stunden nach Bekanntwerden (Art. 33 DSGVO); betroffene Personen sind bei hohem Risiko ebenfalls zu informieren (Art. 34). Diese Angaben stammen aus allgemeinem Fachwissen; den Gesetzestext habe ich in dieser Sitzung nicht abgerufen. Ob ein Vorfall meldepflichtig ist, entscheidet in der Organisation die zuständige Stelle (Datenschutzbeauftragte, Rechtsabteilung), nicht der einzelne Mitarbeitende; die Aufgabe jedes Einzelnen ist, einen Verdacht *sofort* zu melden, damit die Frist eingehalten werden kann. Dieser Abschnitt ist keine Rechtsberatung.

Das folgende Programm zeigt, wie man aus Anmeldeprotokollen einen einfachen Angriff durch Ausprobieren erkennt. Es betrachtet nur fehlgeschlagene Anmeldungen und zählt, wie viele je Adresse in einem Zeitfenster von einer Minute auftreten; ab fünf wird gemeldet. Die Daten sind erzeugt: Eine Adresse versucht innerhalb von 24 Sekunden mehrere Konten, eine andere hat gelegentlich einen Fehlversuch.

```python
from collections import defaultdict, deque
from datetime import datetime, timedelta

def erkenne(ereignisse, fenster=timedelta(minutes=1), schwelle=5):
    fenster_je_ip = defaultdict(deque)
    gemeldet = {}
    for zeit, ip, user, ok in ereignisse:
        if ok:
            continue
        q = fenster_je_ip[ip]
        q.append((zeit, user))
        while q and zeit - q[0][0] > fenster:
            q.popleft()
        if len(q) >= schwelle and ip not in gemeldet:
            gemeldet[ip] = (zeit, len(q), sorted({u for _, u in q}))
    return gemeldet

t0 = datetime(2026, 10, 26, 3, 0, 0)
ereig = []
for i, user in enumerate(["admin", "root", "anna", "admin", "test", "bernd", "admin"]):
    ereig.append((t0 + timedelta(seconds=4 * i), "203.0.113.9", user, False))
ereig += [(t0 + timedelta(minutes=m), "10.0.0.5", "anna", False) for m in range(0, 20, 5)]
for ip, (zeit, n, users) in erkenne(ereig).items():
    print(f"{zeit:%H:%M:%S} {ip}: {n} Fehlversuche in 1 Minute, Konten {users}")
```

Die Ereignisse sind Tupel aus Zeit, Adresse, Benutzer und Erfolg. Für jede Adresse führt das Programm eine Warteschlange (`deque`) der Fehlversuche im Zeitfenster; vorne wird entfernt, was älter als eine Minute ist (`popleft`), hinten kommt der neue Versuch dazu. Sobald die Warteschlange die Schwelle erreicht, merkt sich das Programm die Adresse (jede nur einmal). Die Ausgabe lautet: `03:00:16 203.0.113.9: 5 Fehlversuche in 1 Minute, Konten ['admin', 'anna', 'root', 'test']`. Der fünfte Fehlversuch geschah nach 16 Sekunden. Die Adresse 10.0.0.5 mit vier Fehlversuchen im Abstand von fünf Minuten wird nicht gemeldet: Das ist die Absicht des Zeitfensters, denn gelegentliche Vertipper sind normal. Die Gegenmaßnahmen auf der Systemseite wären eine temporäre Sperre der Adresse, die Verzögerung weiterer Versuche, MFA und die Sperre des betroffenen Kontos nach mehreren Fehlversuchen. Wichtig ist, nicht blind zu reagieren: Eine automatische Kontosperre kann Angreifer dazu bringen, absichtlich legitime Konten zu sperren.

### Typische Fehler.

Falsch ist, einen Verdacht aus Scham zu verschweigen: Die meisten Angriffe gelingen durch normale Fehler, und ein schnell gemeldeter Klick auf einen schlechten Link begrenzt den Schaden erheblich. Falsch ist, ein Gerät sofort “gründlich aufzuräumen” oder neu zu installieren, bevor Spuren gesichert sind. Falsch ist, Logs nur zu sammeln und nie anzusehen. Falsch ist, beim Verdacht mit dem eigenen Gerät weiterzuarbeiten “bis Feierabend”. Und falsch ist, Angreifer “zurückzuhacken” oder auf eigene Faust zu “ermitteln”: Das ist rechtlich problematisch und gehört in die Hände Berufener.

### Praxisbezug.

Meldet jemand “Ich habe auf einen Link geklickt und dann ein Passwort eingegeben”, ist der Support gefragt: ruhig bleiben, Uhrzeit und Adresse notieren, das Kennwort sofort ändern lassen (von einem anderen Gerät), aktive Sitzungen beenden, MFA prüfen, das Gerät vom Netz trennen und die Sicherheitsverantwortlichen informieren. Auch dies ist ein Fall für das Ticket-System (Abschnitt 9.5) mit hoher Priorität.

## 10.8 Secure-by-Design und Security Awareness

Sicherheit, die nachträglich aufgesetzt wird, ist teuer und lückenhaft. *Secure by Design* (sicher durch Entwurf) bedeutet, Sicherheit schon bei der Planung und Entwicklung von Systemen, Prozessen und Software einzubauen, statt sie am Ende “anzukleben”. Ein verwandter Begriff ist *Secure by Default*: Die Grundeinstellungen eines Produkts sind sicher, und der Anwender muss nichts tun, um geschützt zu sein (zum Beispiel ist MFA ab Werk eingeschaltet, oder es gibt kein Standardkennwort). Dahinter stehen bewährte Prinzipien: *geringste Rechte*, *Default Deny*, *gestaffelte Verteidigung*, *Trennung von Aufgaben und Bereichen*, *minimale Angriffsfläche*, *Fehler sicher behandeln* (bei einer Störung lieber den Zugang verweigern als zu öffnen) und *Sicherheit nicht durch Geheimhaltung der Konstruktion* erreichen (ein System soll auch dann sicher sein, wenn Angreifer sein Prinzip kennen; nur der Schlüssel ist geheim).

> **Ergänzung aus der Nachrecherche**
>
> Die US-Behörde für Cybersicherheit CISA veröffentlichte gemeinsam mit internationalen Partnern Leitlinien “Secure by Design” für Softwarehersteller. Nach der Meldung auf cisa.gov (abgerufen, Stand der Aktualisierung Oktober 2023) nennt sie drei Grundsätze: Verantwortung für die Sicherheitsergebnisse der Kunden übernehmen, radikale Transparenz und Rechenschaft pflegen und die Sicherheit von der Führungsebene aus vorantreiben (“lead from the top”). Die Leitlinien richten sich an Hersteller, nicht an Anwender, zeigen aber die Richtung: Sicherheit ist eine Eigenschaft des Produkts und der Organisation, keine Aufgabe, die man dem Endanwender überlässt. Als Prüfungsstoff reicht das Verständnis der Idee; die Wortlaute sind in den Originalpublikationen nachzulesen.

Für Software heißt das: Eingaben *niemals vertrauen*, sondern prüfen (Validierung), Daten getrennt von Befehlen behandeln, Fehlermeldungen nicht mit internen Details füllen, Geheimnisse (Kennwörter, Schlüssel) nie im Quelltext ablegen, Abhängigkeiten aktuell halten und Code prüfen lassen. Der Klassiker ist die *SQL-Injection*: Wenn ein Programm Eingaben direkt in einen SQL-Befehl einbaut, kann ein Angreifer eigene SQL-Teile einschleusen. Das Gegenmittel sind *parametrisierte Abfragen*, bei denen der Befehl und die Daten getrennt an die Datenbank gehen, sodass Eingaben nie als Befehle gedeutet werden. Das Beispiel zeigt beides an einer Anmeldung.

```python
import sqlite3
db = sqlite3.connect(":memory:")
db.executescript("""CREATE TABLE benutzer (name TEXT, passwort_hash TEXT, rolle TEXT);
INSERT INTO benutzer VALUES ('anna', 'x1', 'user'), ('admin', 'x2', 'admin');""")

def login_unsicher(name, hash_):
    sql = f"SELECT rolle FROM benutzer WHERE name = '{name}' AND passwort_hash = '{hash_}'"
    return sql, db.execute(sql).fetchall()

def login_sicher(name, hash_):
    sql = "SELECT rolle FROM benutzer WHERE name = ? AND passwort_hash = ?"
    return sql, db.execute(sql, (name, hash_)).fetchall()

eingabe = ("admin' --", "falsch")
for f in (login_unsicher, login_sicher):
    sql, erg = f(*eingabe)
    print(f.__name__, "->", erg)
    print("   SQL:", sql)
```

Die erste Funktion setzt den Namen per Textformatierung in den SQL-Befehl ein. Gibt der Angreifer als Namen `admin' -{}-` ein (die Anführungszeichen schließen den Text, die zwei Striche leiten in SQL einen Kommentar ein), lautet der fertige Befehl `... WHERE name = 'admin' --' AND passwort_hash = 'falsch'`: Der Rest, also die Prüfung des Passworts, steht im Kommentar und entfällt. Die Abfrage liefert die Rolle `admin`, die Anmeldung gelingt *ohne* Passwort. Die zweite Funktion verwendet Platzhalter: Der SQL-Befehl bleibt unverändert, und die Eingabe wird als Wert übergeben, sodass sie als gewöhnlicher Text gesucht wird (es gibt keinen Benutzer mit dem Namen `admin' -{}-`). Das Ergebnis ist eine leere Liste, die Anmeldung scheitert. Der Unterschied besteht nur in der Art, wie der Befehl zusammengesetzt wird; derselbe Gedanke gilt in jeder Programmiersprache und bei jeder Datenbank. Das Beispiel nutzt eine rein lokale Beispieldatenbank im Arbeitsspeicher; solche Tests gegen fremde Systeme sind unzulässig (siehe die Hinweise zur Rechtslage am Ende des Abschnitts).

Der zweite Teil der Lerneinheit betrifft die Menschen. *Security Awareness* (Sicherheitsbewusstsein) bedeutet, dass Beschäftigte Risiken kennen, richtig reagieren und ihr Verhalten dauerhaft ändern. Wirksame Programme zeichnen sich durch regelmäßige, kurze Schulungen mit Alltagsbezug aus (nicht ein einziger jährlicher Vortrag), durch praktische Übungen (simulierte Phishing-Mails, die den Lerneffekt prüfen, ohne zu bestrafen), durch einfache, klare Regeln und einen unkomplizierten Meldeweg und durch eine *Fehlerkultur*, die Meldungen belohnt und nicht sanktioniert. Wer für einen Klick bestraft wird, meldet beim nächsten Mal nichts. Die Führungsebene lebt die Regeln vor; Ausnahmen für “wichtige Personen” untergraben sie. Zu Awareness gehören auch konkrete Gewohnheiten: Bildschirm sperren beim Verlassen des Platzes (Windows-Taste und L), keine Kennwörter auf Zetteln am Monitor, Besucher begleiten, vertrauliche Unterlagen wegschließen und vernichten (*Clean Desk*), beim Telefon und in Chats nachprüfen, wer fragt, und Datenträger unbekannter Herkunft nicht anschließen.

Beide Seiten gehören zusammen: Technik, die nicht zum Verhalten passt, wird umgangen (wenn das Passwortsystem schikaniert, schreibt man Passwörter auf), und Schulung ersetzt keine sichere Technik (jeder macht einmal einen Fehler). Gute Sicherheit macht den sicheren Weg zum bequemsten Weg: Single Sign-on, Passwortmanager, automatische Updates, klare Meldeknöpfe im Mailprogramm.

> **Ergänzung aus der Nachrecherche**
>
> Wer fremde Systeme ohne Erlaubnis angreift, auf sie zugreift oder auch nur “testet”, macht sich in der Regel strafbar; das gilt auch für gut gemeinte Versuche. Das Beispiel oben läuft ausschließlich gegen eine selbst angelegte lokale Datenbank. Prüfungen der Sicherheit (Penetrationstests) erfolgen nur mit schriftlichem Auftrag und klarem Umfang. Details zur Rechtslage in Österreich habe ich in dieser Sitzung nicht recherchiert; es handelt sich um eine allgemeine Einordnung und nicht um Rechtsberatung.

### Typische Fehler.

Falsch ist, Sicherheit erst vor der Inbetriebnahme zu prüfen: Nachbesserungen sind dann teuer, und man verschiebt sie. Falsch ist, Awareness als reine Pflichtübung zu behandeln, die man abhakt, oder Beschäftigte als “schwächstes Glied” zu beschuldigen, statt Prozesse so zu gestalten, dass Fehler verzeihlich sind. Falsch ist, Geheimnisse im Code zu speichern (sie landen in Versionsarchiven, auch wenn man sie später entfernt). Falsch ist, einzelnen Personen aus Bequemlichkeit Sonderrechte zu geben. Und falsch ist, die Verantwortung zu delegieren, ohne zu prüfen: “Der Cloud-Anbieter kümmert sich schon” gilt nur für seinen Teil.

### Praxisbezug.

Beim Einführen eines neuen Systems stellt der Betrieb früh die Fragen: Welche Daten verarbeitet es, wer darf zugreifen, wie wird protokolliert, wie sichern wir, wie sieht der Notfallplan aus? Das spart später viel Mühe. Im Alltag sind Sie als Supportmitarbeiter oft die erste Anlaufstelle: Wer Fragen zur Sicherheit freundlich und verständlich beantwortet, trägt mehr zum Schutz bei als jede Richtlinie.

> **Merke**
>
> Secure by Design: Sicherheit von Anfang an. Secure by Default: sichere Voreinstellungen. Prinzipien: geringste Rechte, Default Deny, gestaffelte Verteidigung, minimale Angriffsfläche, sicher scheitern. Eingaben nie vertrauen; parametrisierte Abfragen. Awareness: kurz, regelmäßig, ohne Schuldzuweisung, mit einfachem Meldeweg.

## Übungsaufgaben Modul 10

1.  Ordnen Sie jedem Ereignis das primär verletzte Schutzziel zu: (a) Ein Mitarbeiter schickt eine Kundenliste an die falsche Adresse. (b) Ein Angreifer ändert die IBAN in einer Rechnung. (c) Ein DDoS-Angriff legt den Webshop lahm. (d) Ein Keylogger zeichnet Eingaben auf.

2.  Erklären Sie den Unterschied zwischen Authentisierung und Autorisierung und nennen Sie je ein Beispiel. Warum zählt “Passwort plus Sicherheitsfrage” nicht als Multi-Faktor-Authentifizierung?

3.  Unterscheiden Sie Virus, Wurm, Trojaner und Ransomware in je einem Satz. Wie verhalten Sie sich bei einer Lösegeldforderung auf dem Bildschirm?

4.  Beschreiben Sie fünf Merkmale einer Phishing-Mail und fünf Maßnahmen, die Sie als Empfänger ergreifen.

5.  Ein neuer Windows-Laptop soll für den Einsatz im Büro gehärtet werden. Nennen Sie acht Maßnahmen und begründen Sie, warum das Wiederherstellungsschlüsselkonzept zur Verschlüsselung gehört.

6.  **Praxis:** Berechnen Sie mit Python die Entropie in Bit für (a) ein Passwort aus 10 zufälligen Ziffern, (b) eines aus 12 zufälligen Kleinbuchstaben, (c) eine Passphrase aus 5 zufälligen Wörtern einer Liste mit 7 776 Wörtern. Vergleichen Sie die Ergebnisse und kommentieren Sie, wann die Rechnung nicht gilt.

7.  **Praxis:** Erweitern Sie die Firewall-Regelliste aus Abschnitt 10.5 um eine Regel, die aus dem Netz 192.168.10.0/24 den Port 3389 (Remotedesktop) auf dem Server 10.0.5.10 erlaubt. Zeigen Sie mit zwei Aufrufen, dass ein Rechner aus diesem Netz zugelassen und ein Rechner aus dem Internet blockiert wird. Wo in der Liste muss die neue Regel stehen und warum?

8.  **Praxis:** Schreiben Sie eine Python-Funktion `passwort_ok(pw)`, die vorab festgelegte Mindestanforderungen prüft (mindestens 12 Zeichen, nicht in einer kleinen Liste häufiger Passwörter, nicht gleich dem Benutzernamen) und eine Liste von Beanstandungen zurückgibt. Testen Sie mit vier Beispielen.

9.  Ein Kollege berichtet, sein Rechner zeige plötzlich eine Meldung “Ihre Dateien wurden verschlüsselt”. Beschreiben Sie in der richtigen Reihenfolge, was er tun und was er unterlassen soll, und was die IT unternimmt.

## Lösungen Modul 10

1.  \(a\) Vertraulichkeit: Unbefugte erhalten Kenntnis. (b) Integrität: Daten wurden unbefugt verändert. (c) Verfügbarkeit: Der Dienst ist nicht nutzbar. (d) Vertraulichkeit: Geheime Eingaben (Kennwörter) werden abgegriffen.

2.  Authentisierung: Identität nachweisen (Anmeldung mit Passwort); Autorisierung: Rechte prüfen (darf auf Ordner “Buchhaltung” zugreifen). Eine Sicherheitsfrage ist wie das Passwort etwas, das man *weiß*; beide gehören zum selben Faktor, also fehlt der zweite Faktor (Besitz oder Sein). Zudem lassen sich Antworten oft aus öffentlichen Informationen erraten.

3.  Virus: hängt sich an Dateien und braucht einen Auslöser. Wurm: verbreitet sich selbständig über Netze. Trojaner: tarnt sich als nützliches Programm. Ransomware: verschlüsselt Daten und verlangt Lösegeld. Bei einer Lösegeldforderung: Gerät vom Netz trennen (nicht ausschalten), nichts zahlen und nichts anklicken, sofort die IT oder den Servicedesk melden, Uhrzeit und Meldungstext notieren.

4.  Merkmale: Druck und Drohung, unpersönliche Anrede, Rechtschreib- und Stilfehler, abweichende Absenderadresse, unerwartete Anhänge oder Links auf fremde Domains, Aufforderung zur Eingabe von Zugangsdaten. Maßnahmen: Absenderadresse prüfen, mit der Maus über Links fahren, nichts anklicken, Portale über Lesezeichen aufrufen, im Zweifel auf einem anderen Weg beim vermeintlichen Absender nachfragen, Mail über den Meldeweg weiterleiten, danach löschen.

5.  Beispiele: Updates installieren; Laufwerk verschlüsseln; Firewall aktivieren; Virenschutz/EDR installieren; Standardbenutzer statt Administrator anlegen; Gastkonto und unnötige Dienste abschalten; Bildschirmsperre einstellen; MFA aktivieren; Wiederherstellungsschlüssel sichern. Ohne gesicherten Wiederherstellungsschlüssel sind die Daten bei Defekt oder Anmeldeproblemen unwiederbringlich verloren; deshalb wird er an einem getrennten, geschützten Ort hinterlegt (zum Beispiel im Verzeichnisdienst).

6.  Beispiellösung:

    ```python
    import math
    print(round(10 * math.log2(10), 1))
    print(round(12 * math.log2(26), 1))
    print(round(5 * math.log2(7776), 1))
    ```

    Ausgabe: 33,2 Bit; 56,4 Bit; 64,6 Bit. Die Passphrase aus fünf Zufallswörtern ist am stärksten und trotzdem merkbar. Die Rechnung gilt nur bei wirklich zufälliger Wahl; ein Passwort wie “Sommer2026” hat wegen seiner Vorhersehbarkeit eine viel geringere tatsächliche Stärke.

7.  Beispiellösung: Man fügt die Regel vor der Blockade-Regel ein, die alles andere auf Port 3389 verhindert; da keine Allgemeinsperre für Port 3389 existiert, greift ohne Regel die Standardregel. Für die Reihenfolge gilt: spezifische Erlaubnisse vor allgemeinen Verboten.

    ```python
    REGELN.insert(0, ("erlaube", "192.168.10.0/24", "10.0.5.10", 3389, "tcp"))
    print(entscheide("192.168.10.7", "10.0.5.10", 3389, "tcp"))
    print(entscheide("203.0.113.9", "10.0.5.10", 3389, "tcp"))
    ```

    Das erste Ergebnis lautet “erlaube”, das zweite “blockiere” durch die Standardregel. Die Reihenfolge ist wichtig, weil die erste passende Regel entscheidet.

8.  Beispiellösung:

    ```python
    HAEUFIG = {"passwort", "123456", "qwertz", "sommer2026", "willkommen"}
    def passwort_ok(pw, benutzer=""):
        probleme = []
        if len(pw) < 12:
            probleme.append("kuerzer als 12 Zeichen")
        if pw.lower() in HAEUFIG:
            probleme.append("steht auf der Liste haeufiger Passwoerter")
        if benutzer and pw.lower() == benutzer.lower():
            probleme.append("entspricht dem Benutzernamen")
        return probleme
    for pw in ["Passwort", "anna", "Kaffee-Tasse-7-Wolke", "willkommen"]:
        print(pw, passwort_ok(pw, "anna") or "ok")
    ```

    Das Passwort “Passwort” wird als zu kurz und häufig beanstandet, “anna” als zu kurz und gleich dem Benutzernamen, die lange Passphrase ist in Ordnung, und “willkommen” ist mit zehn Zeichen zu kurz und steht außerdem auf der Liste. Beachten Sie: Eine echte Prüfung nutzt große Listen bekannter Passwörter, keine Zusammensetzungsregeln.

9.  Sofort: Gerät vom Netz trennen (Kabel, WLAN aus), aber nicht ausschalten; Bildschirm nicht schließen, Foto der Meldung machen; die IT/Servicedesk telefonisch benachrichtigen. Nicht tun: Lösegeld zahlen, Dateien löschen, Datenträger anschließen, auf eigene Faust “reinigen”, weitere Geräte anschließen. Die IT isoliert das Gerät und prüft, ob weitere Systeme betroffen sind, sperrt Konten, schaltet gegebenenfalls Freigaben ab, sichert Spuren, stellt aus unveränderten Datensicherungen wieder her (Abschnitt 6.6 und Modul 12), prüft die Meldepflicht bei Personenbezug und ermittelt anschließend die Ursache, um die Lücke zu schließen.
