unit myhttpserver;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, blcksock, sockets, Synautil,
  {$ifdef unix}
  cthreads, cmem,
  {$endif}
  LazLogger;

type
  TMyHttpServer = class(TThread)
    private
      statusText: string;

      procedure AttendConnection(ASocket: TTCPBlockSocket);
      procedure ShowStatus;
    protected
      procedure Execute; override;
    public
      constructor Create(createSuspended: boolean);
  end;

implementation

constructor TMyHttpServer.Create(CreateSuspended: boolean);
begin
  FreeOnTerminate := True;
  inherited Create(CreateSuspended);
end;

procedure TMyHttpServer.ShowStatus;
begin
  DebugLn('server status: %s', statusText);
end;

procedure TMyHttpServer.Execute;
var
   //newStatus: string;
   ListenerSocket: TTCPBlockSocket;
   ConnectionSocket: TTCPBlockSocket;
begin
   statusText := 'Start';
   //Syncharonize(@ShowStatus);
   statusText := 'Run';
   //while (not Terminated) do
   //end;
   ListenerSocket := TTCPBlockSocket.Create;
   ConnectionSocket := TTCPBlockSocket.Create;

   ListenerSocket.CreateSocket;
   ListenerSocket.SetLinger(true, 10);
   ListenerSocket.Bind('0.0.0.0', '15000');
   ListenerSocket.Listen;

   repeat
     if ListenerSocket.CanRead(1000) then
     begin
       ConnectionSocket.Socket := ListenerSocket.Accept;
       AttendConnection(ConnectionSocket);
       ConnectionSocket.CloseSocket
     end;
   until false;
   ListenerSocket.Free;
   ConnectionSocket.Free;
end;

procedure TMyHttpServer.AttendConnection(ASocket: TTCPBlockSocket);
var
   timeout: integer;
   s: string;
   method: string;
   uri: string;
   protocol: string;
   OutputDataString: string;
   ResultCode: integer;
begin
  timeout := 120000;

  DebugLn('received');
  // 解析 HTTP 头，空格隔开，如： GET /test HTTP/1.1
  s := ASocket.RecvString(timeout);
  method := fetch(s, ' ');
  uri := fetch(s, ' ');
  protocol := fetch(s, ' ');

  // 读取头部
  repeat
    s := ASocket.RecvString(timeout);
    DebugLn(s);
  until s = '';

  // 路由
  if uri = '/' then
  begin
    outputDataString := '{ "msg": "Ok" }';
    ASocket.SendString('HTTP/1.1 200' + CRLF);
    ASocket.SendString('Content-Type: application/json' + CRLF);
    ASocket.SendString('Connection-Length: ' + IntToStr(Length(outputDataString)) + CRLF);
    ASocket.SendString('Connection: close' + CRLF);
    //ASocket.SendString('Date: ' + Rfc822DateTime(now) + CRLF);
    ASocket.SendString('Server: Synapse Demo'+ CRLF);
    ASocket.SendString('' + CRLF);
    ASocket.SendString(outputDataString);
  end else begin
    ASocket.SendString('HTTP/1.1 404' + CRLF);
  end;
end;

end.

