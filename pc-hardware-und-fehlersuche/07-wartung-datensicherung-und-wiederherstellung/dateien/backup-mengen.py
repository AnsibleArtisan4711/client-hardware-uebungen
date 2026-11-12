#!/usr/bin/env python3
"""Modul 07: Datenmengen von Voll-, differentieller und inkrementeller Sicherung.
Annahme: Montag Vollsicherung 100 GB, danach je Tag geaenderte Daten (GB)."""
from itertools import accumulate
voll = 100
aend = {"Di": 5, "Mi": 3, "Do": 4, "Fr": 2, "Sa": 6, "So": 1}
tage = list(aend)
diff = list(accumulate(aend.values()))
print(f"{'Tag':<4} {'geaendert':>10} {'differentiell':>14} {'inkrementell':>13}")
for t, d in zip(tage, diff):
    print(f"{t:<4} {aend[t]:>10} {d:>14} {aend[t]:>13}")
print(f"\nSumme der Folgetage: differentiell {sum(diff)} GB, inkrementell {sum(aend.values())} GB")
print(f"Wiederherstellung am Sonntag: Voll + letzte Differentielle = {voll} + {diff[-1]} GB in 2 Schritten")
print(f"                              Voll + alle Inkrementellen   = {voll} + {sum(aend.values())} GB in {1+len(aend)} Schritten")
