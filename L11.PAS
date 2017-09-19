{  Дан односвязный линейный список из H объектов, каждый элемент
 которых - вектор символов длиной не более 10, состоящий из английских
 букв и цифр. Создать два односвязных списка. В первый список включить
 вектора, содержащие хотя бы одну цифру, расположив вектора в порядке
 возрастания произведений цифр. Во второй список включить оставшиеся
 вектора в алфавитном порядке по первой встреченной букве.  }
program lab11;
uses crt;
type inf=string[10];
type ptr=^el;
     el=record
       dn:inf;
       nx:ptr;
      end;
type spis=object
       p:ptr;
       constructor init;
       destructor done;
       procedure print;
       function empty:boolean;
       procedure push( d:inf);
       procedure del( d:inf);
       function pop:inf;
       function mxel:inf;
       function alf:inf;
      end;
var d:inf;  s,v,w,bf:spis;  i:word;
constructor spis.init;
 begin
   p:=nil;
 end;
procedure spis.push( d:inf);
 var q:ptr;
  begin
   new(q);
   q^.dn:=d;
   q^.nx:=p;
   p:=q;
  end;
function spis.pop:inf;
var q:ptr;
 begin
    q:=p;
    pop:=q^.dn;
    p:=q^.nx;
 end;
function spis.empty:boolean;
 begin
  empty:=(p=nil);
 end;
procedure spis.print;
var q,y,z:ptr;
 begin
   q:=p;
   y:=nil;
   while q<>nil do
   begin
     new(z);
     z^.dn:=q^.dn;
     z^.nx:=y;
     y:=z;
     q:=q^.nx;
   end;
   while y<>nil do
   begin
    writeln(' ',y^.dn);
    y:=y^.nx
   end;
 end;
function pr(d:inf):longint;
 const cif=['1','2','3','4','5','6','7','8','9','0'];
 var x,y:longint;   i,j,k:integer;
 begin
   j:=1;
   for i:=1 to length(d) do
   begin
      if d[i] in cif then
      begin
        val(d[i],y,k);
        if j=1 then x:=y;
        if j>1 then x:=x*y;
        j:=j+1;
      end;
   end;
   pr:=x;
 end;
function spis.mxel:inf;
 var q:ptr;  i:word; d,dmxel:inf;  x:longint;
 begin
  q:=p;
  i:=1;
  while q<>nil do
  begin
    d:=q^.dn;
    if i=1 then dmxel:=d;
    if i>1 then
     begin
      if pr(dmxel)<pr(d) then  dmxel:=d;
     end;
    q:=q^.nx;
    i:=i+1;
   end;
  mxel:=dmxel;
 end;
procedure spis.del( d:inf);
var q,t:ptr;
begin
 q:=p;
 if q^.dn=d then
 begin
  p:=p^.nx;
  dispose(q);
  exit;
 end;
 while q<>nil do
 begin
   if (q^.nx^.dn=d)and(q^.nx^.nx<>nil) then
      begin
       t:=q^.nx;
       q^.nx:=t^.nx;
       dispose(t);
       break;
      end;
   if (q^.nx^.dn=d)and(q^.nx^.nx=nil) then
      begin
       t:=q^.nx;
       q^.nx:=nil;
       dispose(t);
       break;
      end;
   q:=q^.nx;
 end;
end;
function cifra(d:inf):boolean;
 const cif=['1','2','3','4','5','6','7','8','9','0'];
 var f:boolean;
     i:integer;
 begin
   f:=false;
   for i:=1 to length(d) do  if d[i] in cif then f:=true;
   cifra:=f
  end;
function spis.alf:inf;
var q:ptr; d,dalf:inf; i:word;
 begin
  q:=p;    i:=1;
  while q<>nil do
  begin
    d:=q^.dn;
    if i=1 then dalf:=d;
    if i>1 then
     begin
       if d[1]<dalf[1] then dalf:=d;
     end;
    q:=q^.nx;
    i:=i+1;
  end;
  alf:=dalf;
 end;
destructor spis.done;
 var q:ptr;
 begin
   while p<>nil do
   begin
     q:=p;
     p:=q^.nx;
     dispose(q);
   end;
 end;
BEGIN
clrscr;
s.init; v.init; w.init; bf.init;
writeln('---------- Bведите------------------------------------------------');
 for i:=1 to 10 do
  begin
   readln(d);
   s.push(d);
  end;
writeln('----------------------------0-------------------------------------');
  bf:=s;
 while not(bf.empty) do
  begin
   d:=bf.pop;
   if cifra(d) then w.push(d) else v.push(d);
  end;
 s.print;
writeln('----------------------------1-------------------------------------');
  bf:=w;
  w.init;
 while not(bf.empty) do
 begin
   d:=bf.mxel;
   w.push(d);
   bf.del(d);
 end;
 w.print;
writeln('----------------------------2-------------------------------------');
 bf:=v;
 v.init;
 while not(bf.empty) do
 begin
   d:=bf.alf;
   v.push(d);
   bf.del(d);
 end;
 v.print;
writeln('------------------------------------------------------------------');
 readln;
 s.done; w.done; v.done;
END.