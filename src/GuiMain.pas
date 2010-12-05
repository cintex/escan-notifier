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
  * The Original Code is GuiMain (https://code.google.com/p/escan-notifier/)
  *
  * The Initial Developer of the Original Code is
  * Yann Papouin <yann.papouin at @ gmail.com>
  *
  * ***** END LICENSE BLOCK ***** *)

unit GuiMain;

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
  JclFileUtils,
  ActnList,
  SpTBXItem,
  SpTBXControls,
  StdCtrls,
  SpTBXEditors,
  Generics.Collections,
  ExtCtrls,
  JvComponentBase,
  JvTrayIcon,
  ImgList,
  PngImageList,
  Menus,
  TB2Item,
  JvAppStorage,
  JvAppIniStorage,
  ACS_Classes,
  ACS_DXAudio,
  ACS_WinMedia,
  ACS_smpeg,
  ACS_Vorbis,
  ACS_Wave,
  ACS_Converters,
  NewACDSAudio,
  JvAppXMLStorage,
  JvAppInst,
  GuiUpdateManager;

type

  TWindow = class
    Title: string;
    Classname: string;
    Handle: cardinal;
    PID: cardinal;
  end;

  TWindowList = TObjectList<TWindow>;

  TEpsonStatus = (es_unknown, es_idle, es_preview, es_scanning);

  TMainForm = class(TForm)
    Actions: TActionList;
    FindProgress: TAction;
    Checker: TTimer;
    Tray: TJvTrayIcon;
    Images: TPngImageList;
    TrayPopupMenu: TSpTBXPopupMenu;
    Quit: TAction;
    SpTBXItem1: TSpTBXItem;
    Settings: TAction;
    SpTBXItem2: TSpTBXItem;
    SpTBXSeparatorItem1: TSpTBXSeparatorItem;
    MP3In: TMP3In;
    ApplySettings: TAction;
    ApplicationRun: TAction;
    DSAudioOut: TDSAudioOut;
    AudioCache: TAudioCache;
    AppStorage: TJvAppXMLFileStorage;
    AppInstances: TJvAppInstances;
    MouseIdleCheck: TTimer;
    SpTBXItem3: TSpTBXItem;
    NewVersionAvailable: TAction;
    About: TAction;
    SpTBXItem4: TSpTBXItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FindProgressExecute(Sender: TObject);
    procedure CheckerTimer(Sender: TObject);
    procedure QuitExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure SettingsExecute(Sender: TObject);
    procedure ApplySettingsExecute(Sender: TObject);
    procedure ApplicationRunExecute(Sender: TObject);
    procedure MouseIdleCheckTimer(Sender: TObject);
    procedure NewVersionAvailableExecute(Sender: TObject);
    procedure AboutExecute(Sender: TObject);
  private
    { Déclarations privées }
    FWindowList: TWindowList;
    FChildrenList: TWindowList;
    FPreviewWindow: TWindow;
    FRunningWindow: TWindow;
    FMouseIdleCount: integer;
    FLastPosition: TPoint;
    FStatus: TEpsonStatus;
    FEpsonStatus: TEpsonStatus;
    procedure SetEpsonStatus(const Value: TEpsonStatus);
    procedure SetMouseIdleCount(const Value: integer);
    procedure UpdateReply(Sender: TObject; Result: TUpdateResult);
  public
    { Déclarations publiques }

    AppPath, DataPath, SharePath, SoundPath: string;
    procedure Play;
    property EpsonStatus: TEpsonStatus read FEpsonStatus write SetEpsonStatus;
    property MouseIdleCount: integer read FMouseIdleCount write SetMouseIdleCount;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  GuiAbout,
  GuiSettings,
  PsAPI,
  TlHelp32;

const
  ICO_IDLE = 5;
  ICO_PREVIEW = 6;
  ICO_SCANNING = 1;

const
  RsSystemIdleProcess = 'System Idle Process';
  RsSystemProcess = 'System Process';

function IsWinXP: Boolean;
begin
  Result := (Win32Platform = VER_PLATFORM_WIN32_NT) and (Win32MajorVersion = 5) and (Win32MinorVersion = 1);
end;

function IsWin2k: Boolean;
begin
  Result := (Win32MajorVersion >= 5) and (Win32Platform = VER_PLATFORM_WIN32_NT);
