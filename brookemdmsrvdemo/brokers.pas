unit Brokers;

{$mode objfpc}{$H+}

interface

uses
  BrookFCLHttpDaemonBroker, BrookUtils;

implementation

initialization
  BrookSettings.Port := 28080;

end.
