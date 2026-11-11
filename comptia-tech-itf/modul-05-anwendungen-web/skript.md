# Modul 5 - Anwendungen, Web, Konten und Produktivitaet

> **Hinweis zu diesem Kapitel:** Das ist das Kapitel des Skripts „CompTIA Tech+ / ITF+ (FC0-U71): Lernskript in Modulen“, aus der LaTeX-Quelle in Markdown umgewandelt (Text und Listings unverändert, Boxen als Zitatblöcke, Aufgaben und Lösungen als nummerierte Listen). Laut Skript wurden die Python-Beispiele bei der Erstellung im Arbeitsbereich ausgeführt, die gezeigten Ausgaben stammen aus diesen Läufen; Windows- und PowerShell-Befehle wurden nicht ausgeführt. Für dieses Repository wurden die Listings **nicht erneut ausgeführt**. Prüfungsdetails, Produktnamen und Versionen ändern sich; maßgeblich sind die aktuellen Prüfungsziele (Exam Objectives) von CompTIA. Übersicht zum Modul: [README](README.md).

**Dauer:** 6,5 h

**Priorität:** 2

| Nr. | Lerneinheit                         | Dauer (h) | Prio |
|----:|:------------------------------------|----------:|-----:|
| 5.1 | Anwendungsarten                     |      0,75 |    2 |
| 5.2 | Browser-Grundlagen                  |      0,75 |    1 |
| 5.3 | E-Mail und Messaging                |      0,75 |    1 |
| 5.4 | Office- und Produktivitätswerkzeuge |      0,75 |    2 |
| 5.5 | Kollaborationsplattformen           |      0,75 |    2 |
| 5.6 | Benutzerkonten und Identität        |         1 |    1 |
| 5.7 | SaaS und Service-Konzepte           |      0,75 |    2 |
| 5.8 | Anwendungs-Troubleshooting          |         1 |    2 |
|     | **Summe**                           |   **6,5** |      |

Die meisten Anwender kommen mit IT über Anwendungen in Berührung: Sie öffnen einen Browser, schreiben E-Mails, bearbeiten Dokumente, telefonieren per Videokonferenz und melden sich an unzähligen Diensten an. Wer im Support arbeitet, muss diese Werkzeuge nicht nur bedienen, sondern verstehen, wie sie zusammenhängen: wo Daten liegen, wie Anmeldung funktioniert, warum etwas “nur bei mir” nicht geht. Dieses Modul behandelt die typischen Anwendungsarten, den Browser als wichtigstes Fenster zur Cloud, E-Mail samt ihren Schwächen, Büroanwendungen und Zusammenarbeit, Benutzerkonten mit Einmalanmeldung (Single Sign-on) und Mehr-Faktor-Anmeldung, die Besonderheiten von Software als Dienst und eine Methode, Anwendungsfehler zu beschreiben und weiterzugeben. Die Anwendungs-Domäne macht 18 Prozent der Prüfung aus. Vertiefungen folgen an anderer Stelle: Phishing und Passwortschutz in Modul 10, Cloud-Modelle in Modul 8, Datenschutz und Aufbewahrung in Modul 11; hier werden sie aus der Sicht des Anwenders behandelt und verwiesen. Alle Beispiele sind Python-Programme, die im Arbeitsbereich ausgeführt wurden; Adressen und Namen sind erfunden.

## 5.1 Anwendungsarten

Eine *Anwendung* (englisch *Application*, kurz *App*) ist ein Programm, mit dem Anwender eine Aufgabe erledigen, im Unterschied zum Betriebssystem, das die Hardware verwaltet (Modul 3). Man unterscheidet im Wesentlichen drei Arten, die sich darin unterscheiden, wo das Programm läuft und wie es zum Anwender kommt.

Eine *Desktop-Anwendung* wird auf dem Rechner installiert und läuft dort lokal. Sie nutzt die Rechenleistung und den Speicher des Geräts, kann oft ohne Internet arbeiten (*offline*), greift direkt auf Dateien und Geräte (Drucker, Scanner, Messgeräte) zu und bietet meist den größten Funktionsumfang; Beispiele sind klassische Textverarbeitungen, Bildbearbeitung oder Buchhaltungsprogramme. Der Preis: Installation und Updates müssen für jedes Gerät erfolgen, Versionen können auseinanderlaufen, und die Anwendung ist an das Betriebssystem gebunden (eine Windows-Software läuft nicht ohne Weiteres auf einem Mac). Eine *Web-Anwendung* läuft auf einem Server und wird im Browser bedient; auf dem Gerät ist nichts zu installieren. Sie ist von jedem Gerät mit Browser erreichbar, wird zentral aktualisiert, lässt sich leicht gemeinsam nutzen, braucht aber (meist) eine Internetverbindung, hat eingeschränkten Zugriff auf lokale Geräte und ist von der Verfügbarkeit des Anbieters abhängig; viele moderne Programme dieser Art sind aber weit leistungsfähiger, als man vermuten würde. Eine *mobile Anwendung* wird über einen App-Store auf ein Smartphone oder Tablet geladen und ist auf Touch-Bedienung, Kamera, Ortung und Benachrichtigungen ausgelegt. Es gibt *native* Apps (speziell für ein System gebaut, schnell und tief integriert) und *hybride* oder *plattformübergreifende* Apps (ein Code für mehrere Systeme, mit Abstrichen bei Leistung oder Integration). Dazwischen steht die *Progressive Web App*: eine Web-Anwendung, die sich wie eine App installieren und teilweise offline nutzen lässt.

Für den Betrieb zählen drei Fragen. *Verteilung und Pflege*: Wie kommt die Software auf die Geräte, wer aktualisiert sie? Bei Desktop-Programmen übernimmt das die IT mit Verteilwerkzeugen; bei Web-Apps der Anbieter; bei mobilen Apps die Stores und die Geräteverwaltung (*Mobile Device Management*). *Kompatibilität*: Läuft die Anwendung auf allen Betriebssystemen und Browserversionen der Nutzer? *Sicherheit*: Woher kommt die Software (nur aus vertrauenswürdigen Quellen: Hersteller, Firmen-Portal, offizieller Store), welche Rechte verlangt sie (eine Taschenlampen-App braucht keinen Zugriff auf Kontakte), und welche Daten gehen wohin? Hinzu kommt die *Lizenzierung* (Abschnitt 11.6).

Das folgende Programm formalisiert die Auswahl mit einem einfachen Punktesystem. Jede Anwendungsart hat zu fünf Anforderungen eine Eignung von 0 (ungeeignet) bis 2 (sehr gut). Gefragt ist die Summe über die tatsächlich geforderten Eigenschaften. Die Eignungswerte sind eine grobe, vereinfachte Einschätzung.

```python
EIGENSCHAFTEN = {
    "Desktop-App": {"offline_noetig": 2, "zugriff_von_ueberall": 0, "zugriff_auf_hardware": 2,
                    "zentrale_updates": 0, "touch_bedienung": 0},
    "Web-App":     {"offline_noetig": 0, "zugriff_von_ueberall": 2, "zugriff_auf_hardware": 0,
                    "zentrale_updates": 2, "touch_bedienung": 1},
    "Mobile App":  {"offline_noetig": 1, "zugriff_von_ueberall": 2, "zugriff_auf_hardware": 1,
                    "zentrale_updates": 1, "touch_bedienung": 2},
}

def bewerte(anforderungen):
    ergebnis = {}
    for art, werte in EIGENSCHAFTEN.items():
        ergebnis[art] = sum(werte[k] for k, noetig in anforderungen.items() if noetig)
    return sorted(ergebnis.items(), key=lambda x: -x[1])

werkstatt = {"offline_noetig": True, "zugriff_von_ueberall": False,
             "zugriff_auf_hardware": True, "zentrale_updates": False, "touch_bedienung": False}
buero = {"offline_noetig": False, "zugriff_von_ueberall": True,
         "zugriff_auf_hardware": False, "zentrale_updates": True, "touch_bedienung": False}
for name, anf in (("Werkstatt (Messgeraet auslesen, offline)", werkstatt),
                  ("Buero (ueberall erreichbar, zentral gepflegt)", buero)):
    print(name)
    for art, punkte in bewerte(anf):
        print(f"  {art:12} {punkte} Punkte")
```

Das Wörterbuch `EIGENSCHAFTEN` enthält pro Anwendungsart die Eignungswerte. Die Funktion `bewerte` addiert für jede Anforderung, die auf `True` steht, den zugehörigen Wert und sortiert das Ergebnis absteigend (das Minuszeichen in `key` kehrt die Reihenfolge um). Im ersten Szenario, einer Werkstatt, die offline arbeiten und ein Messgerät auslesen muss, gewinnt die Desktop-App mit 4 Punkten vor der mobilen App (2) und der Web-App (0). Im zweiten Szenario, einem Büro mit Zugriff von überall und zentraler Pflege, liegt die Web-App mit 4 Punkten vorn, vor der mobilen App (3) und der Desktop-App (0). Die Rechnung zeigt, dass es keine “beste” Anwendungsart gibt, sondern nur die zur Aufgabe passende. In der Praxis spielen weitere Kriterien mit: Kosten, vorhandenes Wissen, Schnittstellen, Datenschutz.

