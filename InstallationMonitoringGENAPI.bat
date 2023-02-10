cls
@echo off
REM *******Mise en page********
Color 0A & Mode con cols=65 lines=5
REM *******Verfication des droits de l'utilisateur********
Openfiles > NUL
IF NOT %ERRORLEVEL% == 0 (
	echo.
    	ECHO Veuillez relancer le programme en faisant un clic droit 
		ECHO et "Executer en tant qu'administrateur"
    	pause
	exit
)
REM *******************************************************************************
REM ***************** DEPLOIEMENT DE L'AGENT DE MONITORING GENAPI *****************
REM *******************************************************************************
ECHO Installation de l'agent de monitoring GENAPI
ECHO pour l'etude Maillard
pause

REM **********Teste la presence du service et quitte s'il existe deja**************
ECHO Verification de la presence de l'agent
sc query RG-Supervision > NUL
if not errorlevel 1060 (
 	echo.
		ECHO Agent de monitoring deja installe sur cette machine
		ECHO Merci de le reactiver
		ECHO si besoin, contactez GENAPI support@genapi.be
 		pause
	exit
)
REM *******Determine le chemin d'installation en fonction de l'architecture********
set InstallPath=%ProgramFiles%
if exist "%ProgramFiles(x86)%" set InstallPath=%ProgramFiles(x86)%

REM *************************** Téléchargement de l'Agent *************************
bitsadmin.exe /transfer "Chargement de l'agent GENAPI" https://github.com/TECHCSID/installRG/raw/main/RG-Setup.exe %temp%\MonitoringGENAPI.exe

REM **********************Installation de l'agent**********************************
"%temp%\MonitoringGENAPI.exe" --action register --login token@token.tk --password 1f8684c703b73d0e4c2d8c87febcec65e4ef8914 --node #25373 --install-path "%InstallPath%\RG-Supervision"

REM **********************Nettoyage************************************************
del %temp%\MonitoringGENAPI.exe /F /Q

if "%ERRORLEVEL%" == "0" (
	echo Installation Agent Monitoring GENAPI Reussie
	echo Fin du programme
	pause
	exit
	)
