@echo off
setlocal
set "LUAROCKS_SYSCONFDIR=C:\Program Files (x86)\luarocks"
"C:\luarocks-3.13.0-windows-32\luarocks.exe" --project-tree C:\Users\School\todo-cli\todo-cli\lua_modules %*
exit /b %ERRORLEVEL%
