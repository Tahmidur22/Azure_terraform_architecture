# Azure terraform architecture

![image](https://github.com/Tahmidur22/Azure_terraform_architecture/assets/65872348/b755c061-70cd-4c43-8119-e78316b280fc)

> [!NOTE]
> 1. webvm hosts an application that connect to db hosted on db-subnet
> 2. ddbvm host MSSQL
> 3. webvm have a Public IP address that accept connections from the internet
> 4. RDP connections made via Azure Bastion host
