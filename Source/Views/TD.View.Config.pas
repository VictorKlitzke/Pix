unit TD.View.Config;

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
  TD.Factories.QrCode,
  Vcl.Buttons,
  System.UITypes;

type
  Tconfig = class(TForm)
    Panel: TPanel;
    btnReturn: TcxButton;
    edChave: TEdit;
    btnSalvar: TButton;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    SpeedButton1: TSpeedButton;
    edEmpresa: TEdit;
    procedure btnsalvarClick(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
    procedure btnReturnClick(Sender: TObject);
  private
    { Private declarations }
  public                               
    { Public declarations }
  end;

var
  config: Tconfig;

implementation

{$R *.dfm}

procedure Tconfig.btnReturnClick(Sender: TObject);
begin
  if MessageDlg('Deseja realmente voltar?', mtConfirmation, mbYesNo, 1) = mrYes then
    Close;
end;

procedure Tconfig.btnsalvarClick(Sender: TObject);
begin
    TFactoryConfig
    .New
    .Empresa(edEmpresa.Text)
    .Chave(edChave.Text)
    .Salvar;
end;

procedure Tconfig.btnGerarClick(Sender: TObject);
begin
  TFactoryConfig
    .New
    .Carregar
    .Empresa(edEmpresa)
    .Chave(edChave);
end;

end.
