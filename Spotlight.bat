@echo off
setlocal
cd %~dp0
rmdir /S /Q temp >nul 2>nul
mkdir temp >nul 2>nul
mkdir bgimages >nul 2>nul
copy "%USERPROFILE%\AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets" temp > nul
cd temp
for /F "delims=" %%i in ('dir /B') do (
	ren %%i %%i.jpg
rem	..\tooltipInfo.bat %%i.jpg | findstr Dimensions
	for /F "tokens=2 delims=?" %%j in ('..\tooltipInfo.bat %%i.jpg ^| findstr Dimensions') do (
		if "%%j" == "1920 x 1080" (
			copy %%i.jpg ..\bgimages\ > nul
		)
	)
)
cd ..
rmdir /S /Q temp
echo Files are in %~dp0bgimages\
endlocal