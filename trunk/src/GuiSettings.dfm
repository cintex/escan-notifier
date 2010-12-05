object SettingsForm: TSettingsForm
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Settings'
  ClientHeight = 387
  ClientWidth = 586
  Color = clBtnFace
  Constraints.MinHeight = 330
  Constraints.MinWidth = 450
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Background: TSpTBXPanel
    Left = 0
    Top = 0
    Width = 586
    Height = 387
    Caption = 'Background'
    Align = alClient
    Padding.Left = 5
    Padding.Top = 5
    Padding.Right = 5
    Padding.Bottom = 5
    TabOrder = 0
    Borders = False
    TBXStyleBackground = True
    ExplicitWidth = 434
    ExplicitHeight = 297
    object Footer: TSpTBXPanel
      AlignWithMargins = True
      Left = 5
      Top = 349
      Width = 576
      Height = 33
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alBottom
      UseDockManager = True
      TabOrder = 0
      Borders = False
      ExplicitTop = 259
      ExplicitWidth = 424
      object ButtonOk: TSpTBXButton
        AlignWithMargins = True
        Left = 339
        Top = 3
        Width = 114
        Height = 27
        Action = Ok
        Align = alRight
        TabOrder = 0
        Images = MainForm.Images
        ImageIndex = 8
        ExplicitLeft = 187
      end
      object ButtonCancel: TSpTBXButton
        AlignWithMargins = True
        Left = 459
        Top = 3
        Width = 114
        Height = 27
        Action = Cancel
        Align = alRight
        TabOrder = 1
        Images = MainForm.Images
        ImageIndex = 9
        ExplicitLeft = 307
      end
    end
    object SpTBXGroupBox1: TSpTBXGroupBox
      AlignWithMargins = True
      Left = 8
      Top = 8
      Width = 570
      Height = 224
      Caption = 'Inspector settings'
      Align = alTop
      TabOrder = 1
      ExplicitWidth = 418
      DesignSize = (
        570
        224)
      object PreviewLabel: TSpTBXEdit
        Left = 16
        Top = 116
        Width = 539
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
        Text = 'Preview scan in progress'
        OnChange = LabelChange
        ExplicitWidth = 387
      end
      object ScanLabel: TSpTBXEdit
        Left = 16
        Top = 171
        Width = 539
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 1
        Text = 'Scanning'
        OnChange = LabelChange
        ExplicitWidth = 387
      end
      object SpTBXLabel1: TSpTBXLabel
        Left = 16
        Top = 88
        Width = 92
        Height = 19
        Caption = 'Preview label text'
        Images = MainForm.Images
        ImageIndex = 6
      end
      object SpTBXLabel2: TSpTBXLabel
        Left = 16
        Top = 143
        Width = 77
        Height = 19
        Caption = 'Scan label text'
        Images = MainForm.Images
        ImageIndex = 1
      end
      object EpsonScanLanguage: TSpTBXComboBox
        Left = 16
        Top = 52
        Width = 539
        Height = 21
        Style = csDropDownList
        Anchors = [akLeft, akTop, akRight]
        ItemHeight = 13
        TabOrder = 4
        OnChange = EpsonScanLanguageChange
        Items.Strings = (
          '(Custom)'
          'Dutch'
          'English'
          'French'
          'German'
          'Italian'
          'Portuguese'
          'Russian'
          'Spanish'
          'Ukrainian')
        ExplicitWidth = 387
      end
      object SpTBXLabel4: TSpTBXLabel
        Left = 16
        Top = 24
        Width = 131
        Height = 22
        Caption = 'EPSON scan language'
        Images = MainForm.Images
        ImageIndex = 17
      end
    end
    object SpTBXGroupBox2: TSpTBXGroupBox
      AlignWithMargins = True
      Left = 8
      Top = 238
      Width = 570
      Height = 91
      Caption = 'Notification settings'
      Align = alTop
      TabOrder = 2
      ExplicitTop = 159
      ExplicitWidth = 418
      DesignSize = (
        570
        91)
      object ScanSound: TSpTBXComboBox
        Left = 16
        Top = 52
        Width = 507
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        ItemHeight = 13
        TabOrder = 1
        OnChange = ScanSoundChange
        ExplicitWidth = 355
      end
      object SpTBXLabel3: TSpTBXLabel
        Left = 16
        Top = 24
        Width = 92
        Height = 19
        Caption = 'Sound notification'
        Images = MainForm.Images
        ImageIndex = 10
      end
      object SoundTest: TSpTBXSpeedButton
        Left = 529
        Top = 52
        Width = 25
        Height = 21
        Action = Play
        Anchors = [akTop, akRight]
        Images = MainForm.Images
        ImageIndex = 15
        ExplicitLeft = 450
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
      'ScanSound.Text'
      'EpsonScanLanguage.ItemIndex')
    StoredValues = <>
    Left = 256
    Top = 8
  end
  object Actions: TActionList
    Images = MainForm.Images
    Left = 288
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
    object Play: TAction
      ImageIndex = 15
      OnExecute = PlayExecute
    end
    object Stop: TAction
      ImageIndex = 16
      OnExecute = StopExecute
    end
  end
  object MP3In: TMP3In
    Loop = False
    EndSample = -1
    HighPrecision = False
    OutputChannels = cnMonoOrStereo
    Left = 320
    Top = 8
  end
  object AudioCache: TAudioCache
    Input = MP3In
    Left = 352
    Top = 8
  end
  object DSAudioOut: TDSAudioOut
    Input = AudioCache
    OnDone = DSAudioOutDone
    DeviceNumber = 0
    Calibrate = True
    Latency = 50
    SpeedFactor = 1.000000000000000000
    Left = 384
    Top = 8
  end
end
