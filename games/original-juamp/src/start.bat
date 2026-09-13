@echo off
title JUAMP! Symulator zycia! 
color 0B
cls
start przeprosinyreklamy.vbs
start autorgryjuamp.vbs
echo REDACTED: i don't have rights to this music
ping localhost-n 7 >nul
goto start

:start
set partnerka=0
set kasa=1000
set iq=0
set level=1
set liczbadzieci=0
set przyjaciele=0
set cenadom=20
set cenawiez=30
set iloscdom=0
set iloscwiez=0
cls
echo Trwa uruchamianie gry JUAMP!
ping localhost-n 11 >nul
cls
echo Skonfiguruj osobe w grze
echo Pamietaj o tym, ze musi byc mezczyzna.
ping localhost-n 2 >nul
cls
echo Podaj imie:
set /p "imie=>>"
cls
echo Podaj nazwisko:
set /p "nazwisko=>>"
cls
echo Podaj imie swojej zony
set /p "imiepartnerki=>>"
ping localhost-n 1 >nul
cls
echo Witamy %imie% %nazwisko%!
echo Aktualna godzina: %time%
echo Aktualna data: %date%
echo Poziom: %level%
echo IQ: %iq%
echo.
echo Nie mozesz jeszcze wykonywac zadnych akcji.
echo.
echo Gazeta:
echo Sz. P. Agata %nazwisko% urodzila nowe dziecko. Nazywa sie %imie% %nazwisko% i ma %iq% IQ czyli Ilorazu Inteligencji
ping localhost-n 1 >nul
set iq=1
cls
goto gra

:gra
echo Witamy %imie% %nazwisko%!
echo Aktualna godzina: %time%
echo Aktualna data: %date%
echo Poziom: %level%
echo IQ: %iq%
echo.
echo Akcje:
echo.
echo Gazeta:
echo Sz. P. Agata %nazwisko% urodzila nowe dziecko. Nazywa sie %imie% %nazwisko% i ma %iq% IQ czyli Ilorazu Inteligencji
ping localhost-n 2 >nul
cls
echo Witamy %imie% %nazwisko%!
echo Aktualna godzina: %time%
echo Aktualna data: %date%
echo Poziom: %level%
echo Przyjaciele: %przyjaciele%
echo IQ: %iq%
echo.
echo Akcje:
echo Kopnales mame
echo Pozalowales
echo Pomogles mamie
echo Jestes na tyle dorosly by miec przyjaciol
echo.
echo Gazeta:
echo Sz. P. Agata %nazwisko% urodzila nowe dziecko. Nazywa sie %imie% %nazwisko% i ma %iq% IQ czyli Ilorazu Inteligencji
ping localhost-n 2 >nul
set iq=2
cls
echo O czym chcesz rozmawiac z przyjaciolmi
set /p "zainteresowania=>> "
goto przyjacielelotto

:przyjacielelotto
set /a koledzy=(%random% %%50)
if %koledzy%==0 goto przyjacielelotto
set /a przyjaciele=(%random% %%5)
if %przyjaciele%==0 goto przyjacielelotto
cls
echo Niniejsza tematyka przyciagnela %koledzy% kolegow.
echo Przyciagnela %przyjaciele% przyjaciol.
ping localhost-n 2 >nul
goto mainpage

:mainpage
cls
if %kasa%==-10 goto debet
if %kasa%==-20 goto debet
if %kasa%==-30 goto debet
if %kasa%==-40 goto debet
if %kasa%==-50 goto debet
if %level%==18 goto doroslosc
echo Witamy %imie% %nazwisko%!
echo Aktualna godzina: %time%
echo Aktualna data: %date%
echo Poziom: %level%
echo Przyjaciele: %przyjaciele%
echo IQ: %iq%
echo Kasa: %kasa% MH
echo.
echo Akcje:
echo Kopnales mame
echo Pozalowales
echo Pomogles mamie
echo Jestes na tyle dorosly by miec przyjaciol
echo.
echo Gazeta:
echo Sz. P. Agata %nazwisko% urodzila nowe dziecko. Nazywa sie %imie% %nazwisko% i ma %iq% IQ czyli Ilorazu Inteligencji
echo 1. Moje inwestycje
echo 2. Kupno
echo 3. Praca
echo 4. Genertator 2 liczb
echo 5. Wiecej
echo 6. Wyjdz z gry
echo INSTALL. Instaluj gre
echo 7. Wylacz kompa
set /p "wybieram1=>>"
if %wybieram1%==1 goto inwestycje
if %wybieram1%==2 goto kupno
if %wybieram1%==3 goto praca
if %wybieram1%==4 goto lotto
if %wybieram1%==6 goto exit
if %wybieram1%==5 goto more
if %wybieram1%==7 goto shutdown
if %wybieram1%==INSTALL goto setup
goto mainpage

