unit Pix.View.Principal;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.UITypes,
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
  cxButtons;

type
  TPixViewPrincipal = class(TForm)
    pnContent: TPanel;
    pnHeader: TPanel;
    pnASide: TPanel;
    Image1: TImage;
    QRCode: TImage;
    btnClose: TcxButton;
    btnConfig: TcxButton;
    Button1: TButton;
    edValor: TEdit;
    Label2: TLabel;
    procedure btnCloseClick(Sender: TObject);
    procedure btnConfigClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private

  public

  end;

var
  PixViewPrincipal: TPixViewPrincipal;

implementation

uses
  Pix.View.Config, Pix.Factory.Pix, Pix.Factory.Config;

{$R *.dfm}

procedure TPixViewPrincipal.btnConfigClick(Sender: TObject);
begin
  if not Assigned(PixViewConfig) then
    Application.CreateForm(TPixViewConfig, PixViewConfig);

  PixViewConfig.Parent := pnContent;
  PixViewConfig.Show;
end;

procedure TPixViewPrincipal.Button1Click(Sender: TObject);
var
  LConfig: iFactoryConfig;
begin
  LConfig := TFactoryConfig
    .New.
    Carregar;

  TPixFactory
    .New
    .Chave(LConfig.Chave)
    .Beneficiario(LConfig.Empresa)
    .CidadeBeneficiario(LConfig.Cidade)
    .Valor(edValor.Text)
    .Imagem(QRCode.Picture)
    .Gerar;
end;

procedure TPixViewPrincipal.btnCloseClick(Sender: TObject);
begin
  if MessageDlg('Deseja realmente sair?', mtConfirmation, mbYesNo, 1) = mrYes then
    Close;
end;

end.
