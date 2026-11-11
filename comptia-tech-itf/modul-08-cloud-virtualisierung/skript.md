# Modul 8 - Cloud, Virtualisierung und moderne Plattformen

> **Hinweis zu diesem Kapitel:** Das ist das Kapitel des Skripts „CompTIA Tech+ / ITF+ (FC0-U71): Lernskript in Modulen“, aus der LaTeX-Quelle in Markdown umgewandelt (Text und Listings unverändert, Boxen als Zitatblöcke, Aufgaben und Lösungen als nummerierte Listen). Laut Skript wurden die Python-Beispiele bei der Erstellung im Arbeitsbereich ausgeführt, die gezeigten Ausgaben stammen aus diesen Läufen; Windows- und PowerShell-Befehle wurden nicht ausgeführt. Für dieses Repository wurden die Listings **nicht erneut ausgeführt**. Prüfungsdetails, Produktnamen und Versionen ändern sich; maßgeblich sind die aktuellen Prüfungsziele (Exam Objectives) von CompTIA. Übersicht zum Modul: [README](README.md).

**Dauer:** 8 h

**Priorität:** 2

| Nr. | Lerneinheit                                | Dauer (h) | Prio |
|----:|:-------------------------------------------|----------:|-----:|
| 8.1 | Virtualisierungskonzepte                   |         1 |    2 |
| 8.2 | Container-Grundlagen                       |      0,75 |    2 |
| 8.3 | Cloud-Service-Modelle                      |         1 |    1 |
| 8.4 | Bereitstellungsmodelle                     |      0,75 |    1 |
| 8.5 | Identität und Zugriff in der Cloud         |         1 |    1 |
| 8.6 | Skalierung und Verfügbarkeit               |         1 |    2 |
| 8.7 | Cloud-Speicher und Kernservices            |         1 |    2 |
| 8.8 | Cloud-Troubleshooting und Governance-Basis |       1,5 |    1 |
|     | **Summe**                                  |     **8** |      |

Kaum ein Unternehmen betreibt heute alle Systeme in einem eigenen Serverraum. Rechenleistung, Speicher und Anwendungen kommen zunehmend aus der *Cloud*, also aus großen Rechenzentren von Anbietern, die man über das Netz nutzt und nach Verbrauch bezahlt. Möglich wurde das durch die *Virtualisierung*: Ein physischer Rechner wird in viele logische aufgeteilt. Dieses Modul erklärt zuerst die Technik darunter (virtuelle Maschinen und Container), dann die Servicemodelle (IaaS, PaaS, SaaS) und Bereitstellungsmodelle (öffentlich, privat, hybrid), dann die drei Fragen, die in der Cloud über Erfolg und Sicherheit entscheiden: Wer darf was (Identität und Zugriff), wie wächst das System mit der Last und wie bleibt es verfügbar, wo liegen die Daten. Den Abschluss bilden die Fehlersuche und eine Ordnung für Kosten und Verantwortung. Es ist das Pendant zu Modul 5, wo die Nutzersicht auf SaaS behandelt wurde. Sicherheitsaspekte der Cloud-Freigaben stehen in Abschnitt 10.6, Infrastruktur als Code in Abschnitt 12.2, Kosten und Migration in 12.3 und 12.4. Alle Rechenbeispiele sind in Python geschrieben und wurden ausgeführt; Preise, Mengen und Namen sind erfunden. Ein echter Cloud-Zugang wurde nicht verwendet.

## 8.1 Virtualisierungskonzepte

*Virtualisierung* bedeutet, Hardware-Ressourcen (Prozessor, Arbeitsspeicher, Speicher, Netz) durch eine Softwareschicht zu abstrahieren und mehreren Nutzern oder Systemen als eigene, getrennte Ressourcen zur Verfügung zu stellen. Das wichtigste Beispiel ist die *virtuelle Maschine* (VM): ein vollständiger, in Software nachgebildeter Computer mit eigenem Betriebssystem, der sich aus Sicht der darin laufenden Programme wie echte Hardware verhält. Die Softwareschicht, die VMs erzeugt und verwaltet, heißt *Hypervisor*. Das Betriebssystem in der VM heißt *Gast* (*Guest*), der physische Rechner *Host*.

Man unterscheidet zwei Bauarten. Ein *Typ-1-Hypervisor* (*bare metal*) läuft direkt auf der Hardware und ist selbst ein kleines Spezialbetriebssystem; er wird in Rechenzentren eingesetzt, weil er schnell und gut zu verwalten ist (Beispiele: Hyper-V in Windows Server, VMware ESXi, KVM unter Linux). Ein *Typ-2-Hypervisor* läuft als normales Programm auf einem vorhandenen Betriebssystem; er eignet sich für Arbeitsplätze, Tests und Schulungen (Beispiele: VirtualBox, VMware Workstation). Die Vorteile der Virtualisierung sind *Konsolidierung* (viele schwach ausgelastete Server werden auf wenigen Hosts zusammengefasst, das spart Hardware, Strom und Platz), *Isolation* (eine VM stürzt ab, die anderen laufen weiter), *Flexibilität* (neue Server in Minuten statt Wochen, Kopieren und Verschieben im Betrieb, Vorlagen), *Wiederherstellbarkeit* und *Testbarkeit*. Besonders praktisch sind *Snapshots*: Ein Schnappschuss hält den Zustand einer VM fest, sodass man nach einem fehlgeschlagenen Update zurückspringen kann. Snapshots sind aber kein Ersatz für ein Backup (Abschnitt 6.6): Sie liegen auf demselben Speicher, wachsen mit der Zeit und bremsen die VM. Mit *Live-Migration* kann man eine laufende VM auf einen anderen Host verschieben, etwa für Wartungen. Neben Servern lassen sich auch Arbeitsplätze virtualisieren (*virtuelle Desktops*), Speicher (*Storage-Virtualisierung*) und Netze (*virtuelle Switches* und Netze).

Die Planung eines Virtualisierungshosts ist im Kern Rechenarbeit. Jede VM erhält virtuelle Prozessoren (*vCPUs*) und virtuellen Arbeitsspeicher. Beim Arbeitsspeicher rechnet man meist ohne Überbuchung, beim Prozessor erlaubt man mehr vCPUs als physische Kerne, weil VMs selten gleichzeitig volle Last haben (*Überbuchung*, englisch *Overcommitment*); typische Verhältnisse liegen bei einigen vCPUs je Kern, hängen aber stark von der Last ab. Entscheidend ist die Frage: Was passiert, wenn ein Host ausfällt? Das Programm rechnet es an einem Beispiel mit zwei Hosts und sechs VMs durch.

```python
hosts = [{"name": "host1", "cpu_kerne": 32, "ram_gb": 256},
         {"name": "host2", "cpu_kerne": 32, "ram_gb": 256}]
vms = [("web", 4, 16), ("db", 8, 64), ("app", 8, 32),
       ("test", 4, 16), ("backup", 2, 8), ("dc", 4, 16)]
vcpu = sum(v[1] for v in vms)
vram = sum(v[2] for v in vms)
pcpu = sum(h["cpu_kerne"] for h in hosts)
pram = sum(h["ram_gb"] for h in hosts)
print(f"vCPU gesamt {vcpu}, physische Kerne {pcpu}, Verhaeltnis {vcpu/pcpu:.2f}:1")
print(f"vRAM gesamt {vram} GB, physischer RAM {pram} GB, Belegung {vram/pram*100:.1f} %")
rest_cpu = hosts[0]["cpu_kerne"]
rest_ram = hosts[0]["ram_gb"]
print("Nach Ausfall eines Hosts: vRAM", vram, "von", rest_ram, "GB ->",
      "passt" if vram <= rest_ram else "passt nicht")
print("vCPU:pCPU nach Ausfall", round(vcpu / rest_cpu, 2))
for ziel in (4, 8):
    print(f"Grenze {ziel}:1 ->", "ok" if vcpu / rest_cpu <= ziel else "ueberschritten")
```