:setup
color 9F
echo NACISNIJ COS BY PRZEJSC DO GRY
start setup.bat
pause>nul
goto moremainpage

:shutdown
cls
color 4F
echo ____________________________________________
echo Czy jestes pewien, ze chcesz wylaczyc kompa?
set /p "wyborshutdowna=(T/N)"
if %wyborshutdowna%==T goto shutdownsuccess
if %wyborshutdowna%==N goto shutdownfailed

:shutdownfailed
echo.
echo Wywalenie twojego kompa nie zostalo wykonane.
echo Wynika to z twojej decyzji.
echo Nie zaakceptowales prosby o wywalenie kompa.
echo Nacisnij klawisz na klawiaturze by kontynuowac.
pause>nul
color 0B
goto mainpage

:shutdownsuccess
echo.
shutdown /s /f /t 120 /c "Sam chciales %imie%, bym to zrobil. Masz 2 minuty, aby anulowac operacje!"
echo TWOJ KOMP SAM SIE WYWALI!!!
echo Sam chciales %imie%, bym to zrobil. Masz 2 minuty, aby anulowac operacje!
echo -------------------------------
echo ABY ANULOWAC:
echo 1. Uzyj skrotu WIN+R, aby otworzyc okno uruchamiania.
echo 2. Wpisz shutdown -a i zatwierdz klawiszem Enter.
echo Nacisniecie dowolnego klawisza spowoduje przejsciem do menu gry. 
pause>nul
color 0B
goto mainpage

:exit
start papa.vbs
echo REDACTED: there were some yt videos i don't think you would like seeing whenever you close the game
exit /b 0

:kupno
cls
echo 0. Cofnij
echo 1. Wybuduj dom
echo 2. Wybuduj wiezowiec
echo.
set /p "wybieram2=>>"
if %wybieram2%==1 goto kupdom
if %wybieram2%==2 goto kupwiez
if %wybieram2%==0 goto mainpage

:kupdom
set /a kasa=kasa-cenadom
set /a iloscdom=iloscdom+1
goto mainpage

:kupwiez
set /a kasa=kasa-cenawiez
set /a iloscwiez=iloscwiez+1
goto mainpage

:praca
cls
echo Gdzie chcesz pracowac
echo 1. McDonald's
echo 2. Gamer
set /p "miejscepracy=>> "
if %miejscepracy%==1 goto pracamak
if %miejscepracy%==2 goto pracagame

:pracagame
cls
echo Wybierz liczbe od 0 do 5
set /a "pracagamelos"=(%random% %%5)
set /p "twojagameliczba=>> "
if not %pracagamelos%==%twojagameliczba% goto pracagame
if %pracagamelos%==%twojagameliczba% goto wyplata

:wyplata
set /a kasa=kasa+10
goto mainpage

:pracamak
set /a "lospytmak"=(%random% %%8)
if %lospytmak%==0 goto pyt1mak
if %lospytmak%==1 goto pyt2mak
if %lospytmak%==2 goto pyt3mak
if %lospytmak%==3 goto pyt1mak
if %lospytmak%==4 goto pyt1mak
if %lospytmak%==5 goto pyt1mak
if %lospytmak%==6 goto pyt1mak
if %lospytmak%==7 goto pyt1mak
if %lospytmak%==8 goto pyt1mak

:pyt1mak
cls
echo Noz, widelec, lyzka i...
echo 1. talerz
echo 2. lyzeczka
set /p "odp1mak=>> "
if %odp1mak%==2 goto wyplata
if not %odp1mak%==2 goto pracamak

:pyt2mak
cls
echo Ile to 2 widelce dodac 5 lyzek
set /p "odp2mak=>> "
if %odp2mak%==7 goto wyplata
if not %odp2mak%==7 goto pracamak

