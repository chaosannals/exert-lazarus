unit formpage;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs;

type
  TFormPageNavEventHandle = procedure(Sender: TObject; Target: string) of object;

  { TFormPage }

  TFormPage = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
  protected
    FOnNav: TFormPageNavEventHandle;
  public
    property OnNav: TFormPageNavEventHandle
      read FOnNav
      write FOnNav;
  end;

var
  Form4: TFormPage;

implementation

{$R *.lfm}

{ TFormPage }

procedure TFormPage.FormCreate(Sender: TObject);
begin

end;

end.