Die Liste `vms` enthält Name, vCPUs und RAM in GB. Die Summen über alle VMs ergeben 30 vCPUs und 152 GB. Die beiden Hosts haben zusammen 64 Kerne und 512 GB; das Verhältnis beträgt 0,47 zu 1 (keine Überbuchung) und die Speicherbelegung 29,7 Prozent. Interessant ist der Fall des Ausfalls: Bleibt nur ein Host übrig (32 Kerne, 256 GB), passen alle VMs weiterhin (152 von 256 GB), und das CPU-Verhältnis steigt auf 0,94 zu 1, bleibt also unter den beispielhaft gewählten Grenzen von 4 zu 1 und 8 zu 1. Diese Rechnung heißt *N+1-Planung*: Man dimensioniert die Hosts so, dass der Ausfall eines Hosts verkraftet wird. Die Grenzen von 4:1 und 8:1 sind Annahmen für das Beispiel; in der Praxis richten sie sich nach der gemessenen Last (Abschnitt 9.7).

### Typische Fehler.

Falsch ist, den Hostspeicher voll zu verplanen, sodass bei einem Ausfall nichts mehr Platz hat. Falsch ist, Snapshots als Sicherung zu betrachten oder wochenlang aufzuheben. Falsch ist, VMs ungepflegt “zu vergessen”: Auch virtuelle Server brauchen Updates, Lizenzen und Überwachung, und es entsteht schnell ein *VM-Wildwuchs*. Falsch ist, das Wirtsystem schlechter zu schützen als die Gäste: Wer den Hypervisor übernimmt, kontrolliert alle VMs.

### Praxisbezug.

Beim Entwickeln und Testen nutzt man VMs, um gefahrlos Software auszuprobieren und beim Fehlschlag die Maschine zu verwerfen. Im Rechenzentrum begründet die Virtualisierung die Cloud: Anbieter schneiden aus großen Hosts viele VMs für ihre Kunden.

> **Merke**
>
> Hypervisor Typ 1 läuft direkt auf der Hardware (Rechenzentrum), Typ 2 auf einem Betriebssystem (Arbeitsplatz). Vorteile: Konsolidierung, Isolation, Flexibilität, Snapshots (kein Backup!). Host-Planung immer mit Ausfall eines Hosts rechnen (N+1).

## 8.2 Container-Grundlagen

Ein *Container* verpackt eine Anwendung samt allem, was sie zum Laufen braucht (Bibliotheken, Einstellungen), in ein Paket, das auf jedem Rechner mit passender Container-Laufzeit gleich abläuft. Anders als eine VM enthält ein Container *kein eigenes Betriebssystem*: Alle Container eines Hosts teilen sich dessen Betriebssystemkern (*Kernel*) und sind voneinander durch Mechanismen des Kernels getrennt. Das macht Container klein (Megabyte statt Gigabyte), schnell startbar (Sekunden statt Minuten) und sparsam. Der Preis ist eine schwächere Isolation, weil ein Fehler im gemeinsamen Kernel alle betreffen kann, und die Bindung an die Art des Kernels (Linux-Container laufen auf einem Linux-Kern; unter Windows und macOS läuft dafür im Hintergrund ein kleines virtuelles Linux). Eine Quelle zum Vergleich bestätigt im Kern: Container teilen den Kernel des Hosts, sind kleiner und starten schneller, VMs bringen ein eigenes Gastsystem mit und bieten stärkere Trennung.

> **Ergänzung aus der Nachrecherche**
>
> Ein Vergleichsartikel (nordvpn.com, abgerufen, Anbieter-Blog, daher nur als Überblick zu verstehen) fasst die Unterschiede so zusammen: Container nutzen den Kernel des Hosts, enthalten nur Anwendung und Einstellungen, starten in Sekunden und sind voneinander isoliert, brauchen aber sorgfältige Konfiguration, weil sie den Kernel teilen; VMs laufen mit eigenem Gastbetriebssystem, sind größer, brauchen länger zum Start und isolieren vollständig voneinander. Die Wahl hängt von der Aufgabe ab; in der Praxis laufen Container häufig *in* VMs, sodass sich beide Ebenen ergänzen.

Zentrale Begriffe sind das *Image* (die unveränderliche Vorlage, aus mehreren Schichten aufgebaut: Betriebssystem-Basis, Laufzeit, Bibliotheken, Anwendung), der *Container* (eine laufende Instanz eines Images) und die *Registry* (ein Lager für Images, öffentlich oder privat). Ein Image wird mit einer Bauanleitung erzeugt, bei Docker das *Dockerfile*. Weil Images aus Schichten bestehen, werden gemeinsame Schichten nur einmal gespeichert und übertragen. Bei vielen Containern auf einem Host mit demselben Basisimage sinkt der Platzbedarf deutlich; ein Update lädt nur die geänderte Schicht. Container sind *flüchtig*: Ihr Inneres geht beim Löschen verloren, wichtige Daten gehören daher auf ein eingebundenes *Volume* oder einen externen Speicher. Für viele Container gibt es *Orchestrierung* (am bekanntesten Kubernetes), die Container startet, überwacht, bei Ausfall ersetzt und bei Last vervielfacht.

Das folgende Programm rechnet beide Aussagen mit angenommenen Zahlen nach: den Speicherbedarf von 20 VMs gegenüber 20 Containern und die Wirkung der Schichten bei einem Update.

```python
vm_overhead_gb = 8
container_overhead_gb = 0.1
app_gb = 0.5
n = 20
print("20 VMs:", n * (vm_overhead_gb + app_gb), "GB")
print("20 Container:", n * (container_overhead_gb + app_gb) + 8, "GB (inkl. 8 GB fuer das gemeinsame Host-System)")

schichten = {"basis-os": 80, "python": 120, "bibliotheken": 40, "app-v1": 5, "app-v2": 6}
v1 = ["basis-os", "python", "bibliotheken", "app-v1"]
v2 = ["basis-os", "python", "bibliotheken", "app-v2"]
print("Image v1:", sum(schichten[s] for s in v1), "MB; v2:", sum(schichten[s] for s in v2), "MB")
gemeinsam = set(v1) & set(v2)
print("Gemeinsame Schichten:", sorted(gemeinsam), "=",
      sum(schichten[s] for s in gemeinsam), "MB wird nur einmal gespeichert")
print("Neu zu laden fuer Update v2:", sum(schichten[s] for s in v2 if s not in v1), "MB")
```

Im ersten Teil rechnet das Programm mit der Annahme, dass jedes Gastsystem einer VM 8 GB für das Betriebssystem belegt, jeder Container nur 0,1 GB, und jede Anwendung 0,5 GB. Für 20 VMs ergibt sich 170 GB, für 20 Container einschließlich eines gemeinsamen Host-Systems von 8 GB nur 20 GB; die Zahlen sind Annahmen, die Größenordnung ist typisch. Im zweiten Teil beschreibt das Wörterbuch die Schichten eines Images mit ihrer Größe in Megabyte. Zwei Versionen, `v1` und `v2`, unterscheiden sich nur in der obersten Schicht (der Anwendung). Mengen (`set`) und der Operator `&` bestimmen die gemeinsamen Schichten: Basis, Python und Bibliotheken, zusammen 240 MB, die nur einmal gespeichert werden. Für das Update auf Version 2 sind nur die 6 MB der neuen Anwendungsschicht zu übertragen, obwohl das Gesamtimage 246 MB groß ist. Das erklärt, warum Container so schnell verteilt werden.

