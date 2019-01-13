object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 679
  ClientWidth = 1041
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ScrollBox1: TScrollBox
    AlignWithMargins = True
    Left = 3
    Top = 119
    Width = 1035
    Height = 538
    Align = alClient
    Color = clWhite
    Ctl3D = False
    ParentColor = False
    ParentCtl3D = False
    TabOrder = 0
    object Image1: TImage
      Left = 18
      Top = 16
      Width = 105
      Height = 105
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1041
    Height = 116
    Align = alTop
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 1
    DesignSize = (
      1041
      116)
    object Label1: TLabel
      Left = 520
      Top = 30
      Width = 45
      Height = 13
      Caption = 'FontSize:'
    end
    object Label2: TLabel
      Left = 6
      Top = 65
      Width = 81
      Height = 13
      Caption = 'Chars to include:'
    end
    object Button2: TButton
      Left = 936
      Top = 8
      Width = 89
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Select Font...'
      TabOrder = 0
      OnClick = Button2Click
    end
    object RadioGroup1: TRadioGroup
      Left = 6
      Top = 8
      Width = 499
      Height = 49
      Caption = 'Font Rendering'
      Columns = 4
      ItemIndex = 0
      Items.Strings = (
        'AntiAliased'
        'ClearType'
        'ClearType natural'
        'Non Antialiased')
      TabOrder = 1
      OnClick = RadioGroup1Click
    end
    object SpinEdit1: TSpinEdit
      Left = 571
      Top = 28
      Width = 81
      Height = 22
      MaxValue = 99
      MinValue = 1
      TabOrder = 2
      Value = 1
      OnChange = SpinEdit1Change
    end
    object Memo1: TMemo
      Left = 93
      Top = 63
      Width = 559
      Height = 45
      Lines.Strings = (
        'Memo1')
      TabOrder = 3
      WordWrap = False
    end
    object Button1: TButton
      Left = 936
      Top = 70
      Width = 89
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Save Font...'
      TabOrder = 4
      OnClick = Button1Click
    end
    object Button3: TButton
      Left = 936
      Top = 39
      Width = 89
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Load Chars...'
      TabOrder = 5
      OnClick = Button3Click
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 660
    Width = 1041
    Height = 19
    Panels = <
      item
        Width = 50
      end>
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Left = 872
    Top = 8
  end
  object FileSaveDialog1: TFileSaveDialog
    DefaultExtension = 'pas'
    FavoriteLinks = <>
    FileTypes = <
      item
        DisplayName = 'Pascal Unit File'
        FileMask = '*.pas'
      end>
    Options = [fdoOverWritePrompt, fdoPathMustExist]
    Left = 816
    Top = 8
  end
  object FileOpenDialog1: TFileOpenDialog
    FavoriteLinks = <>
    FileTypes = <>
    Options = [fdoPathMustExist, fdoFileMustExist, fdoNoTestFileCreate]
    Left = 768
    Top = 8
  end
end
