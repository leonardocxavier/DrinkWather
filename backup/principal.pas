unit principal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  ComCtrls,Interfaces, windows, Buttons, MaskEdit, MPlayerCtrl, uplaysound, ComObj, Types,DateUtils;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Panel1: TPanel;
    playsound1: Tplaysound;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    StatusBar1: TStatusBar;
    Timer1: TTimer;
    Timer2: TTimer;
    TrayIcon1: TTrayIcon;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormWindowStateChange(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure Timer2StartTimer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure TrayIcon1Click(Sender: TObject);
    procedure TrayIcon1DblClick(Sender: TObject);
    procedure UpDown1MouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
  private
    nextalarm ,
    sExe      : String;
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.TrayIcon1Click(Sender: TObject);
begin

end;

procedure TForm1.TrayIcon1DblClick(Sender: TObject);
begin
 Form1.Visible:=true;
  Form1.WindowState:=wsNormal;
end;

procedure TForm1.UpDown1MouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
var
  cont:integer;
begin

  label1.caption:=inttostr((strtoint(Label1.Caption)+1));

end;

procedure TForm1.FormWindowStateChange(Sender: TObject);
begin
  if (form1.WindowState=wsMinimized) then begin
    Form1.Hide;
    TrayIcon1.Hint := 'Em Execução';
    TrayIcon1.BalloonTimeout:=2000;
    TrayIcon1.ShowBalloonHint;

   TrayIcon1.Show;
  end;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
var
  inch:integer;
begin
  inch:=strtoint(label1.Caption);
  if RadioButton1.Checked then begin
    nextalarm := TimeToStr(IncMinute(Now,strtoint(Label1.Caption)));
  end else begin
    nextalarm := TimeToStr(IncHour(Now,strtoint(Label1.Caption)));
  end;
  label3.Caption:='Próximo aviso : '+nextalarm;
  Application.Minimize;
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
  if (strtoint(label1.caption)>=0) then begin
  label1.Caption:=inttostr(strtoint(label1.caption)+1);

  end;
end;

procedure TForm1.SpeedButton3Click(Sender: TObject);
begin
  if (strtoint(label1.caption)>0) then begin
    label1.Caption:=inttostr(strtoint(label1.caption)-1);
  end;
end;

procedure TForm1.Timer2StartTimer(Sender: TObject);
begin

end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
     label2.caption:=TimeToStr(now);
     if (Label2.Caption=nextalarm) then begin
        sExe := ExtractFilePath(ParamStr(0));
        playsound1.SoundFile:=sExe+'som.wav';
        TrayIcon1.BalloonTitle:='Atenção!';
        TrayIcon1.BalloonHint := 'Hora de tomar Água!!';
        TrayIcon1.ShowBalloonHint;
        playsound1.Execute;
        if RadioButton1.Checked then begin
    nextalarm := TimeToStr(IncMinute(Now,strtoint(Label1.Caption)));
  end else begin
    nextalarm := TimeToStr(IncHour(Now,strtoint(Label1.Caption)));
  end;
     end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin

end;

procedure TForm1.FormShow(Sender: TObject);
begin
  Timer2.Enabled:=True;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
 sExe := ExtractFilePath(ParamStr(0));
 playsound1.SoundFile:=sExe+'som.wav';
 playsound1.Execute;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
end;

procedure TForm1.Button3Click(Sender: TObject);
begin

end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Application.Minimize;
  Application.MainFormOnTaskbar := true;
  Form1.Hide;
end;

end.

