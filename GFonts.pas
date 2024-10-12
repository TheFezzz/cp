unit GFonts;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OpenGL, DGLUT, Textures,command;


type
  FFont = record
    x,y,sim,Leg,a: integer;
 end;


var
  cis:integer;
  Sim:array[1..196] of string;
  FontI:array[1..196] of FFont;

procedure R3D_To_2D(ClientWidth, ClientHeight:integer);
procedure R2D_To_3D();


implementation
uses GUI,Resurce;




procedure Enable_Atest();
begin
  glEnable(GL_DEPTH_TEST);     // Включает тест глубины.
  glEnable(GL_NORMALIZE);      // Включает нормализацию нормалей.
  glEnable(GL_COLOR_MATERIAL); // Включает цветные материалы.
  glShadeModel(GL_SMOOTH);     // Устанавливает сглаживание (плавное изменение цветов).
end;

procedure Disable_Atest();
begin
  glDisable(GL_NORMALIZE);      // Отключает нормализацию нормалей.
  glDisable(GL_COLOR_MATERIAL); // Отключает цветные материалы.
  glDisable(GL_DEPTH_TEST);     // Отключает тест глубины.
end;

procedure R3D_To_2D(ClientWidth, ClientHeight: integer);
begin
  glPushMatrix;                  // Сохраняет текущую матрицу.
  glLoadIdentity;                // Сбрасывает текущую матрицу.
  glMatrixMode(GL_PROJECTION);   // Переключает в режим работы с проекционной матрицей.
  glPushMatrix;                  // Сохраняет проекционную матрицу.
  glLoadIdentity;                // Сбрасывает проекционную матрицу.
  gluOrtho2D(0, ClientWidth, ClientHeight, 0); // Устанавливает ортогональную проекцию.
  glMatrixMode(GL_MODELVIEW);    // Переключает в режим работы с модельно-видовой матрицей.
end;

procedure R2D_To_3D();
begin
  glMatrixMode(GL_PROJECTION); // Переключает в режим работы с проекционной матрицей.
  glPopMatrix;                 // Восстанавливает предыдущую проекционную матрицу.
  glMatrixMode(GL_MODELVIEW);  // Переключает в режим работы с модельно-видовой матрицей.
  glPopMatrix;                 // Восстанавливает предыдущую модельно-видовую матрицу.
end;


end.