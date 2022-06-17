unit TD.Factories.QrCode;

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
    function Chave(AValue: string) : iFactoryConfig; overload;
    function Empresa(AValue: string) : IFactoryConfig; overload;
    function Chave(var AValue: TEdit): iFactoryConfig; overload;
    function Empresa(var AValue: TEdit): IFactoryConfig; overload;
  end;

  TFactoryConfig = class(TInterfacedObject, iFactoryConfig)
  private
    FIniFile: TIniFile;

    FArquivo,
    FEmpresa,
    FChave: String;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: iFactoryConfig;

    function Carregar: iFactoryConfig;
    function Salvar: iFactoryConfig;

    function Chave: string; overload;
    function Empresa: string; overload;
    function Chave(AValue: string): iFactoryConfig; overload;
    function Empresa(AValue: string): iFactoryConfig; overload;
    function Chave(var AValue: TEdit): iFactoryConfig; overload;
    function Empresa(var AValue: TEdit): iFactoryConfig; overload;
  end;

implementation

uses
  TD.View.Config;

  { iFactoryConfig }

function TFactoryConfig.carregar: iFactoryConfig;
begin
  Result := Self;
  FChave := FIniFile.ReadString('configuracao', 'chave', '');
  FEmpresa := FIniFile.ReadString('configuracao', 'empresa', '');
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

constructor TFactoryConfig.Create;
begin
  FArquivo := ExtractFilePath(Application.ExeName) + 'config.ini';

  if not FileExists(FArquivo) then
    raise
     Exception.Create('Arquivo de configuração inexistente');

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
end;

function TFactoryConfig.Empresa(var AValue: TEdit): iFactoryConfig;
begin
  Result := Self;
  AValue.Text := FEmpresa;
end;

end.
