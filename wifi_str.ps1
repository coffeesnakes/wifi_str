# PowerShell Script to Log WiFi Signal Strength

$LogFilePath = "C:\WiFi_Signal_Strength_Log.txt"

# wifi signal strength
function Get-WiFiSignalStrength {
    $signal = netsh wlan show interfaces | Select-String '^\s+Signal' -ErrorAction SilentlyContinue
    if ($signal) {
        $signalStrength = $signal.ToString().Split(":")[1].Trim()
        return $signalStrength
    }
    return "No Signal"
}


function Log-SignalStrength {
    $strength = Get-WiFiSignalStrength
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logText = "$timestamp - Signal Strength: $strength`r`n"
    Add-Content -Path $LogFilePath -Value $logText
}


$Interval = 60000 # 1 minute

# Main loop
while ($true) {
    Log-SignalStrength
    Start-Sleep -Milliseconds $Interval
}
