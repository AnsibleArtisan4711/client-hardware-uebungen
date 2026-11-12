# Modul 05: Treiberdaten der Netzwerkadapter lesen (nur lesen).
Get-CimInstance Win32_PnPSignedDriver |
    Where-Object DeviceClass -eq 'NET' |
    Select-Object DeviceName, DriverProviderName, DriverVersion, DriverDate
Get-NetAdapter | Select-Object Name, InterfaceDescription, Status, MacAddress, LinkSpeed