### Typische Fehler.

Falsch ist, Software aus beliebigen Quellen zu installieren, weil sie “kostenlos” ist: Gefälschte Installationsprogramme sind ein häufiger Weg für Schadsoftware. Falsch ist auch, eine Web-Anwendung ohne Prüfung der Internetverbindung dort einzuplanen, wo das Netz unzuverlässig ist (Baustelle, Lager). Falsch ist, Apps beliebige Berechtigungen zu geben, ohne zu fragen, wozu sie sie brauchen. Und typisch ist, bei einem Desktop-Programm die Updates “später” zu machen und damit Lücken und Inkompatibilitäten anzuhäufen.

### Praxisbezug.

Beim Rollout einer neuen Anwendung klärt der Support: Desktop, Web oder App? Welche Betriebssysteme? Wie erfolgt die Anmeldung? Wo liegen die Daten? Eine Webanwendung spart Installationsaufwand, verlagert aber die Fehlersuche auf Browser, Netz und Konto (Abschnitt 5.8).

> **Merke**
>
> Desktop = lokal installiert, offline möglich, Hardwarezugriff, Pflege pro Gerät. Web-App = im Browser, überall, zentral gepflegt, braucht Verbindung. Mobile App = Store, Touch, Sensoren. Quellen prüfen, Berechtigungen prüfen, Updates einspielen.

## 5.2 Browser-Grundlagen

Der *Webbrowser* ist das Programm, das Webseiten und Web-Anwendungen darstellt; in der Praxis ist er die wichtigste Anwendung auf einem modernen Arbeitsplatz und die *Zugangsschicht zu Cloud-Diensten*: E-Mail, Dokumente, Buchhaltung, Videokonferenzen laufen vielfach im Browser. Das macht ihn zugleich zum häufigsten Ziel von Angriffen. Der Browser verbindet sich mit einem Server über HTTP oder verschlüsselt über HTTPS (Modul 4), lädt Seiten samt Bildern, Stilvorlagen und Programmen (JavaScript) und stellt sie dar. Moderne Browser trennen die Seiten in einzelnen Tabs voneinander (*Sandboxing*), sodass eine fehlerhafte Seite nicht ohne Weiteres auf andere zugreifen kann, und prüfen auf bekannte gefährliche Adressen.

Mehrere Browser-Bausteine sollten Support-Mitarbeitende genau kennen. *Cookies* sind kleine Textmarken, die ein Server an den Browser sendet und die dieser bei späteren Anfragen zurücksendet. Damit erkennt der Server dieselbe Sitzung wieder (zum Beispiel, dass Sie angemeldet sind) und speichert Einstellungen; Cookies können aber auch zum Verfolgen des Verhaltens dienen (Tracking). Sicherheitsrelevante Eigenschaften steuert der Server mit Attributen. Der *Cache* ist ein Zwischenspeicher für Dateien, die der Browser bereits geladen hat (Logos, Stilvorlagen, Bilder), damit sie nicht bei jedem Besuch neu übertragen werden müssen; das macht Seiten schneller, kann aber dazu führen, dass man eine veraltete Version sieht. *Erweiterungen* (*Add-ons*, *Extensions*) fügen dem Browser Funktionen hinzu (Passwortmanager, Werbeblocker), haben aber oft weitreichende Rechte (“Alle Daten auf allen Webseiten lesen”) und werden gelegentlich zum Einfallstor, wenn sie unbemerkt von einem Schadanbieter übernommen werden. *Downloads* sind Dateien aus dem Netz; sie sind der häufigste Weg, Schadsoftware auf den Rechner zu bringen. Der *Verlauf* zeigt besuchte Seiten, *gespeicherte Passwörter* liegen im Passwortmanager des Browsers, und das *private Fenster* (Inkognito) speichert nach dem Schließen weder Verlauf noch Cookies, macht aber nicht anonym: Arbeitgeber, Netzbetreiber und besuchte Seiten sehen weiterhin den Verkehr.

> **Ergänzung aus der Nachrecherche**
>
> Die Entwicklerplattform MDN (Mozilla) beschreibt in ihrem Leitfaden zu sicheren Cookies (abgerufen) die wichtigsten Attribute: `Secure` (Cookie nur über HTTPS senden), `HttpOnly` (für JavaScript unzugänglich, damit Schadcode auf der Seite die Sitzungskennung nicht stehlen kann), `SameSite` mit `Strict` oder `Lax` (Einschränkung des Versands bei Anfragen von anderen Seiten, ein teilweiser Schutz vor bestimmten Angriffen) sowie `Max-Age` oder `Expires` (Lebensdauer; fehlen beide, wird das Cookie beim Schließen des Browsers verworfen). Der Leitfaden empfiehlt, dass Sitzungskennungen so schnell wie möglich ablaufen. Das Beispiel unten verwendet genau diese Attribute. Die Webstandards und Browser-Voreinstellungen ändern sich; die jeweils aktuelle Dokumentation ist maßgeblich.

Das folgende Programm startet einen winzigen Webserver auf dem eigenen Rechner (Adresse 127.0.0.1, nur lokal erreichbar), ruft ihn per Programm ab und zeigt dabei, was im Hintergrund passiert: Der Server setzt zwei Cookies, ein gut abgesichertes und ein schlecht abgesichertes, und liefert eine Datei mit Zwischenspeicher-Anweisungen. Das Programm bewertet die Cookies und ruft die Datei zweimal ab.

```python
import threading, urllib.request, urllib.error
from http.server import BaseHTTPRequestHandler, HTTPServer
from http.cookies import SimpleCookie

class H(BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path == "/login":
            self.send_response(200)
            self.send_header("Set-Cookie", "sid=abc123; Path=/; Secure; HttpOnly; SameSite=Lax; Max-Age=3600")
            self.send_header("Set-Cookie", "werbung=1; Path=/")
            self.send_header("Cache-Control", "no-store")
            self.end_headers(); self.wfile.write(b"ok")
        elif self.path == "/logo.png":
            if self.headers.get("If-None-Match") == '"v1"':
                self.send_response(304); self.end_headers(); return
            self.send_response(200)
            self.send_header("ETag", '"v1"'); self.send_header("Cache-Control", "max-age=86400")
            self.end_headers(); self.wfile.write(b"PNGDATA")
    def log_message(self, *a): pass

srv = HTTPServer(("127.0.0.1", 0), H)
threading.Thread(target=srv.serve_forever, daemon=True).start()
base = f"http://127.0.0.1:{srv.server_port}"

antwort = urllib.request.urlopen(base + "/login")
for roh in antwort.headers.get_all("Set-Cookie"):
    c = SimpleCookie(); c.load(roh)
    for name, m in c.items():
        probleme = [t for t, ok in (("Secure fehlt", m["secure"]), ("HttpOnly fehlt", m["httponly"]),
                                    ("SameSite fehlt", m["samesite"])) if not ok]
        print(f"Cookie {name}: SameSite={m['samesite'] or '-'} Max-Age={m['max-age'] or '-'} -> {probleme or 'ok'}")
print("Cache-Control login:", antwort.headers["Cache-Control"])
r1 = urllib.request.urlopen(base + "/logo.png")
print("1. Abruf:", r1.status, r1.headers["ETag"], r1.headers["Cache-Control"], len(r1.read()), "Byte")
req = urllib.request.Request(base + "/logo.png", headers={"If-None-Match": '"v1"'})
try:
    urllib.request.urlopen(req)
except urllib.error.HTTPError as e:
    print("2. Abruf:", e.code, "(Not Modified: Inhalt kommt aus dem Cache)")
srv.shutdown()
```

Die Klasse `H` beschreibt das Verhalten des Servers bei einer Anfrage mit `GET`. Beim Pfad `/login` sendet sie zwei Kopfzeilen `Set-Cookie` sowie die Anweisung `Cache-Control: no-store` (nichts zwischenspeichern, richtig für sensible Seiten). Beim Pfad `/logo.png` schickt sie das Bild mit einer *ETag* (einer Versionskennung) und `max-age=86400` (24 Stunden darf der Browser die Datei ohne Nachfrage behalten); kommt die Anfrage mit der bereits bekannten Kennung zurück (`If-None-Match`), antwortet der Server nur mit dem Code 304 und ohne Inhalt: “Nicht verändert”. Der Server startet auf einem vom System gewählten freien Port (Port 0 bedeutet: such dir einen aus). Das Hauptprogramm liest die Cookies, zerlegt sie mit `SimpleCookie` und bewertet sie. Die Ausgabe: Das Cookie `sid` hat `Secure`, `HttpOnly`, `SameSite=Lax` und eine Lebensdauer von einer Stunde, ist also in Ordnung; `werbung` hat gar keine Schutzattribute, das Programm meldet alle drei Mängel. Der erste Abruf der Datei liefert Status 200 mit der Kennung und sieben Byte Inhalt; beim zweiten Abruf antwortet der Server 304, ein Browser würde nun die lokale Kopie verwenden. Man sieht, wie Cache und Cookies technisch funktionieren, und versteht, warum “Cache leeren” bei Anzeigeproblemen hilft.

