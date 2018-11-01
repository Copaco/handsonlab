New-VMSwitch -SwitchName "NatSwitch" -SwitchType Internal

$ifindex = Get-NetAdapter -Name "vEthernet (SwitchName)"

New-VMSwitch -SwitchName "SwitchName" -SwitchType Internal

New-NetIPAddress -IPAddress 192.168.0.1 -PrefixLength 24 -InterfaceIndex $ifindex.ifIndex

New-NetNat -Name MyNATnetwork -InternalIPInterfaceAddressPrefix 192.168.0.0/24