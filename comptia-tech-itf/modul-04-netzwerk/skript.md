# Modul 4 - Netzwerkgrundlagen und Konnektivitaet

> **Hinweis zu diesem Kapitel:** Das ist das Kapitel des Skripts „CompTIA Tech+ / ITF+ (FC0-U71): Lernskript in Modulen“, aus der LaTeX-Quelle in Markdown umgewandelt (Text und Listings unverändert, Boxen als Zitatblöcke, Aufgaben und Lösungen als nummerierte Listen). Laut Skript wurden die Python-Beispiele bei der Erstellung im Arbeitsbereich ausgeführt, die gezeigten Ausgaben stammen aus diesen Läufen; Windows- und PowerShell-Befehle wurden nicht ausgeführt. Für dieses Repository wurden die Listings **nicht erneut ausgeführt**. Prüfungsdetails, Produktnamen und Versionen ändern sich; maßgeblich sind die aktuellen Prüfungsziele (Exam Objectives) von CompTIA. Übersicht zum Modul: [README](README.md).

**Dauer:** 8 h

**Priorität:** 1 (höchste)

| Nr. | Lerneinheit                         | Dauer (h) | Prio |
|----:|:------------------------------------|----------:|-----:|
| 4.1 | Netzwerkmodelle und Begriffe        |         1 |    1 |
| 4.2 | Netzwerkgeräte                      |         1 |    1 |
| 4.3 | IP-Adressierung                     |         1 |    1 |
| 4.4 | Namensauflösung und Internetdienste |      0,75 |    1 |
| 4.5 | Ports und Protokolle                |         1 |    2 |
| 4.6 | WLAN und Funknetze                  |         1 |    1 |
| 4.7 | Netzwerktools                       |         1 |    2 |
| 4.8 | Netzwerk-Troubleshooting            |      1,25 |    1 |
|     | **Summe**                           |     **8** |      |

Kaum ein Gerät arbeitet heute allein. Ein Netzwerk verbindet Rechner, Drucker, Telefone und Sensoren, damit sie Daten austauschen, und das Internet verbindet Millionen solcher Netzwerke miteinander. Dieses Modul erklärt von Grund auf, wie das funktioniert: Welche Arten von Netzen es gibt, welche Geräte sie bilden, wie jedes Gerät eine Adresse bekommt und wie Namen in Adressen übersetzt werden, welche Regeln (Protokolle und Ports) die Kommunikation steuern, wie drahtlose Netze funktionieren und wie man mit einfachen Werkzeugen Fehler eingrenzt. Die Beispiele arbeiten mit Python, weil man Netzwerkkonzepte damit ohne zusätzliche Hardware nachbauen kann: Die Programme laufen auf dem eigenen Rechner und kommunizieren über die Schnittstelle `127.0.0.1` (*Loopback*), die jedes System besitzt. Das Netzwerk ist Teil der Infrastruktur-Domäne der Prüfung, die mit 24 Prozent das höchste Gewicht hat.

## 4.1 Netzwerkmodelle und Begriffe

Ein *Rechnernetz* besteht aus mindestens zwei Geräten, die über ein Medium (Kabel, Funk, Glasfaser) Daten austauschen können. Nach der räumlichen Ausdehnung unterscheidet man das *PAN* (*Personal Area Network*, Reichweite von Metern, etwa Smartphone und Kopfhörer per Bluetooth), das *LAN* (*Local Area Network*, ein Gebäude oder Grundstück, etwa das Büronetz), das *MAN* (*Metropolitan Area Network*, eine Stadt) und das *WAN* (*Wide Area Network*, Länder und Kontinente, das Standorte einer Firma verbindet). Das *Internet* ist das größte WAN: ein weltweiter Verbund vieler selbstständiger Netze, die dieselben Protokolle sprechen. Das Internet ist nicht dasselbe wie das *World Wide Web*, das nur einer von vielen Diensten darauf ist (neben E-Mail, Dateiübertragung oder Videotelefonie).

Zwei weitere Begriffe betreffen die Zugänglichkeit. Ein *Intranet* ist ein internes Netz einer Organisation, das Internettechniken nutzt (Webseiten, Wiki, Verwaltungsportale), aber nur Mitarbeitenden offensteht. Ein *Extranet* erweitert das Intranet um ausgewählte Externe, etwa Lieferanten oder Kunden, die sich anmelden müssen. Ein *VPN* (*Virtual Private Network*) baut über das öffentliche Internet einen verschlüsselten Tunnel auf, sodass sich entfernte Geräte so verhalten, als wären sie im Firmennetz (Modul 10).

Die Anordnung der Verbindungen heißt *Topologie*. In der *Sterntopologie*, die heute in fast jedem LAN vorkommt, hängen alle Geräte an einem zentralen Gerät (Switch). Sie ist einfach zu erweitern, ein ausgefallenes Kabel betrifft nur ein Gerät, doch das zentrale Gerät ist ein Schwachpunkt. In der *Bustopologie* (historisch, Koaxkabel) teilen sich alle ein Kabel; in der *Ringtopologie* sind die Geräte im Kreis verbunden; in der *Vermaschten Topologie* (*Mesh*) sind viele oder alle Geräte untereinander verbunden, wodurch es mehrere Wege gibt und das Netz ausfallsicherer wird; sie kommt bei Backbones, im Internet und bei WLAN-Mesh-Systemen vor. Mehrere Sterne, die über zentrale Geräte verbunden sind, bilden eine *Baumtopologie*.

Das Zusammenspiel der Geräte wird durch *Schichtenmodelle* beschrieben. Kommunikation ist ein komplexes Problem, und es ist leichter, es in Schichten zu teilen, von denen jede eine klar umrissene Aufgabe hat und der darüberliegenden Schicht Dienste bietet. Das *OSI-Modell* (*Open Systems Interconnection*) hat sieben Schichten: 1 Bitübertragung (*Physical*), 2 Sicherung (*Data Link*), 3 Vermittlung (*Network*), 4 Transport (*Transport*), 5 Sitzung (*Session*), 6 Darstellung (*Presentation*) und 7 Anwendung (*Application*). Eine Merkhilfe für die englischen Anfangsbuchstaben von unten nach oben lautet “Please Do Not Throw Sausage Pizza Away”. Das in der Praxis verwendete *TCP/IP-Modell* fasst sie zu vier Schichten zusammen: Netzzugang (Schichten 1 und 2), Internet (3), Transport (4) und Anwendung (5 bis 7). Wichtig ist das Prinzip der *Kapselung*: Beim Senden fügt jede Schicht den Daten der darüberliegenden Schicht ihren eigenen Kopfteil (*Header*) hinzu, so wie man einen Brief in einen Umschlag steckt und diesen in ein Paket. Der Empfänger packt Schicht für Schicht wieder aus. Die Dateneinheiten haben je Schicht eigene Namen: Bits (Schicht 1), *Frames* bzw. Rahmen (Schicht 2), *Pakete* (Schicht 3) und *Segmente* bzw. Datagramme (Schicht 4).

Zwei Beispiele machen das anschaulich. Das erste baut ein Datenpaket in Schichten nach und gibt die Verschachtelung aus. Das zweite startet einen kleinen Server und einen Client, die tatsächlich über das Loopback-Netz kommunizieren; man sieht dabei das Client-Server-Prinzip auf Netzwerkebene.

```python
import socket, threading, json

def schicht_verpacken(daten):
    segment = {"TCP": {"Quellport": 52144, "Zielport": 80}, "Nutzdaten": daten}
    paket   = {"IP": {"Quelle": "192.168.1.20", "Ziel": "93.184.216.34"}, "Segment": segment}
    rahmen  = {"Ethernet": {"Quell-MAC": "AA:BB:CC:00:00:01",
                            "Ziel-MAC": "AA:BB:CC:00:00:FE"}, "Paket": paket}
    return rahmen

print(json.dumps(schicht_verpacken("GET / HTTP/1.1"), indent=2))

def echo_server(srv):
    verbindung, adresse = srv.accept()
    with verbindung:
        daten = verbindung.recv(1024)
        verbindung.sendall(b"ECHO: " + daten)

srv = socket.socket()
srv.bind(("127.0.0.1", 0))
srv.listen(1)
port = srv.getsockname()[1]
threading.Thread(target=echo_server, args=(srv,), daemon=True).start()

with socket.create_connection(("127.0.0.1", port)) as client:
    client.sendall("Hallo Netzwerk".encode("utf-8"))
    print(client.recv(1024).decode("utf-8"))
srv.close()
```

Die Funktion `schicht_verpacken` baut von innen nach außen: Erst entsteht das Segment mit Ports (Schicht 4) und den Nutzdaten, dann das Paket mit IP-Adressen (Schicht 3) und zuletzt der Rahmen mit MAC-Adressen (Schicht 2). `json.dumps(..., indent=2)` gibt die Verschachtelung eingerückt aus; sie zeigt, dass die Nutzdaten ganz innen liegen und jede Schicht eine eigene Hülle ergänzt. Die *MAC-Adresse* (*Media Access Control*) ist die feste Hardwareadresse einer Netzwerkkarte, die *IP-Adresse* die logische Adresse im Netz (siehe 4.3). Der zweite Teil nutzt *Sockets*, die Programmierschnittstelle für Netzwerkverbindungen. Der Server bindet mit `bind` eine Adresse und einen Port (die `0` bedeutet, dass das System einen freien Port auswählt), wartet mit `listen` auf Verbindungen und nimmt mit `accept` eine entgegen. Der Client baut mit `create_connection` eine Verbindung zu dieser Adresse auf, sendet Text und erhält ihn mit der Vorsilbe “ECHO:” zurück. Der Server läuft in einem eigenen Thread, damit beide im selben Programm arbeiten können. Die Ausgabe ist die Zeile `ECHO: Hallo Netzwerk`.

