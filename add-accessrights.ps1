param(
[string]$user,
[string]$group
)

$users = Get-ADGroupMember $group 

ForEach ($user_ in $users) {

if ($user_.SamAccountName -ne $user){
    Add-MailboxPermission `
        -Identity $user_.name `
        -User $user `
        -AccessRights FullAccess `
        -InheritanceType All
}
   

}