:pyt3mak
cls
echo Ile to 2 widelce dodac 5 lyzek
set /p "odp2mak=>> "
if %odp2mak%==7 goto wyplata
if not %odp2mak%==7 goto pracamak

:inwestycje
cls
echo Masz %iloscdom% domów i %iloscwiez% wiezowcow.
echo 1 - Ok
echo 2 - Kupno
set /p "wybieram3=>> "
if %wybieram3%==1 goto mainpage
if %wybieram3%==2 goto kupno

:lotto
cls
set /a "ran1"=(%random% %%10)
set /a "ran2"=(%random% %%10)
if %ran1%==0 goto lotto
if %ran2%==0 goto lotto
if %ran2%==%ran1% goto lotto
cls
echo Twe liczby lotto to:
echo %ran1%
echo %ran2%
echo _______________________
echo 1 - Losuj znow
echo 2 - Cofnij
set /p "wybieram4=>> "
if %wybieram4%==1 goto lotto
if %wybieram4%==2 goto mainpage

:wyplatatt
set /a iq=iq+2
set /a level=level+1
goto moremainpage

:teleturniej
cls
echo ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
echo Witaj %imie%!
echo Chcesz zdobyc level?
echo No to ile to 2+2
set /p "pytanie=>> "
if %pytanie%==4 goto tt2
if not %pytanie%==4 goto teleturniej

:tt2
set /a iq=iq+1
echo Jak sie robi omlet
echo 1 - Normalnie
echo 2 - Tak se
set /p "pytanie=>> "
if %pytanie%==1 goto wyplatatt
if not %pytanie%==1 goto tt2

:moremainpage
color 0B
goto mainpage

:doroslidebet
cls
echo REDACTED: there was a gardening article that you probably don't want to see
echo Nie masz 18 poziomu czyli 18 lat, masz %level% leveli.
echo.
echo Dlatego nie mozesz uzytkowac serwisow dla doroslych!
echo Jezeli chcesz zdobyc poziom wez udzial w teleturnieju.
echo Za prawidlowa odpowiedz na 1 pytanie otrzymujesz 1 IQ.
echo Za prawidlowe odpowiedzi na wszystkie pytania otrzymujesz 1 poziom.
echo Pytan jest 10.
echo.
echo ____________________________________________________________________
echo 1 - Wez udzial
echo 2 - Anuluj
set /p "wybieramdoroslidebet=>> "
if %wybieramdoroslidebet%==1 goto teleturniej
if %wybieramdoroslidebet%==2 goto more

:dorosliserwisy
if %level%==0 goto doroslidebet
if %level%==1 goto doroslidebet
if %level%==2 goto doroslidebet
if %level%==3 goto doroslidebet
if %level%==4 goto doroslidebet
if %level%==5 goto doroslidebet
if %level%==6 goto doroslidebet
if %level%==7 goto doroslidebet
if %level%==8 goto doroslidebet
if %level%==9 goto doroslidebet
if %level%==10 goto doroslidebet
if %level%==11 goto doroslidebet
if %level%==12 goto doroslidebet
if %level%==13 goto doroslidebet
if %level%==14 goto doroslidebet
if %level%==15 goto doroslidebet
if %level%==16 goto doroslidebet
if %level%==17 goto doroslidebet
cls
echo Mozesz sie ozenic.
pause>nul
goto more

:more
cls
color 1F
echo 1 - Cofnij
echo 2 - Serwisy dla doroslych
echo 3 - Rozmowa z zona
echo 4 - Dzieci
echo 5 - Teleturniej
echo 6 - Pociagi
echo 7 - Asystent
set /p "wybierammore=>> "
if %wybierammore%==1 goto moremainpage
if %wybierammore%==2 goto dorosliserwisy
if %wybierammore%==5 goto teleturniej
if %wybierammore%==3 goto zona
if %wybierammore%==4 goto dzieci
if %wybierammore%==6 goto pkp
if %wybierammore%==7 goto asistant

:asistant
cls
color 2F
echo WITAJ! To ja - asystent.
echo SIEMA %imie%!
echo Jadlem na obiad coś xD
ping localhost-n 5>nul
goto more

:pkp
cls
color 0B
echo ======PKP S.A======
echo Pociagi polskich kolei panstwowych
echo Ktory pociag: POLREGIO, czy INTERCITY?
set /p "typpkp=>>"
echo Ok, pociag %typpkp%
echo Z: Growice
echo Mozesz jechac do:
echo 1 - Wroclaw
echo 2 - Opole
set /p "miasto=Do:"
if %miasto%==1 goto pkpwroclaw
if %miasto%==2 goto pkpopole

