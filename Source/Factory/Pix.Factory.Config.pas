unit Pix.Factory.Config;

interface

uses
  Vcl.StdCtrls,
  System.SysUtils,
  Vcl.Forms,
  System.IniFiles;


type
  iFactoryConfig = interface
  ['{75E727FF-6A9A-41B2-95BF-42869B23B83E}']
    function Carregar: iFactoryConfig;
    function Salvar: iFactoryConfig;

    function Chave: string; overload;
    function Empresa: string; overload;
    function Cidade: string; overload;
    function Chave(AValue: string) : iFactoryConfig; overload;
    function Cidade(AValue: string) : iFactoryConfig; overload;
    function Empresa(AValue: string) : IFactoryConfig; overload;
    function Chave(var AValue: TEdit): iFactoryConfig; overload;
    function Empresa(var AValue: TEdit): IFactoryConfig; overload;
  end;

  TFactoryConfig = class(TInterfacedObject, iFactoryConfig)
  private
    FIniFile: TIniFile;

    FArquivo,
    FEmpresa,
    FCidade,
    FChave: String;
    procedure ForcarArquivo;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: iFactoryConfig;

    function Carregar: iFactoryConfig;
    function Salvar: iFactoryConfig;

    function Chave: string; overload;
    function Empresa: string; overload;
    function Cidade: string; overload;
    function Chave(AValue: string): iFactoryConfig; overload;
    function Empresa(AValue: string): iFactoryConfig; overload;
    function Cidade(AValue: string) : iFactoryConfig; overload;
    function Chave(var AValue: TEdit): iFactoryConfig; overload;
    function Empresa(var AValue: TEdit): iFactoryConfig; overload;
  end;

implementation

uses
  Pix.View.Config;

  { iFactoryConfig }

function TFactoryConfig.carregar: iFactoryConfig;
begin
  Result := Self;
  FChave := FIniFile.ReadString('configuracao', 'chave', '');
  FEmpresa := FIniFile.ReadString('configuracao', 'empresa', '');
  FCidade := FIniFile.ReadString('configuracao', 'cidade', '');
end;

function TFactoryConfig.Chave: string;
begin
  Result := FChave;
end;

function TFactoryConfig.Chave(AValue: string): iFactoryConfig;
begin
  Result := Self;
  FChave := AValue;
end;

function TFactoryConfig.Chave(var AValue: TEdit): iFactoryConfig;
begin
  Result := Self;
  AValue.Text := FChave;
end;

function TFactoryConfig.Cidade(AValue: string): iFactoryConfig;
begin
  Result := Self;
  FCidade := AValue;
end;

function TFactoryConfig.Cidade: string;
begin
  Result := FCidade;
end;

constructor TFactoryConfig.Create;
begin
  FArquivo := ExtractFilePath(Application.ExeName) + 'config.ini';

  if not FileExists(FArquivo) then
    ForcarArquivo;

  FIniFile := TIniFile.Create(FArquivo);
end;

destructor TFactoryConfig.Destroy;
begin
  FIniFile.DisposeOf;
  inherited;
end;

function TFactoryConfig.Empresa: string;
begin
  Result := FEmpresa;
end;

function TFactoryConfig.Empresa(AValue: string): iFactoryConfig;
begin
  Result := Self;
  FEmpresa := AValue;
end;

class function TFactoryConfig.New: iFactoryConfig;
begin
  Result := Self.Create;
end;

function TFactoryConfig.Salvar: iFactoryConfig;
begin
  Result := Self;

  FIniFile.WriteString('configuracao', 'chave', FChave);
  FIniFile.WriteString('configuracao', 'empresa', FEmpresa);
  FIniFile.WriteString('configuracao', 'cidade', FCidade);
end;

function TFactoryConfig.Empresa(var AValue: TEdit): iFactoryConfig;
begin
  Result := Self;
  AValue.Text := FEmpresa;
end;

procedure TFactoryConfig.ForcarArquivo;
var
  LLocal : TextFile;
begin
  if not FileExists(FArquivo) then
  begin
    AssignFile(LLocal, FArquivo);
    Rewrite(LLocal, FArquivo);
    Append(LLocal);
    Close(LLocal);
  end;
end;

end.
