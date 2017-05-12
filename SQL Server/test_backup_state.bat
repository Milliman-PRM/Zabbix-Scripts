@echo off
REM This script returns 1 if the backups of existing databases are less than 8 days old
sqlcmd -Q "set nocount on; select case when min(last_backup) > dateadd(dd, -8, getdate()) then 1 else 0 end as backups_current from (select database_name, max(backup_finish_date) as Last_Backup from msdb.dbo.backupset  inner join sys.databases on backupset.database_name = databases.name where type = 'D' group by database_name) tbl1" -h -1 -W
