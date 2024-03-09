program brookdemo;

{$mode objfpc}{$H+}

uses
{$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
{$ENDIF}{$ENDIF}
  BrookApplication, Brokers, demo;

begin
  Application.CreateForm(TBrookDataModule1, BrookDataModule1);
  Application.Run;
end.