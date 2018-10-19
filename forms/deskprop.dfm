object dlgDeskProp: TdlgDeskProp
  Left = 310
  Top = 240
  BorderStyle = bsDialog
  Caption = 'Desktop properties'
  ClientHeight = 208
  ClientWidth = 383
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
  object BitBtn1: TBitBtn
    Left = 304
    Top = 8
    Width = 75
    Height = 25
    TabOrder = 0
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 304
    Top = 40
    Width = 75
    Height = 25
    TabOrder = 1
    Kind = bkCancel
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 289
    Height = 201
    ActivePage = TabSheet1
    TabOrder = 2
    object TabSheet1: TTabSheet
      Caption = 'Main'
      object GroupBox1: TGroupBox
        Left = 8
        Top = 8
        Width = 265
        Height = 153
        Caption = 'GroupBox1'
        TabOrder = 0
        object Label1: TLabel
          Left = 8
          Top = 104
          Width = 50
          Height = 13
          Caption = 'Password:'
        end
        object Label2: TLabel
          Left = 8
          Top = 26
          Width = 72
          Height = 13
          Caption = 'Desktop name:'
        end
        object cbRunshell: TCheckBox
          Left = 8
          Top = 56
          Width = 97
          Height = 17
          Caption = 'Run shell'
          TabOrder = 0
        end
        object cbProptected: TCheckBox
          Left = 8
          Top = 80
          Width = 97
          Height = 17
          Caption = 'Proptected'
          TabOrder = 1
        end
        object edPwd: TEdit
          Left = 64
          Top = 100
          Width = 121
          Height = 21
          TabOrder = 2
        end
        object edname: TEdit
          Left = 86
          Top = 23
          Width = 169
          Height = 21
          TabOrder = 3
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Run list'
      ImageIndex = 1
      object SpeedButton1: TSpeedButton
        Left = 216
        Top = 8
        Width = 23
        Height = 22
        Flat = True
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          0400000000008000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
          5555555555555555555555555555555555555555555555555555550000000000
          5555500B8B8B8B8B055550F0B8B8B8B8B05550BF0B8B8B8B8B0550FBF0000000
          000550BFBFBFBFB0555550FBFBFBFBF0555550BFBFBF00055555550BFBF05555
          5555557000075555555555555555555555555555555555555555}
        OnClick = SpeedButton1Click
      end
      object ListBox1: TListBox
        Left = 0
        Top = 8
        Width = 209
        Height = 153
        ItemHeight = 13
        TabOrder = 0
        OnDblClick = ListBox1DblClick
        OnKeyDown = ListBox1KeyDown
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 96
    Top = 48
  end
end
