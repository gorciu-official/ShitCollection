@echo off
echo Preparing to run JUAMP Setup...
echo _______________________________
ping localhost-n 1>nul
title JUAMP! Setup
color 0B
cls
echo Enter languauge
set /p "languauge=>>"
goto start

:start
cls
echo Witaj w JUAMP Setup!
echo ____________________
echo Niniejszy program pomoze ci zainstalowac JUAMP!
echo Zamknij inne programy, a nastepnie kliknij klawisz
pause>nul
echo 2. Sciezka instalacji
echo Program zostanie zainstalowany na pulpicie. Mozesz ztamtad go przeniesc

:setup2
echo 3. Minimalne wymagania sprzetowe
echo 1 GB ram
echo Procesor 2 watkowy
echo Windows z updatem REDACTED, potrzebna obsluga wiersza polecenia.
echo LICENCJA NA WIN - Bez aktywanego Windows program nie zadziala.
echo W lokalizacji w ktorej to instalujesz musi byc folder Gorciu, a w nim folder JUAMP, bo inaczej nie bedzie chodzic. Jezeli tego nie ma to go utworz - teraz
echo 2026 UPDATE: these system requirements are probably too high, you just have to run windows
start winver
echo NACISNIJ COS BY STARTOWAC
pause>nul
cls
color 8F
echo INSTALATOR
echo Instalacja: Program startowy
echo Instalacja: Gra
copy "start.bat" "%HOMEPATH%\Desktop\Gorciu\JUAMP\"
echo Instalacja: Instalator
copy "setup.bat" "%HOMEPATH%\Desktop\Gorciu\JUAMP\"
echo Instalacja: Muzyka REDACTED
echo REDACTED: private reference i don't want to be public
echo REDACTED: plus music i probably dont have rights to
echo Instalacja: Komunikaty VisualBasic
copy "autorgryjuamp.vbs" "%HOMEPATH%\Desktop\Gorciu\JUAMP\"
copy "dzieci.vbs" "%HOMEPATH%\Desktop\Gorciu\JUAMP\"
copy "papa.vbs" "%HOMEPATH%\Desktop\Gorciu\JUAMP\"
copy "przeprosinyreklamy.vbs" "%HOMEPATH%\Desktop\Gorciu\JUAMP\"
echo Finalizacja
echo REDACTED: private reference i don't want to be public
ping localhost-n 1 >nul
color 0B
cls
echo ZAKONCZONO INSTALCJE JUAMP
pause>nul



