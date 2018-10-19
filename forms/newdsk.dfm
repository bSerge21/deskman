object dlgnewdesktop: Tdlgnewdesktop
  Left = 421
  Top = 221
  BorderStyle = bsDialog
  Caption = 'New desktop'
  ClientHeight = 82
  ClientWidth = 246
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 72
    Height = 13
    Caption = 'Desktop name:'
  end
  object Edit1: TEdit
    Left = 88
    Top = 14
    Width = 145
    Height = 21
    TabOrder = 0
  end
  object BitBtn1: TBitBtn
    Left = 80
    Top = 48
    Width = 75
    Height = 25
    TabOrder = 1
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 160
    Top = 48
    Width = 75
    Height = 25
    TabOrder = 2
    Kind = bkCancel
  end
end