### Typische Fehler.

Falsch ist, Warnungen des Browsers (ungültiges Zertifikat, “Verbindung nicht sicher”) wegzuklicken: Sie bedeuten, dass die Verbindung nicht geprüft werden kann. Falsch ist, Erweiterungen unbesehen zu installieren; weniger ist mehr, und im Unternehmen gibt es meist eine Liste erlaubter. Falsch ist, auf fremden Rechnern “Angemeldet bleiben” zu wählen oder Kennwörter speichern zu lassen. Falsch ist, bei Anzeigeproblemen sofort den ganzen Browser neu zu installieren; meist genügt es, Cache und Cookies dieser einen Seite zu löschen oder ein privates Fenster zu testen (Abschnitt 5.8).

### Praxisbezug.

“Die Seite zeigt noch die alten Preise” führt auf den Cache; “Ich werde ständig abgemeldet” oft auf blockierte Cookies oder falsche Uhrzeit; “Die Seite lädt nur bei mir nicht” auf eine Erweiterung, einen Proxy oder ein Zertifikatsproblem. Wer die Bausteine kennt, grenzt solche Fälle in wenigen Minuten ein.

## 5.3 E-Mail und Messaging

*E-Mail* ist trotz Chat-Diensten das wichtigste Kommunikationsmittel im Beruf und zugleich das beliebteste Einfallstor für Betrug. Technisch durchläuft eine Nachricht mehrere Stationen: Das Mailprogramm des Absenders übergibt sie per *SMTP* (Simple Mail Transfer Protocol) an den Mailserver, dieser reicht sie über das Internet an den Server des Empfängers weiter (das Ziel findet er über den DNS-Eintrag *MX*, Modul 4), und der Empfänger holt sie per *IMAP* (Nachrichten bleiben auf dem Server, mehrere Geräte sehen denselben Stand) oder *POP3* (Nachrichten werden abgeholt und meist vom Server entfernt). In Firmenumgebungen nutzt man häufig ein zusammenhängendes System aus Postfach, Kalender und Kontakten, das im Hintergrund über eigene Protokolle oder eine Weboberfläche läuft.

Eine E-Mail besteht aus dem *Kopf* (*Header*) und dem *Inhalt* (*Body*). Im Kopf stehen `From` (Absender), `To` (Empfänger), `Cc` (Kopie, für alle sichtbar), `Bcc` (Blindkopie, für die anderen unsichtbar), `Subject` (Betreff), `Date` und `Reply-To` (Adresse, an die eine Antwort geht, wenn sie von der Absenderadresse abweicht), dazu zahlreiche technische Zeilen: `Received` protokolliert jede Station, `Message-ID` ist die eindeutige Kennung. Der Inhalt kann Text, formatierten Text (HTML) und *Anhänge* enthalten; Anhänge werden dabei in Text umgewandelt (kodiert) und mit einem *Medientyp* (MIME-Typ, zum Beispiel `application/pdf`) beschriftet. Ein *Verteiler* (*Verteilerliste*) ist eine Adresse, hinter der mehrere Empfänger stehen; er spart Arbeit, birgt aber Risiken (versehentlich “Allen antworten”, ungeprüfte Mitglieder). Zur Terminverwaltung gehört der *Kalender*: Besprechungseinladungen werden als Termineinträge verschickt, die man annehmen, ablehnen oder vorläufig zusagen kann; Freigaben steuern, wer Details sieht.

> **Ergänzung aus der Nachrecherche**
>
> Weil Absenderangaben in der E-Mail leicht zu fälschen sind, gibt es drei ergänzende Verfahren, die der Mailserver des Empfängers prüft. Nach einer Zusammenfassung von linuxize.com (abgerufen, Drittquelle) lässt *SPF* den Empfänger prüfen, ob der sendende Server laut dem DNS-Eintrag der Absender-Domain senden darf, und zwar anhand der Absenderadresse im Übertragungsvorgang, *nicht* anhand der im Mailprogramm sichtbaren From-Zeile. *DKIM* hängt eine digitale Signatur an die Nachricht, die der Empfänger mit einem öffentlichen Schlüssel aus dem DNS prüft; sie zeigt, dass signierte Teile nicht verändert wurden. *DMARC* verlangt, dass SPF oder DKIM zur sichtbaren From-Domain passen, und veröffentlicht die Handlungsempfehlung des Domaininhabers bei Fehlschlägen; die Empfehlung ist ein Wunsch, kein Befehl. Alle drei sind Hilfsmittel; ein bestandener Test beweist weder, dass der Inhalt harmlos ist, noch, dass die Nachricht im Postfach landet.

Phishing wurde in Abschnitt 10.1 als Bedrohung erklärt und das Erkennen verdächtiger Adressen dort mit einem Programm geübt. Hier geht es um die Bausteine der *Nachricht* selbst. Typische *Indikatoren* sind: Anrede und Ton passen nicht (“Sehr geehrter Kunde”), Druck und Drohung (“Ihr Konto wird in 24 Stunden gesperrt”), eine Absenderadresse, die ähnlich aussieht, aber nicht stimmt, eine `Reply-To`-Adresse, die von der Absenderadresse abweicht, fehlgeschlagene Authentifizierungsprüfungen (SPF, DKIM, DMARC) im Kopf, Links, die auf eine andere Adresse zeigen als der angezeigte Text, Aufforderung zur Eingabe von Kennwörtern oder zur Überweisung, und Anhänge mit ungewöhnlichen oder doppelten Endungen, etwa `Rechnung.pdf.exe`: Windows blendet bekannte Endungen standardmäßig aus, sodass man nur “Rechnung.pdf” sähe, obwohl es ein Programm ist. Das folgende Programm baut eine solche verdächtige Nachricht mit dem Modul `email` der Standardbibliothek nach, zerlegt sie wieder und prüft diese Merkmale.

```python
from email.message import EmailMessage
from email import message_from_string, policy
import re

m = EmailMessage()
m["From"] = "IT-Support <support@firma-it-hilfe.example>"
m["To"] = "anna@example.at"
m["Reply-To"] = "kontakt@ganz-anders.example"
m["Subject"] = "Dringend: Ihr Konto wird in 24 Stunden gesperrt"
m["Authentication-Results"] = ("mx.example.at; spf=fail smtp.mailfrom=bounce@fremd.example; "
                               "dkim=none; dmarc=fail header.from=firma-it-hilfe.example")
m.set_content("Sehr geehrter Kunde,\nbitte bestaetigen Sie Ihr Passwort sofort unter http://192.0.2.7/login")
m.add_attachment(b"%PDF-1.4 fake", maintype="application", subtype="pdf", filename="Rechnung.pdf.exe")

n = message_from_string(m.as_string(), policy=policy.default)
print("Teile:", [t.get_content_type() for t in n.walk()])
print("Anhaenge:", [t.get_filename() for t in n.iter_attachments()])

def pruefe(n):
    funde = []
    absender = re.search(r"<(.+?)>", n["From"]).group(1).split("@")[1]
    antwort = re.search(r"@(.+)$", n["Reply-To"]).group(1) if n["Reply-To"] else absender
    if antwort != absender:
        funde.append(f"Reply-To ({antwort}) weicht von From ({absender}) ab")
    ar = n["Authentication-Results"] or ""
    for kurz in ("spf", "dkim", "dmarc"):
        wert = re.search(kurz + r"=(\w+)", ar)
        if not wert or wert.group(1) != "pass":
            funde.append(f"{kurz.upper()}: {wert.group(1) if wert else 'fehlt'}")
    text = n["Subject"] + n.get_body().get_content()
    if re.search(r"dringend|sofort|gesperrt|24 stunden", text, re.I):
        funde.append("Druck/Dringlichkeit")
    if re.search(r"https?://\d+\.\d+\.\d+\.\d+", n.get_body().get_content()):
        funde.append("Link auf IP-Adresse")
    for a in n.iter_attachments():
        if re.search(r"\.(pdf|docx?|xlsx?)\.(exe|js|scr|bat)$", a.get_filename().lower()):
            funde.append(f"Doppelte Endung: {a.get_filename()}")
    return funde

for f in pruefe(n):
    print(" -", f)
```

