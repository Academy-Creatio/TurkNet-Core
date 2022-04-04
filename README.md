
## Download NetCore
- You can take a build from here
https://ftp.bpmonline.com/support/downloads/!Release/installation_files/7.18.5/

- Unzip archive and save into the repository directory

- Create the following directories (Windows)
	- C:\DockerCompose\Volumes\PostgreSQLCore Postgres files will be here
	- C:\DockerCompose\Volumes\PgAdminCore pgAdmin files will be here
	- C:\DockerCompose\Volumes\DbImagesCore creatio db backup file will be here

- Copy backup file to C:\DockerCompose\Volumes\DbImagesCore


## Create Creatio image
```ps
.\createImage.ps1 -imgName creatiostudio
```

## Configure connectionString
```xml
<?xml version="1.0" encoding="utf-8"?>
<connectionStrings>
  <add name="db" connectionString="Server=PostgresDbCore;Port=5432;Database=creatiocore;User ID=Supervisor;password=Supervisor;Timeout=500; CommandTimeout=400;MaxPoolSize=1024;" />
  <add name="dbPostgreSql" connectionString="Server=PostgresDbCore;Port=5432;Database=creatiocore;User ID=Supervisor;password=Supervisor;Timeout=500; CommandTimeout=400;MaxPoolSize=1024;" />
  <add name="redis" connectionString="host=RedisCore; db=1; port=6379" />
  <add name="dbMssqlCore" connectionString="Data Source=tscore-ms-01\mssql2008; Initial Catalog=BPMonlineCore; Persist Security Info=True; MultipleActiveResultSets=True; Integrated Security=SSPI; Pooling = true; Max Pool Size = 100; Async = true" />
  <add name="dbMssqlUnitTest" connectionString="Data Source=TSAppHost-02; Initial Catalog=BPMonlineUnitTest; Persist Security Info=True; MultipleActiveResultSets=True; User ID=UnitTest; Password=UnitTest; Async = true" />
  <add name="tempDirectoryPath" connectionString="%TEMP%/%USER%/%APPLICATION%" />
  <add name="consumerInfoServiceUri" connectionString="http://sso.bpmonline.com:4566/ConsumerInfoService.svc" />
  <add name="consumerInfoServiceAccessInfoPageUri" connectionString="http://sso.bpmonline.com:4566/AccessInfoPage.aspx" />
  <add name="logstashConfigFolderPath" connectionString="%TEMP%\%APPLICATION%\LogstashConfig" />
  <add name="elasticsearchCredentials" connectionString="User=gs-es; Password=DEQpJMfKqUVTWg9wYVgi;" />
  <add name="influx" connectionString="url=http://10.0.7.161:30359; user=; password=; batchIntervalMs=5000" />
  <add name="clientPerformanceLoggerServiceUri" connectionString="http://tsbuild-k8s-m1:30001/" />
  <add name="messageBroker" connectionString="amqp://guest:guest@localhost/BPMonlineSolution" />
</connectionStrings>
```




## Start Redis
```shell
docker-compose -f Redis.yml up -d
```

## Start Postgres with pgAdmin
```shell
docker-compose -f Postgres.yml up -d
```

## Restore DataBase from backup
```ps
.\restoredb.ps1 -AppName "creatiocore" -dbFileName "BPMonline7185Studio_Linux.backup"
```


## Start Creatio
```shell
docker-compose -f Postgres.yml up -d
```

- Open Creatio at  https://localhost:5102
	- Username: Supervisor
	- Password: Supervisor
- Open pgAdmin at  https://localhost:9086 
	- Username: k.krylov@creatio.com
	- Password: Supervisor