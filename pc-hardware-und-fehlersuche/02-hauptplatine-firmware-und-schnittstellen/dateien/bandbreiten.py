#!/usr/bin/env python3
"""Modul 02: Theoretische Datenraten von PCIe-Lanes und SATA.
Rechnung: Rohrate (GT/s) * Kodierungsfaktor / 8 Bit = GB/s je Lane.
Die Kodierungsfaktoren (8b/10b bzw. 128b/130b) sind Kenntnisstand, nicht aus einer geprueften Quelle."""
GENERATIONEN = {            # Name: (Rohrate in GT/s, Nutzbits, Gesamtbits)
    "PCIe 1.0": (2.5, 8, 10),
    "PCIe 2.0": (5.0, 8, 10),
    "PCIe 3.0": (8.0, 128, 130),
    "PCIe 4.0": (16.0, 128, 130),
    "PCIe 5.0": (32.0, 128, 130),
}
def lane_mb_s(gt, nutz, gesamt):
    return gt * 1000 * nutz / gesamt / 8      # MB/s je Lane und Richtung
print(f"{'Generation':<10} {'x1':>8} {'x4':>8} {'x16':>8}   (MB/s je Richtung)")
for name, (gt, n, g) in GENERATIONEN.items():
    l = lane_mb_s(gt, n, g)
    print(f"{name:<10} {l:8.0f} {4*l:8.0f} {16*l:8.0f}")
sata = 6000 * 8 / 10 / 8                      # SATA III: 6 Gbit/s, 8b/10b
print(f"\nSATA III (6 Gbit/s, 8b/10b): {sata:.0f} MB/s")
print(f"PCIe 3.0 x4 / SATA III = {4*lane_mb_s(8.0,128,130)/sata:.1f}")
