program Pix;

uses
  Vcl.Forms,
  Pix.View.Config in 'Source\Views\Pix.View.Config.pas' {PixViewConfig},
  Pix.View.Principal in 'Source\Views\Pix.View.Principal.pas' {PixViewPrincipal},
  Pix.Factory.Config in 'Source\Factory\Pix.Factory.Config.pas',
  Pix.Factory.Pix in 'Source\Factory\Pix.Factory.Pix.pas',
  ACBrDelphiZXingQRCode in 'Source\ACBrDelphiZXingQRCode.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TPixViewPrincipal, PixViewPrincipal);
  Application.Run;
end.