Ein Dockerfile sieht in der einfachsten Form so aus (nicht ausgeführt, nur zur Anschauung; wer Docker installiert hat, kann es mit `docker build` nutzen):

```text
FROM python:3.12-slim
WORKDIR /app
COPY app.py .
USER nobody
CMD ["python", "app.py"]
```

`FROM` nennt das Basisimage, `WORKDIR` das Arbeitsverzeichnis, `COPY` kopiert die Anwendung hinein, `USER nobody` sorgt dafür, dass das Programm nicht mit Administratorrechten im Container läuft, `CMD` legt den Startbefehl fest. Jede Zeile erzeugt eine Schicht. Die Zeile mit dem Benutzer ist eine einfache Sicherheitsmaßnahme (geringste Rechte, Abschnitt 10.4).

### Typische Fehler.

Falsch ist, Container wie VMs zu behandeln und darin Daten zu speichern, die verschwinden dürfen. Falsch ist, Images aus unbekannten öffentlichen Quellen ungeprüft zu verwenden: Sie können Schadcode oder Schwachstellen enthalten. Falsch ist, Container als Administrator laufen zu lassen. Falsch ist, Images nie neu zu bauen, sodass die enthaltenen Bibliotheken veralten. Falsch ist, zu vergessen, dass sich alle Container den Kernel teilen: Eine Sicherheitslücke im Host-Kernel betrifft alle Container.

### Praxisbezug.

Entwickler liefern Anwendungen als Images, damit “bei mir läuft es” auch auf dem Server gilt. Der Betrieb muss wissen, woher die Images kommen, wie sie aktualisiert werden und wo ihre Daten liegen.

## 8.3 Cloud-Service-Modelle

*Cloud Computing* bedeutet nach der Definition des US-Instituts NIST (Special Publication 800-145, abgerufen) den Zugriff auf einen gemeinsamen Pool konfigurierbarer Ressourcen, die schnell und mit geringem Verwaltungsaufwand bereitgestellt werden. Die Definition nennt fünf Merkmale: Selbstbedienung nach Bedarf (man bucht ohne Anruf beim Anbieter), breiter Netzzugang, gebündelte Ressourcen (mehrere Kunden teilen sich dieselben Systeme, *Multi-Tenancy*), schnelle Anpassbarkeit (*Elastizität*) und gemessene Nutzung (man zahlt, was man verbraucht). Dazu gibt es drei Servicemodelle, die sich darin unterscheiden, wie viel der Anbieter übernimmt.

Bei *Infrastructure as a Service* (IaaS) mietet man die Grundbausteine: virtuelle Server, Speicher, Netze. Man verwaltet Betriebssystem, Updates, Anwendungen und Daten selbst, der Anbieter betreibt Hardware und Virtualisierung. IaaS gibt die größte Freiheit und den größten Eigenaufwand. Bei *Platform as a Service* (PaaS) stellt der Anbieter zusätzlich Betriebssystem und Laufzeitumgebung (Datenbank, Webserver, Entwicklungsplattform); man bringt nur die Anwendung und die Daten mit. Es eignet sich für Entwickler, die sich nicht um Server kümmern wollen. Bei *Software as a Service* (SaaS, Abschnitt 5.7) nutzt man die fertige Anwendung; man verwaltet im Wesentlichen nur Konten, Einstellungen und Daten. Mit *Function as a Service* (“Serverless”) schließlich lädt man nur einzelne Funktionen hoch, die der Anbieter bei Bedarf ausführt und nach Ausführungen abrechnet; die Server gibt es natürlich weiterhin, man sieht sie nur nicht.

> **Ergänzung aus der Nachrecherche**
>
> Das *Modell der geteilten Verantwortung* (englisch *Shared Responsibility Model*) legt fest, was der Anbieter und was der Kunde schützt. Nach einer Darstellung von CrowdStrike (abgerufen, Anbieter-Quelle) sichert bei IaaS der Anbieter die Infrastruktur, der Kunde Betriebssystem, Anwendungen, Daten und Code; bei PaaS sichert der Anbieter die Plattform, der Kunde seine Anwendungen und deren Zugänge; bei SaaS sichert der Anbieter die Anwendung, der Kunde Endgeräte, Benutzer, Konfiguration und Daten. In allen Modellen bleiben beim Kunden die Datensicherheit, die Einhaltung von Vorschriften, das Identitäts- und Zugriffsmanagement, die Zugangsdaten der Benutzer und die Sicherheit der Endgeräte. Ein Veeam-Beitrag (abgerufen, Anbieter-Quelle) betont, dass man sogar bei SaaS wie Microsoft 365 selbst für die Sicherung seiner Daten sorgen muss. Bei den konkreten Verträgen der Anbieter gelten deren Bedingungen.

Das Programm bildet die Verantwortung als Tabelle ab. Jede Schicht eines Systems (von den Daten bis zum Rechenzentrum) wird in jedem Modell entweder vom Kunden (`K`) oder vom Anbieter (`A`) verantwortet. Die Zuordnung ist eine vereinfachte Darstellung; Verträge können Abweichungen enthalten.

```python
SCHICHTEN = ["Daten", "Konten/Identitaeten", "Anwendung",
             "Betriebssystem", "Virtualisierung", "Hardware/Rechenzentrum"]
VERANTWORTUNG = {
    "On-Premises": ["K", "K", "K", "K", "K", "K"],
    "IaaS": ["K", "K", "K", "K", "A", "A"],
    "PaaS": ["K", "K", "K", "A", "A", "A"],
    "SaaS": ["K", "K", "A", "A", "A", "A"],
}
print(f"{'':26}" + "".join(f"{m:>12}" for m in VERANTWORTUNG))
for i, s in enumerate(SCHICHTEN):
    print(f"{s:26}" + "".join(f"{VERANTWORTUNG[m][i]:>12}" for m in VERANTWORTUNG))
for m, v in VERANTWORTUNG.items():
    print(m, "Kunde verantwortlich fuer", v.count("K"), "von 6 Schichten")
```

Die Liste `SCHICHTEN` und das Wörterbuch `VERANTWORTUNG` enthalten für jedes Modell sechs Einträge in derselben Reihenfolge. Die Ausgabe ist eine Tabelle mit den Modellen als Spalten: Die Zeilen “Daten” und “Konten/Identitäten” stehen in allen vier Spalten auf `K`; bei “Anwendung” wechselt die Verantwortung erst bei SaaS zum Anbieter, beim Betriebssystem bei PaaS, bei der Virtualisierung bei IaaS. Die Zählung zeigt, dass der Kunde bei On-Premises für 6 von 6 Schichten zuständig ist, bei IaaS für 4, bei PaaS für 3 und bei SaaS für 2. Die wichtigste Erkenntnis ist, dass *zwei Zeilen nie wegfallen*: Daten und Identitäten bleiben beim Kunden. Der häufigste Vorfall in der Cloud ist deshalb nicht der Einbruch ins Rechenzentrum des Anbieters, sondern eine Fehlkonfiguration oder ein gestohlenes Konto beim Kunden.

### Typische Fehler.

