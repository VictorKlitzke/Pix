unit Pix.View.Config;

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
  Pix.Factory.Config,
  Vcl.Buttons,
  System.UITypes;

type
  TPixViewConfig = class(TForm)
    Panel: TPanel;
    btnReturn: TcxButton;
    edChave: TEdit;
    btnSalvar: TButton;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    SpeedButton1: TSpeedButton;
    edEmpresa: TEdit;
    edCidade: TEdit;
    Label1: TLabel;
    procedure btnsalvarClick(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
    procedure btnReturnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public                               
    { Public declarations }
  end;

var
  PixViewConfig: TPixViewConfig;

implementation

{$R *.dfm}

procedure TPixViewConfig.btnReturnClick(Sender: TObject);
begin
  if MessageDlg('Deseja realmente voltar?', mtConfirmation, mbYesNo, 1) = mrYes then
    Close;
end;

procedure TPixViewConfig.btnsalvarClick(Sender: TObject);
begin
  TFactoryConfig
    .New
    .Empresa(edEmpresa.Text)
    .Chave(edChave.Text)
    .Cidade(edCidade.Text)
    .Salvar;
end;

procedure TPixViewConfig.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  PixViewConfig := nil;
end;

procedure TPixViewConfig.btnGerarClick(Sender: TObject);
begin
  TFactoryConfig
    .New
    .Carregar
    .Empresa(edEmpresa)
    .Chave(edChave)
    .Cidade(edCidade);
end;

end.
