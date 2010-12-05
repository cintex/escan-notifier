(* ***** BEGIN LICENSE BLOCK *****
  * Version: GNU GPL 2.0
  *
  * The contents of this file are subject to the
  * GNU General Public License Version 2.0; you may not use this file except
  * in compliance with the License. You may obtain a copy of the License at
  * http://www.gnu.org/licenses/gpl.html
  *
  * Software distributed under the License is distributed on an "AS IS" basis,
  * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  * for the specific language governing rights and limitations under the
  * License.
  *
  * The Original Code is GuiSettings (https://code.google.com/p/escan-notifier/)
  *
  * The Initial Developer of the Original Code is
  * Yann Papouin <yann.papouin at @ gmail.com>
  *
  * ***** END LICENSE BLOCK ***** *)

unit GuiSettings;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  JvComponentBase,
  JvFormPlacement,
  StdCtrls,
  SpTBXEditors,
  SpTBXItem,
  SpTBXControls,
  ActnList,
  ComCtrls, ACS_Classes, NewACDSAudio, ACS_Converters, ACS_WinMedia, ACS_smpeg;

type
  TSettingsForm = class(TForm)
    FormStorage: TJvFormStorage;
    SpTBXLabel1: TSpTBXLabel;
    SpTBXLabel2: TSpTBXLabel;
    PreviewLabel: TSpTBXEdit;
    ScanLabel: TSpTBXEdit;
    SpTBXGroupBox1: TSpTBXGroupBox;
    Background: TSpTBXPanel;
    Footer: TSpTBXPanel;
    ButtonOk: TSpTBXButton;
    ButtonCancel: TSpTBXButton;
    Actions: TActionList;
    Add: TAction;
    Remove: TAction;
    ChoosePath: TAction;
    Ok: TAction;
    Cancel: TAction;
    Browse: TAction;
    Edit: TAction;
    SpTBXGroupBox2: TSpTBXGroupBox;
    SpTBXLabel3: TSpTBXLabel;
    ScanSound: TSpTBXComboBox;
    EpsonScanLanguage: TSpTBXComboBox;
    SpTBXLabel4: TSpTBXLabel;
    SoundTest: TSpTBXSpeedButton;
    Play: TAction;
    Stop: TAction;
    MP3In: TMP3In;
    AudioCache: TAudioCache;
    DSAudioOut: TDSAudioOut;
    procedure OkExecute(Sender: TObject);
    procedure CancelExecute(Sender: TObject);
    procedure ScanSoundChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EpsonScanLanguageChange(Sender: TObject);
    procedure LabelChange(Sender: TObject);
    procedure DSAudioOutDone(Sender: TComponent);
    procedure StopExecute(Sender: TObject);
    procedure PlayExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Déclarations privées }
    FEpsonScanLanguageChanging : boolean;
  public
    { Déclarations publiques }
  end;

var
  SettingsForm: TSettingsForm;

implementation

{$R *.dfm}

uses
  JclFileUtils,
  GuiMain;

const
  ESLG_CUSTOM = 0;
  ESLG_DUTCH = 1;
  ESLG_ENGLISH = 2;
  ESLG_FRENCH = 3;
  ESLG_GERMAN = 4;
  ESLG_ITALIAN = 5;
  ESLG_PORTUGUESE = 6;
  ESLG_RUSSIAN = 7;
  ESLG_SPANISH = 8;
  ESLG_UKRAINIAN = 9;



procedure TSettingsForm.EpsonScanLanguageChange(Sender: TObject);
begin
  FEpsonScanLanguageChanging := true;
  case EpsonScanLanguage.ItemIndex of

    ESLG_CUSTOM:
      begin

      end;
    ESLG_DUTCH:
      begin
        PreviewLabel.Text := 'Voorbeeldscan wordt gemaakt';
        ScanLabel.Text := 'Bezig met scannen';
      end;
    ESLG_ENGLISH:
      begin
        PreviewLabel.Text := 'Preview scan in progress';
        ScanLabel.Text := 'Scanning';
      end;
    ESLG_FRENCH:
      begin
        PreviewLabel.Text := 'Pré-numérisation en cours';
        ScanLabel.Text := 'Numérisation';
      end;
    ESLG_GERMAN:
      begin
        PreviewLabel.Text := 'Vorschauscannen läuft';
        ScanLabel.Text := 'Scanvorgang läuft.';
      end;
    ESLG_ITALIAN:
      begin
        PreviewLabel.Text := 'Anteprima in corso';
        ScanLabel.Text := 'Scansione in corso';
      end;
    ESLG_PORTUGUESE:
      begin
        PreviewLabel.Text := 'Pré-digitalização em curso';
        ScanLabel.Text := 'A Digitalizar';
      end;
    ESLG_RUSSIAN:
      begin
        PreviewLabel.Text := 'Предварительное сканирование';
        ScanLabel.Text := 'Сканирование';
      end;
    ESLG_SPANISH:
      begin
        PreviewLabel.Text := 'Pre-exploración en proceso';
        ScanLabel.Text := 'Escaneando';
      end;
    ESLG_UKRAINIAN:
      begin
        PreviewLabel.Text := 'Відбувається попереднє сканування';
        ScanLabel.Text := 'Сканування';
      end;

  end;
  FEpsonScanLanguageChanging := false;
end;


procedure TSettingsForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if ModalResult = mrNone then
    CanClose := false;
end;

procedure TSettingsForm.FormCreate(Sender: TObject);
var
  i: integer;
  FileList: TStringList;
begin
  ScanSound.Clear;
  FileList := TStringList.Create;
  BuildFileList(MainForm.SoundPath + '*.mp3', faAnyFile, FileList);
  for i := 0 to FileList.Count - 1 do
  begin
    ScanSound.Items.Add(MainForm.SoundPath+FileList[i]);
  end;
  FileList.Free;
end;

procedure TSettingsForm.CancelExecute(Sender: TObject);
begin
  FormStorage.RestoreFormPlacement;
  ModalResult := mrCancel;
end;

procedure TSettingsForm.OkExecute(Sender: TObject);
begin
  FormStorage.SaveFormPlacement;
  ModalResult := mrOk;
end;

procedure TSettingsForm.LabelChange(Sender: TObject);
begin
  if not FEpsonScanLanguageChanging then
    EpsonScanLanguage.ItemIndex := ESLG_CUSTOM;
end;

procedure TSettingsForm.ScanSoundChange(Sender: TObject);
begin

  if not FileExists((Sender as TSpTBXComboBox).Text) then
  begin
    (Sender as TSpTBXComboBox).Font.Color := clRed;
    Play.Enabled := false;
  end
  else
  begin
    (Sender as TSpTBXComboBox).ParentFont := true;
    Play.Enabled := true;
  end;
end;

procedure TSettingsForm.DSAudioOutDone(Sender: TComponent);
begin
  Stop.Execute;
end;

procedure TSettingsForm.PlayExecute(Sender: TObject);
begin
  MP3In.Filename := ScanSound.Text;
  DSAudioOut.Run;
  SoundTest.Action := Stop;
end;

procedure TSettingsForm.StopExecute(Sender: TObject);
begin
  DSAudioOut.Stop;
  SoundTest.Action := Play;
end;

end.
