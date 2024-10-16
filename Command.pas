unit Command;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OpenGL, DGLUT, Textures,mesh, math;

const
  GL_CLAMP_TO_EDGE =$812F;

  VK_W = $57;   VK_1 = $31;
  VK_S = $53;   VK_2 = $32;
  VK_D = $44;   VK_3 = $33;
  VK_A = $41;   VK_4 = $34;
  VK_R = $52;

  VK_5 = $35;   VK_6 = $36;
  VK_7 = $37;   VK_8 = $38;
  VK_9 = $39;   VK_0 = $30;

  VK_YO     =  $C0;
  VK_SPACE = $20;

type
  RObject = record
    x,y,sx,sy:integer;
    cls:byte;
    model:TGLMultyMesh;
    texture:Uint;
  end;
Type
  BBoxT =record
     Texture:array[0..5] of Uint;
  end;


//////----------------****************************************************---------------------------////

Type
  FPlayer = record
    X,Y,Z:Real;
    dx,dy,dz:real;
    w,h,d:real;
    Colizt:integer;
    angleX,AngleY: Single;
    onGround:boolean;
    Speed:real;
    public
    procedure create(X0,Y0,Z0:real); //������� ����������� �� 3 ����
  end;
var
   mbl:boolean;
   Button:array[0..11] of Uint;
   SkyBox:array[0..5] of Uint;
   Commande, KeyClick:boolean;
   fogColor : array[0..3] of GLfloat = (0.14, 0.52, 0.89, 0.5); //���� ������
procedure IdenTifiWindow(ClientWidth, ClientHeight:integer);
procedure Mouse_Move();
function Key_Move(G:Fplayer):Fplayer;
function check(x,y,z:integer):Byte;
function NueThon(fx,fy,fz,fsx,fsy,fsz:real;D:FPlayer):FPlayer;
procedure DrawBox(X,Y,Z,Size:real; Texture:BBoxT);
procedure Active_UnActive_system();
procedure Fog();


implementation
uses GUI;

//�����
procedure Fog();
begin
  glFogi(GL_FOG_MODE, GL_NEAREST ); // ������ ����� �������� ������
  glHint(GL_FOG_HINT, GL_NEAREST);
  glFogf(GL_FOG_START , 10); // ������ ������
  glFogf(GL_FOG_END , 1000); // ����� ������
  glFogfv(GL_FOG_COLOR, @fogColor); // ���� �����6
  glFogf(GL_FOG_DENSITY, 0.8); // ��������� ������
end;



//��������� ��������� ���������
procedure Fplayer.create(X0: Real; Y0: Real; Z0: Real);
begin
  x:=X0;  y:=y0;  z:=Z0;
  dx:=0;  dy:=0; dz:=0;
  w:=5; h:=20; d:=5; speed:=2;
  onGround:=false;
end;
//��������� �������
procedure Active_UnActive_system();
begin
if (GetAsyncKeyState(VK_YO)<>0) then
  begin
    Commande:=true;
  end;
if (GetAsyncKeyState(VK_R)<>0) then
  begin
    SetCursorPos(screen.Width div 2,screen.Height div 2);
    Commande:=false;
  end;
end;
// ������
function NueThon(fx,fy,fz,fsx,fsy,fsz:real;D:FPlayer):FPlayer;
  var
    DX,DY,DZ:real;
    RX,RY,RZ:boolean;
    YAY:real;
begin
DX:=D.X-fx;
DZ:=D.Z-fz;
DY:=D.Y-fy;
  if (abs(DX)<fsx+D.w) and (abs(DZ)<fsz+d.d) and (abs(DY)<fsy+d.h) then
    begin
      if (DX>0) then  RX:=true;
      if (DX<0) then  RX:=false;
      if (DZ>0) then  RZ:=true;
      if (DZ<0) then  RZ:=false;
      if (DY>0) then  RY:=true;
      if (DY<0) then  RY:=false;

          if (RY=true) or (RY=false) then begin
            if DY-D.h>fsy*0.7 then begin
               if D.dy<0 then begin
                d.dy:=0;
                D.Colizt:=D.Colizt+1;
                D.Y:=fy+D.H+fsy*0.95;
               end;
              end else
              begin
              if Rx=true then begin
                if (DZ-D.d<fsz*0.8) and (DZ+d.d>-fsz*0.8) and (DX-d.w>fsx*0.7) then
                  begin
                    D.X:=fx+d.d+fsx;
                  end;
                end;
                if Rx=false then begin
                if (DZ-D.d<fsz*0.8) and (DZ+d.d>-fsz*0.8) and (DX+d.w<-fsx*0.7) then
                  begin
                    D.X:=fx-d.d-fsx;
                  end;
                end;
                if Rz=true then begin
                  if (DX-D.w<fsx*0.8) and (DX+D.d>-fsx*0.8) and (Dz-d.d>fsz*0.7) then
                    begin
                      D.Z:=fz+d.w+fsz;
                    end;
                end;
                if Rz=false then begin
                  if (Dx-D.w<fsx*0.8) and (Dx+D.w>-fsx*0.8) and (Dz+d.d<-fsz*0.7)  then
                    begin
                      D.z:=fz-d.w-fsz;
                    end;
                end;
                if DY+D.h<-fsy*0.7 then begin
                  if D.dy>0 then begin
                    d.dy:=0;
                    D.Y:=fy-D.H-fsy*0.95;
                  end;
