
{ На экране построить семейство кривых, заданных функцией:
                                            2
  Y = 1.7·H·x + 7.8·U·sin(2.1·x) + 3.4·(x-1)  - 7.2;  [-3 < x < 3]

 Группа параметров H,U для построения семейства дана в текстовом
 файле.

                                        Цвет/заполнитель  Цвет/заполнитель
                                             внешнего        внутреннего
                                              контура.         контура.

    В правильный шестиугольник вписаны три     3 / 1           4 / 6
    одинаковые  окружности.
    Вводится сторона шестиугольника.

  6.  Параллельные штриховые прямые в вертикальном     ┌──────────────┐
      направлении (длина штриха равна 5, длина         │||||||||||||||│
      промежутка 3).                                   └──────────────┘

                                                       ┌──────────────┐
  1.  Точки с фиксированным расстоянием Р между        │. . . . . . . │
      ними.                                            └──────────────┘ }

program lab10 ;
uses graph;
const
      F1_Patern:
      FillPatternType=($88,$88,$88,$88,$88,$0,$0,$0);
      F2_Patern:
      FillPatternType=($88,$00,$00,$00,$88,$00,$00,$00);
const l=-8; r=8;

var h,u,max,min:real;
    f:text;
    cv:word;
    j:integer;

procedure grinit;
 var gdrive, gmode,errorcode:integer;
 begin
  gdrive:=detect;
  initgraph(  gdrive,gmode,'c:\lang\tp\bgi');
  errorcode:=graphresult;
  if errorcode<>grok then
   begin
    writeln(' ошибка ! ',errorcode);
    halt;
   end;
 end;
procedure maxmin;
type mr=array[1..2] of real;
var f1:file of mr;
    i:integer;
    dx,x,y:real;
    mr0:mr;
begin
 dx:=(r-l)/(getmaxx-1);

  assign(f1,'c:\1\Vitali\Pascal\Infor\L10\@@@@.@@@');
  {$I-}
  rewrite(f1);
  {$I+}
  if ioresult<>0 then begin write('error'); halt; end;

   for i:=1 to getmaxx do
   begin
    x:=l+(i-1)*dx;
    y:=1.7*h*x + 7.8*u*sin(2.1*x) + 3.4*(x-1)*(x-1)-7.2;
    mr0[1]:=x;
    mr0[2]:=y;
    write(f1,mr0);
   end;
   close(f1);

   {$I-}
   reset(f1);
   {$I+}
   if ioresult<>0 then begin write('error'); halt; end;
   while not(eof(f1)) do
   begin
    i:=filepos(f1);
    read(f1,mr0);
    if (i=0)and(j=0) then min:=mr0[2];
    if (i=0)and(j=0) then max:=mr0[2];
    if mr0[2]>max then max:=mr0[2];
    if mr0[2]<min then min:=mr0[2];
   end;
   close(f1);
end;

procedure  fun;
type mr=array[1..2] of real;
     mi=array[1..2] of integer;
var f1:file of mr;
    f2:file of mi;
    dx,x,y:real;
    mr0:mr;
    mi0:mi;
    i:integer;
