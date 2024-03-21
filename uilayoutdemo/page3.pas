unit page3;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  formpage;

type

  { TForm3 }

  TForm3 = class(TFormPage)
    Button1: TButton;
    Image1: TImage;
    Shape1: TShape;
    Shape2: TShape;
    procedure Button1Click(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Shape2ChangeBounds(Sender: TObject);
  private

  public

  end;

var
  Form3: TForm3;

implementation

{$R *.lfm}

{ TForm3 }

procedure TForm3.Image1Click(Sender: TObject);
begin

end;

procedure TForm3.Button1Click(Sender: TObject);
begin
  FOnNav(Sender, 'unit2');
end;

procedure TForm3.Shape2ChangeBounds(Sender: TObject);
begin
  FOnNav(Sender, 'unit2');
end;

end.

