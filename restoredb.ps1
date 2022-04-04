
# .\restoredb.ps1 -AppName "creatiocore" -dbFileName "BPMonline7185Studio_Linux.backup"

param($AppName, $dbFileName)
# STEP 1 - CREATE DATABASE
$dbName = [string]$AppName.ToLower();
$psqlCmd = "docker exec -it PostgresDbCore psql -U Supervisor postgres -c `"CREATE DATABASE ${dbName} ENCODING='UTF8' CONNECTION LIMIT=-1 `"";
Invoke-Expression $psqlCmd;

# STEP 2 - RESTORE DATABASE
$psqlCmd = "docker exec -it PostgresDbCore pg_restore -U Supervisor --no-owner --no-privilege -d ${dbName} /usr/local/db/${dbFileName}";
Invoke-Expression $psqlCmd;