### Typische Fehler.

Falsch ist die Gleichsetzung von “Internet” und “Browser” oder von Internet und WWW. Falsch ist auch, ein Intranet für “ein sicheres Netz” zu halten: Ein internes Netz kann angegriffen werden, wenn ein Gerät befallen ist (Modul 10). Bei den Schichtenmodellen ist der häufigste Fehler, die Schichten auswendig zu lernen, ohne ihr Prinzip zu verstehen; in der Fehlersuche hilft das Modell, wenn man weiß, welche Probleme in welcher Schicht auftreten (Kabel: Schicht 1; falsche IP: Schicht 3; Port gesperrt: Schicht 4; Webanwendung: Schicht 7).

### Praxisbezug.

Netzwerkpläne in Firmen zeigen die Topologie: Ein Router am Rand, dahinter Switches im Stern zu Arbeitsplätzen, Servern und Druckern, daneben WLAN-Zugangspunkte. Wer die Begriffe LAN, WAN, VPN und Topologie sicher verwendet, versteht diese Pläne sofort.

> **Merke**
>
> LAN = lokal, WAN = weit, Internet = Netz der Netze. Intranet = intern, Extranet = intern plus ausgewählte Externe. Stern = heutiger Standard im LAN. OSI hat sieben, TCP/IP vier Schichten; Kapselung = jede Schicht ergänzt einen Header.

## 4.2 Netzwerkgeräte

Jedes Gerät in einem Netzwerk hat eine Aufgabe. Wer die Rollen unterscheiden kann, versteht, wo eine Störung liegt und wie ein Netz zusammengesetzt ist.

Die *Netzwerkkarte* (*NIC*, Network Interface Card; heute meist fest auf dem Mainboard oder als WLAN-Chip) verbindet ein Gerät mit dem Netz. Jede besitzt eine weltweit eindeutige *MAC-Adresse* mit 48 Bit, die in sechs Hexadezimal-Paaren geschrieben wird (zum Beispiel `AA:BB:CC:00:00:01`); die ersten drei Paare kennzeichnen den Hersteller. Das Kabel zwischen den Geräten ist meist ein *Twisted-Pair-Kabel* mit RJ45-Steckern. Kategorien wie Cat5e oder Cat6 legen fest, welche Geschwindigkeit bis zur typischen Maximallänge von 100 Metern möglich ist: Cat5e für 1 Gbit/s, Cat6a für 10 Gbit/s über die volle Länge. *Glasfaser* überträgt Licht, erreicht große Entfernungen mit hoher Geschwindigkeit und ist unempfindlich gegen elektrische Störungen. Mit *Power over Ethernet* (PoE) kann ein Netzwerkkabel außer Daten auch Strom für Telefone, Kameras oder Zugangspunkte liefern.

Der *Switch* (Netzwerkverteiler) verbindet die Geräte eines LANs. Er arbeitet auf Schicht 2: Er liest die MAC-Adresse im Rahmen und leitet ihn gezielt an den Anschluss (*Port*) weiter, an dem das Zielgerät hängt. Dazu führt er eine Tabelle, die er selbst aufbaut: Er merkt sich, über welchen Port welche Quell-Adresse eingegangen ist. Kennt er das Ziel noch nicht, schickt er den Rahmen an alle anderen Ports (*Flooding*), sonst nur an den richtigen. Dadurch belegen sich die Geräte nicht gegenseitig die Leitung. Der veraltete *Hub* dagegen wiederholte alles an alle Anschlüsse. Der *Router* verbindet verschiedene Netze miteinander und arbeitet auf Schicht 3. Er entscheidet anhand der Ziel-IP-Adresse, an welches nächste Gerät (den *Next Hop*) ein Paket geht, gestützt auf seine *Routingtabelle*. Das Gerät, das ein Rechner für alles außerhalb des eigenen Netzes benutzt, heißt *Standardgateway*. Das *Modem* wandelt Signale zwischen dem digitalen Rechnernetz und dem Übertragungsmedium des Anbieters (Telefonleitung, Kabelnetz, Glasfaser; dort teils als ONT bezeichnet). Der *Access Point* (AP) schafft den Übergang zwischen Kabel und WLAN. Die *Firewall* lässt Verkehr anhand von Regeln durch oder blockiert ihn; sie kann als eigenes Gerät, als Funktion des Routers oder als Software auf dem Rechner vorliegen.

Der Heimrouter vom Internetanbieter vereint viele dieser Rollen in einem Gehäuse: Modem, Router, kleiner Switch, WLAN-Access-Point, Firewall und DHCP-Server. In einem Firmennetz sind die Funktionen getrennt, damit sie unabhängig skaliert, abgesichert und ersetzt werden können. Typisch ist die Platzierung der Firewall am Übergang zum Internet; Server, die von außen erreichbar sein müssen, kommen in eine eigene abgeschirmte Zone (*DMZ*, demilitarisierte Zone), damit ein Angriff auf sie nicht direkt das interne Netz erreicht.

Die folgenden zwei Programme bilden die zentralen Mechanismen nach. Das erste ist ein Switch, der seine MAC-Tabelle lernt; das zweite ist ein Router, der aus einer Routingtabelle die passende Regel nach dem Prinzip “längster passender Präfix” wählt.

```python
class Switch:
    def __init__(self, ports):
        self.ports = ports
        self.tabelle = {}

    def empfange(self, port, quelle, ziel):
        self.tabelle[quelle] = port
        if ziel in self.tabelle:
            return [self.tabelle[ziel]]
        return [p for p in range(1, self.ports + 1) if p != port]

sw = Switch(4)
print(sw.empfange(1, "A", "B"))
print(sw.empfange(2, "B", "A"))
print(sw.empfange(1, "A", "B"))
print(sw.tabelle)

import ipaddress
ROUTEN = [
    (ipaddress.ip_network("192.168.1.0/24"), "direkt (LAN)"),
    (ipaddress.ip_network("10.0.0.0/8"),     "VPN-Gateway 192.168.1.2"),
    (ipaddress.ip_network("0.0.0.0/0"),      "Standard-Gateway 192.168.1.1"),
]

def naechster_hop(ziel):
    ziel = ipaddress.ip_address(ziel)
    treffer = [(netz, hop) for netz, hop in ROUTEN if ziel in netz]
    netz, hop = max(treffer, key=lambda t: t[0].prefixlen)
    return f"{ziel} -> {hop} (Regel {netz})"

for z in ("192.168.1.77", "10.5.5.5", "93.184.216.34"):
    print(naechster_hop(z))
```

Die Klasse `Switch` speichert in `tabelle`, an welchem Port welche Adresse zuletzt gesehen wurde. Bei jedem eingehenden Rahmen lernt der Switch die Quelle. Kennt er das Ziel, gibt er nur dessen Port zurück, sonst alle Ports außer dem Eingangsport (Flooding). Die Ausgabe zeigt es: Der erste Rahmen von A nach B geht an die Ports 2, 3 und 4, weil B unbekannt ist. Antwortet B (an Port 2), kennt der Switch A und leitet nur an Port 1 weiter. Sendet A erneut, geht der Rahmen jetzt nur noch an Port 2. Die Tabelle am Ende enthält beide Adressen. Im zweiten Teil beschreibt `ipaddress.ip_network` ein Netz in der Schreibweise mit Präfixlänge (siehe nächsten Abschnitt). Die Funktion wählt aus allen Regeln, in deren Netz das Ziel liegt, diejenige mit dem längsten Präfix, das heißt der genauesten Beschreibung. Das Ziel 192.168.1.77 liegt im lokalen Netz und wird direkt zugestellt, 10.5.5.5 geht in den VPN-Tunnel, und alles andere (hier 93.184.216.34) an das Standardgateway; die Regel `0.0.0.0/0` passt auf jede Adresse, hat aber den kürzesten Präfix und gilt deshalb nur, wenn nichts Genaueres passt.

### Typische Fehler.

Falsch ist die Gleichsetzung von Switch und Router: Ein Switch verbindet Geräte *innerhalb* eines Netzes, ein Router verbindet *verschiedene* Netze. Falsch ist auch “Der Router macht WLAN”; das ist die Aufgabe des Access Points, der in ein Heimgerät lediglich eingebaut ist. Verbreitet ist außerdem die Annahme, ein Kabel funktioniere immer, solange der Stecker passt: Die Länge über 100 Meter, schlecht gecrimpte Stecker und billige Kabel mit zu dünnen Adern verursachen Aussetzer und niedrige Geschwindigkeit.

### Praxisbezug.

Ein neuer Arbeitsplatz wird mit einem Patchkabel an die Netzwerkdose angeschlossen; im Verteilerschrank verbindet ein weiteres Kabel die Dose über ein *Patchpanel* mit einem Port des Switches. Wer ein Gerät “nicht ins Netz bekommt”, prüft zuerst die Link-LED an Netzwerkkarte und Switch-Port, denn sie zeigt, ob überhaupt eine physische Verbindung besteht.

