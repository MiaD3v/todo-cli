@echo off
setlocal
IF "%*"=="" (set I=-i) ELSE (set I=)
set "LUAROCKS_SYSCONFDIR=C:\Program Files (x86)\luarocks"
"C:\lua\lua.exe" -e "package.path=\"C:\\Users\\School\\todo-cli\\todo-cli\\lua_modules\\share\\lua\\5.5\\?.lua;C:\\Users\\School\\todo-cli\\todo-cli\\lua_modules\\share\\lua\\5.5\\?\\init.lua;C:\\Users\\School\\AppData\\Roaming\\luarocks\\share\\lua\\5.5\\?.lua;C:\\Users\\School\\AppData\\Roaming\\luarocks\\share\\lua\\5.5\\?\\init.lua;\"..package.path;package.cpath=\"C:\\Users\\School\\todo-cli\\todo-cli\\lua_modules\\lib\\lua\\5.5\\?.dll;C:\\Users\\School\\AppData\\Roaming\\luarocks\\lib\\lua\\5.5\\?.dll;\"..package.cpath" %I% %*
exit /b %ERRORLEVEL%