end; end; end; end;
result:=D;
end;

function check(x,y,z:integer):byte;
begin
  if ((x<0) or (X>127) or
      (y<0) or (Y>127) or
      (z<0) or (Z>127)) then
      begin
        result:= 0;
      end else begin
        result:=mass[x,y,z];
      end;

end;


//���������� ���������
function Key_Move(G:Fplayer):Fplayer;
var Gamer:Fplayer;
begin
  Gamer:=G;
    if Gamer.AngleY  >89 then Gamer.AngleY  :=89;
    if Gamer.AngleY  <-89 then Gamer.AngleY  :=-89;


  if (GetAsyncKeyState(VK_W)<>0) then
    begin
      Gamer.dx:= -Sin(Gamer.angleX/180*Pi)*Gamer.Speed;
      Gamer.dz:= -cos(Gamer.angleX/180*Pi)*Gamer.Speed;
    end;
  if (GetAsyncKeyState(VK_S)<>0) then
    begin
      Gamer.dx:= Sin(Gamer.angleX/180*Pi)*Gamer.Speed;
      Gamer.dz:= cos(Gamer.angleX/180*Pi)*Gamer.Speed;
    end;

  if (GetAsyncKeyState(VK_D)<>0) then
    begin
      Gamer.dx:=sin((Gamer.angleX+90)/180*Pi)*Gamer.Speed;
      Gamer.dz:=cos((Gamer.angleX+90)/180*Pi)*Gamer.Speed;
    end;
  if (GetAsyncKeyState(VK_A)<>0) then
    begin
      Gamer.dx:=sin((Gamer.angleX-90)/180*Pi)*Gamer.Speed;
      Gamer.dz:=cos((Gamer.angleX-90)/180*Pi)*Gamer.Speed;
    end;

  if (GetAsyncKeyState(VK_Space)<>0) and (Gamer.onGround=true) then
    begin
      Gamer.dy:=4;
    end;
      if (GetAsyncKeyState(VK_LButton)<>0) and (bclick=false) then
        begin
          lmb:=true;
          bclick:=true;
        end else
        begin
          lmb:=false;
        end;

      if (GetAsyncKeyState(VK_RButton)<>0) and (bclick=false) then
        begin
          rmb:=true;
          bclick:=true;
        end
        else
        begin
          rmb:=false;
        end;

  if (GetAsyncKeyState(VK_1)<>0) then MyBlock:=1;
  if (GetAsyncKeyState(VK_2)<>0) then MyBlock:=2;
  if (GetAsyncKeyState(VK_3)<>0) then MyBlock:=3;
  if (GetAsyncKeyState(VK_4)<>0) then MyBlock:=4;
  if (GetAsyncKeyState(VK_5)<>0) then MyBlock:=5;
  if (GetAsyncKeyState(VK_6)<>0) then MyBlock:=6;
  if (GetAsyncKeyState(VK_7)<>0) then MyBlock:=7;
  if (GetAsyncKeyState(VK_8)<>0) then MyBlock:=8;
  if (GetAsyncKeyState(VK_9)<>0) then MyBlock:=9;
  if (GetAsyncKeyState(VK_0)<>0) then MyBlock:=10;

result:=Gamer;

end;




