unit Pix.Factory.Pix;

interface

uses
  System.SysUtils,
  System.StrUtils,
  Vcl.Graphics,
  ACBrDelphiZXingQRCode;

type
  iPixFactory = interface
    ['{0E5761C0-0CAE-4E51-9153-F06EEFD6F97F}']
    function Chave(AValue: string): iPixFactory;
    function Valor(AValue: Real): iPixFactory; overload;
    function Valor(AValue: string): iPixFactory; overload;
    function Beneficiario(AValue: string): iPixFactory;
    function CidadeBeneficiario(AValue: string): iPixFactory;
    function DescricaoCobranca(AValue: string): iPixFactory;
    function IdentificacaoPagamento(AValue: string): iPixFactory;
    function Imagem(const AValue: TPicture): iPixFactory;
    function Gerar: iPixFactory;
    function Token: string;
  end;

  TPixFactory = class(TInterfacedObject, iPixFactory)
  private
    FChave,
    FBeneficiario,
    FCidadeBeneficiario,
    FDescricaoCobranca,
    FIdentificacaoPagamento: string;

    FValor: Real;
    FValorConvertido: string;

    FToken: string;
    [weak]
    FPicture: TPicture;

    procedure GerarToken;
    function CRC16CCITT(AValue: string): Word;
    procedure GerarPicture;
    function NormalizarValor(AValor: string): string;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: iPixFactory;

    function Chave(AValue: string): iPixFactory;
    function Valor(AValue: Real): iPixFactory; overload;
    function Valor(AValue: string): iPixFactory; overload;
    function Beneficiario(AValue: string): iPixFactory;
    function CidadeBeneficiario(AValue: string): iPixFactory;
    function DescricaoCobranca(AValue: string): iPixFactory;
    function IdentificacaoPagamento(AValue: string): iPixFactory;
    function Imagem(const AValue: TPicture): iPixFactory;
    function Gerar: iPixFactory;
    function Token: string;
  end;

implementation

{ TPixFactory }

function TPixFactory.Beneficiario(AValue: string): iPixFactory;
begin
  Result := Self;
  FBeneficiario := AValue;
end;

function TPixFactory.Chave(AValue: string): iPixFactory;
begin
  Result := Self;
  FChave := AValue;
end;

function TPixFactory.CidadeBeneficiario(AValue: string): iPixFactory;
begin
  Result := Self;
  FCidadeBeneficiario := AValue;
end;

function TPixFactory.CRC16CCITT(AValue: string): WORD;
const
  polynomial = $1021;
var
  crc: WORD;
  i, j: Integer;
  b: Byte;
  bit, c15: Boolean;
begin
  crc := $FFFF;
  for i := 1 to length(AValue) do
  begin
    b := Byte(AValue[i]);
    for j := 0 to 7 do
    begin
      bit := (((b shr (7 - j)) and 1) = 1);
      c15 := (((crc shr 15) and 1) = 1);
      crc := crc shl 1;
      if (c15 xor bit) then
        crc := crc xor polynomial;
    end;
  end;
  Result := crc and $FFFF;
end;

constructor TPixFactory.Create;
begin

end;

function TPixFactory.DescricaoCobranca(AValue: string): iPixFactory;
begin
  Result := Self;
  FDescricaoCobranca := AValue;
end;

destructor TPixFactory.Destroy;
begin

  inherited;
end;

function TPixFactory.Gerar: iPixFactory;
begin
  Result := Self;
  GerarToken;
  GerarPicture;
end;

procedure TPixFactory.GerarPicture;
var
  LQrCode: TDelphiZXingQRCode;
  LQRCodeBitmap: TBitmap;
  LRow, LColumn: Integer;
begin
  if not Assigned(FPicture) then
    Exit;

  LQrCode := TDelphiZXingQRCode.Create;
  LQRCodeBitmap := TBitmap.Create;
  try
    LQrCode.QuietZone := 1;
    LQrCode.Data := AnsiToUTF8(Trim(FToken));

    LQRCodeBitmap.Width := LQrCode.Columns;
    LQRCodeBitmap.Height := LQrCode.Rows;

    for LRow := 0 to LQrCode.Rows - 1 do
    begin
      for LColumn := 0 to LQrCode.Columns - 1 do
      begin
        if (LQrCode.IsBlack[LRow, LColumn]) then
          LQRCodeBitmap.Canvas.Pixels[LColumn, LRow] := clBlack
        else
          LQRCodeBitmap.Canvas.Pixels[LColumn, LRow] := clWhite;
      end;
    end;

    FPicture.Assign(LQRCodeBitmap);
  finally
    LQrCode.DisposeOf;
    LQRCodeBitmap.DisposeOf;
  end;
end;

{
  HFZ-Code
  Everton Pauli
  25/05/2022
  version: 0001.12
}
procedure TPixFactory.GerarToken;
var
  LLinkPix,
  LTemplink,
  LIdent,
  LTempident,
  LCRC16,
  LDescricao: String;

  LTamanhoChave,
  LTamanhoDesc,
  LTamanhoValor,
  LTamanhoBeneficiario,
  LTamanhoCidade,
  LTamanhoTempLink,
  LTamanhoIdentificador,
  LTamanhoCompletoIdentificador: Integer;
