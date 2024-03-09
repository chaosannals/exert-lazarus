unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  BrookAction;

type

  { THello }

  THello = class(TBrookAction)
  public
    procedure Get; override;
  end;

implementation

{ THello }

procedure THello.Get;
begin
  Write('Your content here unit1');
end;

initialization
  THello.Register('/hello');

end.