end;

function IsWinNT4: Boolean;
begin
  Result := Win32Platform = VER_PLATFORM_WIN32_NT;
  Result := Result and (Win32MajorVersion = 4);
end;

function IsWin3X: Boolean;
begin
  Result := Win32Platform = VER_PLATFORM_WIN32_NT;
  Result := Result and (Win32MajorVersion = 3) and ((Win32MinorVersion = 1) or (Win32MinorVersion = 5) or (Win32MinorVersion = 51));
end;

function RunningProcessesList(const List: TStrings; FullPath: Boolean): Boolean;

  function ProcessFileName(PID: DWORD): string;
  var
    Handle: THandle;
  begin
    Result := '';
    Handle := OpenProcess(PROCESS_QUERY_INFORMATION or PROCESS_VM_READ, False, PID);
    if Handle <> 0 then
      try
        SetLength(Result, MAX_PATH);
        if FullPath then
        begin
          if GetModuleFileNameEx(Handle, 0, PChar(Result), MAX_PATH) > 0 then
            SetLength(Result, StrLen(PChar(Result)))
          else
            Result := '';
        end
        else
        begin
          if GetModuleBaseNameA(Handle, 0, PAnsiChar(Result), MAX_PATH) > 0 then
            SetLength(Result, StrLen(PChar(Result)))
          else
            Result := '';
        end;
      finally
        CloseHandle(Handle);
      end;
  end;

  function BuildListTH: Boolean;
  var
    SnapProcHandle: THandle;
    ProcEntry: TProcessEntry32;
    NextProc: Boolean;
    FileName: string;
  begin
    SnapProcHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
    Result := (SnapProcHandle <> INVALID_HANDLE_VALUE);
    if Result then
      try
        ProcEntry.dwSize := SizeOf(ProcEntry);
        NextProc := Process32First(SnapProcHandle, ProcEntry);
        while NextProc do
        begin
          if ProcEntry.th32ProcessID = 0 then
          begin
            FileName := RsSystemIdleProcess;
          end
          else
          begin
            if IsWin2k or IsWinXP then
            begin
              FileName := ProcessFileName(ProcEntry.th32ProcessID);
              if FileName = '' then
                FileName := ProcEntry.szExeFile;
            end
            else
            begin
              FileName := ProcEntry.szExeFile;
              if not FullPath then
                FileName := ExtractFileName(FileName);
            end;
          end;
          List.AddObject(FileName, Pointer(ProcEntry.th32ProcessID));
          NextProc := Process32Next(SnapProcHandle, ProcEntry);
        end;
      finally
        CloseHandle(SnapProcHandle);
      end;
  end;

  function BuildListPS: Boolean;
  var
    PIDs: array [0 .. 1024] of DWORD;
    Needed: DWORD;
    I: integer;
    FileName: string;
  begin
    Result := EnumProcesses(@PIDs, SizeOf(PIDs), Needed);
    if Result then
    begin
      for I := 0 to (Needed div SizeOf(DWORD)) - 1 do
      begin
        case PIDs[I] of
          0:
            FileName := RsSystemIdleProcess;
          2:
            if IsWinNT4 then
              FileName := RsSystemProcess
            else
              FileName := ProcessFileName(PIDs[I]);
          8:
            if IsWin2k or IsWinXP then
              FileName := RsSystemProcess
            else
              FileName := ProcessFileName(PIDs[I]);
        else
          FileName := ProcessFileName(PIDs[I]);
        end;
        if FileName <> '' then
          List.AddObject(FileName, Pointer(PIDs[I]));
      end;
    end;
  end;

begin
  if IsWin3X or IsWinNT4 then
    Result := BuildListPS
  else
    Result := BuildListTH;
end;

function GetProcessNameFromWnd(Wnd: HWND): string;
var
  List: TStringList;
  PID: DWORD;
  I: integer;
begin
  Result := '';
  if IsWindow(Wnd) then
  begin
    PID := INVALID_HANDLE_VALUE;
    GetWindowThreadProcessId(Wnd, @PID);
    List := TStringList.Create;
    try
      if RunningProcessesList(List, True) then
      begin
        I := List.IndexOfObject(Pointer(PID));
        if I > -1 then
          Result := List[I];
      end;
    finally
      List.Free;
    end;
  end;
