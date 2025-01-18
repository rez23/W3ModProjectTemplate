param(
    [Parameter(Mandatory=$false)]
    [bool]$DebugMode = $false
)

# Get mod name from folder
$modName = Split-Path -Leaf (Get-Location)
$projectDir = Get-Location

#Current directory
#project path config
$csvDir = "${projectDir}\csv"
$scriptsDir = "${projectDir}\scripts"
$modScriptsDir = "${scriptsDir}"
$dlcContentDir = "${projectDir}\dlc"
$manifestDir = "${projectDir}\manifests"

# Create a temporary directory 
$tempDir = New-Item -ItemType Directory -Path ($env:TEMP + "\\TempBuildFolder") -Force

# Set up build dir
$outPutDir = "${pwd}\build"
$modDestRoot = New-Item -ItemType Directory -Path "${tempDir}\build-${modName}" -Force
$modDestContentDir = New-Item -ItemType Directory -Path "${tempDir}\build-${modName}\mods\mod${modName}\content" -Force

$dlcDestDir = $null
$manifestDestDir = $null

if (Test-Path $dlcContentDir) {
    Write-Host "INFO - Found dlc bundle"
    Write-Host " INFO - Dlc content will be build in the final packege"
    $dlcDestDir = New-Item -ItemType Directory -Path "${tempDir}\build-${modName}\dlc\dlc${modName}\content" -Force
}

if (Test-Path $manifestDir) { 
    Write-Host "INFO - Found manifest"
    Write-Host " INFO - Manifest content will be built in the final package"
    $manifestDestDir = New-Item -ItemType Directory -Path "${tempDir}\build-${modName}\bin\config\r4game\user_config_matrix\pc" -Force
}

$modScriptDestDir = New-Item -ItemType Directory -Path "${modDestContentDir}\scripts" -Force

# Copy files in temè dest directory
Copy-Item -Path "${modScriptsDir}" -Filter "*.ws" -Destination $modScriptDestDir -Recurse -Force

if ( -not [string]::IsNullOrEmpty($dlcDestDir)) { Copy-Item -Path "${dlcContentDir}\*" -Destination $dlcDestDir -Recurse -Force }
if ( -not [string]::IsNullOrEmpty($manifestDestDir)) { Copy-Item -Path "${manifestDir}\*" -Destination $manifestDestDir -Recurse -Force } 

$w3stringList = @()

if (Test-Path $csvDir) {
    Write-Host "INFO - Found language csv files!"
    Write-Host "INFO - csvs will be encoded and included in the final package"
    Get-ChildItem -Path $csvDir\*.csv | ForEach-Object {
        $language = Split-Path -Path $_.FullName -LeafBase
        $destinationPath = Join-Path -Path $modDestContentDir -ChildPath $language

        $w3stringList += $destinationPath;

        Write-Host "DEBUG - creating ${$_.FullName} in ${destinationPath}"
        Copy-Item -Path $_.FullName -Destination "${destinationPath}" -Force
    }
}

# Momentainaly move inside temp folder for build w3string
Write-Host "INFO - Build w3string binary strings files"

#Encode w3string
$w3stringList | ForEach-Object {
    $language = Split-Path -Path $_ -LeafBase

    Write-Host "INFO - Encoding ${language}.csv"
    w3strings.exe --encode $_ --id-space 9990
    Remove-Item -Path $_ -Force
}


# Build the mod archive
Write-Host "INFO - Build the target archive"
Compress-Archive -Path $modDestRoot\* -DestinationPath "$outPutDir\${modName}.zip" -Force

Remove-Item -Recurse -Force -Path $tempDir
