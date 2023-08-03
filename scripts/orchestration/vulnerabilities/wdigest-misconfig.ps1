### MISCONFIGURE WDIGEST ###

# This should allow mimikatz access to plaintext passwords.

New-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\SecurityProviders\WDigest' -Name 'UseLogonCredential' -Value '1' -PropertyType DWORD -Force
