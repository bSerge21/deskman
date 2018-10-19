object Form1: TForm1
  Left = 465
  Top = 278
  BorderStyle = bsSingle
  Caption = 'Form1'
  ClientHeight = 128
  ClientWidth = 137
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PopupMenu = PopupMenu1
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 137
    Height = 128
    ActivePage = TabSheet2
    Align = alClient
    TabIndex = 1
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Desktops'
      object ListBox1: TListBox
        Left = 0
        Top = 0
        Width = 129
        Height = 100
        Align = alClient
        ItemHeight = 13
        TabOrder = 0
        OnDblClick = ListBox1DblClick
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Keyhook'
      ImageIndex = 1
      object Label1: TLabel
        Left = 1
        Top = 1
        Width = 107
        Height = 13
        Caption = 'ESC - minimize window'
      end
      object Label3: TLabel
        Left = 1
        Top = 33
        Width = 83
        Height = 13
        Caption = 'ALT+Q - quit app'
      end
      object Label2: TLabel
        Left = 1
        Top = 17
        Width = 109
        Height = 13
        Caption = 'ALT+W - close window'
      end
      object Edit1: TEdit
        Left = 8
        Top = 56
        Width = 121
        Height = 21
        TabOrder = 0
      end
      object Button1: TButton
        Left = 16
        Top = 128
        Width = 81
        Height = 25
        Caption = 'Button1'
        TabOrder = 1
        OnClick = Button1Click
      end
      object Edit2: TEdit
        Left = 8
        Top = 80
        Width = 121
        Height = 21
        TabOrder = 2
      end
    end
  end
  object TrayMan1: TTrayMan
    StateImageIndex = -1
    AnimateTimeOut = 100
    ID = 0
    InitState = tsShow
    PopupMenu = PopupMenu1
    DefaultPopup = False
    OnClick = TrayMan1Click
    MinimizeToTray = True
    Left = 80
    Top = 32
  end
  object PopupMenu1: TPopupMenu
    Left = 32
    Top = 32
    object Desktops1: TMenuItem
      Caption = 'Desktops'
      object TMenuItem
      end
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Hiddenapps1: TMenuItem
      Caption = 'Hidden apps'
      Enabled = False
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Showapp1: TMenuItem
      Caption = 'Show app'
      OnClick = Showapp1Click
    end
    object Exit1: TMenuItem
      Caption = '-'
    end
    object exit2: TMenuItem
      Caption = 'Exit'
      OnClick = exit2Click
    end
  end
end
