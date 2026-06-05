object ImportForm: TImportForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Import'
  ClientHeight = 255
  ClientWidth = 591
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 120
  TextHeight = 17
  object LblLibName: TLabel
    Left = 10
    Top = 13
    Width = 86
    Height = 17
    Caption = 'Library Name:'
  end
  object TxtLibName: TEdit
    Left = 100
    Top = 10
    Width = 480
    Height = 25
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    TabOrder = 0
    Text = 'Resistors'
  end
  object LstFiles: TListBox
    Left = 100
    Top = 44
    Width = 480
    Height = 165
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    ItemHeight = 17
    TabOrder = 1
  end
  object BtnFile: TButton
    Left = 10
    Top = 44
    Width = 80
    Height = 30
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'File(s)...'
    TabOrder = 2
    OnClick = BtnFileClick
  end
  object BtnImport: TButton
    Left = 235
    Top = 217
    Width = 120
    Height = 30
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Start Import'
    TabOrder = 3
    OnClick = BtnImportClick
  end
  object OpenDlg: TOpenDialog
    DefaultExt = '.txt'
    Filter = 'Altium Output (*.txt)|*.txt'
    Options = [ofAllowMultiSelect, ofEnableSizing]
    Left = 8
    Top = 220
  end
end
