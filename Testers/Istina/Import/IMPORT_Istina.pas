//****************************************************************************
// Unit Name: IMPORT_Common
//****************************************************************************
// This file is auto generated with paxCompiler engine.                       
// Import mode: global import.
// ---------------------------------------------------------------------------
// Site: http://www.paxcompiler.com                                           
// Author: Alexander Baranovsky (paxscript@gmail.com)                         
// ---------------------------------------------------------------------------
// Copyright (c) Alexander Baranovsky, 2014.                                  
// ---------------------------------------------------------------------------
// Portion copyright Full Circle Development Ltd.                             
// Content: initial design of importer.                                       
// ---------------------------------------------------------------------------
// Code Version: 1.1                                                   
//****************************************************************************

unit IMPORT_Istina;
interface

//uses
//	TESTER_ISTINA;

procedure Register_Istina(P:Pointer);

implementation

uses
  IMP_TESTER_ISTINA_GLOBAL,
  IMP_TESTER_ISTINA;

procedure Register_Istina(P:Pointer);
begin
  Register_TESTER_ISTINA_GLOBAL;
  Register_TESTER_ISTINA(P);
end;

end.
