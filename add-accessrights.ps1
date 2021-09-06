param(
[string]$user
)

$users = Get-ADGroupMember ShowroomUsers 

ForEach ($user_ in $users) {


if ($user_.SamAccountName -ne $user){

        
       
    Add-MailboxPermission `
        -Identity $user_.name `
        -User $user `
        -AccessRights FullAccess `
        -InheritanceType All
        
}
   

}