Die ersten Zeilen bauen die Nachricht auf: Absender “IT-Support” mit einer fremden Domain, eine abweichende `Reply-To`-Adresse, ein dringlicher Betreff, eine Kopfzeile `Authentication-Results` mit den (hier erfundenen) Prüfergebnissen des empfangenden Servers und ein PDF-Anhang, dessen Dateiname `Rechnung.pdf.exe` lautet. Der Text enthält eine Aufforderung und einen Link auf eine reine IP-Adresse. Danach wird die Nachricht in Text umgewandelt und wieder eingelesen, wie es ein Mailprogramm tut. Die Ausgabe der Struktur zeigt drei Teile (`multipart/mixed` als Hülle, `text/plain` und `application/pdf`) und den Anhangsnamen. Interessant ist: Der *deklarierte* Medientyp ist PDF, der Dateiname endet aber auf `.exe`; beides passt nicht zusammen. Die Prüffunktion findet sieben Merkmale: abweichende Antwortadresse, SPF fehlgeschlagen, DKIM nicht vorhanden, DMARC fehlgeschlagen, Dringlichkeit, Link auf IP-Adresse und doppelte Endung. Keines dieser Merkmale beweist allein einen Betrug, zusammen sind sie ein eindeutiges Bild. Umgekehrt gilt: Eine fehlende Warnung heißt nicht “sicher”, denn gut gemachte Angriffe bestehen die technischen Prüfungen, etwa über eine echte, aber kompromittierte Adresse.

Auch *Messaging-Dienste* (Chat, Kurznachrichten) sind betroffen. Sie sind schneller und informeller als E-Mail, sodass man leichter auf “Hallo, hier ist die Chefin, bitte kaufen Sie Geschenkkarten” hereinfällt; die Regeln sind dieselben: Absender über einen zweiten Weg prüfen, keine Zugangsdaten und keine sensiblen Daten in Chats, nicht auf Links unbekannter Absender klicken.

### Typische Fehler.

Falsch ist, bei “Allen antworten” nicht zu prüfen, wer in der Verteilerliste steht, oder vertrauliche Adressen im `Cc` statt im `Bcc` offenzulegen (ein häufiger Datenschutzvorfall). Falsch ist, Anhänge unbekannter Absender zu öffnen, nur weil sie “wichtig” wirken. Falsch ist, auf den angezeigten Namen zu vertrauen: Er lässt sich frei wählen. Falsch ist auch, per E-Mail Kennwörter, Kreditkartennummern oder Gesundheitsdaten zu senden; E-Mails sind standardmäßig nicht vertraulich.

### Praxisbezug.

Im Support kommt täglich die Frage “Ist diese Mail echt?”. Die richtige Antwort lautet nicht “sieht gut aus”, sondern Schritte: Absenderadresse prüfen, mit der Maus über Links fahren, im Zweifel die echte Seite über das Lesezeichen aufrufen, die Nachricht über den Meldeweg an die IT-Sicherheit weiterleiten und nichts anklicken (Abschnitt 10.7).

## 5.4 Office- und Produktivitätswerkzeuge

Unter *Office-Anwendungen* versteht man die Standardwerkzeuge des Büros: *Textverarbeitung* (Briefe, Berichte, Verträge), *Tabellenkalkulation* (Berechnungen, Listen, Diagramme), *Präsentation* (Folien) und *Notizen* (Gedanken, Protokolle, Listen). Bekannte Pakete sind Microsoft 365, LibreOffice und die Browser-Programme von Google; sie unterscheiden sich im Umfang, folgen aber denselben Ideen. Wichtig ist, für jede Aufgabe das passende Werkzeug zu wählen: Eine Liste mit Berechnung gehört in die Tabelle, ein Dokument mit Fließtext in die Textverarbeitung, eine Entscheidungsvorlage in die Präsentation, und Daten, die mehrere Benutzer gleichzeitig verändern und abfragen, gehören in eine Datenbank (Abschnitt 6.3), nicht in eine Tabelle mit fünf Leuten, die abwechselnd tippen.

Für die tägliche Arbeit sind einige Grundfertigkeiten wertvoll: *Formatvorlagen* statt Handformatierung (ein Dokument mit echten Überschriftenformaten erhält automatisch ein Inhaltsverzeichnis und bleibt konsistent), *Formeln* und Funktionen statt abgetippter Ergebnisse in der Tabelle (ändert sich ein Wert, rechnet alles neu), *Filter* und *Sortierung* für Listen, *Diagramme* für Auswertungen (Abschnitt 6.8), *Vorlagen* für wiederkehrende Dokumente und die *Rechtschreibprüfung*. Dateiformate spielen eine Rolle: Die offenen Formate der Programme (zum Beispiel `.docx`, `.xlsx`, `.pptx`, `.odt`) lassen sich bearbeiten, `.pdf` ist für die Weitergabe gedacht und verändert sich beim Empfänger nicht. Makros (automatische Abläufe in Dokumenten) sind praktisch, aber auch ein klassischer Weg für Schadsoftware; Dokumente mit Makros aus unbekannter Quelle öffnet man nicht.

Bei Zusammenarbeit entstehen *Versionen*. Moderne Dienste speichern automatisch jeden Bearbeitungsstand (*Versionsverlauf*) und erlauben das gemeinsame Bearbeiten in Echtzeit; bei klassischen Dateien auf einem Laufwerk gibt es dagegen nur die letzte gespeicherte Fassung, und wer zuletzt speichert, überschreibt die anderen. Dann entstehen Dateien wie “Bericht_final_neu2_wirklichfinal.docx”. Hilfreich sind klare *Namenskonventionen* und die Möglichkeit, zwei Fassungen zu vergleichen. Das folgende Programm demonstriert beides: Es vergleicht zwei Fassungen eines Berichts zeilenweise und findet einen *Konflikt*, der entsteht, wenn zwei Personen auf Grundlage derselben Ausgangsfassung denselben Wert unterschiedlich ändern.

```python
import difflib

v1 = ["Projektbericht", "Budget: 12000 Euro", "Termin: 15.11.", "Verantwortlich: Berger"]
v2 = ["Projektbericht", "Budget: 14500 Euro", "Termin: 15.11.", "Verantwortlich: Berger",
      "Neu: Risikoliste"]
for zeile in difflib.unified_diff(v1, v2, "Version 1 (Anna)", "Version 2 (Bernd)", lineterm=""):
    print(zeile)

basis = {"Budget": "12000", "Termin": "15.11."}
anna = {"Budget": "14000", "Termin": "15.11."}
bernd = {"Budget": "14500", "Termin": "15.11."}
for schluessel in basis:
    if anna[schluessel] != basis[schluessel] and bernd[schluessel] != basis[schluessel] \
            and anna[schluessel] != bernd[schluessel]:
        print(f"Konflikt bei {schluessel}: Anna={anna[schluessel]}, Bernd={bernd[schluessel]}"
              f" (Basis {basis[schluessel]})")
```

Die Funktion `unified_diff` aus dem Modul `difflib` erzeugt eine Änderungsansicht im verbreiteten Format: Zeilen mit einem Minuszeichen wurden entfernt (“Budget: 12000 Euro”), Zeilen mit einem Pluszeichen sind neu (“Budget: 14500 Euro” und “Neu: Risikoliste”), Zeilen ohne Zeichen blieben gleich; die Zeile mit `@@` nennt die betroffenen Zeilenbereiche. Genau so zeigen Office-Programme die “Änderungen nachverfolgen”. Im zweiten Teil gehen beide Personen von der gleichen Ausgangsfassung (`basis`) aus, ändern aber beide das Budget, Anna auf 14000 und Bernd auf 14500. Die Bedingung prüft, ob *beide* vom Ausgangswert abweichen *und* unterschiedliche Werte haben; nur dann meldet das Programm einen Konflikt (hier beim Budget). Der Termin ist unverändert, kein Konflikt. Dieses Prinzip steckt auch in Versionsverwaltungen (Abschnitt 7.7).

### Typische Fehler.

Falsch ist, Dokumente per E-Mail im Kreis zu schicken und nachher fünf Fassungen zusammenführen zu müssen; richtig ist ein gemeinsamer Ablageort mit Versionsverlauf. Falsch ist, Berechnungen mit Taschenrechner in die Tabelle einzutippen, statt Formeln zu verwenden. Falsch ist, personenbezogene Daten in Tabellen ohne Zugriffsschutz abzulegen. Falsch ist, wichtige Dokumente nur auf dem lokalen Desktop zu speichern, wo kein Backup sie erfasst (Abschnitt 6.6). Falsch ist auch, ein bearbeitbares Dokument zu versenden, wenn die Weitergabe eines PDF genügt (versteckte Metadaten, unbeabsichtigte Änderungen).

### Praxisbezug.

“Wer hat meine Änderung überschrieben?” beantwortet der Versionsverlauf; “Das Dokument ist gesperrt” meist eine zweite Person, die es noch geöffnet hat. Der Support zeigt neuen Mitarbeitern, wie sie Vorlagen und gemeinsame Ablageorte verwenden.

## 5.5 Kollaborationsplattformen

Kollaborationsplattformen vereinen Werkzeuge für die Zusammenarbeit an einem Ort: *Chat* in Kanälen und Direktnachrichten, *Videokonferenz* mit Bildschirmfreigabe, *Dateiablage* mit Freigaben, *gemeinsame Bearbeitung* von Dokumenten in Echtzeit, Aufgabenlisten, Kalender und Anbindung weiterer Dienste. Bekannte Beispiele sind Microsoft Teams, Slack, Google Workspace und Zoom; die Namen wechseln, die Konzepte bleiben. Sie ersetzen weitgehend interne E-Mails, weil Kommunikation und Dateien am selben Ort (*Team*, *Kanal*, *Projekt*) liegen und sich nachlesen lassen.

