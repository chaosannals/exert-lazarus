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
    httpServerStatusLabel: TLabel;
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
  if (HttpServerStatusLabel.Caption = 'Close') or (HttpServerStatusLabel.Caption = '[None]') then
  begin
    myThread.Start2;
  end else begin
    myThread.Drop;
    myThread := TMyHttpServer.Create(True);
    myThread.OnStatusTextChanged := @OnMyThreadStatusChanged;
  end;
end;

procedure TMainForm.OnMyThreadStatusChanged(sender: TObject; status: string);
begin
  if status = 'Close' then begin
     HttpServerButton.Caption := '启动 HTTP 服务';
  end else begin
     HttpServerButton.Caption := '关闭 HTTP 服务';
  end;

  HttpServerStatusLabel.Caption := status;
end;

end.

