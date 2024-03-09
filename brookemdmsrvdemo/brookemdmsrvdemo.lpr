program brookemdmsrvdemo;

{$mode objfpc}{$H+}

uses
{$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
{$ENDIF}{$ENDIF}
  BrookApplication, Brokers, unit1;

begin
  Application.CreateForm(TBrookDataModule1, BrookDataModule1);
  Application.Run;
end.