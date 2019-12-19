@echo off

Set SctPath="%~DP0%

Set /P POSTSQL_PATH=請輸入POSTSQL安裝路徑, 如C:\Program Files\PostgreSQL\9.0:
Set POSTSQL_PATH="%POSTSQL_PATH%"

Set /P DB_ROOT_USER=請輸入POSTSQL ROOT使用者名稱, 預設為postgres:
echo %DB_ROOT_USER%

set DB_NAME=einvturnkey
set DB_USER=turnkey


IF %POSTSQL_PATH%=="" (
    echo 未指定Postgre根目錄，請指定路徑
    pause
    EXIT;
)

IF %DB_ROOT_USER%=="" (
    echo 未指定POSTSQL ROOT使用者名稱
    pause
    EXIT;
)

echo %POSTSQL_PATH%
IF NOT EXIST %POSTSQL_PATH% (
    echo %POSTSQL_PATH% 不存在，請重新指定路徑
    pause
    EXIT;
)

IF NOT EXIST %POSTSQL_PATH%\bin (
    echo %POSTSQL_PATH%\bin 不存在，請重新指定路徑
    pause
    EXIT;
)
echo DBConfig
IF EXIST %SctPath%"DBConfig.properties (
    del %SctPath%"DBConfig.properties
)

echo create user %DB_USER% createdb; >> %SctPath%"DBConfig.properties
echo create database %DB_NAME% with encoding 'utf-8'; >> %SctPath%"DBConfig.properties
echo alter user %DB_USER% nocreatedb; >> %SctPath%"DBConfig.properties
echo alter user %DB_USER% with encrypted password '%DB_USER%'; >> %SctPath%"DBConfig.properties
echo \connect %DB_NAME% >> %SctPath%"DBConfig.properties
type %SctPath%"PostgreSQL.sql >> %SctPath%"DBConfig.properties

echo ALTER TABLE from_config     OWNER TO %DB_USER%; >> %SctPath%"DBConfig.properties
echo ALTER TABLE turnkey_transport_config OWNER TO %DB_USER%; >> %SctPath%"DBConfig.properties
echo ALTER TABLE turnkey_user_profile OWNER TO %DB_USER%; >> %SctPath%"DBConfig.properties
echo ALTER TABLE schedule_config OWNER TO %DB_USER%; >> %SctPath%"DBConfig.properties
echo ALTER TABLE sign_config OWNER TO %DB_USER%; >> %SctPath%"DBConfig.properties
echo ALTER TABLE task_config OWNER TO %DB_USER%; >> %SctPath%"DBConfig.properties
echo ALTER TABLE to_config OWNER TO %DB_USER%; >> %SctPath%"DBConfig.properties
echo ALTER TABLE turnkey_message_log OWNER TO %DB_USER%; >> %SctPath%"DBConfig.properties
echo ALTER TABLE turnkey_message_log_detail OWNER TO %DB_USER%; >> %SctPath%"DBConfig.properties
echo ALTER TABLE turnkey_sequence OWNER TO %DB_USER%; >> %SctPath%"DBConfig.properties
echo ALTER TABLE turnkey_sysevent_log OWNER TO %DB_USER%; >> %SctPath%"DBConfig.properties

echo \q >> %SctPath%"DBConfig.properties



cd /D %POSTSQL_PATH%\bin
echo %POSTSQL_PATH%\bin
psql -U postgres < %SctPath%"DBConfig.properties

if NOT %ERRORLEVEL%==0 (
    echo "Schema 建立失敗"
    pause
    EXIT
)

echo "匯入DB Schema成功"
echo 安裝完成, 資料庫名稱:%DB_NAME%，使用者名稱%DB_USER%, 密碼%DB_USER%

@pause
