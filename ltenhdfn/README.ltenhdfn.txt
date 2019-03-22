Lietuvių papildytasis (Fn, deš. taškas) klaviatūros išdėstymas

PRISTATYMAS

   Ši klaviatūros išdėstymo tvarkyklė yra skirta visų pirma skreitiniams
(nešiojamiems) kompiuteriams, kuriuose netikusiai realizuota „Num Lock“ funkcija.

   Daugumoje skreitinių kompiuterių, dėl vietos trūkumo neturinčių tikros skaitmenų
dalies klaviatūroje, šios dalies klavišus galima emuliuoti, laikant nuspaustą Fn 
klavišą ir spaudžiant atitinkamus klavišus dešinėje klaviatūros pusėje. Dažnai ant
šių klavišų skaitmenys būna užrašyti kita spalva, negu visi įprastu būdu pasiekiami
simboliai (mėlyna, raudona, oranžine ar pan.) Tačiau tam, kad šis skaitmenų įvedimo
būdas veiktų, turi būti įjungta skaitmenų įvedimo skaitmenų dalimi („Num Lock“)
veiksena.

   Deja, dažnu atveju, nešiojamame kompiuteryje įjungus šią veikseną, atitinkamais
klavišais tampa nebeįmanoma įvesti raidžių, t.y., įjungus „Num Lock“, skaitmenų
įvedimas yra tarsi užfiksuojamas ir nebepriklauso nuo Fn klavišo būsenos. Kita
vertus, neįjungus „Num Lock“ būsenos, skaitmenis galima įvesti laikant kartu
nuspaustus Fn ir Lyg2 (Shift) klavišus. Abu šie variantai nėra labai patogūs, ypač
žinant, „kaip turėtų būti iš tikrųjų“. :) Šia klaviatūros tvarkykle ši problema
bandoma spręsti, atitinkamiems klavišams priskiriant skaitmenų įvedimo funkciją,
neatsižvelgiant į „Num Lock“ būseną.

REIKALAVIMAI PRIEŠ KOMPILIUOJANT

   Jeigu kažką šiame išdėstyme norite pakeisti, ar tiesiog domitės, kaip jis
padarytas (o jeigu skaitote šį failą, tai tikriausiai taip ir yra), Jums pravers
žinoti keletą dalykų. Ši tvarkyklė yra skirta „Windows“ sistemoms, o norint ją
sukompiliuoti, reikės kompiuteryje turėti:
  * Microsoft Keyboard Layout Creator 1.4 (toliau - MSKLC)
    http://www.microsoft.com/download/en/details.aspx?displaylang=en&id=22339
       Pastaba: tikėtina, jog viskas veiks ir su naujesne šios programos laida,
       jeigu tokia kada nors bus išleista, tačiau jokių garantijų nėra.
  * GNU Patch
    http://gnuwin32.sourceforge.net/packages/patch.htm
       Programos vykdomąjį failą išskleiskite į aplanką „Installer“.
       Pastaba: Mano naudojama OS šios programos vykdomąjį failą palaikė diegimo
       programa (tikriausiai dėl failo vardo) ir jai vykdyti reikalavo
       administratoriaus teisių.  Aš šią problemą apėjau, į patch.exe failą
       įtraukęs atitinkamą XML manifestą, nurodantį, jog papildomų teisių
       nereikia. Be šio pakeitimo netestavau, ar gensetup.bat scenarijus veikia
       normaliai, ar ne.
  * 7-Zip papildomi komponentai – 7zr.exe bei 7zS.sfx
    http://www.7-zip.org/download.html, nuoroda „7z Library, SFXs for installers,
    Plugin for FAR Manager“
       Šiuos failus išskleiskite į aplanką „Installer“.
       Pastaba: Šie failai reikalingi galutiniam vientisam įdiegimo paketui
       pagaminti. Jeigu tai nėra Jūsų tikslas, galite jų ir nesisiųsti.

KOMPILIAVIMAS

   Išdėstymo kompiliavimo procesas yra paprastas:
   1. Jeigu nenorėsite kurti vientiso įdiegimo paketo, šį žingsnį galite praleisti.
      Pirma atverkite *.klc failą MSKLC programa. ir pasirinkite meniu punktą
      Project -> Build DLL and Setup Package. Jeigu procesas praeis sėkmingai,
      programos darbiniame aplanke bus sukurtas aplankas tokiu pat vardu, kaip
      kompiliuojamas klaviatūros išdėstymas, kuriame rasite visus įdiegimo failus
      (setup.exe, *.msi) bei sukompiliuotas tvarkykles. Iš principo, šis žingsnis
      reikalingas tik tam, kad turėtumėte setup.exe ir *.msi failus, nes
      sukompiliuotos tvarkyklės neturės čia aprašomų „Num Lock“ funkcionalumo
      pakeitimų. Šiaip ar taip, visus failus nukopijuokite į tą patį aplanką,
      kuriame yra *.klc failas.
   2. Teksto rašykle atverkite gensetup.bat scenarijų ir patikrinkite, ar SET PATH
      eilutėje nurodytas teisingas KLC įdiegimo aplankas. Jeigu ne – pataisykite.
   3. Įvykdykite gensetup.bat scenarijų. Svarbiausi veiksmai, kuriuos jis atlieka:
      1) iš *.klc aprašo sugeneruoja *.c, *.def, *.h ir *.rc failus;
      2) *.c failui pritaiko faile ltenhdfn.c.diff nurodytą pataisą;
      3) iš pataisytų failų sugeneruoja tvarkykles visoms architektūroms;
      4) visus įdiegimo paketui reikalingus failus suarchyvuooja į 7zip archyvą
         ir padaro jį savaime išsiskleidžiančiu.
   4. Scenarijaus vykdymui pasibaigus, aplanke Installer rasite paruoštą įdiegimo
      paketą – failą LtEnhDFn.exe.

Sėkmės!
Rimas Kudelis, rq@rq.lt