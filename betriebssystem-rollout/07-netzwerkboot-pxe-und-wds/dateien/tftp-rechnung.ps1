# TFTP-Zeit im einfachsten Verfahren: jeder Block wird einzeln bestaetigt.
$bytes = 400000000      # boot.wim, 400 MB
$rtt   = 0.0003         # Antwortzeit in Sekunden (0,3 ms)
foreach ($block in 512, 1456, 8192) {
    $pakete = [math]::Floor($bytes / $block) + 1     # +1: letztes (ggf. leeres) Paket
    $sek    = $pakete * $rtt
    '{0,5} Byte: {1,7} Pakete, {2,6:N1} s' -f $block, $pakete, $sek
}
$mtu = 1500; $ip = 20; $udp = 8; $tftp = 4
'Groesste Nutzlast ohne Fragmentierung: {0} Byte' -f ($mtu - $ip - $udp - $tftp)
$udpNutz = 8192 + $tftp + $udp                        # UDP-Nutzlast inkl. TFTP-Kopf und UDP-Kopf
'IP-Fragmente bei 8192 Byte: {0}' -f [math]::Ceiling($udpNutz / ($mtu - $ip))