Falsch ist die Annahme, “der Anbieter kümmert sich um die Sicherheit”: Das gilt nur für seinen Teil. Falsch ist, bei IaaS keine Updates für die virtuellen Server einzuplanen. Falsch ist, Kosten nur nach dem Preis pro Stunde zu beurteilen, ohne den Eigenaufwand zu rechnen. Falsch ist, das Modell nach dem Namen und nicht nach der Verantwortung zu wählen.

### Praxisbezug.

Bei jeder neuen Cloud-Lösung ist die erste Frage: Welches Modell ist das, und was ist damit meine Aufgabe? Aus der Antwort ergeben sich Updates, Sicherungen, Zugangsverwaltung und Überwachung.

> **Merke**
>
> IaaS = Infrastruktur mieten (ich verwalte OS und Anwendungen); PaaS = Plattform (ich bringe die Anwendung); SaaS = fertige Software (ich verwalte Konten und Daten). Geteilte Verantwortung: Daten, Identitäten, Konfiguration und Endgeräte bleiben immer beim Kunden.

## 8.4 Bereitstellungsmodelle

Während die Servicemodelle sagen, *was* geliefert wird, sagen die Bereitstellungsmodelle, *wo* und *für wen* die Cloud betrieben wird. Die NIST-Definition nennt vier. Die *öffentliche Cloud* (*Public Cloud*) gehört einem Anbieter und steht jedem offen, der bezahlt; die Ressourcen werden mit anderen Kunden geteilt (logisch getrennt). Sie bietet große Auswahl, Elastizität und Zahlung nach Verbrauch, aber weniger Kontrolle über Standort und Technik. Die *private Cloud* wird für eine einzige Organisation betrieben, im eigenen Rechenzentrum oder bei einem Dienstleister; sie bietet mehr Kontrolle und Einhaltung strenger Vorgaben, aber auch den Aufwand und die Kosten des Eigenbetriebs und weniger Elastizität. Die *Hybrid-Cloud* verbindet öffentliche und private Cloud (oder eigene Systeme), sodass Daten und Anwendungen dazwischen bewegt werden können; sie dient zum Beispiel dazu, sensible Daten im eigenen Haus zu halten und Lastspitzen in die öffentliche Cloud auszulagern (*Cloud Bursting*). Die *Community Cloud* wird von einer Gruppe von Organisationen mit gemeinsamen Anforderungen geteilt (etwa Behörden oder Forschungseinrichtungen). Davon zu unterscheiden ist die *Multi-Cloud*: Man nutzt Dienste mehrerer Anbieter, um Abhängigkeit zu vermeiden oder jeweils das Beste zu wählen, erkauft sich das aber mit mehr Komplexität bei Sicherheit, Verwaltung und Wissen.

Die Wahl hängt von Anforderungen ab: Datenschutz und Standort der Daten (Abschnitt 11.3), Vorschriften der Branche, Leistungsbedarf, vorhandene Systeme, Kosten über die Laufzeit (Abschnitt 12.3), Verfügbarkeit, Ausstiegsmöglichkeit (*Lock-in*). Das folgende Programm formt diese Abwägung als einfache Entscheidungsregel nach: Sie nimmt Eigenschaften einer Anwendung entgegen und schlägt ein Modell vor. Solche Regeln sind Hilfen für die Diskussion, keine Entscheidung. Die Eingabewerte und Regeln sind frei gewählt.

```python
def empfehlung(sensibel, lastspitzen, regulierung_streng, eigenes_rz_vorhanden):
    if regulierung_streng and sensibel:
        return "privat" if eigenes_rz_vorhanden else "oeffentlich mit strenger Kontrolle pruefen"
    if sensibel and lastspitzen and eigenes_rz_vorhanden:
        return "hybrid"
    if lastspitzen:
        return "oeffentlich"
    return "oeffentlich oder privat, nach Kosten"

faelle = {
    "Webshop mit Weihnachtsspitze": (False, True, False, True),
    "Patientenakten": (True, False, True, True),
    "Personalsystem mit Spitzen im Jahresabschluss": (True, True, False, True),
    "Interne Wiki": (False, False, False, False),
}
for name, args in faelle.items():
    print(f"{name:48} -> {empfehlung(*args)}")
```

Die Funktion prüft vier Eigenschaften und gibt nach Regeln, die von oben nach unten gelten, eine Empfehlung zurück. Der Aufruf `empfehlung(*args)` entpackt das Tupel in einzelne Argumente. Ergebnis: Der Webshop mit saisonalen Spitzen, nicht sensibel, eignet sich für die öffentliche Cloud; die Patientenakten mit strenger Regulierung und eigenem Rechenzentrum gehören in eine private Umgebung; das Personalsystem mit sensiblen Daten und Spitzen führt zur hybriden Lösung; für das interne Wiki ohne besondere Anforderungen entscheiden die Kosten. Das Beispiel zeigt vor allem, dass dieselbe Organisation verschiedene Modelle gleichzeitig nutzt und dass die Daten, nicht die Technik, die Wahl bestimmen.

### Typische Fehler.

Falsch ist, “Cloud” mit “öffentlich und billig” gleichzusetzen. Falsch ist, eine Hybrid-Cloud ohne einheitliche Identitätsverwaltung und Netzanbindung zu bauen; dann entsteht Chaos zwischen zwei Welten. Falsch ist, bei der Wahl nur den Preis zu betrachten und Standort, Verträge und Ausstieg zu übersehen. Falsch ist, bei Multi-Cloud nicht in Wissen und Werkzeuge zu investieren.

### Praxisbezug.

In kleinen und mittleren Unternehmen ist die Realität fast immer hybrid: E-Mail und Büro-Software in der öffentlichen Cloud, Dateiserver oder Produktionssysteme im Haus, dazwischen eine abgesicherte Verbindung (VPN, Abschnitt 4.6; Identität in Abschnitt 8.5).

## 8.5 Identität und Zugriff in der Cloud

In der Cloud ersetzt die Identität den Netzwerkrand: Der Zugriff erfolgt aus dem Internet, und nicht mehr “im Firmennetz” ist der Schutz, sondern die Frage, wer sich ausweist und was er darf. Das Fachgebiet heißt *Identity and Access Management* (IAM). Die Grundlagen (Authentisierung, Autorisierung, MFA, geringste Rechte) stehen in Abschnitt 10.3, die Einmalanmeldung (SSO) in 5.6; hier werden sie auf die Cloud angewendet.

Eine Cloud-Umgebung kennt *Benutzer*, *Gruppen*, *Rollen* und *Dienstkonten*. Eine *Rolle* bündelt Berechtigungen (“Rechnungen lesen”, “Server neu starten”) und wird Benutzern oder Gruppen zugewiesen (*rollenbasierte Zugriffskontrolle*, RBAC). Dienstkonten (englisch *Service Accounts*) sind Identitäten für Programme, die automatisch auf andere Dienste zugreifen; sie brauchen ebenfalls minimale Rechte und regelmäßig erneuerte Zugangsdaten. Eine *Richtlinie* (*Policy*) legt fest, wer auf welche Ressource welche Aktion ausführen darf. Üblich sind drei Regeln: Was nicht ausdrücklich erlaubt ist, ist verboten (*implizites Verweigern*). Ein ausdrückliches Verbot schlägt jede Erlaubnis. Rechte werden so klein wie möglich vergeben und regelmäßig überprüft (*Access Review*). Besondere Aufmerksamkeit verlangt das *Administratorkonto* des Cloud-Kontos (der “Root”-Zugang): Er wird mit starker MFA geschützt, nicht im Alltag benutzt und nur für wenige Fälle bereitgehalten.

