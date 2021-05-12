object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Analise de imagens'
  ClientHeight = 611
  ClientWidth = 969
  Color = clHighlight
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button2: TButton
    Left = 503
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Analisar'
    TabOrder = 0
    OnClick = Button2Click
  end
  object JvFilenameEdit1: TJvFilenameEdit
    Left = 8
    Top = 8
    Width = 489
    Height = 21
    OnAfterDialog = JvFilenameEdit1AfterDialog
    TabOrder = 1
    Text = 'JvFilenameEdit1'
  end
  object rgTipo: TRadioGroup
    Left = 585
    Top = 5
    Width = 378
    Height = 35
    Caption = 'Tipo'
    Columns = 4
    ItemIndex = 0
    Items.Strings = (
      'Visual'
      'Faces (rostos)'
      'Explicito'
      'Comida')
    TabOrder = 2
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 56
    Width = 969
    Height = 555
    ActivePage = TabSheet1
    Align = alBottom
    TabOrder = 3
    object TabSheet1: TTabSheet
      Caption = 'imagem'
      ExplicitWidth = 281
      ExplicitHeight = 165
      object JvImage1: TJvImage
        Left = 0
        Top = 0
        Width = 961
        Height = 527
        Align = alClient
        Proportional = True
        Stretch = True
        ExplicitLeft = 8
        ExplicitTop = -42
        ExplicitWidth = 641
        ExplicitHeight = 569
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Resposta'
      ImageIndex = 1
      ExplicitWidth = 281
      ExplicitHeight = 165
      object resultado: TMemo
        Left = 0
        Top = 0
        Width = 961
        Height = 527
        Align = alClient
        TabOrder = 0
        ExplicitLeft = 48
        ExplicitTop = 32
        ExplicitWidth = 185
        ExplicitHeight = 89
      end
    end
  end
  object Button1: TButton
    Left = 368
    Top = 40
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 4
    Visible = False
    OnClick = Button1Click
  end
  object RESTClient1: TRESTClient
    Authenticator = OAuth2Authenticator1
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    AutoCreateParams = False
    BaseURL = 
      'https://gateway.watsonplatform.net/visual-recognition/api/v3/cla' +
      'ssify'
    Params = <>
    HandleRedirects = False
    Left = 704
    Top = 312
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Params = <>
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 712
    Top = 248
  end
  object RESTResponse1: TRESTResponse
    ContentType = 'application/json'
    Left = 712
    Top = 184
  end
  object OAuth2Authenticator1: TOAuth2Authenticator
    ResponseType = rtTOKEN
    TokenType = ttBEARER
    Left = 700
    Top = 120
  end
end
