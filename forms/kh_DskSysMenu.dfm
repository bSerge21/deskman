object fmDskSysMenu: TfmDskSysMenu
  Left = 1303
  Top = 267
  BorderStyle = bsNone
  Caption = 'Dsk SysMenu'
  ClientHeight = 215
  ClientWidth = 201
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  KeyPreview = True
  OldCreateOrder = False
  OnClose = FormClose
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 201
    Height = 215
    Align = alClient
    BorderWidth = 2
    TabOrder = 0
    object ListBox1: TListBox
      Left = 3
      Top = 3
      Width = 195
      Height = 209
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvRaised
      Color = clMenu
      ItemHeight = 13
      TabOrder = 0
      OnClick = ListBox1Click
    end
  end
end
