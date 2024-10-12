unit GUI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OpenGL, DGLUT, Textures, Mesh, Resurce, ExtCtrls,Command,GFonts,math,
  GameLavels, Vcl.MPlayer, unit2;

 const
  Pi =3.14;
  size = 20;
type
   TVector = record  //Вектор
   X,Y,Z:GLfloat;
   end;


   TCamera = record
   Pos: Tvector;         //Позиция камеры
   PhiY: single;         //вертикальный улол поворота камеры
   PhiX: single;         //горизонтальный
   Speed: glFloat;       //Скорость камеры
   end;


  TForm1 = class(TForm)
    DrawGrGL: TTimer;
    PhizProcess: TTimer;
    MediaPlayer1: TMediaPlayer;
    procedure PhizProcessTimer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
var
  Form1: TForm1;
  HRC : HGLRC;
  MouseMove1: boolean;
  glLightPos: array[0..3] of glFloat = (0,0,100,1);
  TempX1,TempY1,SingX,SingY,TempX2,TempY2,k : integer;
  Point: Tpoint;
  FPS,FP:integer;
  P:FPlayer;
  TObj : TGLMultyMesh;
   Cursor1,W,S,D,FontF: Uint;

   provrka,WX,WY:integer;
   cetest:byte;
   Sky,Grass,board:BBoxT;
   Blocks:array[0..255] of BBoxT;
   Ttextobj : array[0..256] of Uint;
   Blocs:integer;
   bclick,lmb,rmb:boolean;
   MyBlock:byte;
   Mass:array[0..1024,0..1024,0..1024] of Byte;


   MenuStay:integer;
/// функция для установки текущей текстуры по идентификатору texture
procedure glBindTexture(target: GLenum; texture: GLuint); stdcall; external opengl32;
function Summae(a,b:real):real;  external  'MIZEENG';
implementation

{$R *.dfm}
//действия с блоками
procedure BoxManager();
  var x,y,z:real;
    dist, VX,VY,VZ,oldX,oldY,oldZ:integer;
begin
  if (lmb=true) or (rmb=true) then //считываем начальное положение головы персонажа
  begin
  x:=p.X-size/2;
  y:=p.Y+p.h/2-size/2;
  z:=p.Z-size/2;
  dist:=0;
  while dist<100 do   //чем больше dist тем дальше можно создавать кубики
    begin
    dist:=dist+1;
    if abs(tan(p.AngleY/180*Pi))>1 then
    begin
    x:=x-sin(p.angleX/180*pi)/abs(tan(p.AngleY/180*Pi)); VX:=round(x/size);
    y:=y+tan(p.AngleY/180*Pi)/abs(tan(p.AngleY/180*Pi)); VY:=round(y/size);
    z:=z-cos(p.angleX/180*pi)/abs(tan(p.AngleY/180*Pi)); VZ:=round(z/size);
    end
    else
    begin
    x:=x-sin(p.angleX/180*pi); VX:=round(x/size);
    y:=y+tan(p.AngleY/180*Pi); VY:=round(y/size);
    z:=z-cos(p.angleX/180*pi); VZ:=round(z/size);
    end;

    if (Check(VX,VY,VZ)<>0) then begin  //проверка если столкнулись с боксом
      if lmb=true then mass[VX,VY,VZ]:=0;             //если левая то удаляем кубик по его координатам
      if (rmb=true) and (Check(oldX,oldY,oldZ)=0) then     begin  //если правая ставим выбранный блок на наведённый координат
      if (dist>60) and ((tan(p.AngleY/180*Pi)<-8) or (tan(p.AngleY/180*Pi)>4)) then mass[oldX,oldY,oldZ]:=MyBlock;
      if (dist>25) and (tan(p.AngleY/180*Pi)>=-8) and (tan(p.AngleY/180*Pi)<=4) then mass[oldX,oldY,oldZ]:=MyBlock;
      end;

      lmb:=false;
      rmb:=false;
    end;
    oldX:=VX; oldY:=VY; oldZ:=VZ;
    end;
  end;
