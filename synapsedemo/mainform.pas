unit mainform;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs,
  blcksock, sockets, Synautil, LazLogger, myhttpserver;

type

  { TMainForm }

  TMainForm = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    myThread: TMyHttpServer;
  public

  end;

var
  Form1: TMainForm;

implementation

{$R *.lfm}

procedure TMainForm.FormCreate(Sender: TObject);
begin
  myThread := TMyHttpServer.Create(True);
  myThread.Start;
end;

end.

