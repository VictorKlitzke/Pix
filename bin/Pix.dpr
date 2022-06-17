program Pix;

uses
  Vcl.Forms,
  TD.View.QrCode in '..\Source\Views\TD.View.QrCode.pas' {QrCode},
  TD.Factories.QrCode in '..\Source\Factories\TD.Factories.QrCode.pas',
  TD.View.Config in '..\Source\Views\TD.View.Config.pas' {config};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TQrCode, QrCode);
  Application.CreateForm(Tconfig, config);
  Application.Run;
end.