## 4.3 IP-Adressierung

Damit Daten ihr Ziel finden, braucht jedes Gerät im Netz eine *IP-Adresse*. Sie funktioniert wie eine Postanschrift: Ein Teil benennt das Netz (die Straße), ein Teil das Gerät darin (die Hausnummer). Die heute am weitesten verbreitete Version ist *IPv4*. Eine IPv4-Adresse besteht aus 32 Bit und wird als vier Dezimalzahlen zwischen 0 und 255 geschrieben, getrennt durch Punkte, zum Beispiel `192.168.10.77`. Jede Zahl steht für acht Bit (ein Byte).

Wo das Netz endet und das Gerät beginnt, bestimmt die *Subnetzmaske*. Sie ist ebenfalls 32 Bit lang und hat vorn lauter Einsen für den Netzanteil und hinten lauter Nullen für den Geräteanteil. Die Maske `255.255.255.0` bedeutet: Die ersten 24 Bit gehören zum Netz, die letzten acht zum Gerät. Kürzer schreibt man die Zahl der Einsen als *Präfixlänge* nach einem Schrägstrich (*CIDR*-Schreibweise): `192.168.10.0/24`. In diesem Netz gibt es $2^8 = 256$ Adressen, von denen zwei reserviert sind: die erste (*Netzadresse*, hier `192.168.10.0`) und die letzte (*Broadcastadresse*, hier `192.168.10.255`, Nachricht an alle). Es bleiben 254 nutzbare Geräteadressen. Allgemein gilt: Bei Präfixlänge $p$ gibt es $2^{32-p}-2$ nutzbare Adressen. Zwei Geräte kommunizieren direkt, wenn sie im selben Netz liegen; alles andere schickt ein Gerät an sein *Standardgateway*.

Der Adressraum von IPv4 ist mit rund 4,3 Milliarden Adressen ($2^{32}$) knapp. Deshalb gibt es *private Adressbereiche*, die im Internet nicht geroutet werden und in beliebig vielen lokalen Netzen gleichzeitig vorkommen dürfen: `10.0.0.0/8`, `172.16.0.0/12` und `192.168.0.0/16`. Damit private Geräte trotzdem ins Internet kommen, übersetzt der Router mit *NAT* (*Network Address Translation*) die privaten Adressen auf seine eine öffentliche Adresse. Weitere besondere Adressen sind die *Loopback*-Adresse `127.0.0.1` (das eigene Gerät, “localhost”) und die *Link-Local-Adresse* im Bereich `169.254.0.0/16`, die ein Gerät sich selbst gibt (*APIPA*), wenn es keine Adresse von einem Server bekommt; sie ist ein klares Zeichen für Probleme mit der Adressvergabe.

Die Adresse muss dem Gerät zugewiesen werden, und das geschieht auf zwei Arten. Bei der *statischen* Konfiguration trägt man Adresse, Maske, Gateway und DNS-Server von Hand ein; das ist üblich für Server, Drucker und Netzwerkgeräte, die immer unter derselben Adresse erreichbar sein sollen. Bei der *dynamischen* Vergabe fragt das Gerät beim Verbinden einen *DHCP-Server* (*Dynamic Host Configuration Protocol*), der aus einem Vorrat (*Pool*) für eine begrenzte Zeit (*Lease*) eine Adresse samt Maske, Gateway und DNS-Server verleiht. Der Ablauf heißt auch *DORA*: Das Gerät schickt eine Anfrage an alle (*Discover*), der Server bietet eine Adresse an (*Offer*), das Gerät fordert sie an (*Request*), und der Server bestätigt (*Acknowledge*). Eine *Reservierung* bindet eine feste Adresse an die MAC-Adresse eines Geräts, sodass man zentral verwalten kann und das Gerät trotzdem immer dieselbe Adresse erhält.

*IPv6* löst die Knappheit durch 128-Bit-Adressen. Sie werden in acht Gruppen zu je vier Hexadezimalziffern geschrieben, getrennt durch Doppelpunkte, wobei führende Nullen entfallen und eine Folge von Null-Gruppen einmal mit `::` abgekürzt werden darf: `2001:db8::1`. Ein lokales Netz hat üblicherweise die Präfixlänge 64. Broadcast gibt es nicht; stattdessen nutzt IPv6 Multicast. Jedes IPv6-Gerät hat zusätzlich eine *Link-Local-Adresse* im Bereich `fe80::/10`. IPv4 und IPv6 laufen oft parallel (*Dual Stack*).

Das Programm unten benutzt das Python-Modul `ipaddress`, das all diese Berechnungen übernimmt. Es zeigt die Eigenschaften eines Netzes, prüft, welche Adressen dazugehören und welche besonderen Charakter haben, teilt das Netz in Teilnetze und gibt eine Adresse binär aus.

```python
import ipaddress

netz = ipaddress.ip_network("192.168.10.0/24")
print("Netz        :", netz)
print("Netzmaske   :", netz.netmask)
print("Broadcast   :", netz.broadcast_address)
print("Nutzbare IPs:", netz.num_addresses - 2)
hosts = list(netz.hosts())
print("Erste/letzte:", hosts[0], hosts[-1])

for adresse in ("192.168.10.77", "192.168.11.5", "8.8.8.8", "169.254.3.4", "127.0.0.1"):
    ip = ipaddress.ip_address(adresse)
    print(f"{adresse:14} im Netz: {ip in netz!s:5}  privat: {ip.is_private!s:5}  "
          f"link-local: {ip.is_link_local!s:5}  loopback: {ip.is_loopback}")

print([str(n) for n in netz.subnets(new_prefix=26)])
print(ipaddress.ip_interface("192.168.10.77/24").network)
print(format(int(ipaddress.ip_address("192.168.10.77")), "032b"))
v6 = ipaddress.ip_address("2001:db8::1")
print(v6, v6.exploded)
```

Die Zeilen am Anfang liefern für `192.168.10.0/24` die Maske `255.255.255.0`, die Broadcastadresse `192.168.10.255`, 254 nutzbare Adressen und als erste und letzte Geräteadresse `.1` und `.254`. In der Schleife entscheidet der Operator `in`, ob eine Adresse zum Netz gehört: `192.168.10.77` ja, `192.168.11.5` nein (ein anderes Netz, obwohl ebenfalls privat), `8.8.8.8` nein und öffentlich. Beachtenswert ist die Eigenschaft `is_private`: In Python ist sie auch für `169.254.3.4` und `127.0.0.1` wahr, weil beide nicht öffentlich geroutet werden, gehören aber nicht zu den drei klassischen privaten Bereichen; deshalb gibt es zusätzlich `is_link_local` und `is_loopback`. `subnets(new_prefix=26)` teilt das Netz in vier Teilnetze zu je 64 Adressen (`.0/26`, `.64/26`, `.128/26`, `.192/26`). `ip_interface` verbindet Adresse und Präfix und liefert über `.network` das dazugehörige Netz. Die binäre Ausgabe macht deutlich, dass eine Adresse nur eine 32-stellige Bitfolge ist: `11000000.10101000.00001010.01001101`. Zum Schluss steht die ausgeschriebene Form der IPv6-Adresse: `2001:0db8:0000:0000:0000:0000:0000:0001`. Der Bereich `2001:db8::/32` ist für Dokumentation reserviert.

### Typische Fehler.

Falsch ist das Zählen der Adressen als $2^{n}$ ohne Abzug von Netz- und Broadcastadresse. Falsch ist auch, `192.168.1.5` mit Maske `255.255.255.0` und `192.168.2.5` mit derselben Maske für “dasselbe Netz” zu halten: Sie liegen in unterschiedlichen Netzen und können ohne Router nicht direkt kommunizieren. Ein typischer Einrichtungsfehler ist ein falsches Gateway oder eine falsche Maske: Dann funktioniert das lokale Netz, aber das Internet nicht. Ein weiterer klassischer Fehler ist ein *IP-Konflikt*: Zwei Geräte verwenden dieselbe Adresse, etwa wenn jemand einem Drucker eine statische Adresse aus dem DHCP-Pool gibt.

### Praxisbezug.

Im Büro-LAN vergibt der DHCP-Server Adressen aus einem Bereich, zum Beispiel `192.168.1.100` bis `.199`; Drucker und Server haben feste Adressen außerhalb davon. Meldet ein Rechner eine Adresse aus `169.254.x.x`, ist der DHCP-Server nicht erreichbar. Die dann übliche Prüfung: Kabel, Switch-Port, DHCP-Dienst.

> **Merke**
>
> IPv4: 32 Bit, vier Zahlen. Maske oder Präfix trennt Netz und Gerät. Nutzbare Adressen $=2^{32-p}-2$. Private Bereiche: 10/8, 172.16/12, 192.168/16. 169.254.x.x = keine DHCP-Antwort. DHCP verteilt Adressen (DORA). IPv6: 128 Bit, Schreibweise mit Doppelpunkten.

## 4.4 Namensauflösung und Internetdienste