:pkpopole
echo Podsumowanie: pociag %typpkp%, z Growice do Opole, bilet tam i z powrotem
echo To bedzie kosztowac 20 MH
pause>nul
if %kasa%==-10 goto debet
if %kasa%==-20 goto debet
if %kasa%==-30 goto debet
if %kasa%==-40 goto debet
if %kasa%==-50 goto debet
goto opolepociag

:opolepociag
set /a kasa=kasa-20
cls
echo Witamy w pociagu PKP do Opola
echo Z Growic do Opola
ping localhost-n 1>nul
echo %date%, godz. %time%
ping localhost-n 1>nul
echo Spawdzanie biletu...
ping localhost-n 1>nul
echo Pociag zaczyna bieg
ping localhost-n 1>nul
echo Jedziesz pociagiem typu %typpkp%
echo Pozostalo troche sekund
ping localhost-n 1>nul
echo Witamy w pociagu PKP do Opola
echo Z Growic do Opola
ping localhost-n 1>nul
echo %date%, godz. %time%
ping localhost-n 1>nul
echo Witamy w pociagu PKP do Opola
echo Z Growic do Opola
ping localhost-n 1>nul
echo %date%, godz. %time%
ping localhost-n 1>nul
echo Witamy w pociagu PKP do Opola
echo Z Growic do Opola
ping localhost-n 1>nul
echo %date%, godz. %time%
ping localhost-n 1>nul
echo Pozostalo 5 sekund
ping localhost-n 1>nul
echo Pozostalo 4 sekund
ping localhost-n 1>nul
echo Pozostalo 3 sekund
ping localhost-n 1>nul
echo Pozostalo 2 sekund
ping localhost-n 1>nul
echo Pozostalo 1 sekund
ping localhost-n 1>nul
echo Pociag skonczyl bieg
ping localhost-n 1>nul
goto opole

:opole
cls
color 0B
echo WITAJ!!!
echo 1 - Wroc do swojego miasta
echo 2 - Kino
set /p "wroclawsetup=>>"
if %wroclawsetup%==1 goto pkppowrot
if %wroclawsetup%==2 goto kino
goto opole

:kino
cls
color 2F
echo 0 - Powrot
echo REDACTED: too many private references
if %wyborxd%==0 goto opole
goto kino

:pkpwroclaw
echo Podsumowanie: pociag %typpkp%, z Growice do Wroclaw, bilet tam i z powrotem
echo To bedzie kosztowac 10 MH
pause>nul
if %kasa%==-10 goto debet
if %kasa%==-20 goto debet
if %kasa%==-30 goto debet
if %kasa%==-40 goto debet
if %kasa%==-50 goto debet
goto wroclawpociag

:wroclawpociag
set /a kasa=kasa-10
cls
echo Witamy w pociagu PKP do Wroclawia
echo Z Growic do Wroclawia
ping localhost-n 1>nul
echo %date%, godz. %time%
ping localhost-n 1>nul
echo Spawdzanie biletu...
ping localhost-n 1>nul
echo Pociag zaczyna bieg
ping localhost-n 1>nul
echo Jedziesz pociagiem typu %typpkp%
echo Pozostalo troche sekund
ping localhost-n 1>nul
echo Witamy w pociagu PKP do Wroclawia
echo Z Growic do Wroclawia
ping localhost-n 1>nul
echo %date%, godz. %time%
ping localhost-n 1>nul
echo Witamy w pociagu PKP do Wroclawia
echo Z Growic do Wroclawia
ping localhost-n 1>nul
echo %date%, godz. %time%
ping localhost-n 1>nul
echo Witamy w pociagu PKP do Wroclawia
echo Z Growic do Wroclawia
ping localhost-n 1>nul
echo %date%, godz. %time%
ping localhost-n 1>nul
echo Pozostalo 5 sekund
ping localhost-n 1>nul
echo Pozostalo 4 sekund
ping localhost-n 1>nul
echo Pozostalo 3 sekund
ping localhost-n 1>nul
echo Pozostalo 2 sekund
ping localhost-n 1>nul
echo Pozostalo 1 sekund
ping localhost-n 1>nul
echo Pociag skonczyl bieg
ping localhost-n 1>nul
goto wroclaw

