param(
    [Parameter(Mandatory = $true)]
    [String] $ResourcePrefix,    
    [Parameter(Mandatory = $true)]
    [String] $SubscriptionId
)

$ServicePrincipalName = "$($ResourcePrefix)sp"
$ResourceGroupName = "$($ResourcePrefix)rg"

az ad sp create-for-rbac `
    --name $ServicePrincipalName `
    --sdk-auth `
    --role contributor `
    --scopes "/subscriptions/$($SubscriptionId)/resourceGroups/$($ResourceGroupName))"