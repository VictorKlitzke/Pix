object config: Tconfig
  Left = 0
  Top = 0
  Align = alClient
  BiDiMode = bdLeftToRight
  BorderStyle = bsNone
  ClientHeight = 431
  ClientWidth = 667
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = False
  ParentBiDiMode = False
  Position = poScreenCenter
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel: TPanel
    Left = 0
    Top = 0
    Width = 667
    Height = 431
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object Label3: TLabel
      Left = 0
      Top = 0
      Width = 667
      Height = 400
      Align = alClient
      Alignment = taCenter
      Caption = 'CONFIGURA'#199#213'ES'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      ExplicitWidth = 165
      ExplicitHeight = 30
    end
    object Label4: TLabel
      Left = 232
      Top = 174
      Width = 56
      Height = 17
      Caption = 'EMPRESA'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 232
      Top = 247
      Width = 39
      Height = 17
      Caption = 'CHAVE'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object SpeedButton1: TSpeedButton
      Left = 496
      Top = 197
      Width = 45
      Height = 21
      Caption = 'Gerar'
      OnClick = btnGerarClick
    end
    object btnReturn: TcxButton
      Left = 0
      Top = 400
      Width = 667
      Height = 31
      Align = alBottom
      Cancel = True
      OptionsImage.Glyph.SourceDPI = 96
      OptionsImage.Glyph.Data = {
        89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
        F40000000473424954080808087C086488000000097048597300000226000002
        26016C55B6EC0000001974455874536F667477617265007777772E696E6B7363
        6170652E6F72679BEE3C1A000001B0494441545885EDD73B6B54511007F0DFAC
        121B63B03120F868248595168A9585626329A41104F10B5809B67E00ED2CEDB4
        F18196F90682924610B409E9AC448C185C5DC7E26E96C3CDBA0FB97757D08181
        CB6598F9CF7F1EE79CC84CF394CE5CA3FF07300A40442C44C4E58838D42A82CC
        DCA558C24B24DE2386D935A1BB18888825ACE1EC0EC6993150CB3CF111A7DBCA
        3E33CD35F800C0BC8267A6E8072F6BDEC575AC3750E11E3633B33BCAE8699179
        1BFA0DAF701F2B4326CE46CB004AFD8A9B8AB10EACE211F6F419E9E2057E8E67
        78AC044EE024168AFFCF32F30A064D78153F0AA40FD069ACD3D9873BF85EC4B8
        511FC35641F4635CEC339BF88CA375835980B85BF8BF35CCA00EE25EC3008E14
        BE1FFFCEA804B1D5020B1FFABE37F60E6BDDCC7C1811DBB88D2799D9C44494F2
        05CBD81F3BCB605612110755AB1ED6E671235A2DBE5FCF9481883886375854F5
        C0B9464FB6318D77019B6AD3351503117158B54C262D5D072B3883F3AAD50CEF
        702A33B7A7C960119F4C76E88CD2E7581EF89D02C001D5FAFC93A03DBCC5B5BA
        DF694B701C974C5E829EEA56BD9E995B437DCE7A0FD4E5EF7D19FD33007E0130
        770296AEBAC76A0000000049454E44AE426082}
      SpeedButtonOptions.CanBeFocused = False
      SpeedButtonOptions.Flat = True
      TabOrder = 0
      OnClick = btnReturnClick
    end
    object edChave: TEdit
      Left = 232
      Top = 270
      Width = 241
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object btnSalvar: TButton
      Left = 496
      Top = 269
      Width = 45
      Height = 24
      Caption = 'Salvar'
      TabOrder = 2
      OnClick = btnsalvarClick
    end
    object edEmpresa: TEdit
      Left = 232
      Top = 197
      Width = 241
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
  end
end