Menschen merken sich Namen, Computer rechnen mit Adressen. Das *Domain Name System* (*DNS*) schlägt die Brücke: Es übersetzt einen Namen wie `www.example.at` in die zugehörige IP-Adresse, wie ein Telefonbuch, das Namen in Nummern übersetzt. DNS ist ein verteiltes System aus vielen Servern und eine der wichtigsten Grundlagen des Internets; fällt es aus, “funktioniert das Internet nicht mehr”, obwohl die Verbindung besteht.

Namen sind hierarchisch aufgebaut und werden von rechts nach links gelesen. Ganz rechts steht die *Top-Level-Domain* (TLD) wie `.at`, `.com` oder `.org`, davor die *Second-Level-Domain* (`example`), davor optional *Subdomains* (`www`, `shop`). Die Hierarchie spiegelt sich im Abfrageweg. Das Gerät fragt zuerst einen *rekursiven Resolver*, meist den DNS-Server des Providers oder der Firma (per DHCP zugewiesen). Kennt dieser die Antwort nicht, fragt er bei den *Root-Servern* nach, wer für die TLD zuständig ist, dann bei den Servern der TLD, wer die Domain verwaltet, und schließlich beim *autoritativen Nameserver* der Domain, der die verbindliche Antwort gibt. Antworten werden für eine festgelegte Zeit, die *TTL* (*Time to Live*, in Sekunden), zwischengespeichert (*Caching*), sodass die nächste Abfrage schneller ist. Zusätzlich liest jedes System eine lokale Datei (*hosts*-Datei), die Namen fest Adressen zuordnet und Vorrang vor DNS hat.

In DNS gibt es verschiedene Eintragstypen (*Records*). Ein *A-Record* verknüpft einen Namen mit einer IPv4-Adresse, ein *AAAA-Record* mit einer IPv6-Adresse, ein *CNAME* ist ein Alias auf einen anderen Namen, ein *MX-Record* nennt den Mailserver einer Domain, ein *NS-Record* den zuständigen Nameserver, ein *TXT-Record* Textinformationen (zum Beispiel für E-Mail-Sicherheit), ein *PTR-Record* die umgekehrte Zuordnung von Adresse zu Name.

