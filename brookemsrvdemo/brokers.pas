unit Brokers;

{$mode objfpc}{$H+}

interface

uses
  BrookFCLHttpAppBroker, BrookUtils;

implementation

initialization
  BrookSettings.Port := 18080;

end.
