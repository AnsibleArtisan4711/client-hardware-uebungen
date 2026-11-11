# Changelog

Alle nennenswerten Änderungen an diesem Repository. Format nach [Keep a Changelog](https://keepachangelog.com/de/1.1.0/).

## [Unveröffentlicht]

### Korrigiert

- Überzählige Leerzeichen in Inline-Code entfernt, die bei der Umwandlung aus LaTeX entstanden waren (zum Beispiel `C:\ Windows` statt `C:\Windows`, `^ tree` statt `^tree`, `SUMIF( Bereich;` statt `SUMIF(Bereich;`); in einem `printf`-Beispiel stand `\ n` statt `\n`. Die Codeblöcke waren nicht betroffen.

### Hinzugefügt

- Skript als Markdown: `skript.md` und `README.md` in jedem der 12 Modulordner, `docs/skript-einleitung.md` und `docs/skript-quellenverzeichnis.md` (aus der LaTeX-Quelle umgewandelt, 135 Codebeispiele zeichengleich geprüft), dazu die Abbildung `abb06-umsatz.png` in Modul 06
- Lizenzen: MIT für Code (`LICENSE`), CC BY 4.0 für Texte (`LICENSE-DOCS.md`)