Die Adresse einer Webseite heißt *URL* (*Uniform Resource Locator*) und hat mehrere Bestandteile: das *Schema* (https), den *Host* (Domain), optional den *Port*, den *Pfad* zur Ressource, die *Abfrage* (Query, nach einem Fragezeichen) und einen *Fragment*-Anker (nach \#). Gibt man eine URL im Browser ein, läuft im Hintergrund eine Kette ab: Der Browser zerlegt die URL, löst den Namen per DNS in eine IP-Adresse auf, baut zum Server eine TCP-Verbindung auf (siehe 4.5), verhandelt bei HTTPS die Verschlüsselung (TLS), sendet die HTTP-Anfrage und stellt die Antwort dar. Wenn die Seite nicht lädt, kann jeder dieser Schritte die Ursache sein, und das Wissen um die Reihenfolge hilft bei der Eingrenzung. Neben dem Web gehören zu den Internetdiensten unter anderem E-Mail (Modul 05), Dateiübertragung, Fernzugriff, Telefonie und Videokonferenzen, Zeitdienste (NTP) und natürlich Cloud-Dienste (Modul 08).

Das folgende Beispiel zerlegt eine URL, bildet die Zwischenspeicherung eines Resolvers nach und führt eine echte Auflösung durch. Der Mini-Resolver kennt zwei Einträge, einen A-Record und einen CNAME, und verfolgt Aliase.

```python
import socket
from urllib.parse import urlparse, parse_qs

url = "https://shop.example.at:8443/produkte/liste?kategorie=laptop&seite=2#preise"
t = urlparse(url)
print("Schema  :", t.scheme)
print("Host    :", t.hostname)
print("Port    :", t.port)
print("Pfad    :", t.path)
print("Abfrage :", parse_qs(t.query))
print("Anker   :", t.fragment)
print("Domain-Ebenen:", " <- ".join(reversed(t.hostname.split("."))))

class MiniResolver:
    def __init__(self):
        self.cache = {}
        self.zone = {"shop.example.at": ("A", "203.0.113.10", 300),
                     "www.example.at":  ("CNAME", "shop.example.at", 300)}
    def aufloesen(self, name, jetzt):
        if name in self.cache and self.cache[name][1] > jetzt:
            return self.cache[name][0], "aus Cache"
        art, wert, ttl = self.zone[name]
        if art == "CNAME":
            wert, _ = self.aufloesen(wert, jetzt)
        self.cache[name] = (wert, jetzt + ttl)
        return wert, "vom Nameserver"

r = MiniResolver()
print(r.aufloesen("www.example.at", 0))
print(r.aufloesen("www.example.at", 100))
print(r.aufloesen("www.example.at", 400))

print("localhost ->", socket.gethostbyname("localhost"))
try:
    print("example.org ->", socket.gethostbyname("example.org"))
except OSError as e:
    print("Namensaufloesung fehlgeschlagen:", e)
```

`urlparse` zerlegt die Adresse in ihre Teile; `parse_qs` macht aus der Abfrage ein Dictionary mit Listen (`kategorie` und `seite`). Die letzte Zeile des ersten Blocks zeigt die Domain-Hierarchie von der TLD aus: `at`, `example`, `shop`. Im Mini-Resolver gibt `zone` die Einträge vor: ein A-Record mit Adresse und TTL von 300 Sekunden, ein CNAME, der auf den ersten verweist. `aufloesen` prüft zuerst den Cache und liefert die gespeicherte Antwort, falls ihr Ablaufzeitpunkt noch nicht erreicht ist. Andernfalls wird der Eintrag “beim Nameserver” nachgeschlagen; bei einem CNAME ruft sich die Funktion selbst mit dem Zielnamen auf (*Rekursion*). Der Aufruf mit `jetzt = 0` kommt vom Nameserver; bei `jetzt = 100` liegt der Ablauf (300) noch in der Zukunft, die Antwort kommt aus dem Cache; bei `jetzt = 400` ist die TTL abgelaufen, der Eintrag wird neu geholt. Die Zeiten sind dabei einfache Zahlen statt echter Uhrzeiten. Zum Schluss fragt `socket.gethostbyname` das Betriebssystem. `localhost` liefert immer `127.0.0.1`. Die Auflösung von `example.org` gelang im Testsystem nicht, weil dort kein Zugang zu einem DNS-Server besteht; das abgefangene `OSError` zeigt, wie ein Programm auf ausgefallenes DNS reagieren sollte.

### Typische Fehler.

Falsch ist, “Das Internet geht nicht” mit “DNS geht nicht” zu verwechseln; wenn Adressen funktionieren, Namen aber nicht, ist DNS die Ursache. Falsch ist auch, nach der Änderung eines DNS-Eintrags sofortige Wirkung zu erwarten: Wegen der TTL und des Cachings dauert es, bis alle Geräte die neue Adresse kennen. Ein Fehler bei der Einrichtung ist ein falscher oder fehlender DNS-Server in der Netzwerkkonfiguration. Ein Sicherheitsaspekt: Manipulierte Antworten (*DNS Spoofing*) können Benutzer auf gefälschte Seiten umleiten; Gegenmaßnahmen sind unter anderem signierte DNS-Daten (DNSSEC) und verschlüsselte Abfragen.

### Praxisbezug.

Beim Umzug einer Webseite auf einen neuen Server senkt man vorher die TTL des A-Records auf wenige Minuten, damit die neue Adresse schnell überall bekannt wird. Im Firmennetz sorgen interne DNS-Server dafür, dass Rechnernamen wie `drucker-eg` aufgelöst werden.

## 4.5 Ports und Protokolle

Ein *Protokoll* ist ein Regelwerk, das festlegt, wie zwei Geräte miteinander kommunizieren: Reihenfolge der Nachrichten, Format der Daten, Behandlung von Fehlern. Jeder Internetdienst hat sein Protokoll, so wie jede Sprache ihre Grammatik. Ein *Port* ist eine Zahl zwischen 0 und 65 535, die auf einem Gerät einen bestimmten Dienst bezeichnet. Die IP-Adresse findet das Gerät, der Port den Dienst darauf, vergleichbar mit Hausadresse und Wohnungsnummer. Die Kombination aus Adresse und Port nennt man *Socket*.

Die Portnummern sind in Bereiche eingeteilt: 0 bis 1023 sind die *well-known ports* für Standarddienste, 1024 bis 49151 sind *registrierte* Ports, und 49152 bis 65535 sind *dynamische* Ports, die das System für ausgehende Verbindungen kurzfristig vergibt. Die wichtigsten Zuordnungen, die man auswendig können sollte, sind: HTTP 80, HTTPS 443, FTP 20 und 21, SSH 22, Telnet 23, SMTP 25 (Mailversand zwischen Servern; Mail-Clients nutzen 587 oder 465), DNS 53, DHCP 67 und 68, POP3 110 (mit Verschlüsselung 995), IMAP 143 (verschlüsselt 993), NTP 123, SNMP 161, LDAP 389, SMB 445 (Windows-Dateifreigabe) und RDP 3389 (Fernzugriff auf Windows). Diese Liste ist zugleich ein Sicherheitsthema: Dienste, die unverschlüsselt arbeiten (HTTP, FTP, Telnet, POP3), haben verschlüsselte Gegenstücke (HTTPS, SFTP/FTPS, SSH, POP3S), die man vorziehen sollte.

Unterhalb der Anwendungsprotokolle stehen zwei Transportprotokolle. *TCP* (*Transmission Control Protocol*) ist verbindungsorientiert und zuverlässig: Vor der Datenübertragung wird eine Verbindung per Drei-Wege-Handshake aufgebaut (*SYN*, *SYN-ACK*, *ACK*), jedes Datenpaket wird bestätigt und bei Verlust erneut gesendet, und die Reihenfolge bleibt erhalten. Das kostet etwas Zeit, ist aber richtig für Webseiten, E-Mail und Dateien. *UDP* (*User Datagram Protocol*) ist verbindungslos und schnell: Datenpakete werden einfach abgeschickt, ohne Bestätigung und ohne Garantie. Das passt zu Anwendungen, in denen Tempo wichtiger ist als Vollständigkeit, etwa Sprach- und Videoübertragung, Online-Spiele und DNS-Abfragen. Auf dem Protokollstapel liegt *IP* darunter, das Pakete über Netze hinweg zum Ziel bringt, aber keine Garantien gibt; *ICMP* ist ein Hilfsprotokoll für Fehler- und Statusmeldungen, das etwa `ping` nutzt.

Ein Dienst *lauscht* (*listen*) auf einem Port, ein Client verbindet sich mit diesem Port und bekommt für seine Seite einen dynamischen Port zugeteilt. Eine *Firewall* entscheidet anhand von Adressen, Ports und Protokollen, ob Verkehr erlaubt ist; das Sperren nicht benötigter Ports ist ein zentrales Mittel der Absicherung (Modul 10). Ein häufiger Auftrag lautet daher: “Welche Ports sind auf diesem Rechner offen?”

Das nächste Beispiel zeigt die Zuordnung von Portnummern zu Diensten, prüft auf dem eigenen Rechner, welche Ports erreichbar sind, und demonstriert den Unterschied zwischen TCP und UDP.

```python
import socket

WELL_KNOWN = {20: "FTP-Daten", 21: "FTP", 22: "SSH", 23: "Telnet", 25: "SMTP", 53: "DNS",
              67: "DHCP (Server)", 80: "HTTP", 110: "POP3", 123: "NTP", 143: "IMAP",
              161: "SNMP", 389: "LDAP", 443: "HTTPS", 445: "SMB", 587: "SMTP (Einreichung)",
              993: "IMAPS", 3389: "RDP"}
for port in (22, 80, 443, 3389):
    print(f"{port:5} {WELL_KNOWN[port]}")

server = socket.socket()
server.bind(("127.0.0.1", 0))
server.listen()
offener_port = server.getsockname()[1]

def offen(port):
    with socket.socket() as s:
        s.settimeout(0.3)
        return s.connect_ex(("127.0.0.1", port)) == 0

for p in [22, 80, 443, offener_port]:
    print(f"Port {p:5}: {'offen' if offen(p) else 'geschlossen'}")
server.close()

u1 = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
u1.bind(("127.0.0.1", 0))
u2 = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
u2.sendto(b"ping per UDP", u1.getsockname())
daten, absender = u1.recvfrom(1024)
print("UDP empfangen:", daten.decode(), "- kein Verbindungsaufbau noetig")
u1.close(); u2.close()
```

Das Dictionary hält die Zuordnung von Port zu Dienst; die erste Schleife gibt vier davon aus. Danach startet das Programm einen eigenen Lauschdienst auf einem vom System gewählten freien Port (`bind` mit Port 0). Die Funktion `offen` versucht mit `connect_ex`, eine TCP-Verbindung zu einem Port auf dem eigenen Rechner aufzubauen; `connect_ex` liefert 0, wenn die Verbindung gelingt. Im Testsystem waren die Ports 22, 80 und 443 geschlossen und nur der gerade geöffnete Port (hier 49505, bei jedem Lauf ein anderer) offen. Das ist im Kern das, was ein Portscanner tut. Im UDP-Teil erzeugt `SOCK_DGRAM` UDP-Sockets: Das eine bindet einen Port, das andere sendet mit `sendto` ohne Verbindungsaufbau; das erste empfängt mit `recvfrom` die Daten und die Absenderadresse.

Wichtig für die Praxis: Scannen von Ports ist nur auf eigenen Systemen oder mit ausdrücklicher Erlaubnis zulässig. In vielen Ländern kann das Scannen fremder Systeme rechtliche Folgen haben, und viele Anbieter betrachten es als Angriffsvorbereitung. Dieser Hinweis ist keine Rechtsberatung.

### Typische Fehler.

Falsch ist die Annahme, ein Port sei mit einem Protokoll untrennbar verbunden: Ein Webserver kann auch auf Port 8080 laufen, und auf Port 80 kann ein ganz anderes Programm lauschen. Falsch ist auch, dass UDP “schlecht” und TCP “gut” sei; beide haben ihre Berechtigung. Sicherheitsrelevant ist der Fehler, RDP (Port 3389) oder SMB (445) direkt aus dem Internet erreichbar zu machen; diese Ports gehören zu den am häufigsten angegriffenen. Bei Firewallregeln ist ein typischer Fehler, nur eine Richtung zu erlauben: Für eine Verbindung muss die Antwort zurückfließen können (moderne Firewalls verfolgen den Verbindungszustand und erlauben Antworten automatisch).

### Praxisbezug.

Wenn ein Mail-Programm nicht sendet, vergleicht der Support Port und Verschlüsselung mit den Vorgaben des Mailanbieters (zum Beispiel 587 mit STARTTLS oder 465 mit SSL/TLS). Wenn ein Webserver nicht erreichbar ist, wird geprüft, ob der Dienst läuft, ob er auf dem richtigen Port lauscht und ob die Firewall den Port freigibt.

## 4.6 WLAN und Funknetze

Ein *WLAN* (*Wireless LAN*, auch *Wi-Fi*) überträgt Daten per Funk nach den Normen der Familie IEEE 802.11. Geräte verbinden sich mit einem *Access Point*, der mit dem kabelgebundenen Netz verbunden ist. Jedes WLAN hat einen Namen, die *SSID* (*Service Set Identifier*), die der Access Point aussendet; die eindeutige Kennung des Access Points selbst ist die *BSSID* (seine MAC-Adresse).

Die Generationen werden von der Wi-Fi Alliance einfach nummeriert: Wi-Fi 4 entspricht dem Standard 802.11n, Wi-Fi 5 802.11ac, Wi-Fi 6 802.11ax und Wi-Fi 7 802.11be; Wi-Fi 6E ist 802.11ax mit Erweiterung in das 6-GHz-Band. Neuere Generationen bieten mehr Geschwindigkeit, bessere Verarbeitung vieler gleichzeitiger Geräte und effizientere Nutzung des Funkspektrums. Entscheidend sind die *Frequenzbänder*: Das *2,4-GHz-Band* hat eine große Reichweite und durchdringt Wände gut, bietet aber nur wenige Kanäle und ist stark mit Störungen belegt (Nachbarnetze, Bluetooth, Mikrowellen, schnurlose Telefone). Das *5-GHz-Band* bietet viel mehr Kanäle und weniger Störungen, dafür eine kürzere Reichweite und eine schlechtere Wanddurchdringung. Das *6-GHz-Band* (ab Wi-Fi 6E) bringt weiteren, bislang wenig belegten Platz. Ein Kanal ist ein Frequenzbereich; benachbarte Kanäle auf 2,4 GHz überlappen sich, weshalb als störungsfrei nebeneinander nutzbar die Kanäle 1, 6 und 11 gelten. Breitere Kanäle (40, 80 oder 160 MHz) erhöhen die Geschwindigkeit, brauchen aber mehr Platz und stören leichter.

Die Qualität der Verbindung zeigt der Empfangspegel (*RSSI*) in *dBm*, einer logarithmischen Einheit mit negativen Werten: Je näher bei null, desto besser. Als grobe Richtwerte gelten etwa $-50$ dBm als ausgezeichnet, $-60$ als sehr gut, $-70$ als gerade noch gut für Videostreaming, $-80$ als schwach und darunter als unbrauchbar. Die Dämpfung der Funkwellen steigt mit Entfernung und Frequenz, außerdem mit Hindernissen: Stahlbeton, Metall und Wasser (Aquarium, Heizungsrohre) dämpfen besonders stark. Verbesserungen sind ein günstigerer Aufstellort des Access Points (zentral, erhöht, frei), ein besserer Kanal, mehrere Access Points mit gleicher SSID (*Roaming*) oder ein Mesh-System sowie Kabelverbindung für ortsfeste Geräte.

Das Beispiel rechnet nach, warum 5 GHz weniger weit reicht. Es wandelt dBm-Werte in Milliwatt um, bewertet Pegel und berechnet die Dämpfung im freien Raum für 2,4 und 5 GHz mit der bekannten Formel $\mathrm{FSPL} = 20\log_{10}(d) + 20\log_{10}(f) + 32{,}44$, wobei $d$ in Kilometern und $f$ in Megahertz eingesetzt werden.

```python
import math

def rssi_qualitaet(dbm):
    if dbm >= -50: return "ausgezeichnet"
    if dbm >= -60: return "sehr gut"
    if dbm >= -70: return "gut"
    if dbm >= -80: return "schwach"
    return "unbrauchbar"

for dbm in (-45, -58, -67, -75, -88):
    mw = 10 ** (dbm / 10)
    print(f"{dbm:4} dBm = {mw:.2e} mW -> {rssi_qualitaet(dbm)}")

def freiraumdaempfung_db(entfernung_m, frequenz_mhz):
    return 20 * math.log10(entfernung_m / 1000) + 20 * math.log10(frequenz_mhz) + 32.44

for f in (2437, 5180):
    print(f"{f} MHz, 10 m: {freiraumdaempfung_db(10, f):.1f} dB Daempfung")
print(f"Unterschied: {freiraumdaempfung_db(10, 5180) - freiraumdaempfung_db(10, 2437):.1f} dB")

def kanal_mhz_2g(kanal):
    return 2407 + 5 * kanal
for k in (1, 6, 11):
    print(f"Kanal {k}: Mitte {kanal_mhz_2g(k)} MHz, "
          f"Bereich {kanal_mhz_2g(k)-10} bis {kanal_mhz_2g(k)+10} MHz")
```

Die Umrechnung `10 ** (dbm / 10)` liefert die Leistung in Milliwatt: $-45$ dBm sind etwa 0,00003 mW, $-88$ dBm nur noch etwa 1,6 Milliardstel Milliwatt, also rund zwanzigtausendmal weniger. Je zehn dB entsprechen dabei dem Faktor zehn. Die Funktion `rssi_qualitaet` ordnet die Pegel den Richtwerten zu. Bei der Dämpfung im freien Raum ergibt die Formel 60,2 dB bei 2437 MHz und 66,7 dB bei 5180 MHz für zehn Meter; 5 GHz verliert also bei gleicher Entfernung etwa 6,5 dB mehr; das entspricht einer um den Faktor 4,5 geringeren Empfangsleistung. Dazu kommt, dass Wände bei höheren Frequenzen stärker dämpfen. Die Kanalrechnung zeigt, dass die Kanäle 1, 6 und 11 auf 2,4 GHz jeweils 20 MHz breit sind und mit 25 MHz Abstand nicht überlappen (2402 bis 2422, 2427 bis 2447, 2452 bis 2472 MHz). Die Formel gilt für den freien Raum ohne Hindernisse und ist deshalb nur eine untere Schranke für die Dämpfung.

> **Ergänzung aus der Nachrecherche**
>
> Zur WLAN-Sicherheit: Verschlüsselungsverfahren in zeitlicher Reihenfolge sind WEP (gilt als gebrochen und darf nicht mehr verwendet werden), WPA (mit TKIP, überholt), WPA2 (mit AES, über Jahre Standard) und WPA3 (neuer Zugangsmechanismus SAE gegen Wörterbuchangriffe). Laut einem Fachartikel (Fierce Network, 27.07.2020) macht die Wi-Fi Alliance WPA3 seit dem 01.07.2020 zur Pflicht für Geräte, die ein Wi-Fi-Zertifikat erhalten. Für Heimnetze gilt: möglichst WPA3 oder mindestens WPA2 mit AES, ein langes Passwort, kein WPS, aktuelle Firmware und ein getrenntes Gastnetz. Die Zuordnung der Wi-Fi-Generationen zu den IEEE-Namen stammt aus einer Fachseite (electronics-notes.com); Angaben zu Geschwindigkeiten wurden bewusst weggelassen, weil die Praxiswerte stark vom Umfeld abhängen. Das Verbergen der SSID und das Filtern von MAC-Adressen bieten nur geringen Schutz, weil beides leicht umgangen werden kann.

### Typische Fehler.

Falsch ist, WLAN-Probleme immer dem Provider anzulasten: Meist liegen sie am Funkumfeld. Falsch ist auch die Annahme, “mehr Balken heißt schnellere Verbindung”; der Pegel sagt nichts über die Auslastung des Kanals. Beim Einrichten ist die Wahl des unsicheren oder fehlenden Passworts der schwerste Fehler: Ein offenes WLAN erlaubt jedem im Haus Mitlesen und Mitnutzen, und die Haftung für Missbrauch kann beim Inhaber landen. Beim Betrieb im Büro stören oft zu viele Access Points auf demselben Kanal; mehr Geräte lösen dann das Problem nicht, sondern verschlimmern es.

### Praxisbezug.

Bevor in einem Büro ein WLAN installiert wird, misst man die Funkumgebung (*Site Survey*) und plant Standorte und Kanäle. Im Support gilt: Stockt die Verbindung, wechselt man das Band (5 GHz statt 2,4 GHz), geht näher an den Access Point oder verbindet das Gerät testweise per Kabel, um Netz und WLAN zu trennen.

## 4.7 Netzwerktools

Zur Prüfung eines Netzes sind in jedem Betriebssystem Werkzeuge eingebaut, die man in der Kommandozeile aufruft (Abschnitt 3.5). Sie gehören zum Handwerkszeug jedes Supports, weil sie Fragen beantworten wie “Habe ich eine IP-Adresse?”, “Erreiche ich das Gateway?” oder “Wird der Name aufgelöst?”.

| Zweck                         | Windows   | Linux/macOS                |
|:------------------------------|:----------|:---------------------------|
| Eigene Konfiguration anzeigen | `ipconfig /all`  | `ip addr`, `ifconfig`         |
| Erreichbarkeit prüfen         | `ping Ziel`  | `ping Ziel`                   |
| Weg verfolgen                 | `tracert Ziel`  | `traceroute Ziel`                   |
| DNS abfragen                  | `nslookup Name` | `dig Name`, `nslookup`       |
| DNS-Cache leeren              | `ipconfig /flushdns` | systemabhängig             |
| Adresse erneuern              | `ipconfig /renew` | `dhclient`, Netzwerkmanager |
| Offene Verbindungen           | `netstat -an` | `ss -tuln`, `netstat`       |
| ARP-Cache (IP zu MAC)         | `arp -a` | `arp -a`, `ip neigh`       |
| Port testen (PowerShell)      | `Test-NetConnection Ziel -Port 443` | `nc -vz Ziel 443`                  |
| Webanfrage prüfen             | `curl -I URL` | `curl -I URL`                  |

Das wichtigste Werkzeug ist `ping`. Es sendet *ICMP-Echo-Anfragen* an ein Ziel und misst, wie lange die Antwort braucht (*Round-Trip-Time*, RTT). Die Ausgabe zeigt die Antwortzeit je Paket, den *TTL*-Wert (Zahl der Netzübergänge, die ein Paket maximal machen darf) und eine Zusammenfassung mit Paketverlust. Antwortet ein Ziel nicht, heißt das nicht zwingend, dass es ausgefallen ist: Manche Firewalls blockieren ICMP. `tracert` (Windows) und `traceroute` (Linux/macOS) zeigen den Weg eines Pakets über alle Zwischenstationen (*Hops*); sie senden Pakete mit schrittweise erhöhtem TTL-Wert, und jede Station, die das Paket verwirft, meldet sich zurück. Damit lässt sich erkennen, an welcher Stelle eine Verbindung abbricht oder langsam wird. `ipconfig` (Windows) und `ip` bzw. `ifconfig` (Linux/macOS) zeigen die Adresse, Maske, Gateway und DNS-Server der Netzwerkkarten; `nslookup` und `dig` fragen DNS-Server ab; `netstat` und `ss` zeigen offene Ports und bestehende Verbindungen.

Die folgenden Befehle geben eine typische Prüfreihenfolge für ein Windows-System wieder. Sie wurden in der Testumgebung nicht ausgeführt, weil sie ein Windows-System und Internetzugang voraussetzen; die Syntax entspricht der dokumentierten.

```text
ipconfig /all
ping 127.0.0.1
ping 192.168.1.1
ping 8.8.8.8
ping www.example.org
tracert www.example.org
nslookup www.example.org
```

Die erste Zeile zeigt die Konfiguration. Der Ping auf `127.0.0.1` prüft, ob der Netzwerkstapel des eigenen Rechners arbeitet. Der Ping auf das Gateway (hier als Beispiel `192.168.1.1`) prüft das lokale Netz. Der Ping auf eine öffentliche Adresse prüft die Verbindung ins Internet ohne Namensauflösung; der Ping auf einen Namen prüft zusätzlich DNS. `tracert` zeigt, wo es hakt, `nslookup` fragt DNS direkt. Wichtig ist die Reihenfolge von unten nach oben: Jeder Schritt setzt die vorigen voraus.

Das folgende Python-Programm wertet eine Ping-Ausgabe aus und misst Verbindungszeiten zu einem Port, eine Technik, die man “TCP-Ping” nennt und die auch dann funktioniert, wenn ICMP gesperrt ist. Die Ping-Ausgabe steht dabei als fertiger Text im Programm, weil sie in der Testumgebung nicht erzeugt werden kann.

```python
import re, socket, statistics, threading, time

AUSGABE = """PING 192.168.1.1 (192.168.1.1) 56(84) bytes of data.
64 bytes from 192.168.1.1: icmp_seq=1 ttl=64 time=1.21 ms
64 bytes from 192.168.1.1: icmp_seq=2 ttl=64 time=1.08 ms
64 bytes from 192.168.1.1: icmp_seq=3 ttl=64 time=24.90 ms
Request timeout for icmp_seq 4
--- 192.168.1.1 ping statistics ---
4 packets transmitted, 3 received, 25% packet loss, time 3004ms
"""
zeiten = [float(z) for z in re.findall(r"time=([\d.]+) ms", AUSGABE)]
verlust = int(re.search(r"(\d+)% packet loss", AUSGABE).group(1))
print(f"Antworten: {len(zeiten)}, Verlust: {verlust} %")
print(f"min {min(zeiten):.2f} ms, Mittel {statistics.mean(zeiten):.2f} ms, max {max(zeiten):.2f} ms")
print(f"Schwankung (Jitter): {statistics.stdev(zeiten):.2f} ms")

srv = socket.socket(); srv.bind(("127.0.0.1", 0)); srv.listen()
port = srv.getsockname()[1]
def annehmen():
    while True:
        try:
            c, _ = srv.accept(); c.close()
        except OSError:
            return
threading.Thread(target=annehmen, daemon=True).start()

def tcp_ping(host, port, anzahl=3):
    ergebnisse = []
    for _ in range(anzahl):
        start = time.perf_counter()
        try:
            with socket.create_connection((host, port), timeout=1):
                ergebnisse.append((time.perf_counter() - start) * 1000)
        except OSError:
            ergebnisse.append(None)
    return ergebnisse

for r in tcp_ping("127.0.0.1", port):
    print("Verbindungsaufbau:", f"{r:.3f} ms" if r is not None else "Timeout")
print(tcp_ping("127.0.0.1", 9, 1))
srv.close()
```

Der erste Teil nutzt *reguläre Ausdrücke*: `re.findall` sammelt alle Zahlen hinter `time=`, `re.search` holt den Prozentwert hinter “packet loss”. Drei Antworten bei vier gesendeten Paketen ergeben 25 Prozent Verlust. Die Zeiten 1,21, 1,08 und 24,90 ms haben einen Mittelwert von 9,06 ms, aber eine Standardabweichung von 13,72 ms; solche Schwankungen (*Jitter*) sind für Telefonie schädlicher als eine konstant leicht höhere Latenz, und der Ausreißer deutet auf zeitweise Überlast hin. Der zweite Teil startet einen Mini-Server, der Verbindungen entgegennimmt und sofort schließt, und misst mit `perf_counter` die Dauer des Verbindungsaufbaus; in der Testumgebung war es rund eine Millisekunde beim ersten und deutlich weniger bei den folgenden Aufrufen. Auf `127.0.0.1` Port 9 lauscht niemand, die Verbindung wird abgelehnt, und die Funktion gibt `None` zurück. Gegenüber einem fernen Server liegen die Werte wegen Entfernung und Geräten dazwischen bei vielen Millisekunden.

### Typische Fehler.

Falsch ist, einen fehlgeschlagenen Ping als Beweis für einen Ausfall zu werten, ohne zu wissen, ob ICMP erlaubt ist. Falsch ist auch, `ping` nur mit einem Namen zu testen: Fällt DNS aus, scheint das gesamte Netz tot zu sein. Richtig ist, zuerst mit IP-Adressen zu testen und dann mit Namen. Ein weiterer Fehler bei `tracert` ist, Sternchen (`*`) als Fehler zu deuten: Manche Router antworten nicht auf Traceroute-Pakete, ohne dass die Verbindung gestört ist. Wichtig ist, ob das Ziel am Ende erreicht wird.

### Praxisbezug.

Im Support lässt man sich bei Netzproblemen die Ausgabe von `ipconfig /all` und einigen Pings schicken. Daraus ergibt sich meist sofort, ob Adresse, Gateway, DNS oder das Internet betroffen ist, und das Ticket enthält die Messwerte als Beleg.

## 4.8 Netzwerk-Troubleshooting

Ein Netzwerkproblem erscheint dem Anwender fast immer als “Das Internet geht nicht”. Dahinter stecken Dutzende mögliche Ursachen auf mehreren Ebenen. Systematisches Vorgehen verhindert, dass man planlos an Einstellungen dreht. Die Grundidee verwendet das Schichtenmodell aus 4.1: Man prüft Schicht für Schicht, bevorzugt von unten nach oben (*Bottom-up*), weil jede Schicht auf der darunterliegenden aufbaut. Alternativ beginnt man in der Mitte (Ping auf das Gateway) und geht je nach Ergebnis nach oben oder unten (*Divide and Conquer*); *Top-down* beginnt bei der Anwendung und eignet sich, wenn das Problem offensichtlich nur eine Anwendung betrifft.

Die Prüfkette bei einem nicht funktionierenden Netz besteht aus sechs Fragen. Erstens, *Schicht 1 und 2*: Ist eine Verbindung da? Leuchtet die Link-LED, ist das Kabel gesteckt, ist das WLAN verbunden, ist der Adapter aktiv, der Flugmodus aus? Zweitens, *Adresse*: Hat das Gerät eine gültige IP-Adresse? Eine Adresse aus `169.254.x.x` verrät, dass DHCP nicht geantwortet hat. Drittens, *Gateway*: Erreicht das Gerät das Standardgateway? Fehlt das, sind Maske, Gateway-Eintrag, Switch oder Router verdächtig, oder es liegt ein IP-Konflikt vor. Viertens, *Internet über IP*: Ist eine öffentliche Adresse erreichbar? Falls nicht, liegt die Ursache am Router, am Anschluss oder beim Provider. Fünftens, *Namensauflösung*: Funktioniert der Ping auf einen Namen? Wenn der Ping auf die IP-Adresse klappt, auf den Namen aber nicht, ist DNS die Ursache. Sechstens, *Anwendung*: Funktioniert der Zugriff mit einem anderen Programm oder Browser? Falls nicht, kommen Proxy, VPN, Firewall, Zertifikatsprobleme oder eine Störung des Zielservers infrage.

Weitere typische Fehlerbilder sind: der *IP-Konflikt* (zwei Geräte teilen sich eine Adresse; das System meldet es meist; Ursache sind oft statische Adressen im DHCP-Bereich), *falsche Subnetzmaske oder falsches Gateway* (lokal geht alles, nach außen nichts), *Paketverlust* und *hohe Latenz* (schlechtes Kabel, überlastetes WLAN, überlastete Leitung, Konfigurationsfehler im Duplex-Modus), *Captive Portal* (öffentliches WLAN verlangt Anmeldung im Browser, bevor es Verkehr zulässt), *VPN-Probleme* (Tunnel steht, aber Verkehr fließt nicht oder falsch) und *Zeitprobleme* (falsche Systemzeit führt zu Zertifikatsfehlern). Zum Vorgehen gehört außerdem: Änderungen einzeln vornehmen, Ergebnisse notieren, einen Vergleich mit einem funktionierenden Gerät im selben Netz ziehen (Betrifft es nur diesen Rechner oder alle?) und zuletzt das Problem und die Lösung dokumentieren.

Das folgende Beispiel übersetzt die Prüfkette in eine Funktion. Sie erhält die Ergebnisse der einzelnen Prüfungen (wahr oder falsch) und gibt die Schicht aus, in der das Problem am wahrscheinlichsten liegt. Ergänzend zeigt eine zweite Funktion, wie ein Programm die eigene lokale Adresse ermittelt, ohne etwas zu senden.

```python
import ipaddress, socket

def lokale_ip():
    with socket.socket(socket.AF_INET, socket.SOCK_DGRAM) as s:
        try:
            s.connect(("203.0.113.1", 9))
            return s.getsockname()[0]
        except OSError:
            return None

def diagnose(ergebnisse):
    if not ergebnisse["link"]:
        return "Schicht 1/2: Kein Link - Kabel, WLAN, Adapter pruefen"
    ip = ipaddress.ip_address(ergebnisse["ip"]) if ergebnisse["ip"] else None
    if ip is None or ip.is_link_local:
        return "Schicht 3: Keine gueltige IP (APIPA) - DHCP-Server erreichbar?"
    if not ergebnisse["gateway"]:
        return "Schicht 3: Gateway nicht erreichbar - Maske, Gateway, Switch pruefen"
    if not ergebnisse["internet_ip"]:
        return "Schicht 3: Internet ueber IP nicht erreichbar - Router/Provider"
    if not ergebnisse["dns"]:
        return "Namensaufloesung: Ping per IP klappt, per Name nicht - DNS pruefen"
    if not ergebnisse["web"]:
        return "Schicht 7: Netz in Ordnung - Browser, Proxy, Zertifikat pruefen"
    return "Alle Pruefungen bestanden - Problem zeitweilig oder serverseitig"

faelle = {
    "Kabel gezogen":     {"link": False, "ip": None, "gateway": False,
                          "internet_ip": False, "dns": False, "web": False},
    "DHCP faellt aus":   {"link": True, "ip": "169.254.8.9", "gateway": False,
                          "internet_ip": False, "dns": False, "web": False},
    "DNS-Server defekt": {"link": True, "ip": "192.168.1.20", "gateway": True,
                          "internet_ip": True, "dns": False, "web": False},
    "Seite blockiert":   {"link": True, "ip": "192.168.1.20", "gateway": True,
                          "internet_ip": True, "dns": True, "web": False},
}
for name, werte in faelle.items():
    print(f"{name:18} -> {diagnose(werte)}")
print("Lokale IP dieses Rechners:", lokale_ip())
```

Die Funktion `diagnose` arbeitet die Prüfkette von unten nach oben ab und gibt bei der ersten fehlgeschlagenen Prüfung eine Diagnose zurück (*frühzeitiger Abbruch*). Fehlt der Link, ist alles Weitere sinnlos. Die Adresse wird mit `ipaddress` untersucht: Eine fehlende oder eine Link-Local-Adresse führt zur DHCP-Diagnose. Die vier Testfälle ergeben die erwarteten Diagnosen von “Kabel prüfen” bis “Browser und Proxy prüfen”. Die Funktion `lokale_ip` baut einen UDP-Socket auf, “verbindet” ihn mit einer Dokumentationsadresse (bei UDP wird dabei nichts gesendet; das System wählt nur die Schnittstelle aus, über die es das Ziel erreichen würde) und liest die eigene Adresse. Welche Adresse erscheint, hängt vom System ab. In der Testumgebung war es eine Adresse aus einem Dokumentationsbereich; auf einem normalen Büro-PC wäre es eine private Adresse aus dem lokalen Netz.

### Typische Fehler.

Falsch ist, bei jedem Netzwerkproblem sofort den Router neu zu starten, ohne das Ergebnis zu notieren; zwar hilft das oft, aber man erfährt nicht, was die Ursache war, und das Problem kehrt wieder. Falsch ist ebenfalls, Fehler bei “allen” Geräten dem eigenen Rechner zuzuschreiben, wenn gleichzeitig alle anderen im Raum ebenfalls Probleme haben (dann liegt die Ursache im gemeinsamen Netz). Und falsch ist, Einstellungen “auf Verdacht” zu ändern, ohne den vorherigen Zustand zu merken: Dann kann man sie nicht zurücknehmen.

### Praxisbezug.

Ein Support-Mitarbeiter hört “Das Internet geht nicht” und stellt die Fragen der Prüfkette: Gibt es eine Verbindung? Welche Adresse hat das Gerät? Erreicht es das Gateway? Der Ping auf eine öffentliche Adresse? Der Ping auf einen Namen? Betrifft es alle Geräte oder nur dieses? So lässt sich in wenigen Minuten aus “Das Internet geht nicht” ein konkreter Befund machen, der ins Ticket geschrieben wird (Modul 09).

> **Merke**
>
> Prüfkette von unten nach oben: Link, IP-Adresse, Gateway, Internet per IP, DNS, Anwendung. 169.254.x.x = DHCP fehlt. IP geht, Name nicht = DNS. Nur eine Änderung auf einmal, Ergebnisse notieren, Vergleich mit funktionierendem Gerät.

## Übungsaufgaben Modul 04

1.  Erklären Sie die Unterschiede zwischen LAN, WAN, Internet, Intranet und Extranet. Welche Rolle hat ein VPN?

2.  Welche Schicht des OSI-Modells ist betroffen, wenn (a) ein Kabel locker ist, (b) zwei Geräte dieselbe IP-Adresse haben, (c) ein Webserver den Port 443 nicht annimmt, (d) ein Browser eine Seite nicht darstellt?

3.  Ordnen Sie zu: Switch, Router, Access Point, Modem, Firewall. Ordnen Sie jedem Gerät eine Hauptaufgabe und die OSI-Schicht zu, auf der es hauptsächlich arbeitet.

4.  Berechnen Sie für das Netz `172.16.8.0/22` die Netzmaske, die Anzahl der nutzbaren Adressen sowie Netz- und Broadcastadresse. Liegt `172.16.10.20` in diesem Netz? Ist die Adresse privat?

5.  Ein Notebook hat die Adresse `169.254.12.7`. Nennen Sie die wahrscheinlichste Ursache und drei Prüfschritte in sinnvoller Reihenfolge.

6.  **Praxis:** Schreiben Sie ein Programm mit dem Modul `ipaddress`, das für ein Netz mit Präfix `/24` einen Plan mit vier gleich großen Teilnetzen erstellt und je Teilnetz Netzadresse, erste und letzte nutzbare Adresse und Broadcastadresse ausgibt.

7.  **Praxis:** Schreiben Sie ein Programm, das eine Liste von Ports (`[22, 80, 443, 8080]`) auf `127.0.0.1` prüft und mit Dienstname (aus einem Dictionary) und Zustand ausgibt. Starten Sie davor einen eigenen Server auf Port 8080 (oder einem anderen freien Port) und erklären Sie, warum der Test nur auf dem eigenen Rechner erfolgt.

8.  **Praxis:** Erweitern Sie die Funktion `diagnose` um den Fall “hoher Paketverlust”, in dem alle Prüfungen bestanden sind, aber mehr als 5 Prozent der Pakete verloren gehen, und geben Sie dann Hinweise für WLAN-Probleme aus. Beschreiben Sie, wie Sie in diesem Fall WLAN und Kabel unterscheiden würden.

## Lösungen Modul 04

1.  LAN: lokales Netz (Gebäude), WAN: Netz über große Entfernung (zum Beispiel zwischen Standorten), Internet: weltweiter Verbund vieler Netze. Intranet: internes Netz mit Internettechnik nur für Mitarbeitende, Extranet: Intranet plus ausgewählte externe Partner. Ein VPN baut einen verschlüsselten Tunnel über ein öffentliches Netz auf, sodass entfernte Geräte sicher auf das interne Netz zugreifen können.

2.  \(a\) Schicht 1 (Bitübertragung), (b) Schicht 3 (Vermittlung, IP), (c) Schicht 4 (Transport, Port), (d) Schicht 7 (Anwendung).

3.  Switch: verbindet Geräte im LAN anhand der MAC-Adresse (Schicht 2). Router: verbindet verschiedene Netze anhand der IP-Adresse (Schicht 3). Access Point: Übergang zwischen Kabel und WLAN (Schicht 1 und 2). Modem: wandelt Signale zum Übertragungsmedium des Providers (Schicht 1). Firewall: filtert Verkehr nach Regeln, meist Schichten 3 und 4, moderne auch höher.

4.  Präfix 22 bedeutet Maske `255.255.252.0`. Das Netz hat $2^{10}=1024$ Adressen, nutzbar sind 1022. Netzadresse `172.16.8.0`, Broadcast `172.16.11.255` (der Bereich reicht von `.8.0` bis `.11.255`). `172.16.10.20` liegt in diesem Bereich, und `172.16.0.0/12` ist ein privater Bereich, die Adresse ist also privat. Probe mit Python: `ipaddress.ip_network("172.16.8.0/22")`.

5.  Wahrscheinlichste Ursache: Das Gerät hat keine Antwort von einem DHCP-Server erhalten und eine Link-Local-Adresse gewählt. Prüfschritte: (1) Verbindung prüfen (Kabel, Link-LED, WLAN-Verbindung, richtiges Netz), (2) mit anderen Geräten im selben Netz vergleichen und prüfen, ob dort ebenfalls keine Adresse vergeben wird (dann DHCP-Server oder Router), (3) Adresse erneuern (`ipconfig /renew`) beziehungsweise bei einem Ausfall des DHCP-Servers diesen prüfen und neu starten.

6.  Beispiellösung:

    ```python
    import ipaddress

    netz = ipaddress.ip_network("192.168.20.0/24")
    for t in netz.subnets(new_prefix=26):
        h = list(t.hosts())
        print(f"{str(t):18} erste {h[0]}  letzte {h[-1]}  Broadcast {t.broadcast_address}")
    ```

    Ausgabe: vier Zeilen für `.0/26`, `.64/26`, `.128/26` und `.192/26` mit jeweils 62 nutzbaren Adressen (erste `.1`, `.65`, `.129`, `.193`; letzte `.62`, `.126`, `.190`, `.254`).

7.  Beispiellösung:

    ```python
    import socket
    DIENSTE = {22: "SSH", 80: "HTTP", 443: "HTTPS", 8080: "HTTP-Alternativ"}

    server = socket.socket()
    server.bind(("127.0.0.1", 8080))
    server.listen()
    for port, name in DIENSTE.items():
        with socket.socket() as s:
            s.settimeout(0.3)
            zustand = "offen" if s.connect_ex(("127.0.0.1", port)) == 0 else "geschlossen"
        print(f"{port:5} {name:16} {zustand}")
    server.close()
    ```

    Ergebnis: 8080 offen, die anderen geschlossen (sofern auf Ihrem Rechner nichts lauscht). Ist 8080 belegt, scheitert `bind`; dann einen anderen Port wählen. Der Test erfolgt nur auf dem eigenen Rechner, weil das Scannen fremder Systeme ohne Erlaubnis rechtlich problematisch sein kann und als Angriffsvorbereitung gilt.

8.  Beispiellösung (zusätzliche Zeilen am Ende von `diagnose`, vor dem letzten `return`, mit einem Eintrag `"verlust"` in den Ergebnissen):

    ```python
        if ergebnisse.get("verlust", 0) > 5:
            return "Paketverlust ueber 5 Prozent - WLAN-Signal, Kanal, Kabel pruefen"
    ```

    Unterscheidung WLAN und Kabel: Das Gerät testweise per Kabel anschließen oder einen Ping auf das Gateway sowohl über WLAN als auch über Kabel messen. Tritt der Verlust nur über WLAN auf, liegen Signalstärke, Störungen oder Kanalwahl nahe; tritt er auch am Kabel auf, ist die Leitung, der Switch-Port oder der Provider zu prüfen.