begin
 dx:=(r-l)/(getmaxx-1);

  assign(f1,'c:\1\Vitali\pascal\Infor\L10\$$$$.$$$');
  {$I-}
  rewrite(f1);
  {$I+}
  if ioresult<>0 then begin write('error'); halt; end;

   for i:=1 to getmaxx do
   begin
    x:=l+(i-1)*dx;
    y:=1.7*h*x + 7.8*u*sin(2.1*x) + 3.4*(x-1)*(x-1)-7.2;
    mr0[1]:=x;
    mr0[2]:=y;
    write(f1,mr0);
   end;
   close(f1);

  assign(f2,'c:\1\Vitali\Pascal\Infor\l10\&&&&.&&&');
  {$I-}
  rewrite(f2);
  {$I+}
  if ioresult<>0 then begin write('error'); halt; end;

   {$I-}
   reset(f1);
   {$I+}
   if ioresult<>0 then begin write('error'); halt; end;

   while not(eof(f1)) do
   begin
    read(f1,mr0);
    mi0[1]:=round((mr0[1]-l)*(getmaxx-50)/(r-l))+30;
    mi0[2]:=getmaxy-round((mr0[2]-min)*(getmaxy-20)/(max-min))-10;
    write(f2,mi0);
   end;
    mi0[1]:=round((0-l)*(getmaxx-50)/(r-l))+30;
    mi0[2]:=getmaxy-round((0-min)*(getmaxy-20)/(max-min))-10;
    setcolor(15);
    line(3,mi0[2],getmaxx-3,mi0[2]);
    line(mi0[1],40,mi0[1],getmaxy-10);
    line(mi0[1],40,mi0[1]+3,50);
    line(mi0[1],40,mi0[1]-3,50);
    line(getmaxx-3,mi0[2],getmaxx-13,mi0[2]-3);
    line(getmaxx-3,mi0[2],getmaxx-13,mi0[2]+3);
    outtextxy(mi0[1]-13,40,'y');
    outtextxy(getmaxx-18,mi0[2]+7,'x');


   close(f2);
   {$I-}
   reset(f2);
   {$I+}
   if ioresult<>0 then begin write('error'); halt; end;
   while not(eof(f2)) do
   begin
    read(f2,mi0);
    putpixel(mi0[1],mi0[2],cv);
   end;
   close(f1);
   close(f2);
end;

procedure  ris;
var s,br,mr,x,y,side:integer;
begin
x:=320;
y:=240;
write('side='); readln(side);
s:=round(3*side/2);
br:=round(s/sqrt(3));
mr:=round((br*sqrt(3) )/(2+sqrt(3) ));
setcolor(1);
circle(x,y+br-mr,mr);
circle(x-mr,y-round( mr/sqrt(3) ),mr);
circle(x+mr,y-round( mr/sqrt(3) ),mr);
line(x-round(side/2),y-br,x+round(side/2),y-br);
line(x-round(side/2),y+br,x+round(side/2),y+br);
 line(x-round(br*2/sqrt(3)),y,x-round(side/2),y-br);
 line(x-round(br*2/sqrt(3)),y,x-round(side/2),y+br);
line(x+round(br*2/sqrt(3)),y,x+round(side/2),y-br);
line(x+round(br*2/sqrt(3)),y,x+round(side/2),y+br);
 setfillpattern(f1_patern,3);
 setfillstyle(12,3);
 floodfill(x,y,1);
 floodfill(x,y-br+5,1);
 floodfill(x+round(br*2/sqrt(3))-5,y,1);
 floodfill(x-round(br*2/sqrt(3))+5,y,1);
 setfillpattern(f2_patern,4);
 setfillstyle(12,4);
 floodfill(x,y+br-mr,1);
 floodfill(x-mr,y-round( mr/sqrt(3) ),1);
 floodfill(x+mr,y-round( mr/sqrt(3) ),1);
end;

begin
grinit;
ris;
setcolor(14);
rectangle(0,0,getmaxx,getmaxy);
readln;
closegraph;
grinit;
setviewport(0,0,getmaxx,getmaxy,true);
setcolor(14);
rectangle(0,0,getmaxx,getmaxy);
setcolor(15);
outtextxy(130,20,' y=1.7*h*x+7.8*u*sin(2.1*x)+3.4*(x-1)^2-7.2');

 assign(f,'c:\1\Vitali\Pascal\Infor\L10\text.pas');
 {$I-}
 reset(f);
 {$I+}
 if ioresult<>0 then begin write('error'); halt; end;
   cv:=1;
   j:=0;
 while not(eof(f)) do
  begin
   readln(f,h);
   readln(f,u);
   maxmin;
   j:=j+1;
  end;
  close(f);

 {$I-}
 reset(f);
 {$I+}
 if ioresult<>0 then begin write('error'); halt; end;
 while not(eof(f)) do
  begin
   readln(f,h);
   readln(f,u);
   fun;
   cv:=cv+1;
   readln;
  end;
 close(f);

closegraph;
end.
