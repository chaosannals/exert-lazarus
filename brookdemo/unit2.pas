unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  BrookAction;

type

  { TTest }

  TTest = class(TBrookAction)
  public
    procedure Get; override;
  end;

implementation

{ TTest }

procedure TTest.Get;
begin
  Write('Your content here ...2222222');
end;

initialization
  TTest.Register('/test');

end.
