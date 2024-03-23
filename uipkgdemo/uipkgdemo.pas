{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit uipkgdemo;

{$warn 5023 off : no warning about unused units}
interface

uses
  MyNavbar, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('MyNavbar', @MyNavbar.Register);
end;

initialization
  RegisterPackage('uipkgdemo', @Register);
end.
