program brookdemo;

{$mode objfpc}{$H+}

uses
{$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
{$ENDIF}{$ENDIF}
  BrookApplication, Brokers, unit1, unit2, unit3, unit4;

begin
  Application.CreateForm(TBrookDataModule1, BrookDataModule1);
  Application.Run;
end.