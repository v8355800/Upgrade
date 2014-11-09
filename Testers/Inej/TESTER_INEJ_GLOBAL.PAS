{******************************************************************************}
{                                    "»Õ≈…"                                    }
{                            √ÀŒ¡¿À‹Õ€≈ œ≈–≈Ã≈ÕÕ€≈                             }
{                                                                              }
{                «¿Œ Õ“÷ —ıÂÏÓÚÂıÌËÍË Ë »ÌÚÂ„‡Î¸Ì˚ı “ÂıÌÓÎÓ„ËÈ                }
{                                     2014                                     }
{******************************************************************************}

unit TESTER_INEJ_GLOBAL;

interface

CONST
  maxgroup = 15;
  maxtest  = 100;

TYPE
  Parameter    = (Ice, Icbo, Iebo, h21e, Ucesat, Ubesat, Uceo, Uin, h21);
  Conductivity = (npn, pnp);
  Plug         = (normal, inverse);
  Rbe          = (r0, r1, r2, r3, r4, r5, r6, r7);
  Range        = (D0, D1, D10, D100, D500);
//  Units        = (no, nA, uA, mA, A, mV, V, mS, S, x3, x4, x5, x6, x7, x8, x9, x10, x11);
	Units        = (no, nA, uA, mA, mA9, mA10, A, mV, V, V8, mS, S, x3, x4, x5, x6, x7, x8, x9, x10, x11);
  Jumps        = (none, Osc, Grt, Lwr, Over);
  relay    = 1 .. 16;
  relays   = set of relay;
  ITOGO   = (PASS, FAIL);                                                        { –≈«”À‹“¿“ »—œ€“¿Õ»ﬂ }
  ARLIM   = ARRAY [1 .. maxtest, 1 .. 2] OF REAL;

VAR
  Connection         : Plug;

  PLAN, PLANK        : Byte;
  PULT               : Byte;
  MEASURE            : Boolean;
  PRINT              : Boolean;

  RES_ADC            : array [1 .. maxtest] of Real;
  ResultUnit         : String;
  sign               : Jumps;
  TESTNAM            : string;
  TESTUN             : String;                                                   { »Ãﬂ » ≈ƒ. »«Ã. “≈—“¿ }
  TESTNO             : Integer;                                                  { ÕŒÃ≈– “≈—“¿ }
  TOTALBRAK          : Boolean;                                                  { Õ≈œŒÕﬂ“Õ€… ¡–¿  }
  brakgroup          : Boolean;                                                  { œÓÔ‡Î ‚ „ÛÔÔÛ ·‡Í‡ }
  GRIEF              : Boolean;                                                  { œ–»«Õ¿  ¡–¿ ¿ Õ¿ “≈—“≈ }
  SKIP               : Boolean;                                                  { »√ÕŒ–»–Œ¬¿Õ»≈ ’¬Œ—“¿ }

//  NAMETESTB          : Boolean;                                                  { ‘À¿√ ƒÀﬂ œ≈◊¿“» }
//  LIST               : (ALL, ILL);                                               { ◊“Œ œ≈◊¿“¿“‹ }
  ostanov            : set of 1 .. maxtest;

  DOWNLIMIT, UPLIMIT : Real;                                                     { ÕŒ–Ã€ –¿«¡–¿ Œ¬ » }
  lastgrp            : Integer;
  curgrp             : Integer;
  maxgrp             : Integer;
  maxtst             : Integer;
//  pnno               : array [1 .. maxtest] of Integer;
  tsun               : array [1 .. maxtest] of String;
  tsnam              : array [1 .. maxtest] of String;
  grpmsg             : array [1 .. maxgroup] of String;                          { Ì‡Á‚‡ÌËˇ „ÛÔÔ }
  lim                : ARLIM;
  limx               : array [1 .. maxgroup] of ARLIM;
  smenagr, endpr     : Boolean;

implementation

end.
