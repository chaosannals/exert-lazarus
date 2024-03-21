unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SQLite3Conn, SQLDB, Forms, Controls, Graphics, Dialogs,
  Buttons, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    TipLabel: TLabel;
    SqliteLinkEdit: TEdit;
    Label1: TLabel;
    SQLite3Connection1: TSQLite3Connection;
    SQLTransaction1: TSQLTransaction;
    procedure Button1Click(Sender: TObject);
    procedure SqliteLinkEditChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure SQLite3Connection1AfterConnect(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin

end;

procedure TForm1.Label1Click(Sender: TObject);
begin

end;

procedure TForm1.Button1Click(Sender: TObject);
var
  newFile : Boolean;
begin
  try
    SQLite3Connection1.DatabaseName := SqliteLinkEdit.Text;
    newFile := not FileExists(SQLite3Connection1.DatabaseName);
    if newFile then
    begin
      try
         TipLabel.Caption := 'TTTT';
         SQLite3Connection1.Open;
         SQLTransaction1.Active := true;

         SQLite3Connection1.ExecuteDirect('CREATE TABLE "Person"('+
                    ' "id" Integer NOT NULL PRIMARY KEY AUTOINCREMENT,'+
                    ' "Current_Time" DateTime NOT NULL,'+
                    ' "User_Name" Char(128) NOT NULL,'+
                    ' "Info" Char(128) NOT NULL);', SQLTransaction1);
         SQLite3Connection1.ExecuteDirect('CREATE UNIQUE INDEX "Person_id_idx" ON "Person"( "id" );', SQLTransaction1);

         SQLite3Connection1.ExecuteDirect('INSERT INTO Person("Current_Time", "User_Name", "Info") VALUES ("2024-01-01 00:00:01", "aaa", "bbb");', SQLTransaction1);

         SQLTransaction1.Commit;
      finally
      end;
    end;
  finally
  end;
end;

procedure TForm1.SqliteLinkEditChange(Sender: TObject);
begin

end;

procedure TForm1.SQLite3Connection1AfterConnect(Sender: TObject);
begin

end;

end.