Mit der Bequemlichkeit entstehen neue Regeln. Für die *Dateiablage* gilt: Es gibt *einen* verbindlichen Ort pro Dokument (kein Kopieren in zehn Kanäle), eine nachvollziehbare Ordnerstruktur, klare Namen (Abschnitt 5.4), und Freigaben nach dem Prinzip der geringsten Rechte (Abschnitt 10.6): Mitglieder des Teams, nicht “jeder mit dem Link”. Für *Chat* gilt: Kanäle für Themen statt für Personen, Direktnachrichten für Persönliches, keine vertraulichen Daten in öffentlichen Kanälen, Verzicht auf Entscheidungen, die nur im Chat verschwinden (Beschlüsse gehören ins Protokoll). Für *Videokonferenzen* gilt die *Meeting-Hygiene*: Zweck und Agenda vorab, nur die nötigen Personen, Beginn und Ende pünktlich, Mikrofon stumm, wenn man nicht spricht, Kamera nach Absprache, Ergebnisse und Aufgaben mit Verantwortlichem und Termin am Ende, Aufzeichnung nur nach Zustimmung (Datenschutz). Zugangslinks sind Zugangsdaten: Sie gehören nicht öffentlich ins Netz, und bei vertraulichen Besprechungen nutzt man Wartebereich und Teilnehmerprüfung, damit keine Fremden eintreten (“Zoom-Bombing”).

Dateiablage-Regeln lassen sich teilweise automatisch prüfen, was das folgende Programm für eine einfache Namenskonvention tut: Dateien sollen nach dem Muster `JJJJ-MM-TT_Projekt_Thema_vNN.endung` heißen. Ein regulärer Ausdruck prüft die Form, anschließend wird das Datum auf Plausibilität kontrolliert.

```python
import re

MUSTER = re.compile(r"^(\d{4})-(\d{2})-(\d{2})_([A-Za-z0-9]+)_([A-Za-z0-9-]+)_v(\d{2})\.(docx|xlsx|pptx|pdf)$")

def pruefe(name):
    m = MUSTER.match(name)
    if not m:
        return "entspricht nicht JJJJ-MM-TT_Projekt_Thema_vNN.endung"
    monat, tag = int(m.group(2)), int(m.group(3))
    if not (1 <= monat <= 12 and 1 <= tag <= 31):
        return "ungueltiges Datum"
    return "ok"

for n in ["2026-10-26_Alpha_Kickoff-Protokoll_v02.docx",
          "Protokoll final final NEU.docx",
          "2026-13-01_Alpha_Plan_v01.xlsx",
          "2026-10-26_Alpha_Budget_v1.xlsx"]:
    print(f"{pruefe(n):55} {n}")
```

Der reguläre Ausdruck beschreibt den Namen Stück für Stück: vier Ziffern, zwei Ziffern, zwei Ziffern, jeweils mit Bindestrich getrennt, dann ein Unterstrich, ein Projektname aus Buchstaben und Ziffern, ein Thema (zusätzlich mit Bindestrich erlaubt), `_v` gefolgt von genau zwei Ziffern und eine erlaubte Endung. Die runden Klammern bilden “Gruppen”, die man mit `m.group(n)` einzeln abfragen kann; so werden Monat und Tag herausgelöst und geprüft. Die Ausgabe: Der erste Name ist in Ordnung; “Protokoll final final NEU.docx” hat nicht die Form; `2026-13-01_...` hat die Form, aber Monat 13 gibt es nicht; `_v1` hat nur eine Ziffer, sodass die Form nicht erfüllt ist. Der Wert solcher Regeln liegt im Alltag: Namen mit Datum sortieren sich von selbst chronologisch, und “v02” sagt klar, welche Fassung gemeint ist. Streng genommen ist der Versionsverlauf der Plattform der bessere Weg; die Konvention hilft dort, wo Dateien verschickt werden.

### Typische Fehler.

Falsch sind Kanäle ohne Zweck und ohne Regeln, in denen sich nach Monaten niemand zurechtfindet. Falsch ist, Dateien zu verschicken, statt auf die Ablage zu verlinken, und damit jede Aktualität zu verlieren. Falsch ist, in Besprechungen zu schweigen, was beschlossen wurde. Falsch ist, in Videokonferenzen den Bildschirm freizugeben, ohne vorher private Fenster und Benachrichtigungen zu schließen: Mailvorschauen und Kennwortmanager sind dann für alle sichtbar. Falsch ist, ehemaligen Teammitgliedern den Zugang zu belassen.

### Praxisbezug.

Beim Projektstart richtet das Team einen Kanal ein, legt die Ablagestruktur an und vereinbart die Regeln; beim Projektende werden Dateien archiviert und die Zugriffe beendet (Abschnitt 6.2). Support-Fragen drehen sich um Mikrofon und Kamera (Berechtigung im Betriebssystem), um Berechtigungen für Dateien und um die Frage “Warum sehe ich den Kanal nicht?” (Mitgliedschaft).

## 5.6 Benutzerkonten und Identität

Ein *Benutzerkonto* (*Account*) ist die digitale Identität eines Menschen (oder eines Programms) in einem System. Es besteht aus einem *Benutzernamen* (*Username*, öffentlich bekannt, oft die E-Mail-Adresse), einem Nachweis (*Passwort* oder andere Faktoren) und *Rechten* (was darf das Konto?). Die Begriffe Authentisierung (wer bist du?) und Autorisierung (was darfst du?) und die Schutzmaßnahmen dazu (Passwortlänge, Salz und Hash, Faktoren, geringste Rechte) werden in Abschnitt 10.3 ausführlich erklärt; hier geht es um das Verständnis im Alltag eines Anwenders und um die Frage, wie sich mehrere Dienste mit einer Anmeldung nutzen lassen.

Der Alltag zeigt ein Problem: Jeder Mitarbeiter nutzt Dutzende Dienste, und niemand merkt sich Dutzende gute Passwörter. Die Folgen sind wiederverwendete oder aufgeschriebene Kennwörter. Die Lösung heißt *Single Sign-on* (SSO, Einmalanmeldung). Dabei meldet man sich einmal bei einer zentralen Stelle an, dem *Identity Provider* (IdP, Identitätsanbieter), und erhält einen *Nachweis*, ein *Token*. Die einzelnen Anwendungen (die “Dienstanbieter”) vertrauen dem IdP: Sie prüfen das Token und lassen den Nutzer ein, ohne dass er sich neu anmelden muss. Technisch kommen dafür Standards wie SAML und OpenID Connect zum Einsatz. Die Vorteile: weniger Passwörter, zentrale Verwaltung (beim Austritt wird ein Konto gesperrt, und alle Zugänge sind weg), einheitliche Regeln und MFA an einer Stelle. Der Nachteil: Der IdP ist ein *Single Point of Failure* und ein wertvolles Angriffsziel, daher muss er besonders geschützt sein (MFA, Überwachung).

Die *Mehr-Faktor-Anmeldung* (MFA) kombiniert verschiedene Faktoren (Wissen, Besitz, Sein; Abschnitt 10.3). Für Anwender sind drei Dinge wichtig: Codes oder Bestätigungen *niemals weitergeben*, auch nicht an “die IT”; Bestätigungsanfragen, die man *nicht ausgelöst* hat, ablehnen und melden (Angreifer bombardieren Nutzer manchmal mit Anfragen, in der Hoffnung, dass jemand irgendwann “Genehmigen” drückt); und *Wiederherstellungscodes* sicher aufbewahren, damit man nach Verlust des Smartphones wieder hineinkommt. Verbreitet sind Passwortmanager: Sie erzeugen und speichern lange, einzigartige Kennwörter, sind selbst durch ein starkes Hauptkennwort und MFA geschützt und tragen sie nur auf der echten Seite ein, was ein wirksamer Schutz vor Phishing ist, denn auf einer gefälschten Domain bietet der Manager nichts an.

Das folgende Programm zeigt die Idee des Tokens in Miniatur. Ein “Identitätsanbieter” stellt ein Token aus, das Name, Rollen und Ablaufzeit enthält und mit einem geheimen Schlüssel signiert ist (ein HMAC, wie in Abschnitt 10.2); ein “Dienst” prüft Signatur und Ablauf. Echte Tokens (zum Beispiel JSON Web Tokens) sind ähnlich aufgebaut, verwenden aber geprüfte Bibliotheken und oft asymmetrische Signaturen; das Beispiel ist ein Lehrmodell und kein Muster für eigene Sicherheitslösungen.