Das Programm wertet einfache Richtlinien nach diesen Regeln aus. Jede Richtlinie nennt Personen, Aktionen, einen Ressourcenpfad und eine Wirkung. Der Pfad `speicher/projekt-a/` gilt auch für alles darunter.

```python
def erlaubt(richtlinien, nutzer, aktion, ressource):
    ergebnis = "implizit verweigert"
    for r in richtlinien:
        if nutzer in r["fuer"] and aktion in r["aktionen"] and ressource.startswith(r["ressource"]):
            if r["wirkung"] == "verweigern":
                return "verweigert (explizit)"
            ergebnis = "erlaubt"
    return ergebnis

richtlinien = [
    {"fuer": ["anna", "bernd"], "aktionen": ["lesen"],
     "ressource": "speicher/projekt-a/", "wirkung": "erlauben"},
    {"fuer": ["anna"], "aktionen": ["lesen", "schreiben"],
     "ressource": "speicher/projekt-a/", "wirkung": "erlauben"},
    {"fuer": ["anna"], "aktionen": ["lesen"],
     "ressource": "speicher/projekt-a/vertraulich/", "wirkung": "verweigern"},
]
tests = [("anna", "schreiben", "speicher/projekt-a/plan.txt"),
         ("bernd", "schreiben", "speicher/projekt-a/plan.txt"),
         ("anna", "lesen", "speicher/projekt-a/vertraulich/gehalt.xlsx"),
         ("carla", "lesen", "speicher/projekt-a/plan.txt")]
for t in tests:
    print(t, "->", erlaubt(richtlinien, *t))
```

Die Funktion beginnt mit dem Ergebnis “implizit verweigert”. Sie geht alle Richtlinien durch; passt eine auf Person, Aktion und Pfad, so wird entweder sofort “verweigert (explizit)” zurückgegeben (ein ausdrückliches Verbot gewinnt immer) oder das Ergebnis auf “erlaubt” gesetzt. Passt nichts, bleibt es beim impliziten Verweigern. Die vier Tests zeigen die Fälle: Anna darf in Projekt A schreiben (Richtlinie 2). Bernd darf nur lesen, das Schreiben bleibt implizit verweigert. Anna darf eigentlich lesen, aber im Unterordner `vertraulich` verbietet es eine ausdrückliche Richtlinie, deshalb: verweigert (explizit). Carla kommt in keiner Richtlinie vor und hat deshalb keinen Zugriff. Echte Cloud-Anbieter haben ausgefeiltere Sprachen, dieselben Grundregeln gelten aber überall.

### Typische Fehler.

Falsch ist, aus Bequemlichkeit allen “Vollzugriff” zu geben oder Administratorrechte dauerhaft zu vergeben. Falsch ist, Zugangsschlüssel im Programmtext oder in Git zu speichern (Abschnitt 7.8). Falsch ist, ausgeschiedene Mitarbeiter oder nicht mehr gebrauchte Dienstkonten nicht zu sperren. Falsch ist, MFA beim Cloud-Administrator auszulassen. Falsch ist, Rechte nur zu vergeben und nie zu überprüfen (*Privilege Creep*, schleichende Rechteansammlung).

### Praxisbezug.

Typische Vorfälle: “Ich komme nicht an die Freigabe” (fehlende Gruppenmitgliedschaft), “Das Skript läuft nicht mehr” (abgelaufener Schlüssel des Dienstkontos), “Jeder konnte die Dateien sehen” (zu weit offene Freigabe, Abschnitt 10.6). Eine Quartalsprüfung der Rechte gehört zu den Aufgaben der Governance (Abschnitt 11.7).

## 8.6 Skalierung und Verfügbarkeit

*Skalierung* heißt, ein System an wachsende oder schwankende Last anzupassen. *Vertikale Skalierung* (*Scale up*) macht einen einzelnen Server stärker (mehr CPU und RAM); sie ist einfach, hat aber eine Obergrenze und erfordert oft einen Neustart. *Horizontale Skalierung* (*Scale out*) fügt weitere Server hinzu, auf die ein *Lastverteiler* (*Load Balancer*) die Anfragen verteilt; sie ist praktisch unbegrenzt und erhöht gleichzeitig die Ausfallsicherheit, setzt aber voraus, dass die Anwendung mit mehreren Instanzen umgehen kann (der Zustand liegt nicht in einer einzelnen Instanz). *Elastizität* ist die automatische Skalierung im laufenden Betrieb: Das System fügt bei steigender Last Instanzen hinzu und entfernt sie wieder, wenn die Last fällt (*Autoscaling*). Das spart Kosten, weil man nur zahlt, was gebraucht wird.

Das Programm simuliert einfaches Autoscaling. Pro Minute treffen Anfragen ein; jede Instanz schafft 150 Anfragen pro Minute. Das System soll die durchschnittliche Auslastung bei etwa 60 Prozent halten, mindestens zwei und höchstens zehn Instanzen betreiben, und passt die Anzahl jeweils für die nächste Minute an.

```python
import math

def instanzen_neu(aktuell, last_pro_instanz, ziel=60, minimum=2, maximum=10):
    gewuenscht = math.ceil(aktuell * last_pro_instanz / ziel)
    return max(minimum, min(maximum, gewuenscht))

anfragen = [100, 200, 500, 900, 1400, 800, 300, 100]
KAP = 150
n = 2
for minute, a in enumerate(anfragen):
    last = a / (n * KAP) * 100
    neu = instanzen_neu(n, last)
    print(f"Min {minute}: {a:5} Anfragen, {n} Instanzen, Last {last:5.1f} % -> naechste Minute {neu}")
    n = neu
```

Die Funktion `instanzen_neu` rechnet die benötigte Anzahl aus: Bei `aktuell` Instanzen und der Last pro Instanz in Prozent braucht man `aktuell * last / ziel` Instanzen, um auf 60 Prozent zu kommen, aufgerundet mit `math.ceil`. `min` und `max` begrenzen das Ergebnis auf den erlaubten Bereich. Die Schleife läuft über acht Minuten. In Minute 0 liegt die Last bei 33,3 Prozent, zwei Instanzen bleiben das Minimum. In Minute 1 steigt sie auf 66,7 Prozent, das System fügt eine dritte hinzu. In Minute 2 sind es bei drei Instanzen 111 Prozent, also Überlast (Anfragen würden warten oder verloren gehen), und das System verdoppelt auf sechs. In Minute 3 bei sechs Instanzen 100 Prozent, wieder zu hoch, nun zehn (das Maximum). In Minute 4 bleibt die Last bei 93 Prozent; die Obergrenze verhindert mehr, ein Hinweis darauf, dass Grenzen bewusst gewählt werden müssen, weil sie vor Kostenexplosionen schützen, aber bei Spitzen bremsen. Ab Minute 5 sinkt die Last, und das System baut ab: neun, dann vier, dann zwei Instanzen. Das Muster zeigt auch eine Schwäche einfacher Regeln: Sie reagieren *nach* dem Anstieg; deshalb nutzt man zusätzlich geplante Skalierung für bekannte Spitzen und Vorwärmzeiten.

