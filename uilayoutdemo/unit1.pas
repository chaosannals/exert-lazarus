unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, unit2, LazLogger, unit3;

type

  { TForm1 }

  TForm1 = class(TForm)
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  current: TForm;
  form2: TForm2;
  form3: TForm3;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormActivate(Sender: TObject);
begin
  debugln(['FormActivate ', self]);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  debugln(['FormCreate ', Self]);
  form2 := TForm2.Create(Application);
  with form2 do begin
      SetBounds(0, 0, Self.Width, Self.height);
      Parent := Self;
      Visible := true;
  end;
  current := form2;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  current.SetBounds(0, 0, Self.Width, Self.height);

end;

end.

