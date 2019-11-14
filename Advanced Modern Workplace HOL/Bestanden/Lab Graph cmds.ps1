#get all users
$uri = "https://graph.microsoft.com/beta/users"
$users = Invoke-RestMethod -Method GET -Uri $uri -Headers @{Authorization = "Bearer $token" } -ErrorAction Stop
$users.value | Select-Object DisplayName, ID, UserPrincipalName

#get specific user
$uri = "https://graph.microsoft.com/beta/users/CameronW@M365x428595.OnMicrosoft.com"
$megan = invoke-restmethod -Method GET -Uri $uri -Headers @{Authorization = "Bearer $token" } -ErrorAction Stop
$megan.displayName
$megan | Select-Object DisplayName, MobilePhone, City

#update user info
$PatchJSON = @{
    "mobilephone" = "+31640409642"
    "city"        = "Eindhoven"
} | ConvertTo-Json

Invoke-RestMethod -Uri $uri -Method PATCH -Headers @{Authorization = "Bearer $token" } -Body $PatchJSON -ContentType 'Application/JSON'


#Check if user info is updated
$uri = "https://graph.microsoft.com/beta/users/CameronW@M365x428595.OnMicrosoft.com"
$megan = invoke-restmethod -Method GET -Uri $uri -Headers @{Authorization = "Bearer $token" } -ErrorAction Stop
$megan.displayName
$megan | Select-Object DisplayName, MobilePhone, City



#create new user
$uri = "https://graph.microsoft.com/beta/users"
$NewUserJSON = @{
    "accountEnabled"    = $true
    "displayName"       = "EL Demo User"
    "mailNickname"      = "eldemouser"
    "userPrincipalName" = "eldemouser@M365x428595.OnMicrosoft.com"
    "mobilephone" = "+31640409642"
    "city"        = "Eindhoven"
    "passwordProfile"   = @{
        "forceChangePasswordNextSignIn" = $true 
        "password"                      = "Welkom2019"
    }
} | convertto-Json

$response = Invoke-RestMethod -Uri $uri -Method POST -Headers @{Authorization = "Bearer $token" } -Body $NewUserJSON -ContentType 'application/json'
$response
$response.displayname
$response.passwordprofile
$response.passwordProfile.forceChangePasswordNextSignIn
$response.id

#check created user
$uri = "https://graph.microsoft.com/beta/users/$($response.userPrincipalName)"
$DemoUser = invoke-restmethod -Method GET -Uri $uri -Headers @{Authorization = "Bearer $token" } -ErrorAction Stop
$DemoUser.displayName
$DemoUser | Select-Object DisplayName, MobilePhone, City


#get and delete created user
$uri = "https://graph.microsoft.com/beta/users"
$uri = $uri + '/' + $response.id
invoke-restmethod -Method GET -Uri $uri -Headers @{Authorization = "Bearer $token" } -ErrorAction Stop

Invoke-RestMethod -Method DELETE -Uri $uri -Headers @{Authorization = "Bearer $token" } -ErrorAction Stop


#get all groups
$uri = "https://graph.microsoft.com/beta/groups"
Invoke-RestMethod -Method GET -Uri $uri -Headers @{Authorization = "Bearer $token" } -ErrorAction Stop
$groups = Invoke-RestMethod -Method GET -Uri $uri -Headers @{Authorization = "Bearer $token" } -ErrorAction Stop
$groups.value
$groups.value | ft DisplayName

#get member of first group
$groups.value[0]
$groupid = $groups.value[0].id
$uri = $uri + '/' + $groupid
Invoke-RestMethod -Method GET -Uri $uri -Headers @{Authorization = "Bearer $token" } -ErrorAction Stop
$uri = $uri + '/' + 'members'
$members = Invoke-RestMethod -Method GET -Uri $uri -Headers @{Authorization = "Bearer $token" } -ErrorAction Stop
$members.value | select DisplayName, UserPrincipalName

#get groups user is member of
$uri = "https://graph.microsoft.com/beta/users" + '/' + "CameronW@M365x428595.OnMicrosoft.com" + '/' + 'MemberOf'
$membership = Invoke-RestMethod -Method GET -Uri $uri -Headers @{Authorization = "Bearer $token" } -ErrorAction Stop
$membership.value | select DisplayName