end;

function EnumChildren(hHwnd: THandle; var lParam: THandle): Boolean; stdcall;
var
  pPid: DWORD;
  Title, Classname: string;
  AWindow: TWindow;
begin
  // if the returned value in null the
  // callback has failed, so set to false and exit.
  if (hHwnd = NULL) then
  begin
    Result := False;
  end
  else
  begin
    // additional functions to get more
    // information about a process.
    // get the Process Identification number.
    GetWindowThreadProcessId(hHwnd, pPid);
    // set a memory area to receive
    // the process class name
    SetLength(Classname, 255);
    // get the class name and reset the
    // memory area to the size of the name
    SetLength(Classname, GetClassName(hHwnd, PChar(Classname), Length(Classname)));
    SetLength(Title, 255);
    // get the process title; usually displayed
    // on the top bar in visible process
    SetLength(Title, GetWindowText(hHwnd, PChar(Title), Length(Title)));
    // Display the process information
    // by adding it to a list box
    AWindow := TWindow.Create;
    AWindow.Title := Title;
    AWindow.Classname := Classname;
    AWindow.Handle := hHwnd;
    AWindow.PID := pPid;
    MainForm.FChildrenList.Add(AWindow);
    Result := True;
  end;
end;

function EnumProcess(hHwnd: THandle; var lParam: THandle): Boolean; stdcall;
var
  pPid: DWORD;
  Title, Classname: string;
  AWindow: TWindow;
begin
  // if the returned value in null the
  // callback has failed, so set to false and exit.
  if (hHwnd = NULL) then
  begin
    Result := False;
  end
  else
  begin
    // additional functions to get more
    // information about a process.
    // get the Process Identification number.
    GetWindowThreadProcessId(hHwnd, pPid);
    // set a memory area to receive
    // the process class name
    SetLength(Classname, 255);
    // get the class name and reset the
    // memory area to the size of the name
    SetLength(Classname, GetClassName(hHwnd, PChar(Classname), Length(Classname)));
    SetLength(Title, 255);
    // get the process title; usually displayed
    // on the top bar in visible process
    SetLength(Title, GetWindowText(hHwnd, PChar(Title), Length(Title)));
    // Display the process information
    // by adding it to a list box
    AWindow := TWindow.Create;
    AWindow.Title := Title;
    AWindow.Classname := Classname;
    AWindow.Handle := hHwnd;
    AWindow.PID := pPid;
    MainForm.FWindowList.Add(AWindow);
    Result := True;
  end;
end;

procedure TMainForm.CheckerTimer(Sender: TObject);
var
  Info: tagWINDOWINFO;
begin
  FindProgress.Execute;

  if FPreviewWindow <> nil then
  begin
    if GetWindowInfo(FPreviewWindow.Handle, Info) then
    begin
      EpsonStatus := es_preview;
    end
    else
      FPreviewWindow := nil;
  end
  else if FRunningWindow <> nil then
  begin
    if GetWindowInfo(FRunningWindow.Handle, Info) then
    begin
      EpsonStatus := es_scanning;
    end
    else
      FRunningWindow := nil;
  end
  else
  begin
    EpsonStatus := es_idle;
  end;
end;

procedure TMainForm.FindProgressExecute(Sender: TObject);
var
  ProcId: cardinal;
  I, j: integer;
  AWindow, CWindow: TWindow;
begin
  FPreviewWindow := nil;
  FRunningWindow := nil;
  FWindowList.Clear;
  EnumWindows(@EnumProcess, 0);

  AWindow := nil;
  CWindow := nil;

  I := 0;
  while I <= FWindowList.Count - 1 do
  begin
    AWindow := FWindowList[I];

    // if (Pos('escndv.exe', GetProcessNameFromWnd(AWindow.Handle)) > 0) then
    begin
      FChildrenList.Clear;
      EnumChildWindows(AWindow.Handle, @EnumChildren, 0);
      for j := 0 to FChildrenList.Count - 1 do
      begin
        CWindow := FChildrenList[j];

        if AWindow.Classname = '#32770' then
        begin
          if Pos('Pré-numérisation', CWindow.Title) > 0 then
            FPreviewWindow := AWindow
          else if Pos('Numérisation', CWindow.Title) > 0 then
            FRunningWindow := AWindow;
        end;
      end;
    end;

    inc(I);
  end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  AppPath := ExtractFilePath(Application.ExeName);
  DataPath := PathExtractPathDepth(AppPath, PathGetDepth(AppPath) - 1) + 'data\';
  SharePath := PathExtractPathDepth(AppPath, PathGetDepth(AppPath) - 1) + 'share\';
  SoundPath := SharePath + 'sounds\';

  AppStorage.FileName := DataPath + 'settings.xml';

  FWindowList := TWindowList.Create;
  FChildrenList := TWindowList.Create;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  FChildrenList.Free;
  FWindowList.Free;
