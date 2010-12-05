object SettingsForm: TSettingsForm
  Left = 0
  Top = 0
  Caption = 'Settings'
  ClientHeight = 297
  ClientWidth = 434
  Color = clBtnFace
  Constraints.MinHeight = 330
  Constraints.MinWidth = 450
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Background: TSpTBXPanel
    Left = 0
    Top = 0
    Width = 434
    Height = 297
    Caption = 'Background'
    Align = alClient
    Padding.Left = 5
    Padding.Top = 5
    Padding.Right = 5
    Padding.Bottom = 5
    TabOrder = 0
    Borders = False
    TBXStyleBackground = True
    object Footer: TSpTBXPanel
      AlignWithMargins = True
      Left = 5
      Top = 259
      Width = 424
      Height = 33
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alBottom
      UseDockManager = True
      TabOrder = 0
      Borders = False
      object ButtonOk: TSpTBXButton
        AlignWithMargins = True
        Left = 187
        Top = 3
        Width = 114
        Height = 27
        Action = Ok
        Align = alRight
        TabOrder = 0
        Images = MainForm.Images
        ImageIndex = 8
      end
      object ButtonCancel: TSpTBXButton
        AlignWithMargins = True
        Left = 307
        Top = 3
        Width = 114
        Height = 27
        Action = Cancel
        Align = alRight
        TabOrder = 1
        Images = MainForm.Images
        ImageIndex = 9
      end
    end
    object SpTBXGroupBox1: TSpTBXGroupBox
      AlignWithMargins = True
      Left = 8
      Top = 8
      Width = 418
      Height = 145
      Caption = 'Inspector settings'
      Align = alTop
      TabOrder = 1
      DesignSize = (
        418
        145)
      object PreviewLabel: TSpTBXEdit
        Left = 16
        Top = 52
        Width = 387
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
        Text = 'Pr'#233'-num'#233'risation'
      end
      object ScanLabel: TSpTBXEdit
        Left = 16
        Top = 107
        Width = 387
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 1
        Text = 'Num'#233'risation'
      end
      object SpTBXLabel1: TSpTBXLabel
        Left = 16
        Top = 24
        Width = 112
        Height = 22
        Caption = 'Preview label text'
        Images = MainForm.Images
        ImageIndex = 6
      end
      object SpTBXLabel2: TSpTBXLabel
        Left = 16
        Top = 79
        Width = 97
        Height = 22
        Caption = 'Scan label text'
        Images = MainForm.Images
        ImageIndex = 1
      end
    end
    object SpTBXGroupBox2: TSpTBXGroupBox
      AlignWithMargins = True
      Left = 8
      Top = 159
      Width = 418
      Height = 91
      Caption = 'Notification settings'
      Align = alTop
      TabOrder = 2
      DesignSize = (
        418
        91)
      object ScanSound: TSpTBXComboBox
        Left = 16
        Top = 52
        Width = 387
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        ItemHeight = 13
        TabOrder = 1
      end
      object SpTBXLabel3: TSpTBXLabel
        Left = 16
        Top = 24
        Width = 112
        Height = 22
        Caption = 'Sound notification'
        Images = MainForm.Images
        ImageIndex = 10
      end
    end
  end
  object FormStorage: TJvFormStorage
    AppStorage = MainForm.AppStorage
    AppStoragePath = 'Settings\'
    Options = []
    StoredProps.Strings = (
      'PreviewLabel.Text'
      'ScanLabel.Text'
      'ScanSound.Text')
    StoredValues = <>
    Left = 352
    Top = 8
  end
  object Actions: TActionList
    Left = 384
    Top = 8
    object Add: TAction
      Caption = 'Add'
      ImageIndex = 179
    end
    object Remove: TAction
      Caption = 'Remove'
      ImageIndex = 471
    end
    object ChoosePath: TAction
      Caption = 'ChoosePath'
    end
    object Ok: TAction
      Caption = 'Ok'
      ImageIndex = 1118
      OnExecute = OkExecute
    end
    object Cancel: TAction
      Caption = 'Cancel'
      ImageIndex = 143
      OnExecute = CancelExecute
    end
    object Browse: TAction
      Caption = 'Browse'
      ImageIndex = 124
    end
    object Edit: TAction
      Caption = 'Edit'
      ImageIndex = 51
    end
  end
end