Zur Verfügbarkeit gehört außerdem die *Redundanz*: Kritische Teile sind mehrfach vorhanden, und der Ausfall eines Teils führt nicht zum Ausfall des Ganzen. Cloud-Anbieter gliedern ihre Infrastruktur in *Regionen* (geografische Gebiete) und darin *Verfügbarkeitszonen* (getrennte Rechenzentren mit eigener Strom- und Netzanbindung). Wer eine Anwendung auf mehrere Zonen verteilt, übersteht den Ausfall eines Rechenzentrums. Für die Verfügbarkeit gelten zwei Rechenregeln, die das nächste Programm zeigt: Hängen zwei Teile in Reihe (beide müssen laufen), multiplizieren sich die Verfügbarkeiten, das Ergebnis ist schlechter als jede einzelne. Sind zwei Teile parallel (einer genügt), multiplizieren sich die Ausfallwahrscheinlichkeiten, das Ergebnis ist deutlich besser.

```python
def ausfall_min(v, tage=365):
    return (1 - v) * tage * 24 * 60

a, b = 0.999, 0.999
print(f"Einzeln 99,9 %: {ausfall_min(a):.0f} min/Jahr")
serie = a * b
print(f"Serie (beide noetig): {serie*100:.3f} % -> {ausfall_min(serie):.0f} min/Jahr")
par = 1 - (1 - a) * (1 - b)
print(f"Parallel (einer genuegt): {par*100:.4f} % -> {ausfall_min(par):.2f} min/Jahr")
kette = 0.999 * 0.9995 * 0.99
print(f"Kette Web x DB x Netz: {kette*100:.3f} % -> {ausfall_min(kette):.0f} min/Jahr")
```

Ein einzelnes System mit 99,9 Prozent darf im Jahr rund 526 Minuten ausfallen. Zwei davon in Reihe schaffen nur 99,800 Prozent, das sind 1 051 Minuten, fast das Doppelte. Zwei parallele Systeme dagegen erreichen 99,9999 Prozent, nur 0,53 Minuten Ausfall im Jahr. Die Kette aus Webserver (99,9), Datenbank (99,95) und Netz (99,0) erreicht 98,852 Prozent, rund 6 036 Minuten, über vier Tage im Jahr: das schwächste Glied bestimmt das Ergebnis, und jedes zusätzliche Glied verschlechtert es. Die Rechnung gilt unter der Annahme, dass die Ausfälle unabhängig voneinander sind; gemeinsame Ursachen (derselbe Stromkreis, derselbe Softwarefehler) machen die Parallelschaltung schlechter als berechnet. Mehr zu Verfügbarkeit und Ausfallplanung: Abschnitte 9.1 und 12.7.

### Typische Fehler.

Falsch ist, nur vertikal zu skalieren und dann an eine Grenze zu stoßen. Falsch ist, Autoscaling ohne Obergrenze zu betreiben: Ein Fehler in einer Schleife oder ein Angriff erzeugt dann tausende Instanzen und eine hohe Rechnung. Falsch ist, einen Lastverteiler einzusetzen, aber alle Server in derselben Zone zu betreiben. Falsch ist, Sitzungsdaten lokal in einer Instanz zu speichern, sodass Nutzer bei Wechsel der Instanz herausfliegen. Falsch ist, Verfügbarkeitszusagen ohne Blick auf die Kette zu vergleichen.

### Praxisbezug.

Ein Onlineshop skaliert zur Weihnachtszeit; eine Lohnabrechnung zum Monatsende. Das Wissen hilft, Fragen wie “Warum war die Seite um 9 Uhr langsam?” (Lastspitze, Reaktionszeit der Skalierung) einzuordnen und mit dem Betrieb zu klären.

## 8.7 Cloud-Speicher und Kernservices

Cloud-Anbieter bieten Speicher in drei Grundformen an. *Blockspeicher* verhält sich wie eine virtuelle Festplatte, die man an einen Server hängt; sie ist schnell und für Betriebssysteme und Datenbanken geeignet. *Dateispeicher* stellt Ordner über das Netz bereit (wie ein Netzlaufwerk) und eignet sich für gemeinsam genutzte Dateien. *Objektspeicher* legt Daten als einzelne Objekte (Datei plus Metadaten plus eindeutige Kennung) in einem flachen Namensraum ab, erreichbar über Webschnittstellen; er ist nahezu unbegrenzt, sehr günstig und robust, ideal für Sicherungen, Medien, Protokolle und Archive, aber nicht als Laufwerk für Datenbanken geeignet. Objekte sind meist durch Kopien auf mehrere Geräte oder Zonen gegen Verlust geschützt; trotzdem ersetzt das keine Sicherung gegen versehentliches Löschen oder Verschlüsselung durch Schadsoftware, dafür gibt es Versionierung und getrennte Sicherungskopien (Abschnitt 12.6).

Zu den Kernservices neben dem Speicher gehören Rechenleistung (virtuelle Server, Container, Funktionen), Netzwerk (virtuelle Netze, Firewalls, Lastverteiler, DNS), Datenbanken als Dienst, Überwachung und Protokollierung (Abschnitte 9.2 und 9.3) sowie Identität (8.5). Eine wichtige wirtschaftliche Idee ist der *Speicherklassen-Lebenszyklus*: Häufig genutzte Daten liegen auf teurem, schnellem Speicher (“heiß”), selten genutzte auf günstigerem (“kühl”), Archivdaten auf sehr billigem, aber langsamem Speicher mit Abrufgebühr und Wartezeit. Automatische Regeln verschieben Objekte nach Alter von einer Klasse in die nächste. Das Programm rechnet es mit erfundenen Preisen durch.

```python
PREIS_GB_MONAT = {"heiss": 0.020, "kuehl": 0.010, "archiv": 0.002}
ABRUF_PREIS_GB = {"heiss": 0.0, "kuehl": 0.01, "archiv": 0.05}

def klasse(alter_tage):
    if alter_tage < 30:
        return "heiss"
    if alter_tage < 180:
        return "kuehl"
    return "archiv"

objekte = [("bericht-q1.pdf", 2.0, 10), ("log-2025.zip", 50.0, 200),
           ("foto-archiv.tar", 400.0, 400), ("angebot.docx", 0.5, 45)]
gesamt = 0
alle_heiss = 0
for name, gb, alter in objekte:
    k = klasse(alter)
    kosten = gb * PREIS_GB_MONAT[k]
    gesamt += kosten
    alle_heiss += gb * PREIS_GB_MONAT["heiss"]
    print(f"{name:16} {gb:6.1f} GB  {alter:3} Tage -> {k:6} {kosten:7.3f} EUR/Monat")
print(f"Summe mit Lebenszyklus: {gesamt:.2f} EUR, alles heiss: {alle_heiss:.2f} EUR")
print(f"Abruf 400 GB aus Archiv: {400 * ABRUF_PREIS_GB['archiv']:.2f} EUR")
```

Die Funktion `klasse` ordnet ein Objekt nach seinem Alter einer Klasse zu: unter 30 Tage heiß, bis 180 Tage kühl, danach Archiv. Die Schleife berechnet für vier Objekte die monatlichen Kosten in der jeweiligen Klasse und zum Vergleich in der heißen. Der Bericht (2 GB, 10 Tage) bleibt heiß und kostet 0,04 Euro, das Protokoll (50 GB, 200 Tage) liegt im Archiv und kostet 0,10 Euro, das Fotoarchiv (400 GB, 400 Tage) 0,80 Euro, das Angebot (0,5 GB, 45 Tage) in der kühlen Klasse 0,005 Euro. Die Summe beträgt 0,95 Euro, gegenüber 9,05 Euro, wenn alles heiß läge: etwa ein Zehntel. Die letzte Zeile zeigt die Kehrseite: Muss man das gesamte Fotoarchiv einmal abrufen, kostet das 20 Euro Abrufgebühr, mehr als 25 Monate Speicherkosten im Archiv. Archivklassen lohnen sich also für Daten, die kaum je gelesen werden. Alle Preise sind erfunden und dienen nur der Veranschaulichung.

