### Creates a vulnerable service account to be kerberoasted. ###
# This must be run on a domain connected computer by a domain administrator.
# FORMAT:
# vulnerable-service-account.ps1 <domain name> <username> <password> <service> <port>
# EXAMPLE:
# vulnerable-service-account.ps1 purple.mat testuser Passw0rd! http 80
$hostname = hostname # Gets the computer name
$domain = $args[0] # The name of the domain you are trying to connect to, ex. purple.mat
$username = $args[1] # The username of the service account, ex. testuser
$password = $args[2] # The password of the service account. Keep it easy so it can be cracked, ex. Passw0rd!
$service = $args[3] # The type of service you want to be operating, ex. http
$port = $args[4] # The port you want the service account to be operating on, ex. 80

net user $username $password /ADD /DOMAIN
setspn -s $service/$hostname.$domain`:$port $username
