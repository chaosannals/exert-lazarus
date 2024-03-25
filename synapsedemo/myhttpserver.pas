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
  TMyHttpServerStatusChangedEventHandle = procedure(Sender: TObject; status: string) of object;

  TMyHttpServer = class(TThread)
    private
      statusText: string;
      ListenerSocket: TTCPBlockSocket;
      mutex: TMultiReadExclusiveWriteSynchronizer;

      procedure AttendConnection(ASocket: TTCPBlockSocket);
      procedure ShowStatus;
    protected
      FOnStatusTextChanged: TMyHttpServerStatusChangedEventHandle;

      procedure Execute; override;
    public
      constructor Create(createSuspended: boolean);
      procedure Start2();
      procedure Drop();

      function Status(): string;

      property OnStatusTextChanged: TMyHttpServerStatusChangedEventHandle
        read FOnStatusTextChanged
        write FOnStatusTextChanged;
  end;

implementation

constructor TMyHttpServer.Create(CreateSuspended: boolean);
begin
  FreeOnTerminate := True;
  mutex := TMultiReadExclusiveWriteSynchronizer.Create;
  inherited Create(CreateSuspended);
end;

procedure TMyHttpServer.ShowStatus;
begin
  DebugLn('server status: %s', statusText);
end;

function TMyHttpServer.Status(): string;
begin
  mutex.Beginread;
  result := statusText;
  mutex.Endread;
end;

procedure TMyHttpServer.Execute;
var
   ConnectionSocket: TTCPBlockSocket;
   ClientSocket: TSocket;
begin
   //Syncharonize(@ShowStatus);
   ListenerSocket := TTCPBlockSocket.Create;
   ConnectionSocket := TTCPBlockSocket.Create;

   with ListenerSocket do begin
     CreateSocket;
     SetLinger(true, 10);
     Bind('0.0.0.0', '15000');
     Listen;
   end;

   mutex.BeginWrite;
   statusText := 'Run';
   FOnStatusTextChanged(Self, statusText);
   mutex.EndWrite;

   repeat
     // 这个判断好似没有必要，Accept 会阻塞。
     //if ListenerSocket.CanRead(4) then
     begin
       // 有过至少一次请求后，
       // Accept 在 ListenerSocket 被关闭后，
       // 等下次请求才能触发并终止阻塞。
       ClientSocket := ListenerSocket.Accept;
       if ClientSocket >= 0 then begin
         ConnectionSocket.Socket := ClientSocket;
         AttendConnection(ConnectionSocket);
         ConnectionSocket.CloseSocket;
       end;
     end;
   until statusText = 'Closing';

   mutex.BeginWrite;
   statusText := 'Close';
   FOnStatusTextChanged(Self, statusText);
   ListenerSocket.Free;
   ConnectionSocket.Free;
   mutex.EndWrite;
end;

procedure TMyHttpServer.Start2();
begin
   mutex.BeginWrite;
   statusText := 'Start';
   FOnStatusTextChanged(Self, statusText);
   mutex.EndWrite;
   Start();
end;

procedure TMyHttpServer.Drop();
begin
  mutex.BeginWrite;
  statusText := 'Closing';
  FOnStatusTextChanged(Self, statusText);
  mutex.EndWrite;
  ListenerSocket.CloseSocket;
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

