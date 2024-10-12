object Form1: TForm1
  Left = 1064
  Top = 456
  AlphaBlendValue = 100
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'DelphiCraft'
  ClientHeight = 750
  ClientWidth = 1356
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnPaint = FormPaint
  TextHeight = 13
  object MediaPlayer1: TMediaPlayer
    Left = 96
    Top = 0
    Width = 29
    Height = 30
    VisibleButtons = [btPlay]
    AutoOpen = True
    DoubleBuffered = True
    FileName = 'DATA\Music.wav'
    Visible = False
    ParentDoubleBuffered = False
    TabOrder = 0
  end
  object DrawGrGL: TTimer
    Interval = 1
    OnTimer = FormPaint
  end
  object PhizProcess: TTimer
    Interval = 1
    OnTimer = PhizProcessTimer
    Left = 40
  end
end
