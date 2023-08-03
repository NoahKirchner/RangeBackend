### Disables SMB security signatures ###
Set-SmbClientConfiguration -RequireSecuritySignature $false
Set-SmbServerConfiguration -RequireSecuritySignature $false
