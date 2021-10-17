﻿#Future addition- check if your CPU/GPU Is capable of transcoding.
$FFMPEG = "C:\FFMPEG"
$Resources = "$FFMPEG\_Conversion"
$GPU = "$Resources\GPU.csv"
If (!( Test-Path -Path $GPU )) { 
    $Url = "https://raw.githubusercontent.com/dmankl/HomeCode/master/GPU.csv"
    $Output = "$GPU"
    Invoke-WebRequest -Uri $Url -OutFile $Output
}
$GPUs = Import-Csv -Path $GPU 
$graphics = (Get-WmiObject win32_VideoController).name
if ($graphics.Length -gt 1) {
    ForEach ($Graphic in $graphics) {
        if ($GPUs.contains($Graphic)) {
            $Compatible = "Yes"
        }
    }
    elseif ($GPUs -contains $graphics) {
        $Compatible = "Yes"
    }
}
if ($Compatible -ne "Yes") {
    Read-Host "It seems you do not have a compatible CPU/GPU to convert to HEVC, Exiting."
    Break
}