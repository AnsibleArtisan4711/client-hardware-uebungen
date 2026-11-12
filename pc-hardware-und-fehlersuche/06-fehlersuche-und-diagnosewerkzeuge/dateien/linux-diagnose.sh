#!/usr/bin/env bash
# Modul 06: Hardware-Uebersicht in einem Linux-Live-System (nur lesen).
# Aufruf im Terminal: bash linux-diagnose.sh
echo "== Laufwerke (lsblk) =="; lsblk
echo; echo "== Prozessor (lscpu, Auszug) =="; lscpu | grep -E '^(Architecture|CPU\(s\)|Model name|Thread|Core)'
echo; echo "== Arbeitsspeicher (free -h) =="; free -h
echo; echo "== Kernel-Meldungen (letzte 15 Zeilen) =="; sudo dmesg | tail -n 15
