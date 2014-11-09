{******************************************************************************}
{                                   "хярхмю"                                   }
{                            цкнаюкэмше оепелеммше                             }
{                                                                              }
{                гюн мрж яУЕЛНРЕУМХЙХ Х хМРЕЦПЮКЭМШУ рЕУМНКНЦХИ                }
{                                     2014                                     }
{******************************************************************************}

unit TESTER_ISTINA_GLOBAL;

interface

CONST
//	{ пЕФХЛ РЕЯРЮ }
//  MADC        = 1;                                                               // южо
//  MHALT       = 2;                                                               // нЯРЮМНБЙЮ МЮ РЕЯРЕ
//  MLOOP       = 4;                                                               // гЮЖХЙКХРЭ РЕЯР
//  MSINCH      = 8;                                                               // яХМУПНМХГЮЖХЪ
//  MSTAT       = 16;                                                              // яРЮРХЯРХЙЮ

  MAXGROUP    = 10;
//  MAXPOINT    = 100;                                                             { вхякн рнвей мюакчдемхи }
  OPEN        = $20;                                                             { нрйпшрэ йюмюк ябъгх я реярепнл }
  maxtest     = 100;

TYPE
  EDIZM    = (V, NA, MKA, MA, MS, S, OM, KOM, MOM);                              { едхмхжш хглепемхъ }
  IMYA     = STRING[4];                                                          { хлъ реярю хкх оюпюлерпю }
  ITOGO    = (PASS, FAIL);                                                       { пегскэрюр хяошрюмхъ }
  NUMBER   = 1 .. 16;                                                            { мнлепю бшбнднб }
  PINS     = SET OF NUMBER;                                                      { лмнфеярбн бшбнднб }
  SCALE    = (S0V1, S1V, S10V, S100V, S1000V);                                   { дхюоюгнмш бнкэрлерпю }
  SELECTOR = (sON, sOFF);                                                        { бйкчвемхе пефхлнб }
  TYPMODE  = (U, I);                                                             { пефхл пюанрш хярнвмхйнб }

  ARLIM  = ARRAY [1 .. maxtest, 1 .. 2] OF REAL;
  arv    = array [1 .. maxtest] of INTEGER;

VAR
  RES_ADC                       : ARRAY [NUMBER] OF REAL;                        { пегскэрюр южо }
  LOWCOMP, UPCOMP               : WORD;                                          { пегскэрюр йнлоюпюрнпнб }
  EDIZMRES                      : ARRAY [NUMBER] OF EDIZM;                       { ед. хгл. пегскэрюрю }
  N                             : PINS;                                          { мнлепю бшбнднб }
  TESTNAM, TESTUN               : IMYA;                                          { хлъ х ед. хгл. реярю }
  TestNum                       : Word;                                                { мнлеп реярю }
  PULT, PLAN                    : Byte;                                          { мнлеп оскэрю х окюмю }
  PLN, PLANK                    : Byte;                                          { гюйюгюммши окюм }
  COM032                        : Word;                                          { люяйю йнл тсмйжхнммхп }
  COM116                        : WORD;                                          { люяйю йнл на-у сякнбхи }
  COMU,                                                                          { люяйх мюопъф хярнвмхйнб }
  CLAMPRANGE,                                                                    { дхюоюгнм рнйю CLAMP }
  PINNO,                                                                         { оепенопедекемхе бшбнднб }
  COM376                        : ARRAY [NUMBER] OF WORD;                        { люяйю йнлюмд гюдепф-пеф }
  NEWMODE                       : PINS;                                          { лмнф намнбк хярнвмхйнб }
  TOTALBRAK,                                                                     { унръ аш ндхм FAIL }
  TOTALADC,                                                                      { унръ аш ндхм опхгмюй ADC }
  GRIEF,                                                                         { опхгмюй FAILю мю реяре }
  STOP,                                                                          { HALT хкх LOOP }
  ADCSTAT,                                                                       { ADC хкх STAT }
  ADCB,                                                                          { гюлеп я южо }
  HALTB,                                                                         { нярюмнб мю реяре }
  LOOP,                                                                          { жхйк реярю }
  SINCH                         : BOOLEAN;                                       { яхмупнмхг мю реяре }
  STAT                          : BOOLEAN;                                       { мюанп ярюрхярхйх }
  MOD376                        : ARRAY [NUMBER] OF TYPMODE;                     { пефхл пюанрш хярнвмхйнб }
  FORCE,                                                                         { мнлхмюк хярнвмхйю }
  CLAMP,                                                                         { нцпюмхвемхе }
  DOWNLIMIT, UPLIMIT,                                                            { мнплш пюгапюйнбйх }
  TIMEON,                                                                        { бпелъ бйкчвемхъ }
  TIMEOFF                       : ARRAY [NUMBER] OF REAL;                        { бпелъ бшйкчвемхъ }
  LENTEST                       : REAL;                                          { дкхрекэмнярэ реярю }
  DEL3,                                                                          { гюдепфйю мю йнллсрюжхч }
  SMALLI                        : BOOLEAN;                                       { пефхл люкшу рнйнб }
  OFFPIN,                                                                        { нрйкчвемхе бшбнднб }
  LOADPIN,                                                                       { ондйкчвемхе мюцпсгйх }
  DLOADPIN                      : WORD;                                          { ондйк дхмюлхв мюцпсгйх }
  UNITF, UNITC, UNITONOFF,                                                       { едхмхжш хглепемхъ }
  UNITCOMP                      : ARRAY [NUMBER] OF EDIZM;
  UNITLEN                       : EDIZM;                                         { едхмхжш хглепемхъ }
  DISCRADC                      : ARRAY [NUMBER] OF REAL;                        { дхяйпермнярэ южо }
  TIMERANG                      : INTEGER;                                       { дхюоюгнм гюдеп бйк/бшйк }
  CHANGEDELAYRANG, CHANGELENGTH : BOOLEAN;                                       { ткюцх ялемш гюдепфей }
  RESHIGH, RESLOW,                                                               { пегскэрюр HIGH & LOW }
  RESCOM                        : WORD;                                          { пегскэрюр HIGH + LOW }
  LOW, HIGH,                                                                     { ткюцх пефхлю пюгFAIL-йх }
  CMPCHK,                                                                        { ткюц сяр йнло б пеф южо }
  SKIP                          : BOOLEAN;                                       { хцмнпхпнбюмхе убнярю }
  numtst                        : INTEGER;
  lim                           : ARLIM;
  limx                          : array [1 .. maxgroup] of ARLIM;
  pnno                          : arv;
  tsun                          : array [1 .. maxtest] of IMYA;
  tsnam                         : array [1 .. maxtest] of IMYA;
  izm_, curgrp, maxgrp, maxtst  : INTEGER;
  grpmsg                        : array [1 .. maxgroup] of string;               { мюгбюмхъ цпсоо }
  lastpl                        : INTEGER;
  endpr                         : BOOLEAN;                                       { ткюц йнмжю опнцпюллш }
  smenagr                       : BOOLEAN;                                       { ткюц ялемш цпсоо }
  shiftres                      : REAL;

implementation

end.