end;

procedure TMainForm.MouseIdleCheckTimer(Sender: TObject);
var
  CurrentPosition: TPoint;
begin
  GetCursorPos(CurrentPosition);

  if (CurrentPosition.X = FLastPosition.X) and (CurrentPosition.Y = FLastPosition.Y) then
  begin
    MouseIdleCount := MouseIdleCount + 1;
  end
  else
  begin
    MouseIdleCheck.Enabled := False;
  end;
  FLastPosition := CurrentPosition;
end;

procedure TMainForm.NewVersionAvailableExecute(Sender: TObject);
begin
  UpdateManagerForm.ShowModal;
end;

procedure TMainForm.QuitExecute(Sender: TObject);
begin
  Checker.Enabled := False;
  Close;
end;

procedure TMainForm.SetEpsonStatus(const Value: TEpsonStatus);
begin
  if Value <> FEpsonStatus then
  begin
    case Value of
      es_idle:
        begin
          Tray.IconIndex := ICO_IDLE;

          if FEpsonStatus = es_scanning then
          begin
            DSAudioOut.Run;
            MouseIdleCount := 0;
            MouseIdleCheck.Enabled := True;
            GetCursorPos(FLastPosition);
          end;

        end;
      es_preview:
        begin
          Tray.IconIndex := ICO_PREVIEW;
          DSAudioOut.Stop;
          MouseIdleCheck.Enabled := False;
        end;
      es_scanning:
        begin
          Tray.IconIndex := ICO_SCANNING;
          DSAudioOut.Stop;
          MouseIdleCheck.Enabled := False;
        end;

    end;
  end;

  FEpsonStatus := Value;
end;

procedure TMainForm.Play;
begin
  if FileExists(MP3In.FileName) then
  begin
    if not(DSAudioOut.Status = tosPlaying) then
      DSAudioOut.Run
  end
  else
    Beep;
end;

procedure TMainForm.SetMouseIdleCount(const Value: integer);
begin
  if (DSAudioOut.Status = tosPlaying) then
    FMouseIdleCount := 0
  else
    FMouseIdleCount := Value;

  if (FMouseIdleCount >= 30) then
  begin
    FMouseIdleCount := 0;
    Play;
  end;
end;

procedure TMainForm.AboutExecute(Sender: TObject);
begin
  AboutForm.ShowModal;
end;

procedure TMainForm.ApplicationRunExecute(Sender: TObject);
begin
  FStatus := es_unknown;
  SettingsForm.FormStorage.RestoreFormPlacement;
  ApplySettings.Execute;

  UpdateManagerForm.OnUpdateReply := UpdateReply;
  UpdateManagerForm.Check.Execute;
end;

procedure TMainForm.SettingsExecute(Sender: TObject);
begin
  if SettingsForm.ShowModal = mrOk then
  begin
    ApplySettings.Execute;
  end;
end;

procedure TMainForm.ApplySettingsExecute(Sender: TObject);
begin
  MP3In.FileName := SettingsForm.ScanSound.Text;
  if not FileExists(MP3In.FileName) then
    MP3In.FileName := SoundPath + SettingsForm.ScanSound.Text;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  DSAudioOut.Stop(False);
end;

procedure TMainForm.UpdateReply(Sender: TObject; Result: TUpdateResult);
begin
  NewVersionAvailable.Enabled := True;
  if Result = rs_UpdateFound then
  begin
    if not NewVersionAvailable.Visible then
    begin
      NewVersionAvailable.Visible := True;
      NewVersionAvailable.Execute;
    end
    else
      NewVersionAvailable.Visible := True;
  end
  else
  begin
    NewVersionAvailable.Visible := False;
  end;
end;

end.