end;
//формат пикселей
procedure SetDCPixelFormat ( hdc : HDC );
 var
  pfd : TPixelFormatDescriptor;
  nPixelFormat : Integer;
 begin
  FillChar (pfd, SizeOf (pfd), 0);
  pfd.dwFlags  := PFD_DRAW_TO_WINDOW or PFD_SUPPORT_OPENGL or PFD_DOUBLEBUFFER;
   nPixelFormat := ChoosePixelFormat (hdc, @pfd);
  SetPixelFormat (hdc, nPixelFormat, @pfd);
 end;

//создание мира
procedure TForm1.FormCreate(Sender: TObject);
var
 I,J,Y,G,K:integer;
 U:TBitmap;
 Color:TColor;
 R:byte;
begin
ShowCursor(false);
MediaPlayer1.filename:=('DATA\Music.wav');
Mediaplayer1.Play;
U:= TBitmap.Create;
 U.LoadFromFile('Data\Map.bmp');
for I := 0 to 127 do
  for J := 0 to 127 do
   for Y := 0 to 127 do
   begin
       Mass[I,J,Y]:=0;
   end;

 for G := 0 to 127 do
  for K := 0 to 127 do
      begin
        Color:=U.Canvas.Pixels[K,G];
        R:=GetBValue(Color);

        for I := 0 to Round(R/4)-1 do
          begin
            If I<Round(R/4)-1 then Mass[K,I,G] := 9 ;
            If I=Round(R/4)-1 then Mass[K,I,G] := 1 ;
          end;
end;
U.Free;

  SetDCPixelFormat(Canvas.Handle);
  hrc := wglCreateContext(Canvas.Handle);
  wglMakeCurrent(Canvas.Handle, hrc);

  Load_First_Tex_settings();
  Load_Game_Textures();
  Load_Game_Models();

{ for I := 0 to 19 do
  for J := 0 to 19 do
   for Y := 0 to 19 do
   begin
      K:=random(150);
      If (K mod 140 <> 0)  then Mass[I,J,Y]:=0;
      if (K mod 140 = 0)  then Mass[I,J,Y]:=1;
      if J=0 then Mass[I,J,Y]:=1;
   end; }
      P.create(400,700,400);
    MyBlock:=1;
  provrka:=2;
  MenuStay:=0;
end;
//отрисовка
procedure TForm1.FormPaint(Sender: TObject);
var i : integer;
    j : integer;
    l : integer;
begin
  IdenTifiWindow(ClientWidth, ClientHeight);
 Active_UnActive_system();
     if (GetAsyncKeyState(VK_ESCAPE)<>0) then
      begin
        ShowCursor(true);
        form2.show;
        form1.close;
      end;
       if (GetAsyncKeyState(VK_LButton)=0) and (GetAsyncKeyState(VK_RButton)=0) and (bclick=true) then
        begin
          bclick:=false;
        end;
GluLookAt(P.X,P.Y+P.h/2,P.Z,   P.X-sin(P.angleX/180*Pi),
     P.Y+P.h/2+tan(P.AngleY/180*Pi),P.Z-cos(P.angleX/180*Pi),0,1,0);
MainGame(ClientWidth, ClientHeight);

FP:=FP+1;
SwapBuffers(Canvas.Handle); //для обновления содержимого холста на экране
end;

//движение персонажа
procedure TForm1.PhizProcessTimer(Sender: TObject);
var I,J,Y,O:integer;
dir:real;
begin
     if (Commande=false) then
       begin
         Mouse_Move();
       end;

   P:=Key_Move(P);
 P.dy:=P.Dy-0.2;
 if P.dy<-3 then P.dy:=-3;

for I := 1 to 127 do
  for J := 1 to 127 do
   for Y := 1 to 127 do
   begin
         dir:=sqrt(sqr(p.X-size*i+size/2)+sqr(p.Y-size*j+size/2)+sqr(p.z-size*y+size/2));

      If (Mass[I,J,Y]<>0) and (abs(dir)<80) then begin P:=NueThon(size*i+size/2, size*j+size/2, size*y+size/2,
      size/2,size/2,size/2,P);
      end;
   end;

if P.Colizt>0 then begin
P.onGround:=true;
end else begin
  P.onGround:=false;
end;

 p.Colizt:=0;
 P.X:=P.X+P.dx;
 P.Y:=P.Y+P.dy;
 P.Z:=P.Z+P.dz;

 BoxManager();
        P.dx:=0;
        P.dz:=0;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
Form1.Handle;
end;

end.
