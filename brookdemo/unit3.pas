unit Unit3;

{$mode objfpc}{$H+}

interface

uses
  BrookAction;

type

  { TGogogo }

  TGogogo = class(TBrookAction)
  public
    procedure Get; override;
  end;

implementation

{ TGogogo }

procedure TGogogo.Get;
begin
  Write('Your content here ...333333');
end;

initialization
  TGogogo.Register('/gogogo');

end.
