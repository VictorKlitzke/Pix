unit TD.View.QrCode;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  cxGraphics,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  Vcl.Menus,
  dxSkinsCore,
  dxSkinsDefaultPainters,
  dxGDIPlusClasses,
  Vcl.StdCtrls,
  cxButtons,
  TD.Factories.QrCode;

type
  TQrCode = class(TForm)
    pnContent: TPanel;
    pnHeader: TPanel;
    pnASide: TPanel;
    Image1: TImage;
    QRCode: TImage;
    btnClose: TcxButton;
    btnConfig: TcxButton;
    procedure btnCloseClick(Sender: TObject);
    procedure btnConfigClick(Sender: TObject);

  private

  public

  end;

var
  QrCode: TQrCode;

implementation

uses
  TD.View.Config;

{$R *.dfm}

procedure TQrCode.btnConfigClick(Sender: TObject);
begin
  if Assigned(config) then FreeAndNil(config);
  if not Assigned(config) then
    Application.CreateForm(Tconfig, config);

    config.Parent := pnContent;
    config.Show;
end;

procedure TQrCode.btnCloseClick(Sender: TObject);
begin
  if MessageDlg('Deseja realmente sair?', mtConfirmation, mbYesNo, 1) = mrYes then
    Close;
end;

end.
