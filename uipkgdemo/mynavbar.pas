unit MyNavbar;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, ExtCtrls;

type
  TMyNavbar = class(TPanel)
  private

  protected

  public

  published

  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Standard',[TMyNavbar]);
end;

end.
