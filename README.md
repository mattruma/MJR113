# Introduction

## Azure

Create service principal.

```azurecli
az ad sp create-for-rbac --name "{sp-name}" --sdk-auth --role contributor \
    --scopes /subscriptions/{subscription-id}/resourceGroups/{resource-group}/providers/Microsoft.Web/sites/{app-name}
```
