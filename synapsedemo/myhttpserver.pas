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
     // 应该是和这个库的内部实现有关，这种写法很吊诡。
     // 因为如果不这么写，在不关闭 ListenerSocket 的情况下直接关闭程序，
     // 有一定几率触发，不是 ListenerSocket 读会失败，而是 ConnectionSocket 的读会失败。
     // 而且触发的点不同，都是空指针访问。加上此句就没问题。
     // 猜测，这条函数有副作用，会填充一个一定会让 Accept 成功的对象。
     // 即使这个对象是 Mock 假对象，用来结束使用。
     if ListenerSocket.CanRead(4) then
     begin
       // Accept 在 ListenerSocket 被关闭后，还是要等下次请求才能触发并终止阻塞。
       // 这里很奇怪，明明 ListenerSocket 被关闭后， Accept 还是有一次会通过的。
       // 这里也没判定，程序是会继续的，但是不报错。
       // 也就是存在最后一次通过是无效，但是一切正常的情况。
       ConnectionSocket.Socket := ListenerSocket.Accept;
       AttendConnection(ConnectionSocket);
       ConnectionSocket.CloseSocket;
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

