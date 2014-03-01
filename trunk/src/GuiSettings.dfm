object SettingsForm: TSettingsForm
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Settings'
  ClientHeight = 502
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
    Height = 502
    Caption = 'Background'
    Align = alClient
    Padding.Left = 5
    Padding.Top = 5
    Padding.Right = 5
    Padding.Bottom = 5
    TabOrder = 0
    Borders = False
    TBXStyleBackground = True
    ExplicitHeight = 459
    object Footer: TSpTBXPanel
      AlignWithMargins = True
      Left = 5
      Top = 464
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
      ExplicitTop = 421
      object ButtonOk: TSpTBXButton
        AlignWithMargins = True
        Left = 339
        Top = 3
        Width = 114
        Height = 27
        Action = Ok
        Align = alRight
        TabOrder = 0
        DrawPushedCaption = False
        Images = MainForm.Images
        ImageIndex = 8
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
        DrawPushedCaption = False
        Images = MainForm.Images
        ImageIndex = 9
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
      end
      object SpTBXLabel1: TSpTBXLabel
        Left = 16
        Top = 88
        Width = 112
        Height = 22
        Caption = 'Preview label text'
        Images = MainForm.Images
        ImageIndex = 6
      end
      object SpTBXLabel2: TSpTBXLabel
        Left = 16
        Top = 143
        Width = 97
        Height = 22
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
      Height = 203
      Caption = 'Notification settings'
      Align = alTop
      TabOrder = 2
      ExplicitLeft = -72
      DesignSize = (
        570
        203)
      object ScanSound: TSpTBXComboBox
        Left = 16
        Top = 52
        Width = 507
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        ItemHeight = 13
        TabOrder = 1
        OnChange = ScanSoundChange
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
      object SoundTest: TSpTBXSpeedButton
        Left = 529
        Top = 52
        Width = 25
        Height = 21
        Action = Play
        Anchors = [akTop, akRight]
        DrawPushedCaption = False
        Images = MainForm.Images
        ImageIndex = 15
      end
      object SendMail: TSpTBXCheckBox
        Left = 19
        Top = 79
        Width = 94
        Height = 21
        Caption = 'Send an e.mail'
        TabOrder = 3
      end
      object EMailAddress: TSpTBXEdit
        Left = 16
        Top = 106
        Width = 321
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 4
        TextHint = 'username@mail.com'
      end
      object SmtpUsername: TSpTBXEdit
        Left = 16
        Top = 160
        Width = 161
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 5
        TextHint = 'SMTP Username'
      end
      object SmtpPassword: TSpTBXEdit
        Left = 183
        Top = 160
        Width = 154
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        PasswordChar = '*'
        TabOrder = 6
        TextHint = 'SMTP Password'
      end
      object SmtpHost: TSpTBXEdit
        Left = 16
        Top = 133
        Width = 236
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 7
        Text = 'smtp.gmail.com'
        TextHint = 'SMTP Host'
      end
      object SmtpPort: TSpTBXSpinEdit
        Left = 258
        Top = 133
        Width = 79
        Height = 21
        TabOrder = 8
        SpinButton.Left = 61
        SpinButton.Top = 0
        SpinButton.Width = 14
        SpinButton.Height = 17
        SpinButton.Align = alRight
        SpinButton.DrawPushedCaption = False
        SpinButton.ExplicitLeft = 103
        SpinOptions.MaxValue = 65535.000000000000000000
        SpinOptions.Value = 587.000000000000000000
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
      'EpsonScanLanguage.ItemIndex'
      'SendMail.Checked'
      'SmtpPassword.Text'
      'SmtpUsername.Text'
      'SmtpHost.Text'
      'SmtpPort.Value'
      'EMailAddress.Text')
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
