param(
    [ValidatePattern('^[a-zA-Z0-9]+$')]
    [Parameter(Mandatory = $true)] 
    [String] $ProductId,
    [Parameter(Mandatory = $true)]
    [String] $PrincipalId,
    [String] $LocationName = "eastus",
    [String] $TemplateFile = './src/main.json'
)

if ($ProductId.Trim() -eq "" ) { 
    throw "'ProductId' is required, please provide a value for '-ProductId' argument."
}

if ($PrincipalId.Trim() -eq "" ) { 
    throw "'PrincipalId' is required, please provide a value for '-ProductId' argument."
}

$ResourceGroupName = "$($ProductId)rg"

az group create -n $ResourceGroupName -l $LocationName

az deployment group create `
    -f $TemplateFile `
    -g $ResourceGroupName `
    --parameters productId=$ProductId `
    --parameters principalId=$PrincipalId