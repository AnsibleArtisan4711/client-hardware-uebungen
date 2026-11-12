#!/usr/bin/env python3
"""Modul 03: Rechenhilfen zu RAM und CPU.
Spitzenrate eines 64-Bit-Kanals = Transfers pro Sekunde * 8 Byte. Das ist ein Hoechstwert, kein Messwert."""
MODULE = {"DDR4-3200": 3200, "DDR5-4800": 4800, "DDR5-6400": 6400}
for name, mt in MODULE.items():
    print(f"{name}: {mt} MT/s * 8 Byte = {mt*8/1000:.1f} GB/s je 64-Bit-Kanal (Spitzenwert)")
print()
for kerne, faden in [(4, 1), (4, 2), (8, 2), (6, 2)]:
    print(f"{kerne} Kerne, {faden} Thread(s) je Kern -> {kerne*faden} logische Prozessoren")
