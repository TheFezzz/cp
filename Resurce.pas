unit Resurce;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OpenGL, DGLUT, Textures,Mesh, command,GFonts;



procedure Load_First_Tex_settings();
procedure Load_Game_Textures();
procedure Load_Game_Models();

Procedure RenderBox();
procedure RenderSprite(PX,PY,SX,SY,Rot:real;Pict:Uint);
function SpriteButton(PX,PY,SX,SY:real;Pict:Uint; SN,SP,Key:integer):integer;
procedure RenderFlore(x,y,size:integer; Texture:Uint);
procedure RenderGMSModel(x,y,z,size:integer; model:TGLMultyMesh; Texture:Uint);

implementation
uses GUI;
//��������� ������� �� ������
procedure RenderSprite(PX,PY,SX,SY,Rot:real;Pict:Uint);
begin

  glTranslatef(PX,PY,0);
  glRotatef(Rot,0,0,1);
  glPushMatrix;  //������ ������ � �������
     //  glColor(255,255,255);
  glBindTexture(GL_TEXTURE_2D, Pict);
    glBegin(GL_Quads);
      glTexCoord2d(0.0, 1.0);  glVertex2d(-sx,-sy);
      glTexCoord2d(0.0, 0.0);  glVertex2d(-sx,+sy);
      glTexCoord2d(1.0, 0.0);  glVertex2d(+sx,+sy);
      glTexCoord2d(1.0, 1.0);  glVertex2d(+sx,-sy);
    glEnd;
       // glColor(255,255,255);
  GLpOPmATRIX;
  glRotatef(-Rot,0,0,1);
  glTranslatef(-PX,-PY,0);
end;
//�������� ��������� ������� ������������ ������ � ����������� �������� ��� ������� �� ������ �����
function SpriteButton(PX,PY,SX,SY:real;Pict:Uint; SN,SP,Key:integer):integer;
var X,Y:integer;
begin
  GetCursorPos(Point);
  X:=-Form1.Left +Point.X;
  Y:=-Form1.Top-15  +point.Y;
  RenderSprite(PX,PY,SX,SY,0,Pict);
  if (Point.X>Form1.Left) and (Point.X<Form1.Left+Form1.Width) and
      (point.Y>Form1.Top-15) and (point.Y<Form1.Top+Form1.Height) and
       (X<px+sx) and (X>px-sx) and
       (Y<py+sy) and (Y>py-sy) then begin
       if(GetAsyncKeyState(VK_LBUTTON)<>0) and (MBL=false) then
          begin
            result:=Key;
            MBL:=true;
          end else   begin
            result:=SP;
          end;
      end else begin
        result:=SN;

      end;


