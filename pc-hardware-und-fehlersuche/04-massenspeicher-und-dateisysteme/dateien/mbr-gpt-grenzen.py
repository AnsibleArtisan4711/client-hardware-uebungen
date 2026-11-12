#!/usr/bin/env python3
"""Modul 04: Grenzen von MBR und FAT32 aus den Zahlenbreiten.
MBR: 32-Bit-Sektornummern. GPT: 64-Bit-Sektornummern. FAT32: Dateigroesse in 32 Bit.
Die Bitbreiten sind Kenntnisstand (Lehrplan nennt keine Quelle); die Rechnung ist exakt."""
def fmt(b):
    for e, n in [(70,"ZiB"),(60,"EiB"),(50,"PiB"),(40,"TiB"),(30,"GiB"),(20,"MiB")]:
        if b >= 2**e:
            return f"{b/2**e:.2f} {n}"
    return f"{b} B"
for sektor in (512, 4096):
    print(f"MBR bei {sektor} B je Sektor: 2^32 * {sektor} = {fmt(2**32*sektor)}")
print(f"GPT bei 512 B je Sektor (theoretisch): 2^64 * 512 = {fmt(2**64*512)}")
print(f"FAT32, groesste Datei: 2^32 - 1 Byte = {2**32-1} B = {fmt(2**32-1)} (knapp unter 4 GiB)")
print(f"Beispiel: 4,5 GiB grosse Datei passt auf FAT32: {int(4.5*2**30) <= 2**32-1}")
