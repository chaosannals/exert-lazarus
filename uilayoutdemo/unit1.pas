unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, unit2, LazLogger;

type

  { TForm1 }

  TForm1 = class(TForm)
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormActivate(Sender: TObject);
var
  form2: TForm2;
begin
  debugln('FormActivate');
  form2 := TForm2.Create(self);
  form2.Parent := self;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  form2: TForm2;
begin
  debugln('FormCreate');
  form2 := TForm2.Create(Self);
  form2.Parent := Self;

end;

end.