end;
//��������� ������� ����� �� ��������������
procedure Load_First_Tex_settings();
begin
  glEnable(GL_DEPTH_TEST); // �������� �������� ���������� ����� (������� ������� ��������� ������ �� ���)
  glDepthFunc(GL_LEQUAL);  //��� ��������
  glEnable(GL_TEXTURE_2D);   //��������� ���� ��������� �������
  glEnable(GL_ALPHA_TEST);     //��������� ����� ���� (������������ �������)
  glAlphaFunc(GL_GREATER,0.025);
  glEnable (GL_BLEND);         //�������� ����� ���������� ������
  glDepthMask(GL_True);

  glTexEnvi( GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_REPLACE );


  glBlendFunc (GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA) ; //��� ����������
  glTexParameter (GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST); //��������� ��������� ��������
  glTexParameter (GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST); //��������� ��������� ��������
  glTexParameter (GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
  glTexParameter (GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
end;
//�������� ������� � ������ �������
procedure Load_Game_Textures();
begin
   LoadTexture('TEXTURES\skybox\left.tga',W,false);
   LoadTexture('TEXTURES\skybox\right.tga',S,false);
   LoadTexture('TEXTURES\skybox\bottom.tga',D,false);

  LoadTexture('GRE\Stex\SCursor.tga', Cursor1, false);
  LoadTexture('GRE\Stex\F.tga', FontF, false);


    LoadTexture('data\cursor.tga',Ttextobj[0],false);

    LoadTexture('data\image\1.tga',Ttextobj[1],false);
    LoadTexture('data\image\2.tga',Ttextobj[2],false);
    LoadTexture('data\image\3.tga',Ttextobj[3],false);
    LoadTexture('data\image\4.tga',Ttextobj[4],false);
    LoadTexture('data\image\5.tga',Ttextobj[5],false);
    LoadTexture('data\image\6.tga',Ttextobj[6],false);
    LoadTexture('data\image\7.tga',Ttextobj[7],false);
    LoadTexture('data\image\8.tga',Ttextobj[8],false);
    LoadTexture('data\image\9.tga',Ttextobj[9],false);
    LoadTexture('data\image\10.tga',Ttextobj[10],false);

    LoadTexture('data\image\enter.tga',Ttextobj[200],false);

    LoadTexture('data\Grass\LRBT.tga',Blocks[0].Texture[0],false);
    LoadTexture('data\Grass\LRBT.tga',Blocks[0].Texture[1],false);
    LoadTexture('data\Grass\LRBT.tga',Blocks[0].Texture[2],false);
    LoadTexture('data\Grass\LRBT.tga',Blocks[0].Texture[3],false);
    LoadTexture('data\Grass\dn.tga',Blocks[0].Texture[4],false);
    LoadTexture('data\Grass\up.tga',Blocks[0].Texture[5],false);


    LoadTexture('data\board\bt.tga',Blocks[1].Texture[0],false);
    LoadTexture('data\board\bt.tga',Blocks[1].Texture[1],false);
    LoadTexture('data\board\bt.tga',Blocks[1].Texture[2],false);
    LoadTexture('data\board\bt.tga',Blocks[1].Texture[3],false);
    LoadTexture('data\board\bt.tga',Blocks[1].Texture[4],false);
    LoadTexture('data\board\bt.tga',Blocks[1].Texture[5],false);

    LoadTexture('data\Case\cb.tga',Blocks[2].Texture[0],false);
    LoadTexture('data\Case\cb.tga',Blocks[2].Texture[1],false);
    LoadTexture('data\Case\cf.tga',Blocks[2].Texture[2],false);
    LoadTexture('data\Case\cb.tga',Blocks[2].Texture[3],false);
    LoadTexture('data\Case\cuw.tga',Blocks[2].Texture[4],false);
    LoadTexture('data\Case\cuw.tga',Blocks[2].Texture[5],false);

    LoadTexture('data\brick\br.tga',Blocks[3].Texture[0],false);
    LoadTexture('data\brick\br.tga',Blocks[3].Texture[1],false);
    LoadTexture('data\brick\br.tga',Blocks[3].Texture[2],false);
    LoadTexture('data\brick\br.tga',Blocks[3].Texture[3],false);
    LoadTexture('data\brick\br.tga',Blocks[3].Texture[4],false);
    LoadTexture('data\brick\br.tga',Blocks[3].Texture[5],false);

    LoadTexture('data\stone\Brick.tga',Blocks[4].Texture[0],false);
    LoadTexture('data\stone\Brick.tga',Blocks[4].Texture[1],false);
    LoadTexture('data\stone\Brick.tga',Blocks[4].Texture[2],false);
    LoadTexture('data\stone\Brick.tga',Blocks[4].Texture[3],false);
    LoadTexture('data\stone\Brick.tga',Blocks[4].Texture[4],false);
    LoadTexture('data\stone\Brick.tga',Blocks[4].Texture[5],false);

    LoadTexture('data\tree\cora.tga',Blocks[5].Texture[0],false);
    LoadTexture('data\tree\cora.tga',Blocks[5].Texture[1],false);
    LoadTexture('data\tree\cora.tga',Blocks[5].Texture[2],false);
    LoadTexture('data\tree\cora.tga',Blocks[5].Texture[3],false);
    LoadTexture('data\tree\corat.tga',Blocks[5].Texture[4],false);
    LoadTexture('data\tree\corat.tga',Blocks[5].Texture[5],false);

    LoadTexture('data\tree\list.tga',Blocks[6].Texture[0],false);
    LoadTexture('data\tree\list.tga',Blocks[6].Texture[1],false);
    LoadTexture('data\tree\list.tga',Blocks[6].Texture[2],false);
    LoadTexture('data\tree\list.tga',Blocks[6].Texture[3],false);
    LoadTexture('data\tree\list.tga',Blocks[6].Texture[4],false);
    LoadTexture('data\tree\list.tga',Blocks[6].Texture[5],false);

    LoadTexture('data\sand\sand.tga',Blocks[7].Texture[0],false);
    LoadTexture('data\sand\sand.tga',Blocks[7].Texture[1],false);
    LoadTexture('data\sand\sand.tga',Blocks[7].Texture[2],false);
    LoadTexture('data\sand\sand.tga',Blocks[7].Texture[3],false);
    LoadTexture('data\sand\sand.tga',Blocks[7].Texture[4],false);
    LoadTexture('data\sand\sand.tga',Blocks[7].Texture[5],false);

    LoadTexture('data\Grass\dn.tga',Blocks[8].Texture[0],false);
    LoadTexture('data\Grass\dn.tga',Blocks[8].Texture[1],false);
    LoadTexture('data\Grass\dn.tga',Blocks[8].Texture[2],false);
    LoadTexture('data\Grass\dn.tga',Blocks[8].Texture[3],false);
    LoadTexture('data\Grass\dn.tga',Blocks[8].Texture[4],false);
    LoadTexture('data\Grass\dn.tga',Blocks[8].Texture[5],false);

    LoadTexture('data\window\wind.tga',Blocks[9].Texture[0],false);
    LoadTexture('data\window\wind.tga',Blocks[9].Texture[1],false);
    LoadTexture('data\window\wind.tga',Blocks[9].Texture[2],false);
    LoadTexture('data\window\wind.tga',Blocks[9].Texture[3],false);
    LoadTexture('data\window\wind.tga',Blocks[9].Texture[4],false);
    LoadTexture('data\window\wind.tga',Blocks[9].Texture[5],false);


    LoadTexture('data\Blocktex\bluecloud_rt.jpg',Sky.Texture[0],false);
    LoadTexture('data\Blocktex\bluecloud_lf.jpg',Sky.Texture[1],false);
    LoadTexture('data\Blocktex\bluecloud_bk.jpg',Sky.Texture[2],false);
    LoadTexture('data\Blocktex\bluecloud_ft.jpg',Sky.Texture[3],false);
    LoadTexture('data\Blocktex\bluecloud_dn.jpg',Sky.Texture[4],false);
    LoadTexture('data\Blocktex\bluecloud_up.jpg',Sky.Texture[5],false);
end;

procedure Load_Game_Models();
begin
  TObj := TGLMultyMesh.Create;
  TObj.LoadFromFile('GRE\sphere.gms');
  TObj.Extent := true;
  TObj.fSmooth := false; // ���������� � ������
end;



Procedure RenderBox();
begin
glPushMatrix;
glBegin(GL_QUADS);
    glNormal3f( 0.0, 0.0, 1.0);
    glTexCoord2f(0.0, 0.0); glVertex3f(-1.0, -1.0,  1.0);
    glTexCoord2f(1.0, 0.0); glVertex3f( 1.0, -1.0,  1.0);
    glTexCoord2f(1.0, 1.0); glVertex3f( 1.0,  1.0,  1.0);
    glTexCoord2f(0.0, 1.0); glVertex3f(-1.0,  1.0,  1.0);
   glEnd; glPopMatrix;  glPushMatrix;
   glBegin(GL_QUADS);
    glNormal3f( 0.0, 0.0,-1.0);
    glTexCoord2f(1.0, 0.0); glVertex3f(-1.0, -1.0, -1.0);
    glTexCoord2f(1.0, 1.0); glVertex3f(-1.0,  1.0, -1.0);
    glTexCoord2f(0.0, 1.0); glVertex3f( 1.0,  1.0, -1.0);
    glTexCoord2f(0.0, 0.0); glVertex3f( 1.0, -1.0, -1.0);
   glEnd;    glPopMatrix;  glPushMatrix;
   glBegin(GL_QUADS);
    glNormal3f( 0.0, 1.0, 0.0);
    glTexCoord2f(0.0, 1.0); glVertex3f(-1.0,  1.0, -1.0);
    glTexCoord2f(0.0, 0.0); glVertex3f(-1.0,  1.0,  1.0);
    glTexCoord2f(1.0, 0.0); glVertex3f( 1.0,  1.0,  1.0);
    glTexCoord2f(1.0, 1.0); glVertex3f( 1.0,  1.0, -1.0);
   glEnd();  glPopMatrix;  glPushMatrix;
   glBegin(GL_QUADS);
    glNormal3f( 0.0,-1.0, 0.0);
    glTexCoord2f(1.0, 1.0); glVertex3f(-1.0, -1.0, -1.0);
    glTexCoord2f(0.0, 1.0); glVertex3f( 1.0, -1.0, -1.0);
    glTexCoord2f(0.0, 0.0); glVertex3f( 1.0, -1.0,  1.0);
    glTexCoord2f(1.0, 0.0); glVertex3f(-1.0, -1.0,  1.0);
   glEnd();  glPopMatrix;
                 glPushMatrix;
   glBegin(GL_QUADS);
    glNormal3f( 1.0, 0.0, 0.0);
    glTexCoord2f(1.0, 0.0); glVertex3f( 1.0, -1.0, -1.0);
    glTexCoord2f(1.0, 1.0); glVertex3f( 1.0,  1.0, -1.0);
    glTexCoord2f(0.0, 1.0); glVertex3f( 1.0,  1.0,  1.0);
    glTexCoord2f(0.0, 0.0); glVertex3f( 1.0, -1.0,  1.0);
   glEnd();  glPopMatrix;

   glBegin(GL_QUADS);  glPushMatrix;
    glNormal3f(-1.0, 0.0, 0.0);
    glTexCoord2f(0.0, 0.0); glVertex3f(-1.0, -1.0, -1.0);
    glTexCoord2f(1.0, 0.0); glVertex3f(-1.0, -1.0,  1.0);
    glTexCoord2f(1.0, 1.0); glVertex3f(-1.0,  1.0,  1.0);
    glTexCoord2f(0.0, 1.0); glVertex3f(-1.0,  1.0, -1.0);
  glEnd(); glPopMatrix;
end;

procedure RenderFlore(x,y,size:integer; Texture:Uint);
begin
glTranslatef(x,y,-10);
glPushMatrix;
glBindTexture(GL_TEXTURE_2D,Texture);
glBegin(GL_QUADS);
    //glNormal3f( 0.0, 0.0, 1.0);
    glTexCoord2f(0.0, 0.0); glVertex3f(-1.0*size, -1.0*size,  1.0);
    glTexCoord2f(1.0, 0.0); glVertex3f( 1.0*size, -1.0*size,  1.0);
    glTexCoord2f(1.0, 1.0); glVertex3f( 1.0*size,  1.0*size,  1.0);
    glTexCoord2f(0.0, 1.0); glVertex3f(-1.0*size,  1.0*size,  1.0);
   glEnd;
glPopMatrix;
glTranslatef(-x,-y,+10);
end;

procedure RenderGMSModel(x,y,z,size:integer; model:TGLMultyMesh; Texture:Uint);
begin
         glBindTexture(GL_TEXTURE_2D,Texture);
        glTranslatef(x,y,z);
          glPushMatrix;
            glScalef(size,size,size);
            model.Draw;
          glPopMatrix;
        glTranslatef(-x,-y,-z);
end;

end.
 