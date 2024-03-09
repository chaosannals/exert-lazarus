unit Brokers;

{$mode objfpc}{$H+}

interface

uses
  BrookFCLHttpAppBroker, BrookUtils, BrookHttpConsts, Classes, SysUtils;

const
  PUBLIC_HTML = 'F:\.github\exlzr\brookdemo\';

implementation

initialization
  BrookSettings.Port := 38080;
  BrookSettings.Charset := BROOK_HTTP_CHARSET_UTF_8;
  BrookSettings.Page404File := PUBLIC_HTML + '404.html';
  BrookSettings.Page500File := PUBLIC_HTML + '500.html';

end.