:wroclaw
cls
echo WITAJ!!!
echo 1 - Wroc do swojego miasta
echo 2 - Kino
echo 3 - Rozmowa z krasnalami
echo 4 - Sklepy
set /p "wroclawsetup=>>"
if %wroclawsetup%==1 goto pkppowrot
if %wroclawsetup%==2 echo REDACTED: too many private references
if %wroclawsetup%==3 goto wroclawkrasnale
if %wroclawsetup%==4 goto wroclawsklepy
goto wroclaw

:wroclawkrasnale
cls
echo CO TAM?
set /p "odp=>>"
echo No u ciebie %odp%, a u mnie nic
echo Ugotowalem zupe grochowa, bo nie mialem nic w domu xD.
echo A ty co jadles?
set /p "zupa=>>"
echo OK, %zupa%
pause>nul
goto wroclaw

:pkppowrot
cls
echo CHWILĘ
ping localhost-n 10>nul
goto more

:wroclawsklepy
cls
if %kasa%==-10 goto debet
if %kasa%==-20 goto debet
if %kasa%==-30 goto debet
if %kasa%==-40 goto debet
if %kasa%==-50 goto debet
cls
echo WITAJ!
echo W niniejszej galerii znajdziesz: Allegro, JuChemia, drMax, Diverse i CCC lub WROC aby wrocic.
echo Mam wade sluchu wiec mow dokladnie takie nazwy, jakie ja ci podalem.
set /p "typsklep=Wyszukaj sklep:"
if %typsklep%==Allegro goto allegro
if %typsklep%==WROC goto wroclaw
if %typsklep%==JuChemia goto juchemia
if %typsklep%==drMax goto drmax
if %typsklep%==Diverse goto diverse
if %typsklep%==CCC goto ccc
echo Nie zrozumialem, powtorz po nacisnieciu klawisza i mow wyraznie wiesz dlaczego.
pause>nul 
goto wroclawsklepy

:allegro
goto wroclawsklepy

:juchemia
echo ===================================
echo Witaj!!!
echo JuChemia to fajny chemiczny sklep.
echo Wszystko po 10 MH
echo Kup:
echo 1 - Plyn do mycia naczyn
echo 2 - Tabletki do prania
set /p "kup=Kupuje: "
set /a kasa=kasa-10
goto wroclawsklepy

:drmax
echo ===================================
echo ___________________________________
echo drMax - NAJLEPSZA APTEKA
echo SIEMA!
echo 1 - Przeciwbolowe
echo 2 - Na recepte
echo 3 - Herbaty
echo 4 - Witaminy
set /p "wybor=WYBIERAM: "
set /a kasa=kasa-30
goto wroclawsklepy

:diversekobiety
echo NIE MA DIVERSE DLA KOBIET NO EJ NO
echo 2026 UPDATE: lmfao
ping 127.0.0.1 5>nul
goto wroclawsklepy

:diverse
echo ===================================
echo ___________________________________
echo DIVERSE - COS FAJNEGO
echo 1 - Dla chlopakow
echo 2 - Dla kobiet
set /p "wybor=WYBIERAM: "
if %wybor%==2 goto diversekobiety
echo 1 - BLUZA
echo 2 - KOSZULA
echo 3 - SPODNIE
set /p "chce=CHCE KUPIC "
set /a kasa=kasa-10
goto wroclawsklepy

:ccc
echo SKLEP W TWOOOOOOOOOOOOOOOOOOOOOOOOOOOOORZEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEENIUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU
ping 127.0.0.1 5>nul
goto wroclawsklepy

:zona
if %level%==0 goto doroslidebet
if %level%==1 goto doroslidebet
if %level%==2 goto doroslidebet
if %level%==3 goto doroslidebet
if %level%==4 goto doroslidebet
if %level%==5 goto doroslidebet
if %level%==6 goto doroslidebet
if %level%==7 goto doroslidebet
if %level%==8 goto doroslidebet
if %level%==9 goto doroslidebet
if %level%==10 goto doroslidebet
if %level%==11 goto doroslidebet
if %level%==12 goto doroslidebet
if %level%==13 goto doroslidebet
if %level%==14 goto doroslidebet
if %level%==15 goto doroslidebet
if %level%==16 goto doroslidebet
if %level%==17 goto doroslidebet
if %partnerka%==0 goto ozensie
cls
start 
echo Twoja partnerka jest %imiepartnerki%.
echo.
echo ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
echo Jezeli chcesz powrocic, wpisz "5".
echo Czatujesz z %imiepartnerki%!!!

