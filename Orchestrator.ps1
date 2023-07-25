if ($env:COMPUTERNAME -eq 'SWAGGY'){
        #Sets values of characters and numbers to pull from
    $TokenSet = @{
            U = [Char[]]'DEFENDER'
            L = [Char[]]'defender'
            N = [Char[]]'69'
        }

    #Sets values to variables
    $Upper = Get-Random -Count 5 -InputObject $TokenSet.U
    $Lower = Get-Random -Count 5 -InputObject $TokenSet.L
    $Number = Get-Random -Count 5 -InputObject $TokenSet.N

    #Assembles variable
    $StringSet = $Upper + $Lower + $Number
    $computername = (Get-Random -Count 15 -InputObject $StringSet) -join ''

    #Renames computer
    Rename-Computer $computername
    Start-Sleep 1
    Restart-Computer -Force
}
$domainTest=(Get-WmiObject -Class Win32_ComputerSystem).domain
if ($domainTest -ne 'purple.mat' -and $env:COMPUTERNAME -ne 'SWAGGY'){
    # Add any additional registry settings or values you want to create here, if needed.
    # Now, execute your commands here as the key is created.
    #Sets DNS to Domain Controller

    $IntIndex = Get-NetAdapter | Select-Object InterfaceIndex
    Set-DnsClientServerAddress -InterfaceIndex $IntIndex.InterfaceIndex -ServerAddresses 192.168.2.2

    #Sets domain information to variables
    
    $domain = "purple.mat"
    $password = "1qaz2wsx!QAZ@WSX" | ConvertTo-SecureString -asPlainText -Force
    $username = "purple\Administrator" 

    #Automates the input of domain credentials
    $credential = New-Object System.Management.Automation.PSCredential($username,$password)

    #Adds the computer to domain
    Add-Computer -DomainName $domain -Credential $credential
    Restart-Computer -Force
}