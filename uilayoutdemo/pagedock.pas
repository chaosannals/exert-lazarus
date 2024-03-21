unit pagedock;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  AnchorDockPanel, formpage;

type

  { TForm5 }

  TForm5 = class(TFormPage)
    AnchorDockPanel1: TAnchorDockPanel;
    Button1: TButton;
    procedure AnchorDockPanel1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button1Resize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private

  public

  end;

var
  Form5: TForm5;

implementation

{$R *.lfm}

{ TForm5 }

procedure TForm5.Button1Resize(Sender: TObject);
begin

end;

procedure TForm5.FormCreate(Sender: TObject);
begin

end;

procedure TForm5.FormResize(Sender: TObject);
begin
  with AnchorDockPanel1 do begin

  end;
end;

procedure TForm5.AnchorDockPanel1Click(Sender: TObject);
begin

end;

procedure TForm5.Button1Click(Sender: TObject);
begin
  FOnNav(Sender, 'unit2');
end;

end.