```python
import base64, hashlib, hmac, json

GEHEIM = b"idp-schluessel-nur-auf-dem-idp"

def b64(x):
    return base64.urlsafe_b64encode(x).rstrip(b"=").decode()

def unb64(s):
    return base64.urlsafe_b64decode(s + "=" * (-len(s) % 4))

def ausstellen(user, rollen, gueltig_s, jetzt):
    nutzlast = json.dumps({"sub": user, "rollen": rollen, "exp": jetzt + gueltig_s, "mfa": True}).encode()
    sig = hmac.new(GEHEIM, nutzlast, hashlib.sha256).digest()
    return b64(nutzlast) + "." + b64(sig)

def pruefen(token, jetzt):
    p, s = token.split(".")
    nutzlast = unb64(p)
    soll = hmac.new(GEHEIM, nutzlast, hashlib.sha256).digest()
    if not hmac.compare_digest(soll, unb64(s)):
        return "ABGELEHNT: Signatur ungueltig"
    daten = json.loads(nutzlast)
    if daten["exp"] < jetzt:
        return "ABGELEHNT: abgelaufen"
    return f"OK: {daten['sub']} Rollen={daten['rollen']}"

t0 = 1_800_000_000
token = ausstellen("anna", ["buchhaltung"], 3600, t0)
print(pruefen(token, t0 + 60))
print(pruefen(token, t0 + 7200))
p, s = token.split(".")
falsch = json.dumps({"sub": "anna", "rollen": ["admin"], "exp": t0 + 3600, "mfa": True}).encode()
print(pruefen(b64(falsch) + "." + s, t0 + 60))
```

Die Funktion `ausstellen` verpackt Benutzer, Rollen, Ablaufzeitpunkt und den Vermerk “MFA wurde durchgeführt” als Text (JSON), berechnet darüber die Signatur und hängt beides, jeweils in eine druckbare Schreibweise (Base64) umgewandelt, mit einem Punkt zusammen. Die Zeit wird als Parameter übergeben (hier als Sekundenzahl), damit das Beispiel reproduzierbar ist. `pruefen` zerlegt das Token, berechnet die Signatur neu und vergleicht sie; stimmt sie nicht, ist das Token gefälscht oder verändert. Erst danach wird der Ablauf geprüft. Die Ausgabe: Eine Minute nach Ausstellung ist das Token gültig (`OK: anna Rollen=['buchhaltung']`), nach zwei Stunden ist es abgelaufen, und eine Fälschung, bei der jemand sich selbst die Rolle “admin” gibt, aber die alte Signatur beibehält, wird abgelehnt, weil die Signatur nicht zum veränderten Inhalt passt. Genau deshalb kann ein Dienst dem Token vertrauen, ohne selbst Passwörter zu kennen. Die begrenzte Gültigkeit begrenzt den Schaden, falls ein Token gestohlen wird.

### Typische Fehler.

Falsch ist, Konten zu teilen (“wir benutzen alle das Konto von Frau Berger”): Dann ist nichts mehr nachvollziehbar, und beim Austritt vergisst man den Zugang. Falsch ist, Standardkennwörter nicht zu ändern, Passwörter in Chats oder Tickets zu schreiben oder per E-Mail zu versenden. Falsch ist, aus Bequemlichkeit MFA-Prompts blind zu bestätigen. Falsch ist, bei der “Passwort vergessen”-Funktion unsichere Sicherheitsfragen zu verwenden, deren Antworten man öffentlich recherchieren kann. Und falsch ist, bei SSO nur den Komfort zu sehen: Der zentrale Zugang muss besonders gesichert werden.

### Praxisbezug.

Anfragen “Ich komme nicht mehr in mein Konto” sind der Klassiker im Support. Vor der Hilfe muss der Support die Identität des Anrufers prüfen (Rückruf unter bekannter Nummer, Freigabe durch Vorgesetzte), denn Betrüger rufen an und geben sich als Mitarbeiter aus. Zurückgesetzt wird das Konto nach festem Verfahren; Kennwörter werden nie am Telefon vorgelesen.

> **Merke**
>
> Konto = Benutzername + Nachweis + Rechte. SSO: einmal anmelden, Token gilt für viele Dienste; Identity Provider schützen. MFA: Codes nie weitergeben, unbekannte Anfragen ablehnen. Passwortmanager statt Wiederverwendung. Details zu Passwörtern, Faktoren und Rechten: Abschnitt 10.3.

## 5.7 SaaS und Service-Konzepte

*Software as a Service* (SaaS, Software als Dienst) bedeutet, dass der Anbieter die Anwendung betreibt und der Kunde sie über das Internet nutzt, meist im Browser, gegen eine regelmäßige Gebühr. Der Kunde installiert, wartet und aktualisiert nichts; das erledigt der Anbieter für alle Kunden gleichzeitig. Beispiele sind E-Mail- und Büro-Pakete aus der Cloud, Kundenverwaltung, Buchhaltung, Ticketsysteme und Videokonferenzen. Wie sich SaaS zu den anderen Cloud-Modellen (IaaS, PaaS) verhält und wer wofür die Verantwortung trägt, erklärt Abschnitt 8.3; hier geht es um Eigenschaften, die man als Nutzer und Support-Mitarbeiter kennen muss.

> **Ergänzung aus der Nachrecherche**
>
> Die Definition des amerikanischen Standardisierungsinstituts NIST (Special Publication 800-145, abgerufen) beschreibt Cloud-Dienste mit fünf Merkmalen: Selbstbedienung bei Bedarf, breiter Netzzugang, gebündelte Ressourcen (“pooled to serve multiple consumers using a multi-tenant model”, also mit gemeinsamer Nutzung durch mehrere Kunden), schnelle Anpassbarkeit und gemessene Nutzung. SaaS wird dort so definiert, dass Anwender die vom Anbieter betriebenen Anwendungen nutzen, meist über einen Browser oder eine Programmschnittstelle, ohne die zugrunde liegende Infrastruktur zu verwalten. Diese Definition stammt aus dem Jahr 2011 und ist weiterhin die meistzitierte Grundlage; Marketingbegriffe einzelner Anbieter gehen darüber hinaus.

Ein zentrales Konzept ist die *Mandantenfähigkeit* (*Multi-Tenancy*). Der Anbieter betreibt nicht für jeden Kunden eine eigene Installation, sondern eine gemeinsame, in der viele Kunden (*Mandanten*, englisch *Tenants*) nebeneinander arbeiten und logisch streng voneinander getrennt sind: Jeder Kunde sieht nur seine Daten, seine Benutzer und seine Einstellungen. Das macht den Betrieb für den Anbieter effizient und damit für den Kunden günstig, stellt aber hohe Anforderungen an die Trennung, denn ein Fehler könnte Daten eines Kunden einem anderen zeigen. Die *Verfügbarkeit* ist vertraglich zugesichert, meist als Prozentwert pro Monat oder Jahr (Abschnitt 9.1); sie gilt für den Dienst des Anbieters, nicht für die Internetverbindung des Kunden. Die Abrechnung erfolgt im *Abonnement*: pro Nutzer und Monat oder Jahr, nach Funktionsumfang gestaffelt (Basis, Standard, Premium), oder nutzungsabhängig. Ein Jahresabonnement ist oft günstiger als monatliche Zahlung, bindet aber länger. Zu den Risiken zählen der Anbieterwechsel (Datenmitnahme: “Vendor Lock-in”), die Abhängigkeit vom Anbieter, Preisänderungen, Änderungen am Funktionsumfang ohne Mitspracherecht und rechtliche Fragen (Wo liegen die Daten? Wer hat Zugriff? Auftragsverarbeitungsvertrag, Abschnitt 11.3). Gegenüber lokal installierter Software verliert man also Kontrolle und gewinnt Bequemlichkeit.

Das folgende Programm zeigt zwei Dinge. Erstens, wie Mandantentrennung in einer gemeinsamen Datenbank mit einem Mandantenkennzeichen funktioniert und was bei einem vergessenen Filter passiert. Zweitens rechnet es den Preisunterschied zwischen monatlicher und jährlicher Zahlung und die erlaubte Ausfallzeit bei 99,9 Prozent Verfügbarkeit aus.

```python
import sqlite3

db = sqlite3.connect(":memory:")
db.executescript("""CREATE TABLE rechnung (id INTEGER PRIMARY KEY, mandant TEXT NOT NULL,
                    kunde TEXT, betrag REAL);
INSERT INTO rechnung VALUES (1,'firma_a','Huber',100),(2,'firma_a','Moser',250),
                            (3,'firma_b','Weiss',999);""")

def liste(mandant):
    return db.execute("SELECT id, kunde, betrag FROM rechnung WHERE mandant = ?", (mandant,)).fetchall()

def liste_fehlerhaft():
    return db.execute("SELECT id, mandant, kunde FROM rechnung").fetchall()

print("firma_a sieht:", liste("firma_a"))
print("firma_b sieht:", liste("firma_b"))
print("Fehler ohne Mandantenfilter:", liste_fehlerhaft())

nutzer, preis_monat, preis_jahr = 40, 12.5, 125.0
monatlich = nutzer * preis_monat * 12
jaehrlich = nutzer * preis_jahr
print("Monatlich:", monatlich, "pro Jahr; Jahresabo:", jaehrlich, "-> Ersparnis", monatlich - jaehrlich)
verfuegbarkeit = 0.999
print(f"99,9 % = {(1 - verfuegbarkeit) * 365 * 24 * 60:.0f} Minuten Ausfall pro Jahr erlaubt")
```

