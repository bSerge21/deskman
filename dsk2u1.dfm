object Form1: TForm1
  Left = 478
  Top = 804
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'dsk2'
  ClientHeight = 116
  ClientWidth = 144
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  PopupMenu = PopupMenu1
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object ListBox1: TListBox
    Left = 0
    Top = 0
    Width = 144
    Height = 101
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 13
    ParentFont = False
    TabOrder = 0
    OnDblClick = ListBox1DblClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 101
    Width = 144
    Height = 15
    Align = alBottom
    Alignment = taLeftJustify
    BevelOuter = bvNone
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    PopupMenu = PopupMenu2
    TabOrder = 1
    OnMouseDown = Panel1MouseDown
    object lbTime: TLabel
      Left = 96
      Top = 2
      Width = 48
      Height = 11
      Caption = '00:00:00'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clNavy
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
      OnMouseUp = lbTimeMouseUp
      OnMouseLeave = lbTimeMouseLeave
    end
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 6
    Top = 8
    object Desktop1: TMenuItem
      Caption = 'New desktop...'
      OnClick = Desktop1Click
    end
    object Deletedesktop1: TMenuItem
      Caption = 'Delete desktop'
      OnClick = Deletedesktop1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Properties1: TMenuItem
      Caption = 'Properties...'
      OnClick = Properties1Click
    end
  end
  object TrayMan1: TTrayMan
    StateImageIndex = -1
    AnimateTimeOut = 100
    ImageList = sysmenuImages
    ID = 0
    InitState = tsShow
    Icon.Data = {
      0000010001002020000100000000A80800001600000028000000200000004000
      0000010008000000000080040000000000000000000000000000000000000000
      0000000080000080000000808000800000008000800080800000C0C0C000C0DC
      C000F0CAA6000020400000206000002080000020A0000020C0000020E0000040
      0000004020000040400000406000004080000040A0000040C0000040E0000060
      0000006020000060400000606000006080000060A0000060C0000060E0000080
      0000008020000080400000806000008080000080A0000080C0000080E00000A0
      000000A0200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0
      000000C0200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0
      000000E0200000E0400000E0600000E0800000E0A00000E0C00000E0E0004000
      0000400020004000400040006000400080004000A0004000C0004000E0004020
      0000402020004020400040206000402080004020A0004020C0004020E0004040
      0000404020004040400040406000404080004040A0004040C0004040E0004060
      0000406020004060400040606000406080004060A0004060C0004060E0004080
      0000408020004080400040806000408080004080A0004080C0004080E00040A0
      000040A0200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0
      000040C0200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0
      000040E0200040E0400040E0600040E0800040E0A00040E0C00040E0E0008000
      0000800020008000400080006000800080008000A0008000C0008000E0008020
      0000802020008020400080206000802080008020A0008020C0008020E0008040
      0000804020008040400080406000804080008040A0008040C0008040E0008060
      0000806020008060400080606000806080008060A0008060C0008060E0008080
      0000808020008080400080806000808080008080A0008080C0008080E00080A0
      000080A0200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0
      000080C0200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0
      000080E0200080E0400080E0600080E0800080E0A00080E0C00080E0E000C000
      0000C0002000C0004000C0006000C0008000C000A000C000C000C000E000C020
      0000C0202000C0204000C0206000C0208000C020A000C020C000C020E000C040
      0000C0402000C0404000C0406000C0408000C040A000C040C000C040E000C060
      0000C0602000C0604000C0606000C0608000C060A000C060C000C060E000C080
      0000C0802000C0804000C0806000C0808000C080A000C080C000C080E000C0A0
      0000C0A02000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C0
      0000C0C02000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A0008080
      80000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
      00000000000000000000000000000000A4A4A400000000000000000000000000
      0000000000000000000000000000B75D00A4A4A4000000000000000000000000
      000000000000000000000000AEAEB75D5D00A4A4A40000000000000000000000
      0000000000000000000000AEAEAEB75D5D5D00A4A4A400000000000000000000
      0000000000000000000000AEB713B75D5D5D5D00A4A4A4000000000000000000
      0000000000A4A4A4A4A400AE13AEB75D5D5D5D5D00A4A4A40000000000000000
      000000001300A4A4A4A400AEAEAEB75D5D5D5D5D5D00A4A4A400000000000000
      0000AEAE131300A4A4A400AEAE5D5D5D5D5D5D5D5D5D00A4A4A4000000000000
      AEAEAEAE13131300A4A4005D5DAEB75D5D5D5D5D5D5D5D00A4A4A40000000000
      AEB713AE1313131300A400AEAEAEB75D5D5D5D5D5D5D5D5D00A4A4A400000000
      AE13AEAE13131313130000AEB713B75D5D5D5D5D5D5D5D5D5D00A4A4A4000000
      AEAEAEAE1313131313AE13AE135DB75D5D5D5D5D5D5D5D5D5D00A4A400000000
      AEAE5D5D131313AEAEAE135D5D1313135D5D5D5D5D5D5D5D5D00000000000000
      5D5DAEAE13AEAE13135D131313AEAE5D135D5D5D5D5D5D5D5D00000000000000
      AEAEAEAE13AE135D5D1313AEAEAEFF5D5D135D5D5D5D5D5D5D00000000000000
      AEB713AE135D5D1313AEAEAEAEB7B7FF5D5D135D5D5D5D5D5D00000000000000
      AE13AE5D131313AEAEAEAEB7B7B7B7B7FF5D5D135D5D5D5D5D00000000000000
      AE5D5D1313AEAEAEAEB7B7B7B7B7B7B7B7FF5D5D135D135D5D00000000000000
      5D1313AEAEAEAEB7B7B7B7B7B7B7B7B7B7B7FF5D5D13135D5D00000000000000
      13AEAEAEAEB7B7B7AEAEB7B7B7B7B7B7B7B7B7FF5D13135D5D00000000000000
      AEAEAEB7B7B7AEAEFFFFAEB7B7B7B7B7B7AEAEAEAE1313135D00000000000000
      AEB7B7B7AEAEFFFFFFFFFFAEB7B7B7B7AE000000AEAE135D1300000000000000
      00B7B7FFFFFFFFFFFFFF08AEAEAEB7B70007F7F700AEAE5D5D00000000000000
      0000B7B7FFFFFFFF08F700000000AEB700FF005BF700B7FF5D00000000000000
      000000B7B7FFFFFFFFFFFFFFFFFFFFB7005BFF0000B7B7000000000000000000
      00000000B7B7FFFFFFFFFFFFFFB7B7B7B75BF700B75200520000000000000000
      0000000000B7B7FFFFFFFFB7B7B7B7B7B75B5B52521802000000000000000000
      000000000000B7B7FFB7B7B7B7B7B7B7B7525238FA3002000000000000000000
      00000000000000B7B7B7B7B7B7B7B7525238FA30303000000000000000000000
      0000000000000000B7B7B7B7B7000038FA303030000000000000000000000000
      000000000000000000B7B7000052000030300000520000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      07FFFFFC03FFFFF001FFFFF000FFFFF0007FFC00003FF000001FC000000F8000
      00078000000380000001800000038000000F8000000F8000000F8000000F8000
      000F8000000F8000000F8000000F8000000F8000000FC000000FE000000FF000
      001FF800003FFC00003FFE00003FFF00003FFF8000FFFFC081FFFFE7CFFF}
    PopupMenu = PopupMenu2
    DefaultPopup = False
    OnClick = TrayMan1Click
    MinimizeToTray = False
    Left = 40
    Top = 40
  end
  object PopupMenu2: TPopupMenu
    AutoHotkeys = maManual
    Images = PopupImageList
    Left = 72
    Top = 8
    object N6: TMenuItem
      Caption = '-'
      Visible = False
    end
    object Hiddenapps1: TMenuItem
      Caption = 'Hidden windows'
      Enabled = False
      Visible = False
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object QuickMenu1: TMenuItem
      Caption = 'Quick menu'
      object N2: TMenuItem
        Caption = '-'
      end
      object run1: TMenuItem
        Caption = 'Run...'
        OnClick = run1Click
      end
      object N5: TMenuItem
        Caption = '-'
      end
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object exit1: TMenuItem
      Caption = 'Exit'
      OnClick = exit1Click
    end
    object TMenuItem
      Caption = '-'
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 104
    Top = 40
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 40
    Top = 8
  end
  object XMLDoc: TXMLDocument
    Left = 6
    Top = 40
    DOMVendorDesc = 'MSXML'
  end
  object DirRunner1: TDirRunner
    FileMask = '*.lnk'
    ApplyMaskOnlyToFile = True
    FileSize = 0
    Attribute = 63
    Recurse = True
    UseEvent2 = False
    MaxLevel = 0
    IncludeUpdir = False
    IncludeRootDir = False
    Left = 72
    Top = 40
  end
  object PopupImageList: TImageList
    DrawingStyle = dsTransparent
    Left = 104
    Top = 8
  end
  object popupSysmenu: TPopupMenu
    AutoPopup = False
    Images = sysmenuImages
    Left = 16
    Top = 80
    object N7: TMenuItem
      Caption = '-'
    end
    object Close1: TMenuItem
      Caption = 'Close'
    end
  end
  object sysmenuImages: TImageList
    Left = 64
    Top = 80
    Bitmap = {
      494C010101000400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000808080000080800000000000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808000000080000080800000808000000000008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000808080008080800080808000808080000080800000808000008080000000
      0000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000808080000000
      8000000000008080800000808000808080000080800000808000008080000080
      8000000000008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000008000808080000000
      8000000080000000000080808000000080000080800000808000008080000080
      8000008080000000000080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000008080000000
      8000808080008080800000808000000080000000800000808000008080000080
      8000008080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000808080008080
      8000008080000000800080808000808080000080800000008000008080000080
      8000008080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000008000008080000000
      80008080800080808000C0C0C000C0C0C000C0C0C00000808000000080000080
      8000008080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000008000808080008080
      8000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000008080000000
      8000008080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000C0C0C000C0C0
      C00080808000FFFFFF00C0C0C000C0C0C000C0C0C00080808000808080000000
      8000000080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C0C0C000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF008080800080808000C0C0C000C0C0C000C0C0C0008080
      8000008080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C0C0C000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C0000080800000000000C0C0
      C000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C0C0
      C000FFFFFF00FFFFFF00C0C0C000C0C0C000C0C0C00000808000000000000080
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C0C0C000C0C0C000C0C0C000C0C0C0000000000000FF000000FF000000FF
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C0C0C00000000000000000000000000000FF0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FF3F000000000000FC1F000000000000
      FC0F000000000000C00700000000000000030000000000000001000000000000
      0003000000000000000300000000000000030000000000000003000000000000
      00030000000000008003000000000000C007000000000000E007000000000000
      F007000000000000F81F00000000000000000000000000000000000000000000
      000000000000}
  end
end
