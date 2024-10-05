Import-Module ActiveDirectory
# The script creates new users from a .txt file that contains the first and last name of the users on each line.
$FilePath = "C:\Users\Administrator\Desktop\ADScript\Users.txt"
$FileContent = Get-Content -Path $FilePath

$i = 1
ForEach ($Line in $FileContent) {

    $FirstName, $LastName = $Line -split " "
    $RandNumb = Get-Random -Minimum 10 -Maximum 99
    $Name = $FirstName + " " + $LastName
    $FirstInitial = $FirstName.Substring(0,1)
    $SAM = $FirstInitial.ToLower() + $LastName.ToLower()
    $UPN = $SAM + $RandNumb + "@mydomain.local"
    $i++

    New-ADUser -Name $Name -GivenName $FirstName -Surname $LastName -DisplayName $Name -SamAccountName $SAM -UserPrincipalName $UPN -Path "OU=_USERS, DC=mydomain, DC=local" -AccountPassword (ConvertTo-SecureString "Password123" -AsPlainText -Force) -Enabled $true -ChangePasswordAtLogon $false
}