Die Tabelle `rechnung` enthält die Daten zweier Kunden, unterschieden durch die Spalte `mandant`. Die Funktion `liste` stellt die Abfrage immer mit dem Filter `WHERE mandant = ?` und übergibt den Mandanten als Parameter; so sieht `firma_a` die Rechnungen 1 und 2 und `firma_b` nur Rechnung 3. Die Funktion `liste_fehlerhaft` lässt den Filter weg und liefert alle drei Zeilen: Ein solcher Programmierfehler wäre bei einem echten Anbieter ein schwerer Datenschutzvorfall. Gute Anbieter verhindern das, indem die Trennung nicht dem einzelnen Entwickler überlassen, sondern zentral erzwungen wird. Die Preisrechnung ergibt für 40 Nutzer bei 12,50 monatlich 6 000 pro Jahr, beim Jahresabonnement für 125 pro Nutzer 5 000, also 1 000 Ersparnis, wenn man sich für ein Jahr bindet. 99,9 Prozent Verfügbarkeit erlauben rund 526 Minuten (knapp neun Stunden) Ausfall pro Jahr, das ist die Rechnung aus Abschnitt 9.1. Preise und Nutzerzahlen sind erfunden.

### Typische Fehler.

Falsch ist anzunehmen, dass SaaS-Daten ohne eigenes Zutun gesichert sind: Anbieter sichern ihre Systeme, nicht unbedingt die versehentlich gelöschten Daten des Kunden in jeder gewünschten Aufbewahrungsdauer; das ist im Vertrag nachzulesen (Abschnitt 6.6, 12.6). Falsch ist, ein Abonnement nach Mitarbeiterfluktuation ungeprüft weiterzuzahlen (“Lizenzleichen”) oder Konten ausgetretener Mitarbeiter bestehen zu lassen. Falsch ist, beim Wechsel zu SaaS die Datenmitnahme nicht zu klären. Falsch ist, den Anbieter für alles verantwortlich zu halten: Konten, Rechte und Freigaben sind Sache des Kunden.

### Praxisbezug.

Beim Entscheid “lokal oder SaaS?” wägt man ab: Aufwand für Betrieb und Updates, Datenschutz, Funktionsumfang, Kosten über die Laufzeit (Abschnitt 12.3), Verfügbarkeit, Ausstiegsmöglichkeiten. Der Support merkt es im Alltag: Ein Ausfall des Anbieters ist nicht mit eigenen Mitteln zu beheben; man informiert die Nutzer, prüft die Statusseite des Anbieters und wartet oder weicht auf Notverfahren aus.

## 5.8 Anwendungs-Troubleshooting

Für Fehler in Anwendungen gilt dieselbe Methode wie für alle Störungen (Abschnitt 9.8): Problem identifizieren, Theorie bilden, testen, Plan, umsetzen oder eskalieren, prüfen, dokumentieren. In diesem Abschnitt geht es um typische Fehlerbilder bei Anwendungen und um die Kunst, ein Problem so zu beschreiben, dass andere damit arbeiten können.

Bei *Browserproblemen* (Seite lädt nicht, zeigt Altes, Anmeldung scheitert) klärt man zuerst: Betrifft es nur diese Seite oder alle? Nur diesen Browser oder alle? Nur dieses Gerät oder auch andere? Dann bewährt sich eine feste Reihenfolge: Seite neu laden (mit Strg+F5, das den Cache umgeht), ein *privates Fenster* testen (ohne Cookies, Cache und Erweiterungen), *Cache und Cookies* der betroffenen Seite löschen, *Erweiterungen* nacheinander ausschalten, einen anderen Browser versuchen, das Netz wechseln (zum Beispiel mobiles Datennetz statt Firmen-WLAN), Datum und Uhrzeit des Geräts prüfen (eine falsche Zeit lässt Zertifikate ungültig erscheinen). Bei *Office-Problemen* (Programm hängt, Add-in macht Ärger, Druck funktioniert nicht) startet man das Programm im *abgesicherten Modus* (ohne Add-ins), deaktiviert Add-ins einzeln, prüft, ob die Datei selbst das Problem ist (anderes Dokument öffnen), und lässt die Installation bei Bedarf reparieren. Bei *Synchronisationsproblemen* von Cloud-Dateien prüft man Internetverbindung, Anmeldung, freien Speicherplatz im Konto und auf dem Gerät, ob Konflikt-Dateien entstanden sind und ob Dateinamen unzulässige Zeichen oder zu lange Pfade enthalten. Beim *Druck aus Office-Anwendungen* prüft man Standarddrucker, ob ein anderes Dokument oder ein anderer Drucker funktioniert, die Druckwarteschlange und den Treiber; so grenzt man ein, ob Dokument, Programm, Treiber oder Gerät schuld ist.

Mindestens ebenso wichtig ist die *Fehlerbeschreibung*. Der Support braucht: Was genau geschieht (Wortlaut der Fehlermeldung, Screenshot)? Wer ist betroffen (eine Person, eine Abteilung)? Seit wann, und was hat sich zuvor geändert? Welche Anwendung, Version, welches Gerät? Wie lässt sich der Fehler wiederholen? Was wurde schon versucht? Je vollständiger das ist, desto weniger Rückfragen braucht es (Abschnitt 9.5). Das folgende Programm erzeugt aus diesen Angaben einen Bericht, der bereits Getanes von noch Ausstehendem trennt.

```python
DIAGNOSE = {
    "seite_laedt_nicht": ["anderen Browser/Privatfenster testen", "Cache und Cookies der Seite loeschen",
                          "Erweiterungen deaktivieren", "anderes Netz testen"],
    "office_add_in_haengt": ["Programm im abgesicherten Modus starten", "Add-ins einzeln deaktivieren",
                             "Office reparieren lassen"],
    "konto_sync_fehler": ["Internetverbindung pruefen", "ab- und neu anmelden",
                          "Speicherplatz im Konto pruefen", "Konflikt-Dateien suchen"],
    "druck_aus_office": ["Standarddrucker pruefen", "anderes Dokument/anderer Drucker testen",
                         "Druckwarteschlange leeren", "Treiber pruefen"],
}

def bericht(symptom, wer, seit, schritte_getan, meldung):
    ueberig = [s for s in DIAGNOSE[symptom] if s not in schritte_getan]
    zeilen = [f"Symptom: {symptom}", f"Betroffen: {wer}, seit {seit}",
              f"Fehlermeldung (Wortlaut): {meldung!r}",
              "Bereits geprueft: " + (", ".join(schritte_getan) or "nichts"), "Naechste Schritte:"]
    zeilen += [f"  {i}. {s}" for i, s in enumerate(ueberig, 1)]
    return "\n".join(zeilen)

print(bericht("seite_laedt_nicht", "Anna Berger, Buchhaltung", "heute 08:15",
              ["anderen Browser/Privatfenster testen"], "ERR_CONNECTION_TIMED_OUT"))
```

Das Wörterbuch `DIAGNOSE` enthält pro Fehlerbild die Standardschritte in sinnvoller Reihenfolge. Die Funktion `bericht` filtert die noch nicht durchgeführten Schritte heraus (`ueberig`) und setzt den Bericht zusammen; der Wortlaut der Fehlermeldung wird mit `!r` in Anführungszeichen ausgegeben, damit Leerzeichen und Sonderzeichen sichtbar bleiben. Die Ausgabe zeigt das Symptom, die betroffene Person und den Beginn, die Meldung `ERR_CONNECTION_TIMED_OUT`, den bereits erledigten Test im privaten Fenster und drei nummerierte nächste Schritte (Cache löschen, Erweiterungen deaktivieren, anderes Netz testen). Das Beispiel ist eine Gedächtnisstütze, kein Ersatz für Verständnis: Es nennt Schritte, aber wählt nicht die richtigen aus. Dafür braucht man das Wissen aus den vorigen Abschnitten.

### Typische Fehler.

Falsch ist, bei jedem Problem sofort die Anwendung zu deinstallieren und neu zu installieren: Das kostet Zeit und verdeckt die Ursache. Falsch ist, nur “Es geht nicht” zu melden. Falsch ist, mehrere Änderungen gleichzeitig vorzunehmen (Abschnitt 9.8). Falsch ist, bei Konto- und Synchronisationsproblemen Daten zu löschen, bevor eine Sicherung existiert. Und falsch ist, die Fehlermeldung wegzuklicken, ohne sie zu lesen oder zu fotografieren; sie enthält oft die Lösung oder zumindest ein Stichwort für die Suche.

### Praxisbezug.

Die meisten Anfragen im First-Level-Support betreffen genau diese Fälle. Wer die Eingrenzungsfragen (Nur ich oder alle? Nur hier oder auch anderswo? Seit wann?) und die Standardschritte beherrscht, löst einen großen Teil der Fälle selbst und übergibt den Rest sauber. Eine gute Übergabe an den Second Level enthält den Bericht, die Ergebnisse der Tests und eine Einschätzung der Dringlichkeit.

## Übungsaufgaben Modul 05

