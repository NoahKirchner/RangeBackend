#Imports list of email users
$emailUsers = Import-Csv -Path "C:\Users\defender\Desktop\EmailUsers.csv"

#Imports list of emails
$jsonFilePath = "C:\Users\defender\Desktop\Emails_Dictionary.json" #File Path
$jsonContent = Get-Content -Path $jsonFilePath -Raw #Grap content
$emailData = $jsonContent | ConvertFrom-Json #converts the data from JSON

#Variable Instantiation
$senderName = "" #Name of the Sender
$senderEmail = "" #Email of the Sender
$receiverName = "" #Name of the Receiver
$receiverEmail = "" #Email of the Receiver


#Main
foreach ($email in $emailData.PSObject.Properties) { #Goes through the dictionary of emails
    #Email Content
    $subject = $email.name #Assigns the key to the subject
    $body = $email.value #Assigns the value to the body

    #Sender
    $randomIndex = Get-Random -Minimum 0 -Maximum ($emailUsers.count - 1) #Gets a random user from the emailUsers as an index number
    $senderName = $emailUsers[$randomIndex].Name #Assigns the Senders name from emailUsers based on the randomIndex number
    $senderEmail = $emailUsers[$randomIndex].Email #Assigns the Senders email from emailUsers based on the randomIndex number
    $senderInfo = "$senderName <$senderEmail>" #Groups sender info together to plug into "Send-MailMessage"

    #Receiver
    $randomIndex = Get-Random -Minimum 0 -Maximum ($emailUsers.count - 1) #Gets a random user from the emailUsers as an index number
    $receiverName = $emailUsers[$randomIndex].Name #Assigns the Receivers name from emailUsers based on the randomIndex number
    $receiverEmail = $emailUsers[$randomIndex].Email #Assigns the Receivers email from emailUsers based on the randomIndex number
    $receiverInfo = "$receiverName <$receiverEmail>" #Groups receiver info together to plug into "Send-MailMessage"

    #Sends the email from the sender to the receiver
    Send-MailMessage -From "$senderInfo" -To "$receiverInfo" -Subject "$subject" -Body "$body" -SmtpServer 192.168.5.50

}
