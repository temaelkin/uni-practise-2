@echo off

echo SILENT SOFTWARE INSTALLATION
echo Run with administrator access.
echo Internet connection required.
echo.

echo Installing Chocolatey...
echo.

REM Checking for Chocolatey on your machine.
REM You need to restart Script after Choco installation.
where choco >nul 2>&1
if %errorlevel% neq 0 (
	powershell -Command "Set-ExecutionPolicy Bypass -Scope Process -Force; " ^
	"[System.Net.ServicePointManager]::SecurityProtocol = " ^
	"[System.Net.ServicePointManager]::SecurityProtocol -bor 3072; " ^
	"iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))"
	echo Succesfully installed latest Chocolatey!
	echo.
	echo RESTART SCRIPT TO APPLY CHANGES!
	pause
	exit /b
) else (
	echo You already have Chocolatey.
	echo Checking for fresher version...
	choco upgrade chocolatey -y --no-progress
)


echo Installing software via Chocolatey...
echo.

REM Developer tools.
choco upgrade vscode -y --force --no-progress --params="'/AddToPath'"
choco upgrade docker-desktop -y --force --no-progress --params="'/EnableWindowsContainers'"
choco upgrade pycharm-community -y --force --no-progress
choco upgrade git -y --force --no-progress --params="'/GitAndUnixToolsOnPath /WindowsTerminal'"
choco upgrade github-desktop -y --force --no-progress
choco upgrade anaconda3 -y --force --no-progress --params="'/AddToPath'"
choco upgrade julia -y --force --no-progress
choco upgrade rust -y --force --no-progress

REM Utility tools.
choco upgrade 7zip -y --force --no-progress
choco upgrade qalculate -y --force --no-progress
choco upgrade gimp -y --force --no-progress
choco upgrade zettlr -y --force --no-progress
choco upgrade miktex.install -y --force --no-progress
choco upgrade texstudio -y --force --no-progress
choco upgrade far -y --force --no-progress
choco upgrade sumatrapdf -y --force --no-progress
choco upgrade firefox -y --force --no-progress
choco upgrade googlechrome -y --force --no-progress
choco upgrade flameshot -y --force --no-progress
choco upgrade archi -y --force --no-progress
choco upgrade maxima -y --force --no-progress

echo Updating environment variables...
echo.
call refreshenv >nul 2>&1

echo Installing Visual Studio Code extensions...
call code --install-extension ms-vscode.cpptools --force
call code --install-extension ms-python.python --force  
call code --install-extension ms-azuretools.vscode-docker --force
call code --install-extension julialang.language-julia --force
call code --install-extension rust-lang.rust-analyzer --force
call code --install-extension vadimcn.vscode-lldb --force

echo Installing remaining software...
echo.

echo Installing Python...
"D:\BATCH\python-3.13.7-amd64.exe" /quiet InstallAllUsers=1 PrependPath=1 Include_test=0 Shortcuts=0

echo Installing MSYS2...
"D:\BATCH\msys2-x86_64-20250830.exe" install --root C:\MSYS2 --confirm-command

echo Installing KNIME Analytics Platform...
REM Not completely silent
"D:\BATCH\KNIME-5.7.0-Installer-(64bit).exe" /VERYSILENT /NORESTART

echo Installing SberJazz...
"D:\BATCH\jazz.exe" /S /D=C:\Program Files\Jazz\

echo Installing Yandex Browser...
"D:\BATCH\Yandex.exe" --silent --do-not-launch-browser

echo Installing Yandex Telemost...
msiexec /i "D:\BATCH\YandexTelemostSetup.msi" /qn ALLUSERS="1" MSIINSTALLPERUSER="" SKIP_LAUNCH=1

echo Installing Google Chrome...
msiexec /i "D:\BATCH\googlechromestandaloneenterprise64.msi" /qn

REM echo Installing Arc Browser...
REM winget install --id=TheBrowserCompany.Arc  -e

REM Software for class 313.

REM Delete 'REM' in next THREE lines to install.
REM "D:\BATCH\jre-8u461-windows-x64.exe" /s
REM "D:\BATCH\ramus-2.0-setup.exe" /S /D=C:\Program Files\Ramus
REM "D:\BATCH\aris-express-setup.exe"
REM Aris Express setup is NOT SILENT!!!

pause