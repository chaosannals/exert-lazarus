unit mainform;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  blcksock, sockets, Synautil, LazLogger, myhttpserver;

type

  { TMainForm }

  TMainForm = class(TForm)
    HttpServerButton: TButton;
    procedure HttpServerButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure OnMyThreadStatusChanged(sender: TObject; status: string);
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
  myThread.OnStatusTextChanged := @OnMyThreadStatusChanged;
end;

procedure TMainForm.HttpServerButtonClick(Sender: TObject);
begin
  if (HttpServerButton.Caption = 'Close') or (HttpServerButton.Caption = '启动HTTP服务') then
  begin
    myThread.Start2;
  end else begin
    myThread.Drop;
    myThread := TMyHttpServer.Create(True);
    myThread.OnStatusTextChanged := @OnMyThreadStatusChanged;
  end;
  //HttpServerButton.Caption := myThread.status;
end;

procedure TMainForm.OnMyThreadStatusChanged(sender: TObject; status: string);
begin
  HttpServerButton.Caption := status;
end;

end.

