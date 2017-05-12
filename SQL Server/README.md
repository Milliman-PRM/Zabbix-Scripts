# SQL Server monitoring scripts

## test_backup_state.bat

This script runs a query against the local SQL Server to determine whether all databases have a recent full backup (within the last 7 days).



|Program|Server|Location|Notes|
|-----------|----------|-----------------------|--|
|`test_backup_state.bat`|Indy-SQL02|`C:\Zabbix\test_backup_state.bat`||
|`test_backup_state.bat`|Indy-SS01|`C:\Zabbix\test_backup_state.bat`|Requires an additional flag for `sqlcmd`: `-S localhost\sqlexpress`|
