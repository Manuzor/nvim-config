@echo off

set NVIM_CONFIG_DIR=%LOCALAPPDATA%\nvim

if exist "%NVIM_CONFIG_DIR%" (
    echo ERROR: The destination folder already exists '%NVIM_CONFIG_DIR%'
    echo        Please delete it manually and re-run this script.
    goto :eof
)

mklink /J "%NVIM_CONFIG_DIR%" "%~dp0nvim"

