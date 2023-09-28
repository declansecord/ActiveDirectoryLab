# Import the Active Directory module
Import-Module ActiveDirectory

# Path to the txt file containing the names
$filePath = "!!!add\path\to\names\file!!!"

# Create the Organizational Unit if it doesn't exist
$ouPath = "OU=_USERS,DC=!!!yourdomainname!!!,DC=com"

if (-not (Get-ADOrganizationalUnit -Filter {Name -eq "_USERS"})) {
    New-ADOrganizationalUnit -Name "_USERS" -Path "DC=!!!yourdomainname!!!,DC=com" -PassThru
}

# Read the content of the file
$names = Get-Content -Path $filePath

foreach ($name in $names) {
    # Split the name into firstname and lastname
    $firstname, $lastname = $name -split ' '
    
    # Construct the username
    $username = $firstname.Substring(0, 1) + $lastname

    # Create the AD User
    New-ADUser `
        -SamAccountName $username `
        -Name "$firstname $lastname" `
        -GivenName $firstname `
        -Surname $lastname `
        -UserPrincipalName "$username@homelab.com" `
        -DisplayName "$firstname $lastname" `
	-Path $ouPath `
        -AccountPassword (ConvertTo-SecureString -AsPlainText "!!!ChosenPassword!!!" -Force) `
        -PassThru `
        -Enabled $true
}

# Output a message when done
Write-Output "Users created successfully!"