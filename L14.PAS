{     Продемонстрировать процесс соударения двух  упругих  шаров
      разной массы, но  из  одинакового  материала,  двигающихся
      навстречу друг другу по параллельным траекториям, расстоя-
      ние между которыми Н. Задаются массы шаров и их  начальные
      скорости.                                                }
program lab14;
uses crt,graph;
const h=10;
      m1=3;
      m2=1;
      v1=2;
      v2=3;
type shar=object
       r:word;
       constructor init;
       procedure cir(x0,y0,color:word);
       procedure mov(t1,v1,t2,v2:word; t:real);
       function e(h:word):word;
      end;
constructor shar.init;
 begin
  r:=10;
 end;
procedure shar.cir(x0,y0,color:word);
begin
  setcolor(color);
  circle(x0,y0,r);
  setfillstyle(1,color);
  floodfill(x0,y0,color);
end;
procedure shar.mov(t1,v1,t2,v2:word; t:real);
begin
 while (t1<getmaxx-r-1)and(r+1<t1) and (v1<getmaxy-r-1)and(r+1<v1)  and
       (t2<getmaxx-r-1)and(r+1<t2) and (v2<getmaxy-r-5)and(r+1<v2)
 do
 begin
   cir(t1,v1,4);
   cir(t2,v2,2);
   delay(350);
   cir(t1,v1,15);
   cir(t2,v2,15);
   v1:=v1-m2;
   v2:=v2+m1;
 end;
 cir(t1,v1,4);
 cir(t2,v2,2);
end;
function shar.e(h:word):word;
 begin
  e:=round(sqrt(r*r-(h*h)/4));
 end;
var i,j,e,x1,y1,x2,y2:word;
    k:real;
    sh:shar;
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
BEGIN
 grinit;
 sh.init;
 setfillstyle(1,15);
 floodfill(1,1,15);
 delay(30000);
 i:=sh.r;
 j:=getmaxx-sh.r;
 while (i+sh.e(h)<j-sh.e(h)) do
 begin
   sh.cir(i,200,4);
   sh.cir(j,200+h,2);
   delay(350);
   sh.cir(i,200,15);
   sh.cir(j,200+h,15);
   i:=i+v1;
   j:=j-v2;
 end;
 x1:=i; y1:=200;
 x2:=j; y2:=200+h;
 if h>=2*sh.r then
 begin
   while (i+2*sh.r<getmaxx)and(2*sh.r<j) do
   begin
     sh.cir(i,200,4);
     sh.cir(j,200+h,2);
     delay(350);
     sh.cir(i,200,15);
     sh.cir(j,200+h,15);
     i:=i+v1;
     j:=j-v2;
   end;
   sh.cir(i,200,4);
   sh.cir(j,200+h,2);
 end;
 if h<2*sh.r then
 begin
   k:=h/sh.e(h)*2;
   sh.mov(x1,y1,x2,y2,k);
 end;
readln;
closegraph;
END.