### Typische Fehler.

Falsch ist, Daten ohne Lebenszyklusregeln für immer auf der teuersten Klasse zu lassen. Falsch ist, Archivdaten zu wählen und sie dann ständig abzurufen. Falsch ist, Objektspeicher öffentlich lesbar zu konfigurieren, obwohl er vertrauliche Daten enthält (Abschnitt 10.6). Falsch ist, auf Versionierung und Sicherungskopien zu verzichten, weil “die Cloud ja sicher ist”. Falsch ist, den Standort der Daten (Region) nicht zu prüfen (Abschnitt 11.3).

### Praxisbezug.

Beim Umzug eines Dateiservers in die Cloud wählt man Datei- oder Objektspeicher je nach Zugriff; für Sicherungen eignet sich Objektspeicher mit Unveränderlichkeit, damit auch ein Angreifer sie nicht löschen kann.

## 8.8 Cloud-Troubleshooting und Governance-Basis

Fehler in der Cloud lassen sich mit derselben Methode wie sonst eingrenzen (Abschnitt 9.8); die Besonderheit liegt darin, dass man die Umgebung nicht vollständig sieht und die Verantwortung geteilt ist. Zuerst klärt man, *wessen* Problem es ist: Gibt es eine Störung beim Anbieter (Statusseite prüfen)? Betrifft es nur ein Konto, nur eine Region, nur einen Dienst? Dann folgen die typischen Ursachen. *Zugriff verweigert*: fehlende Rolle, falsche Gruppe, abgelaufener Schlüssel, ungültige MFA (Abschnitt 8.5). *Nicht erreichbar*: Firewall- oder Sicherheitsgruppen-Regel, falsche Netzwerkadresse, DNS (Abschnitt 4.4), Zertifikat abgelaufen. *Langsam*: Lastspitze, Skalierungsgrenze, Speicherklasse, Entfernung zwischen Nutzer und Region. *Unerwartete Kosten*: vergessene Ressourcen, fehlende Obergrenzen, hohe Datenabflüsse. *Konfiguration weicht ab*: Jemand hat von Hand etwas geändert (*Drift*, Abschnitt 12.2). Wichtige Hilfsmittel sind die Protokolle und Aktivitätsprotokolle der Plattform (wer hat wann was getan, Abschnitt 9.3) und die Überwachung.

Die Governance-Basis (Abschnitt 11.1) bedeutet hier: Ordnung und Verantwortung. Dazu gehören eine klare Benennung und *Kennzeichnung* (*Tagging*) aller Ressourcen mit Eigentümer, Kostenstelle und Umgebung (Produktion, Test), damit Kosten zuordenbar und verwaiste Ressourcen auffindbar sind, Budgets mit Warnungen, Regeln, wer was anlegen darf, Standards für Sicherheit und Regionen, und Abschaltpläne für Test- und Entwicklungsumgebungen. Das Programm prüft eine kleine Ressourcenliste auf Pflichtkennzeichen, sucht ungenutzte Ressourcen und rechnet die Kosten nach Kostenstelle.

```python
ressourcen = [
    {"id": "vm-01", "typ": "vm", "kosten": 120.0, "genutzt": True,
     "tags": {"owner": "anna", "kostenstelle": "4711", "umgebung": "prod"}},
    {"id": "vm-02", "typ": "vm", "kosten": 80.0, "genutzt": True,
     "tags": {"owner": "bernd"}},
    {"id": "disk-07", "typ": "disk", "kosten": 15.0, "genutzt": False, "tags": {}},
    {"id": "ip-03", "typ": "ip", "kosten": 4.0, "genutzt": False,
     "tags": {"owner": "anna", "kostenstelle": "4711", "umgebung": "test"}},
]
PFLICHT = {"owner", "kostenstelle", "umgebung"}
for r in ressourcen:
    fehlt = sorted(PFLICHT - set(r["tags"]))
    if fehlt:
        print(f"{r['id']}: Pflicht-Tags fehlen: {fehlt}")
verwaist = [r for r in ressourcen if not r["genutzt"]]
print("Ungenutzt:", [r["id"] for r in verwaist], "=", sum(r["kosten"] for r in verwaist), "EUR/Monat")
nach_ks = {}
for r in ressourcen:
    ks = r["tags"].get("kostenstelle", "ohne Zuordnung")
    nach_ks[ks] = nach_ks.get(ks, 0) + r["kosten"]
print(nach_ks)
```

Jede Ressource ist ein Wörterbuch mit Kennung, Typ, Monatskosten, einem Merker, ob sie genutzt wird, und den Tags. `PFLICHT - set(r["tags"])` bildet die Mengendifferenz: alle Pflicht-Tags, die fehlen. Die Ausgabe meldet für `vm-02` die fehlenden Tags Kostenstelle und Umgebung und für `disk-07` alle drei. Die Liste der ungenutzten Ressourcen enthält `disk-07` und `ip-03` mit zusammen 19 Euro im Monat; solche vergessenen Reste (Datenträger ohne Server, ungenutzte feste Adressen) sind typische Kostentreiber. Die Kostenverteilung zeigt 124 Euro für Kostenstelle 4711 und 95 Euro “ohne Zuordnung”: Fast ein Drittel der Kosten kann niemandem zugerechnet werden. Genau das macht fehlende Kennzeichnung teuer, denn niemand fühlt sich verantwortlich. Kostenfragen vertieft Abschnitt 12.3.

### Typische Fehler.

Falsch ist, Fehler im eigenen Bereich zu suchen, ohne die Anbieter-Statusseite zu prüfen, oder umgekehrt den Anbieter zu beschuldigen, ohne die eigene Konfiguration zu prüfen. Falsch ist, Ressourcen ohne Besitzer anzulegen. Falsch ist, Testumgebungen dauerhaft laufen zu lassen. Falsch ist, Änderungen von Hand in der Oberfläche vorzunehmen, ohne sie zu dokumentieren oder als Code festzuhalten. Falsch ist, Kostenwarnungen nicht einzurichten.

### Praxisbezug.

Der monatliche Blick in den Kostenbericht, ein Tag-Pflichtfeld und eine Quartalsprüfung der Rechte sind drei einfache Maßnahmen, mit denen Unternehmen Cloud-Kosten und -Risiken wirksam begrenzen. Im Support helfen die Fragen: Wer? Was? Wo? Seit wann? Was wurde zuletzt geändert?

## Übungsaufgaben Modul 08

1.  Erklären Sie den Unterschied zwischen Hypervisor Typ 1 und Typ 2 und nennen Sie je einen sinnvollen Einsatz. Warum sind Snapshots kein Backup?

2.  Vergleichen Sie virtuelle Maschinen und Container in Bezug auf Betriebssystem, Größe, Startzeit und Isolation. Wann ist die VM die bessere Wahl?

3.  Ordnen Sie zu, ob IaaS, PaaS oder SaaS vorliegt: (a) ein gemieteter virtueller Server mit Linux, (b) ein Online-Ticketsystem, (c) eine verwaltete Datenbank, bei der nur Tabellen und Daten selbst angelegt werden, (d) ein Entwicklungs- und Laufzeitumgebungsdienst für Webanwendungen. Wer ist jeweils für das Betriebssystem verantwortlich?

4.  Welche Verantwortlichkeiten bleiben unabhängig vom Servicemodell immer beim Kunden? Nennen Sie vier und begründen Sie eine davon.

