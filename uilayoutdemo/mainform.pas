unit mainform;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, pageflow, LazLogger, unit3, formpage;

type

  { TForm1 }

  TForm1 = class(TForm)
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure NavPage(Sender: TObject; Target: string);
  private

  public

  end;

var
  Form1: TForm1;
  current: TFormPage;
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

  // 初始化 form2
  form2 := TForm2.Create(Application);
  with form2 do begin
      SetBounds(0, 0, Self.Width, Self.height);
      Parent := Self;
      Visible := false;
  end;

  // 初始化 form3
  form3 := TForm3.Create(Application);
  with form3 do begin
      SetBounds(0, 0, Self.Width, Self.height);
      Parent := Self;
      Visible := false;
  end;

  current := form2;
  with current do begin
    Visible:= true;
    OnNav := @NavPage;
  end;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  current.SetBounds(0, 0, Self.Width, Self.height);

end;

procedure TForm1.NavPage(Sender: TObject; Target: string);
begin
  current.Visible:= false;
  case Target of
  'unit2':begin
      current := form2;
  end;
  'unit3':begin
      current := form3;
  end;
  else begin
      current := form2;
  end;
  end;

  DebugLn('nav to', Target);
  with current do begin
    Visible:= true;
    OnNav := @NavPage;
  end;
end;

end.