1.  Nennen Sie je zwei Vor- und Nachteile von Desktop-, Web- und mobilen Anwendungen. Für welche Art entscheiden Sie sich bei einer Zeiterfassung, die Außendienstmitarbeiter auf Baustellen mit schlechtem Netz nutzen, und warum?

2.  Erklären Sie in je einem Satz, was ein Cookie, der Cache und eine Browser-Erweiterung sind, und nennen Sie je ein Risiko. Wozu dienen die Attribute `Secure`, `HttpOnly` und `SameSite`?

3.  Beschreiben Sie den Weg einer E-Mail vom Absender zum Empfänger (SMTP, MX, IMAP/POP3). Worin unterscheiden sich `Cc` und `Bcc`, und warum ist `Bcc` bei Rundschreiben an Kunden die bessere Wahl?

4.  Nennen Sie sechs Indikatoren einer Phishing-Nachricht und erklären Sie, warum die Anzeige “SPF: pass” allein keine Entwarnung ist.

5.  Erklären Sie Single Sign-on mit den Begriffen Identity Provider, Token und Dienst. Nennen Sie je zwei Vor- und Nachteile.

6.  **Praxis:** Schreiben Sie ein Python-Programm, das mit `http.cookies.SimpleCookie` die Kopfzeile `sid=xyz; Path=/; Secure; HttpOnly; SameSite=Strict` zerlegt und ausgibt, ob die drei Schutzattribute gesetzt sind. Testen Sie es auch mit `theme=dark; Path=/`.

7.  **Praxis:** Erweitern Sie die Namensprüfung aus Abschnitt 5.5 so, dass sie zusätzlich verbietet, dass das Thema das Wort “final” enthält, und melden Sie bei jedem Namen alle Verstöße als Liste. Testen Sie mit drei Beispielnamen.

8.  **Praxis:** Schreiben Sie eine Funktion `abo_kosten(nutzer, monat, jahr, monate_nutzung)`, die für eine Nutzungsdauer in Monaten (zwischen 1 und 36) die günstigere Variante (monatlich oder jährlich, wobei Jahre jeweils voll bezahlt werden) und den Preis zurückgibt. Testen Sie für 10 Nutzer, 12,50 Euro pro Monat, 125 Euro pro Jahr und Nutzungsdauern von 6, 12 und 18 Monaten.

9.  Eine Kollegin meldet: “Seit heute Morgen kann ich unsere Projektseite im Browser nicht mehr öffnen.” Formulieren Sie die ersten fünf Rückfragen und die ersten fünf Prüfschritte in sinnvoller Reihenfolge.

## Lösungen Modul 05

1.  Desktop: Vorteile offline, Hardwarezugriff, hoher Funktionsumfang; Nachteile Installation und Pflege pro Gerät, an Betriebssystem gebunden. Web: Vorteile überall erreichbar, zentral gepflegt; Nachteile braucht Verbindung, eingeschränkter Gerätezugriff. Mobil: Vorteile Touch, Kamera, Ortung, Benachrichtigungen; Nachteile kleiner Bildschirm, Abhängigkeit von Stores und Gerätehersteller. Für die Zeiterfassung auf Baustellen mit schlechtem Netz eignet sich eine mobile App mit Offline-Speicherung und späterer Übertragung (oder eine Progressive Web App mit Offline-Funktion), nicht eine reine Web-Anwendung, die ständig Verbindung braucht.

2.  Cookie: kleine Textmarke, die der Browser an den Server zurücksendet; Risiko: Verfolgung oder Diebstahl der Sitzung. Cache: Zwischenspeicher bereits geladener Dateien; Risiko: veraltete Anzeige, sensible Inhalte auf gemeinsam genutzten Geräten. Erweiterung: Zusatzfunktion mit weitreichenden Rechten; Risiko: Mitlesen von Daten. `Secure`: nur über HTTPS senden. `HttpOnly`: nicht für JavaScript lesbar, schützt die Sitzungskennung vor Diebstahl durch Schadcode. `SameSite`: schränkt den Versand bei Anfragen von fremden Seiten ein.

3.  Das Mailprogramm übergibt die Nachricht per SMTP an den Mailserver, dieser ermittelt über den MX-Eintrag im DNS den Server der Ziel-Domain und liefert sie dort ab; der Empfänger holt sie per IMAP (bleibt auf dem Server, mehrere Geräte) oder POP3 (wird abgeholt, meist vom Server entfernt). `Cc`-Empfänger sind für alle sichtbar, `Bcc`-Empfänger für die anderen unsichtbar; bei Rundschreiben verhindert `Bcc`, dass Kunden die Adressen der anderen sehen (Datenschutz).

4.  Indikatoren: Druck und Drohung, unpersönliche Anrede, abweichende Absender- oder Antwortadresse, Link-Ziel passt nicht zum Text, Aufforderung zur Passworteingabe, Anhang mit doppelter Endung, fehlgeschlagene Authentifizierungsprüfungen, unerwartete Nachricht von bekanntem Absender. SPF prüft die Absenderadresse im Übertragungsvorgang, nicht die sichtbare From-Zeile; ein Betrüger kann eine eigene Domain mit gültigem SPF betreiben, oder das Konto eines echten Absenders übernehmen. “pass” beweist nur, dass der Server senden durfte.

5.  Man meldet sich beim Identity Provider an und erhält ein Token; die Dienste vertrauen dem Provider, prüfen das Token (Signatur, Ablauf) und lassen den Nutzer ein. Vorteile: weniger Passwörter, zentrale Verwaltung und Sperre, einheitliche Regeln, MFA an einer Stelle. Nachteile: Der Provider ist Single Point of Failure und besonders wertvolles Angriffsziel; ein gestohlenes Token gilt bei vielen Diensten.

6.  Beispiellösung:

    ```python
    from http.cookies import SimpleCookie

    def pruefe(zeile):
        c = SimpleCookie()
        c.load(zeile)
        for name, m in c.items():
            print(name, "Secure:", bool(m["secure"]), "HttpOnly:", bool(m["httponly"]),
                  "SameSite:", m["samesite"] or "-")

    pruefe("sid=xyz; Path=/; Secure; HttpOnly; SameSite=Strict")
    pruefe("theme=dark; Path=/")
    ```

    Die erste Zeile liefert `True`, `True` und `Strict`; die zweite `False`, `False` und einen Bindestrich: Das zweite Cookie ist unproblematisch, wenn es nur eine Designwahl speichert, wäre aber als Sitzungscookie falsch gesetzt.

7.  Beispiellösung:

    ```python
    import re
    MUSTER = re.compile(r"^(\d{4})-(\d{2})-(\d{2})_([A-Za-z0-9]+)_([A-Za-z0-9-]+)_v(\d{2})\.(docx|xlsx|pptx|pdf)$")

    def verstoesse(name):
        liste = []
        m = MUSTER.match(name)
        if not m:
            liste.append("Form entspricht nicht der Konvention")
        else:
            if not (1 <= int(m.group(2)) <= 12 and 1 <= int(m.group(3)) <= 31):
                liste.append("ungueltiges Datum")
            if "final" in m.group(5).lower():
                liste.append("Thema enthaelt 'final'")
        return liste

    for n in ["2026-10-26_Alpha_Plan-final_v02.docx", "plan.docx", "2026-10-26_Alpha_Plan_v01.pdf"]:
        print(n, verstoesse(n) or "ok")
    ```

    Der erste Name verletzt nur die Regel “final”, der zweite die Form, der dritte ist in Ordnung.

8.  Beispiellösung:

    ```python
    import math
    def abo_kosten(nutzer, monat, jahr, monate_nutzung):
        monatlich = nutzer * monat * monate_nutzung
        jaehrlich = nutzer * jahr * math.ceil(monate_nutzung / 12)
        return ("monatlich", monatlich) if monatlich <= jaehrlich else ("jaehrlich", jaehrlich)

    for monate in (6, 12, 18):
        print(monate, abo_kosten(10, 12.5, 125.0, monate))
    ```

    Ergebnis: Bei 6 Monaten kostet monatlich 750, jährlich 1 250: monatlich ist günstiger. Bei 12 Monaten kostet monatlich 1 500, jährlich 1 250: jährlich ist günstiger. Bei 18 Monaten kostet monatlich 2 250, jährlich (zwei volle Jahre) 2 500: monatlich ist günstiger. Der Umkehrpunkt liegt knapp unter 10 Monaten; die Rechnung zeigt, dass ein Jahresvertrag nur bei voller Nutzung ein Vorteil ist.

9.  Rückfragen: Betrifft es nur Sie oder auch andere? Wie lautet die Fehlermeldung genau (Foto)? Seit wann, was hat sich zuvor geändert? Funktionieren andere Seiten? Welcher Browser, welches Gerät, im Büro oder von zu Hause? Prüfschritte: privates Fenster testen, anderen Browser testen, Cache und Cookies der Seite löschen, Erweiterungen deaktivieren, anderes Netz testen oder Datum und Uhrzeit prüfen; bei Zertifikatsfehlern die Meldung genau lesen und gegebenenfalls eskalieren.
