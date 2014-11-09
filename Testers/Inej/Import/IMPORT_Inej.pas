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

unit IMPORT_Inej;
interface

//uses
//	TESTER_INEJ;

procedure Register_INEJ(P: Pointer);

implementation

uses
  IMP_TESTER_INEJ_GLOBAL,
  IMP_TESTER_INEJ;

procedure Register_INEJ(P: Pointer);
begin
  Register_TESTER_INEJ_GLOBAL;
  Register_TESTER_INEJ(P);
end;

end.