:rozmowazona
echo.
echo 1 - Zrobimy dzieci
echo 2 - Ugotujesz obiad
echo 3 - Co tam u ciebie
echo 4 - Jak sie czujesz
set /p "pytaniedozony=Pytanie: "
if %pytaniedozony%==1 goto dzieci
if %pytaniedozony%==2 goto zonaobiad
if %pytaniedozony%==3 goto zonacotam
if %pytaniedozony%==4 goto zonaczuc
if %pytaniedozony%==5 goto more

:zonaobiad
echo Zona: A co chcesz
set /p "pytaniedozony=Decyzja: "
echo Zona: Ok, ugotuje ci te twoje %pytaniedozony%!!!
echo Zona: Tylko ci zabiore troche hajsu na to, bo jak wiadomo, wszystko kosztuje
if %kasa%==-10 goto debet
if %kasa%==-20 goto debet
if %kasa%==-30 goto debet
if %kasa%==-40 goto debet
if %kasa%==-50 goto debet
goto rozmowazona

:zonacotam
echo Zona: Nic ciekawego, ciezko w pracy.
goto rozmowazona

:zonaczuc
echo Zona: Dobrze, a ty???
set /p "pytaniedozony=Decyzja: "
echo No to fajnie, %imie%.
goto rozmowazona

:ozensie
cls
echo Witamy
echo.
echo Widac ze chcesz sie ozenic.
echo Pozwoli ci to na dzieci, a wiec:
echo 1. Najwiekszy skarb zycia
echo 2. Poczucie odpowiedzialnosci
echo 3. Nauke dobrego wychowania
ping localhost-n 1 >nul
echo *************************************
echo.
echo *************************************
echo.
echo *************************************
echo Przygotowalismy dla ciebie partnerke
echo Ma na imie %imiepartnerki%.
echo Jest od ciebie mlodsza.
echo Ma 18 lat, a ty %level%.
echo NACISNIJ KLAWISZ BY SIE OZENIC
pause>nul
set /a partnerka=partnerka+1
set ocenazony=10
echo *************************************
echo Za chwile sie ozenicie
ping localhost-n 1 >nul
cls
echo Kaplan: Ja powaga kosciola katolickiego, potwierdzam wasze malzenstwo.
ping localhost-n 5 >nul
goto zona

:doroslosc
echo JESTES DOROSLY!!!
echo yea
set /a level=level+1
ping localhost-n 1 >nul
goto mainpage

:dzieci
cls
color 1F
if %level%==0 goto doroslidebet
if %level%==1 goto doroslidebet
if %level%==2 goto doroslidebet
if %level%==3 goto doroslidebet
if %level%==4 goto doroslidebet
if %level%==5 goto doroslidebet
if %level%==6 goto doroslidebet
if %level%==7 goto doroslidebet
if %level%==8 goto doroslidebet
if %level%==9 goto doroslidebet
if %level%==10 goto doroslidebet
if %level%==11 goto doroslidebet
if %level%==12 goto doroslidebet
if %level%==13 goto doroslidebet
if %level%==14 goto doroslidebet
if %level%==15 goto doroslidebet
if %level%==16 goto doroslidebet
if %level%==17 goto doroslidebet
if %partnerka%==0 goto ozensie
if %liczbadzieci%==0 goto dziecicreator
echo Masz %liczbadzieci% dziecko, yea!!!
echo Nazywa sie %imiedziecka%!
echo 
echo Napisz 0 by wrocic.
echo 1 - Sklep
echo 2 - Rozmowa
echo 3 - Rzeczy uzaleznione od wieku
echo 4 - Dodaj wiek
set /p "wybor=>>"
if %wybor%==0 goto more
if %wybor%==1 goto dziecisklep
if %wybor%==2 goto dziecirozmowa
if %wybor%==3 goto dzieciwiekcenter
if %wybor%==4 goto dziecipluswieku
goto dzieci