begin
  LLinkPix := '000201';
  LLinkPix := LLinkPix + '010211';
  LLinkPix := LLinkPix + '26';
  LTemplink := '0014br.gov.bcb.pix';
  LTamanhoChave := Length(FChave);

  if (LTamanhoChave > 0) and (LTamanhoChave <= 77) then
  begin
    if Length(IntToStr(LTamanhoChave)) = 1 then
      LTemplink := LTemplink + '01' + '0' + IntToStr(LTamanhoChave) + FChave
    else
      LTemplink := LTemplink + '01' + IntToStr(LTamanhoChave) + FChave;
  end
  else
    raise Exception.Create('Você deve cadastrar uma Chave PIX válida com tamanho máximo de 77 caracteres!');

  LDescricao := Copy(FDescricaoCobranca, 1, 25);
  LTamanhoDesc := Length(LDescricao);
  if (LTamanhoDesc > 0) and (LTamanhoDesc <= 72) then
  begin
    if Length(IntToStr(LTamanhoDesc)) = 1 then
      LTemplink := LTemplink + '02'+ '0' + IntToStr(LTamanhoDesc) + LDescricao
    else
      LTemplink := LTemplink + '02' + IntToStr(LTamanhoDesc) + LDescricao
  end;

  LTamanhoTempLink := Length(LTemplink);
  LLinkPix := LLinkPix + IntToStr(LTamanhoTempLink) + LTemplink;
  LLinkPix := LLinkPix + '52040000';
  LLinkPix := LLinkPix + '5303986';

  LTamanhoValor := Length(FValorConvertido);
  if (LTamanhoValor > 0) and (LTamanhoValor < 10) and (FValorConvertido <> '0.00') then
    LLinkPix := LLinkPix + '54' + '0' + IntToStr(LTamanhoValor) + FValorConvertido
  else if (LTamanhoValor >= 10) then
     LLinkPix := LLinkPix + '54' + IntToStr(LTamanhoValor) + FValorConvertido
  else
    raise Exception.Create('Você deve fazer o PIX com um VALOR válido e MAIOR que ZERO! ;)');

  LLinkPix := LLinkPix + '5802BR';
  LTamanhoBeneficiario := Length(FBeneficiario);
  if  (LTamanhoBeneficiario > 0) and (LTamanhoBeneficiario < 10) then
    LLinkPix := LLinkPix + '59' + '0' + IntToStr(LTamanhoBeneficiario) + FBeneficiario
  else if (LTamanhoBeneficiario >= 10) and (LTamanhoBeneficiario <= 25) then
    LLinkPix := LLinkPix + '59' + IntToStr(LTamanhoBeneficiario) + FBeneficiario
  else if (LTamanhoBeneficiario > 25) then
    raise Exception.Create('O Beneficiário não deve ultrapassar 25 caracteres!')
  else
    raise Exception.Create('Você deve cadastrar um Beneficiário com tamanho máximo de 25 caracteres!');

  LTamanhoCidade := Length(FCidadeBeneficiario);
  if (LTamanhoCidade > 0) and (LTamanhoCidade <= 15) then
  begin
    if Length(IntToStr(LTamanhoCidade)) = 1 then
      LLinkPix := LLinkPix + '60' + '0' + IntToStr(LTamanhoCidade) + FCidadeBeneficiario
    else
      LLinkPix := LLinkPix + '60' + IntToStr(LTamanhoCidade) + FCidadeBeneficiario;
  end
  else
    raise Exception.Create('Para gerar o PIX adicione uma CIDADE no Dados da Empresa!');


  LIdent := StringReplace(FIdentificacaoPagamento,' ','',[rfReplaceAll]);
  LTamanhoIdentificador := length(FIdentificacaoPagamento);
  if (LTamanhoIdentificador > 0) and (LTamanhoIdentificador <= 20) then
  begin
    if Length(IntToStr(LTamanhoIdentificador)) = 1 then
      LTempident := '05' + '0' +IntToStr(LTamanhoIdentificador) + FIdentificacaoPagamento
    else
      LTempident := '05' + IntToStr(LTamanhoIdentificador) + FIdentificacaoPagamento;
  end
  else
     LTempident := '05' + '03' + '***';

  LTamanhoCompletoIdentificador := length(LTempident);
  if (LTamanhoCompletoIdentificador > 0) then
  begin
    if Length(IntToStr(LTamanhoCompletoIdentificador)) = 1 then
      LLinkPix := LLinkPix + '62' + '0' + IntToStr(LTamanhoCompletoIdentificador) + LTempident
    else
      LLinkPix := LLinkPix + '62' + IntToStr(LTamanhoCompletoIdentificador) + LTempident
  end;


  LLinkPix := LLinkPix + '6304';
  LCRC16 := IntToHex(CRC16CCITT(LLinkPix),4);
  LLinkPix := LLinkPix + LCRC16;

  FToken := LLinkPix;
end;

function TPixFactory.IdentificacaoPagamento(AValue: string): iPixFactory;
begin
  Result := Self;
  FIdentificacaoPagamento := AValue;
end;

function TPixFactory.Imagem(const AValue: TPicture): iPixFactory;
begin
  Result := Self;
  FPicture := AValue;
end;

class function TPixFactory.New: iPixFactory;
begin
  Result := Self.Create;
end;

function TPixFactory.NormalizarValor(AValor: string): string;
begin
  Result := AValor.Replace('.', '').Replace(',', '.');
end;

function TPixFactory.Token: string;
begin
  Result := FToken;
end;

function TPixFactory.Valor(AValue: string): iPixFactory;
begin
  Result := Self;
  FValorConvertido := NormalizarValor(AValue);
end;

function TPixFactory.Valor(AValue: Real): iPixFactory;
begin
  Result := Self;
  FValor := AValue;
  FValorConvertido := NormalizarValor(FloatToStr(AValue));
end;

end.