//������� ������
procedure Mouse_Move();
begin
  try
    if MouseMove1 = false then
    begin
      GetCursorPos(Point);
      TempX1 := Point.X;
      TempY1 := Point.Y;
      MouseMove1 := true;
    end;
  finally
    if Form1.Active then
    begin
      SetCursorPos(Screen.Width div 2, Screen.Height div 2);
    end;
    GetCursorPos(Point);
    if MouseMove1 = true then
    begin
      TempX2 := Point.X;
      TempY2 := Point.Y;
      SingX := TempX1 - TempX2;
      SingY := TempY1 - TempY2;
      P.AngleY := P.AngleY + (-SingY / 8);
      P.AngleX := P.AngleX + (-SingX / 4);
      TempX1 := 0;
      TempY1 := 0;
      TempX2 := 0;
      TempY2 := 0;
      SingX := 0;
      SingY := 0;
      MouseMove1 := false;
    end;
  end;
end;

//////----------------****************************************************---------------------------////


procedure IdenTifiWindow(ClientWidth, ClientHeight:integer);
begin
  glViewport(0, 0, ClientWidth, ClientHeight); //�������� ������� ���� ����� ���������� ��� �����
  glMatrixMode ( GL_PROJECTION ); //��������� � ������� ��������
  glLoadIdentity;  //���������� ������� �������
  gluPerspective(60,ClientWidth/ClientHeight,0.1,10000); //������� ���������
  glMatrixMode ( GL_MODELVIEW ); //��������� � ��������� �������
  glLoadIdentity;//���������� ������� �������
end;

//��������� ������
procedure DrawBox(X,Y,Z,Size:real; Texture:BBoxT);
begin
   glTranslatef(X,Y,Z);
      glPushMatrix;
  	    glBindTexture(GL_TEXTURE_2D, Texture.Texture[0]);
	    glBegin(GL_QUADS);
		    //front
            glTexCoord2f(0, 0);   glVertex3f(-size, -size, -size);
            glTexCoord2f(1, 0);   glVertex3f(size,  -size, -size);
            glTexCoord2f(1, 1);   glVertex3f( size,  size, -size);
            glTexCoord2f(0, 1);   glVertex3f( -size, size, -size);
        glEnd();
    glPopmatrix;
      glPushMatrix;
	    glBindTexture(GL_TEXTURE_2D, Texture.Texture[1]);
	    glBegin(GL_QUADS);
			//back
            glTexCoord2f(0, 0); glVertex3f(size, -size, size);
            glTexCoord2f(1, 0); glVertex3f(-size,  -size, size);
            glTexCoord2f(1, 1); glVertex3f( -size,  size, size);
            glTexCoord2f(0, 1); glVertex3f( size, size, size);
        glEnd();
    glPopmatrix;
      glPushMatrix;
		glBindTexture(GL_TEXTURE_2D, Texture.Texture[2]);
	    glBegin(GL_QUADS);
			//left
            glTexCoord2f(0, 0); glVertex3f(-size, -size,  size);
            glTexCoord2f(1, 0); glVertex3f(-size, -size, -size);
            glTexCoord2f(1, 1); glVertex3f(-size,  size, -size);
            glTexCoord2f(0, 1); glVertex3f(-size,  size,  size);
        glEnd();
    glPopmatrix;
      glPushMatrix;
		glBindTexture(GL_TEXTURE_2D, Texture.Texture[3]);
	    glBegin(GL_QUADS);
			//right
            glTexCoord2f(0, 0); glVertex3f(size, -size, -size);
            glTexCoord2f(1, 0); glVertex3f(size,  -size, size);
            glTexCoord2f(1, 1); glVertex3f(size,  size,  size);
            glTexCoord2f(0, 1); glVertex3f(size, size,  -size);
        glEnd();
    glPopmatrix;
      glPushMatrix;
		glBindTexture(GL_TEXTURE_2D, Texture.Texture[4]);
	    glBegin(GL_QUADS);
			//bottom
            glTexCoord2f(0, 0); glVertex3f(-size, -size,  size);
            glTexCoord2f(1, 0); glVertex3f(size, -size, size);
            glTexCoord2f(1, 1); glVertex3f( size, -size, -size);
            glTexCoord2f(0, 1); glVertex3f( -size, -size,  -size);
        glEnd();
    glPopmatrix;
      glPushMatrix;
	    glBindTexture(GL_TEXTURE_2D, Texture.Texture[5]);
	    glBegin(GL_QUADS);
			//top
            glTexCoord2f(0, 0); glVertex3f(-size, size,  -size);
            glTexCoord2f(1, 0); glVertex3f(size, size, -size);
            glTexCoord2f(1, 1); glVertex3f( size, size, size);
            glTexCoord2f(0, 1); glVertex3f( -size, size,  size);
        glEnd();
    glPopmatrix;
   glTranslatef(-X,-Y,-Z);
end;

end.
