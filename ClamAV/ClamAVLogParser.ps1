# Code Owners: Steve Gredell
# Objective: Read ClamAV logs for reading into Zabbix
# Developer Notes: First argument is what to scan, second argument should be the path to the log to scan
#                   If you chose one of the "update" purposes, you must give the update log as the log file argument

$purpose = $args[0]
$log_file = $args[1]
$start_scan_regex = 'Scan Started\s((\w{3})\s(\w{3})\s(\d{1,2})\s(\d{2}:\d{2}:\d{2})\s(\d{4}))'
$infected_regex = 'Infected files:\s(\d.*)'
$start_update_regex = 'started at\s((\w{3})\s(\w{3})\s(\d{1,2})\s(\d{2}:\d{2}:\d{2})\s(\d{4}))'
$db_update_regex = 'Database Updated\s\((\d+)\s\w+\)'
$epoch_start= Get-Date -Date "01/01/1970"


if($purpose -eq "scan_value")
{
    $infected_matches = Select-String -Pattern $infected_regex -Path $log_file -AllMatches
    $infected_value = $infected_matches[-1].Matches.Groups[1].value
    echo "$infected_value"
} 
elseif($purpose -eq "scan_start")
{
    $start_matches = Select-String -Pattern $start_scan_regex -Path $log_file -AllMatches
    $start_stamp_scan = [DateTime]::ParseExact($start_matches[-1].Matches.Groups[1].value, "ddd MMM dd HH:mm:ss yyyy", [System.Globalization.CultureInfo]::InvariantCulture)
    $unix_stamp = (New-TimeSpan -Start $epoch_start -End $start_stamp_scan).TotalSeconds
    echo "$unix_stamp"
}
elseif($purpose -eq "update_value")
{

    $db_update_matches = Select-String -Pattern $db_update_regex -Path $log_file -AllMatches
    $db_update_value = $db_update_matches[-1].Matches.Groups[1].value
    echo "$db_update_value"
}
elseif($purpose -eq "update_start")
{
    $start_matches = Select-String -Pattern $start_update_regex -Path $log_file -AllMatches
    $start_stamp_updates = [DateTime]::ParseExact($start_matches[-1].Matches.Groups[1].value, "ddd MMM dd HH:mm:ss yyyy", [System.Globalization.CultureInfo]::InvariantCulture)
    $unix_stamp = (New-TimeSpan -Start $epoch_start -End $start_stamp_updates).TotalSeconds
    echo "$unix_stamp"
}