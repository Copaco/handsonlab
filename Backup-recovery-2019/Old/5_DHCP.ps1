
$StartRange="192.168.0.10"
$EndRange="192.168.0.253"
$Subnet="255.255.255.0"
$Router="192.168.0.1"
$DNS = "168.63.129.16"

Install-WindowsFeature -Name 'DHCP' –IncludeManagementTools

$DHCP = Get-WindowsFeature -Name "DHCP"

if($DHCP.Installed -eq $false){

Start-Sleep -Seconds 300
}

if($DHCP.Installed -eq $true){
    
   Add-DhcpServerv4Scope -Name "Backup Network" -StartRange $StartRange -EndRange $EndRange -SubnetMask $Subnet 

   Set-DhcpServerV4OptionValue -Router $Router -DnsServer $DNS
}