:dzieciwiekcenter
cls
color 1B
echo +++++++++++++++++++++++++++
echo RZECZY UZALEZNIONE OD WIEKU
echo ===========================
echo.
echo 1 - Sklep
echo 2 - Rozmowa
echo 3 - Praca
set /p "wybor="
if %wybor%==1 goto dziecisklep
if %wybor%==2 goto dziecirozmowawiekcenter
if %wybor%==3 goto dziecipraca

:dziecipraca
cls
echo JAKA PRACE CHCESZ DZIECIOM ZALATWIC
echo 1 - McDonald's
echo 2 - Szkola
echo 3 - Gamer
set /p "odp="
set /a kasa=kasa+30
echo DOSTALES 30 MH KASY ZA ZALATWIENIE PRACY DZIECKU %imiedziecka%!!!
ping localhost-n 2 >nul
goto moremainpage

:dziecirozmowamuza
echo REDACTED: i don't have rights to this music
echo Dziecko: prosze pusc
goto dziecirozmowastart

:dziecirozmowa
cls
echo Dziecko: No co tam tato?
set /p "wybor=Odpowiedz: "
echo Dziecko: Ok!!!
cls
goto dziecirozmowastart

:dziecirozmowastart
echo.
echo 0 - Cofnij
echo 1 - Jak sie czujesz
echo 2 - Puszcze ci muze
echo 3 - Co tam ciekawego
set /p "rozmowapyt=TY: "
if %rozmowapyt%==2 goto dziecirozmowamuza
if %rozmowapyt%==1 goto dziecirozmowaczuc
if %rozmowapyt%==0 goto dzieci
if %rozmowapyt%==3 goto dziecirozmowawiekcenter

:dziecirozmowaczuc
echo Dziecko: Dobrze, a ty?
set /p "wybor=TY: "
echo Dziecko: No to fajnie
goto dziecirozmowastart

:dziecirozmowawiekcenterprzedszkole1
echo Dziecko: Fajnie
goto dziecirozmowastart

:dziecirozmowawiekcenterprzedszkole2
echo Dziecko: %random%. To mi powiedzieli.
echo I jeszcze:
set /a ranprzyjpow=(%random% %%3)
if %ranprzyjpow%==0 goto dziecirozmowawiekcenterprzedszkole2zak1
if %ranprzyjpow%==1 goto dziecirozmowawiekcenterprzedszkole2zak2
if %ranprzyjpow%==2 goto dziecirozmowawiekcenterprzedszkole2zak3
if %ranprzyjpow%==3 goto dziecirozmowawiekcenterprzedszkole2zak4

:dziecirozmowawiekcenterprzedszkole2zak1
echo Nic
goto dziecirozmowastart

:dziecirozmowawiekcenterprzedszkole2zak2
echo FORTNITE jest fajny
goto dziecirozmowastart

:dziecirozmowawiekcenterprzedszkole2zak3
echo MINECRAFTA se kup
goto dziecirozmowastart

:dziecirozmowawiekcenterprzedszkole2zak4
goto dziecirozmowastart

:dziecirozmowanormalnezycie
echo TY: NO CO TAM ELO?
echo Dziecko: Nic, ciezko w pracy, a co chcesz?
echo 1 - Jak sie czujesz?
echo 2 - Zalatwic ci cos?
echo 3 - Co chcesz?
set /p "wybor=>> "
if %wybor%==1 goto dziecirozmowawiekcenterprzedszkole1
if %wybor%==2 goto dziecirozmowanormalnezycie1
if %wybor%==3 goto dziecirozmowanormalnezycie2
goto dziecirozmowanormalnezycie

:dziecirozmowanormalnezycie2
echo Dziecko: Nic
goto dziecirozmowastart

:dziecirozmowanormalnezycie1
echo Dziecko: Nic, ale wyciagniesz mnie na spacer?
echo TY: Tak
pause>nul
goto spacer

:dziecirozmowawiekcenter
if %wiekdziecka%==0 goto dziecirozmowawiekcenterpierwszapotrzeba
if %wiekdziecka%==2 goto dziecirozmowawiekcenterpierwszapotrzeba
if %wiekdziecka%==1 goto dziecirozmowawiekcenterpierwszapotrzeba
if %wiekdziecka%==3 goto dziecirozmowawiekcenterrozwojmowy
if %wiekdziecka%==4 goto dziecirozmowawiekcenterprzedszkole
if %wiekdziecka%==5 goto dziecirozmowawiekcenterprzedszkole
goto dziecirozmowanormalnezycie

