Import-Module WebAdministration              

$siteName = Read-Host "Enter the site name"
$sitepath = Read-Host "Enter the path: (D:\Testing Folder)" 
$foldername = Read-Host "Enter the folder name"
$ippath = Read-Host "Enter the Ip Path"
$sitePort = Read-Host "Enter the Port" 443
$hostName = "localhost"

#Restart-Website -Name $siteName

Test-Path $sitepath

if(-not (Test-Path $sitepath)){

Write-Host "Directory $sitepath is not available.! Creating it..."
New-Item -Path $sitepath -ItemType directory
}
else
{
Write-Host "Directory $sitepath already available..."
}

if(-not ( Test-Path "$sitepath\$foldername\$siteName")){
Write-Host "Website $siteName is not available.! Creating it..."

#Remove-Website -Name "new"

New-Website -Name $siteName -Port $sitePort -PhysicalPath "$sitepath\$foldername" -IPAddress $ippath -Force


#New-WebBinding -Name $siteName -IPAddress "192.168.1.12" -Port "443" -Protocol "https"
}
else
{
Write-Host "$siteName is available..."
}

Get-Website -Name $siteName | Select-Object -ExpandProperty PhysicalPath

$site = $siteName
$status = Read-Host "Enter 'start' or 'stop'"

if ($site) {
    if ($status -eq "start") {
        if ($site.state -eq "Started") {
            Write-Host "$siteName is already started..!"
        } else {
            Start-Website -Name $siteName
            Write-Host "$siteName started successfully..!"
        }
    } elseif ($status -eq "stop") {
        if ($site.state -eq "Stopped") {
            Write-Host "$siteName is already stopped."
        } else {
            Stop-Website -Name $siteName
            Write-Host "$siteName stopped successfully."
        }
    } else {
        Write-Host "Invalid input..! Please enter 'start' or 'stop'."
    }
} else {
    Write-Host "Website '$siteName' does not exist."
}

Write-Host "Starting the IIS server"


Start-Process "inetmgr"



#$website = Get-Website -Name $siteName

