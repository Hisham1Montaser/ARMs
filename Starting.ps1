

#Install VS code
#Install ARM tools extension.
#Install ARM viewer extension.

#Run: 
install-module az


Import-Module Az.Accounts


#The error you’re encountering is due to PowerShell’s execution policy, which is preventing the Az.Accounts module from being loaded. By default, PowerShell is configured to prevent the execution of scripts to protect your system from running potentially harmful scripts.
#To resolve this issue, you can change the execution policy to allow scripts to run. The most common and recommended execution policy setting for this situation is RemoteSigned, which allows scripts to run if they are created on your local machine or are signed by a trusted publisher.
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned



Connect-AzAccount


#If you want to specifiy the parameters in PS instaed of creating a dedicated file for parameter:
$ParametersObj= @{
    StorageAccountName= 'bastawisisi'
    StorageAccountType= 'Standard_LRS'
}

New-AzResourceGroupDeployment -Name "dep1" -ResourceGroupName "RG1" -TemplateFile 'D:\Labs\Azure\IaC\SA Template.json' -TemplateParameterObject $ParametersObj


#If I want to use a dedciated parameter file with my deployment:
New-AzResourceGroupDeployment -Name "dep1" -ResourceGroupName "AVD-RG" -TemplateFile 'D:\Labs\Azure\IaC\RG for DC\template.json' -TemplateParameterFile 'D:\Labs\Azure\IaC\RG for DC\parameters.json'

#If I want to test my template preflight
Test-AzResourceGroupDeployment -Name "dep1" -ResourceGroupName "RG1" -TemplateFile 'D:\Labs\Azure\IaC\WebApp with Storage Account\Webapp.json' -TemplateParameterFile 'D:\Labs\Azure\IaC\WebApp with Storage Account\Webapp Parameter.json'

#If I want to log my deplyment status inflight:
#1
New-AzResourceGroupDeployment -Name "dep1" -ResourceGroupName "RG2" -TemplateFile 'D:\Labs\Azure\IaC\WebApp with Storage Account\Webapp.json' -TemplateParameterFile 'D:\Labs\Azure\IaC\WebApp with Storage Account\Webapp Parameter.json' -DeploymentDebugLogLevel all
#2
$errout= Get-AzResourceGroupDeployment -DeploymentName "dep1" -ResourceGroupName "RG2"
#3
$errout



#Deployment on the subscription scope
New-AzSubscriptionDeployment -Name "dep12" -Location "East US" -TemplateFile "D:\Labs\Azure\IaC\Resource Group\Spot VM with RG (Linked).json"


#Using TTK to test a template:
import-module "D:\Labs\Azure\TTK module\arm-ttk-master\arm-ttk\arm-ttk.psd1" -force 
Test-AzTemplate -TemplatePath "D:\Labs\Azure\IaC\Single VM\VM Parameter.json"