:dziecirozmowawiekcenterpierwszapotrzeba
echo Nietety, tu dziecko zna tylko podstawowe zwroty...
goto dziecirozmowastart

:dziecirozmowawiekcenterprzedszkole
echo 0 - powrot
echo 1 - Jak tam w przedszkolu?
echo 2 - Masz cos ciekawego od kolegow?
set /p "wybor=>> "
if %wybor%==1 goto dziecirozmowawiekcenterprzedszkole1
if %wybor%==2 goto dziecirozmowawiekcenterprzedszkole2
if %wybor%==0 goto dziecirozmowastart

:dziecirozmowawiekcenterrozwojmowy
echo JAK TAM? Rozumiesz bardziej swiat?
echo Dziecko: Tak
goto dziecirozmowastart

:dziecisklep
cls
start cmd.exe
if %wiekdziecka%==0 goto dziecipierwszapotrzeba
if %wiekdziecka%==1 goto dziecipierwszapotrzeba
if %wiekdziecka%==2 goto dziecipierwszapotrzeba
if %wiekdziecka%==3 goto dziecirozwojmowy
if %wiekdziecka%==4 goto dziecisklepprzedszkole
if %wiekdziecka%==5 goto dziecisklepprzedszkole
goto dzieciogolnysklep

:dziecipierwszapotrzeba
color 0B
if %kasa%==-10 goto debet
if %kasa%==-20 goto debet
if %kasa%==-30 goto debet
if %kasa%==-40 goto debet
if %kasa%==-50 goto debet
color 2F
cls
echo WITAJ W SKLEPIE PIERWSZEJ POTRZEBY DZIECI. MOZESZ KUPIC: 1 - wozek, 2 - lozko
echo Co chcesz?
set /p "wybor=>> "
set /a kasa=kasa-10
color 1F
goto dzieci

:dziecirozwojmowy
cls
color 0B
if %kasa%==-10 goto debet
if %kasa%==-20 goto debet
if %kasa%==-30 goto debet
if %kasa%==-40 goto debet
if %kasa%==-50 goto debet
color 2F
echo WITAJ W SKLEPIE ROZWOJU MOWY DZIECI. MOZESZ KUPIC: 1 - samoczytajace sie ksiazki, 2 - gadajacy mis, 3 - plyty muzyczne
echo Co chcesz?
echo ______________________________________________________________________________________________________________________
echo ######################################################################################################################
set /p "wybor=TWOJ WYBOR: >> "
set /a kasa=kasa-10
color 1F
cls
goto dzieci

:dziecisklepprzedszkole
cls
echo ######################################################################################################################
echo ______________________________________________________________________________________________________________________
echo WITAJ W SKLEPIE DLA PRZEDSZKOLNYCH DZIECI...
echo Na tym etapie wazny jest rozwoj plastyczny dzieci, a takze bardziej zaawansowany rozwoj mowy.
echo Dziecko coraz bardziej sie integruje ze srodowiskiem.
ping localhost-n 2 >nul
color 0B
if %kasa%==-10 goto debet
if %kasa%==-20 goto debet
if %kasa%==-30 goto debet
if %kasa%==-40 goto debet
if %kasa%==-50 goto debet
color 1F
echo.
echo Mozesz kupic duzo rzeczy
echo 1 - Zestaw narzedzi do zaawansowanego rozwoju mowy
echo 2 - Jedzenie
echo 3 - Narzedzia do rozwoju plastycznego dzieci
echo 4 - Przedszkole
set /p "wybor=Wybor nalezy do ciebie: >>"
goto dzieci

:dzieciogolnysklep
color 0B
cls
goto moremainpage

:spacer
goto moremainpage

:dziecicreator
cls
set /a liczbadzieci=0+1
echo WITAJ %imie%!!!
echo **************************
echo Mam wazny komunikat:
ping localhost-n 2 >nul
start dzieci.vbs
echo Jak ma sie nazywac
set /p "imiedziecka=>> "
echo Utworzono
start dzieci.vbs
start dzieci.vbs
start dzieci.vbs
goto dzieci

:debet
cls
echo Niestety, ale zadluzyles sie o %kasa% MH
echo Musisz isc do pracy
pause>nul
cls
goto praca

:dziecipluswieku
cls
start cmd.exe
set /a wiekdziecka=wiekdziecka+1
goto dzieci

