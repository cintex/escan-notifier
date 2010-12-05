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
  ComCtrls;

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
    procedure OkExecute(Sender: TObject);
    procedure CancelExecute(Sender: TObject);
    procedure ScanSoundChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Déclarations privées }
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

procedure TSettingsForm.FormCreate(Sender: TObject);
var
  i: integer;
  FileList: TStringList;
begin
  ScanSound.Clear;
  FileList := TStringList.Create;
  BuildFileList(IncludeTrailingBackslash(MainForm.SoundPath) + '*.mp3', faAnyFile, FileList);
  for i := 0 to FileList.Count - 1 do
  begin
    ScanSound.Items.Add(FileList[i]);
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

procedure TSettingsForm.ScanSoundChange(Sender: TObject);
begin
  if not FileExists((Sender as TSpTBXEdit).Text) then
  begin (Sender as TSpTBXEdit)
    .Font.Color := clRed;
  end
  else
  begin (Sender as TSpTBXEdit)
    .ParentFont := true;
  end;
end;

end.