5.  Erklären Sie die vier Bereitstellungsmodelle und nennen Sie je eine typische Einsatzsituation. Was unterscheidet Hybrid-Cloud von Multi-Cloud?

6.  **Praxis:** Schreiben Sie ein Python-Programm, das für drei Hosts mit je 24 Kernen und 128 GB RAM und eine Liste von VMs (Name, vCPU, RAM) berechnet, ob alle VMs auch nach dem Ausfall eines Hosts Platz haben (RAM ohne Überbuchung, CPU höchstens 4:1). Testen Sie mit VMs mit zusammen 60 vCPUs und 210 GB RAM, dann mit 60 vCPUs und 300 GB RAM.

7.  **Praxis:** Erweitern Sie die Zugriffsprüfung aus Abschnitt 8.5 um die Aktion `loeschen`, die nur die Gruppe `admins` erhalten soll. Schreiben Sie dafür eine Richtlinie und drei Testfälle, darunter einen mit ausdrücklichem Verbot für den Benutzer `praktikant`, der zufällig in `admins` ist.

8.  **Praxis:** Schreiben Sie eine Funktion, die für eine Verfügbarkeit von zwei in Reihe geschalteten Diensten mit 99,95 und 99,9 Prozent die jährliche Ausfallzeit in Minuten berechnet, und eine zweite für zwei parallele Instanzen mit je 99,9 Prozent. Vergleichen Sie die Ergebnisse.

9.  Ein Mitarbeiter meldet, dass er auf eine Datei im Cloud-Speicher nicht mehr zugreifen kann, obwohl es gestern ging. Nennen Sie sechs Prüfschritte in sinnvoller Reihenfolge und sagen Sie jeweils, welche Ursache sie ausschließen.

## Lösungen Modul 08

1.  Typ 1 läuft direkt auf der Hardware (Rechenzentrum, Server), Typ 2 als Programm auf einem Betriebssystem (Arbeitsplatz, Test, Schulung). Ein Snapshot hält den Zustand auf demselben Speicher fest, wächst mit der Zeit und geht mit dem Speicher verloren; er schützt vor einem misslungenen Update, aber nicht vor Defekt, Löschen des Speichers oder Schadsoftware, die auch den Snapshot trifft. Ein Backup liegt getrennt.

2.  VM: eigenes Gastbetriebssystem, groß (Gigabyte), Start in Minuten, starke Isolation. Container: teilen den Kernel des Hosts, klein (Megabyte), Start in Sekunden, schwächere Isolation. Die VM ist besser bei unterschiedlichen Betriebssystemen auf einem Host, bei hohen Isolationsanforderungen (fremde Mandanten) und bei klassischen Anwendungen, die ein vollständiges Betriebssystem erwarten.

3.  \(a\) IaaS, Betriebssystem beim Kunden. (b) SaaS, beim Anbieter. (c) PaaS, beim Anbieter. (d) PaaS, beim Anbieter.

4.  Daten, Identitäten und Zugriffsverwaltung, Konfiguration und Endgeräte, Einhaltung von Vorschriften. Beispiel Daten: Der Anbieter kann den Dienst sichern, aber nur der Kunde weiß, welche Daten sensibel sind, wer sie sehen darf und wie lange sie aufzubewahren sind; ein öffentlich geschalteter Speicher ist ein Fehler des Kunden.

5.  Öffentlich: Anbieter für alle, flexibel und günstig (Webshop). Privat: nur für eine Organisation, mehr Kontrolle (strenge Vorschriften). Hybrid: Verbindung beider (sensible Daten im Haus, Spitzen in der öffentlichen Cloud). Community: Gruppe mit gemeinsamen Anforderungen (Behörden). Multi-Cloud nutzt mehrere Anbieter, Hybrid verbindet verschiedene Betriebsarten, auch ein einzelner Anbieter plus eigenes Rechenzentrum.

6.  Beispiellösung:

    ```python
    def passt_nach_ausfall(hosts, vms, max_verhaeltnis=4):
        rest = hosts[:-1]
        cpu = sum(h[0] for h in rest)
        ram = sum(h[1] for h in rest)
        vcpu = sum(v[1] for v in vms)
        vram = sum(v[2] for v in vms)
        ok_ram = vram <= ram
        ok_cpu = vcpu / cpu <= max_verhaeltnis
        return ok_ram, ok_cpu

    hosts = [(24, 128)] * 3
    vms_a = [("a", 30, 100), ("b", 30, 110)]
    vms_b = [("a", 30, 150), ("b", 30, 150)]
    print(passt_nach_ausfall(hosts, vms_a))
    print(passt_nach_ausfall(hosts, vms_b))
    ```

    Nach dem Ausfall bleiben 48 Kerne und 256 GB. Fall A: RAM 210 von 256 GB, CPU 60 zu 48 gleich 1,25 zu 1: beides in Ordnung (`True, True`). Fall B: 300 GB sind mehr als 256, daher passt der RAM nicht (`False, True`); die CPU ist unproblematisch. Der Engpass ist hier der Speicher, der sich nicht überbuchen lässt.

7.  Beispiellösung:

    ```python
    richtlinien = [
        {"fuer": ["anna", "praktikant"], "aktionen": ["loeschen"],
         "ressource": "speicher/", "wirkung": "erlauben"},
        {"fuer": ["praktikant"], "aktionen": ["loeschen"],
         "ressource": "speicher/", "wirkung": "verweigern"},
    ]
    tests = [("anna", "loeschen", "speicher/a.txt"),
             ("praktikant", "loeschen", "speicher/a.txt"),
             ("bernd", "loeschen", "speicher/a.txt")]
    for t in tests:
        print(t, "->", erlaubt(richtlinien, *t))
    ```

    Mit der Funktion `erlaubt` aus Abschnitt 8.5 ergibt sich: Anna erlaubt, der Praktikant ausdrücklich verweigert (das Verbot schlägt die Erlaubnis), Bernd implizit verweigert, weil er nicht genannt ist.

8.  Beispiellösung:

    ```python
    def minuten(v):
        return (1 - v) * 365 * 24 * 60

    serie = 0.9995 * 0.999
    parallel = 1 - (1 - 0.999) ** 2
    print(round(minuten(serie)), "min in Reihe")
    print(round(minuten(parallel), 2), "min parallel")
    ```

    In Reihe: 0,9995 mal 0,999 gleich 0,9985005, also rund 788 Minuten Ausfall pro Jahr. Parallel: 1 minus 0,001 zum Quadrat gleich 0,999999, rund 0,53 Minuten. Die Parallelschaltung ist um Größenordnungen besser, vorausgesetzt, die Ausfälle sind unabhängig.

9.  Reihenfolge: (1) Fehlermeldung genau lesen (Zugriff verweigert, nicht gefunden, nicht erreichbar) und klären, ob andere Dateien oder andere Personen betroffen sind: grenzt Einzelfall und Allgemeinstörung ab. (2) Statusseite des Anbieters prüfen: schließt eine Anbieterstörung aus. (3) Eigene Anmeldung prüfen (abgelaufen, MFA, Konto gesperrt): schließt Identitätsprobleme aus. (4) Berechtigungen und Gruppenmitgliedschaften der Person und der Datei prüfen, ob sich zuletzt etwas geändert hat (Aktivitätsprotokoll): schließt Rechteänderungen aus. (5) Prüfen, ob die Datei verschoben, gelöscht oder umbenannt wurde (Papierkorb, Versionen): schließt Datenänderung aus. (6) Netz und Gerät prüfen (anderes Netz, anderer Browser, Synchronisationsstatus): schließt lokale Ursachen aus.
