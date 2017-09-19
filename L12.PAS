{  Дана последовательность вещественных чисел, завеpшающаяся 0.
   Постpоить для нее деpево поиска и pаспечатать его, указав для
  главного коpня число веpшин в пpавом и левом поддеpевьях.
   Исключить из деpева все элементы, не попадающие в интеpвал от Х
  до У и pаспечатать пpеобpазованное деpево.
   Опpеделить в новом деpеве значение и уpовень максимального элемента.}
program lab12;
uses graph;
const k=0;
      h=0;
type ptr=^tree;
    tree=object
       b:boolean;
       dn:real;
       ln:ptr;
       rn:ptr;
       constructor init;
       destructor done;
       procedure print(k:word);
       procedure push( d:real);
       procedure zed(h:word);
       procedure put;
       procedure del;
       function boss:real;
      end;
var p:tree;
    main,maxlevel,level,maxel,rig,left:real;
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
constructor tree.init;
 begin
   b:=true;
 end;
function tree.boss:real;
begin
 boss:=dn;
end;
procedure tree.push(d:real);
 var bf:boolean;
 begin
  bf:=b;
  if bf=true then
         begin
             b:=false;
             dn:=d;
             new(ln,init);
             new(rn,init);
         end;
  if bf=false then
         begin
            if d<dn then ln^.push(d)
            else rn^.push(d);
         end;
 end;
procedure tree.put;
var d:real;
    f:text;
begin
  assign(f,'c:\1\Vitali\pascal\infor\l12\txt.pas');
  {$I-}
  reset(f);
  {$I+}
  if ioresult<>0 then begin write('error'); halt; end;
 repeat
  readln(f,d);
  if d<>0 then p.push(d);
 until d=0;
 close(f);
end;
procedure tree.zed(h:word);
begin
 if not b then
 begin
  ln^.zed(h+1);
    if maxel<dn then
    begin
     level:=h;
     maxel:=dn;
    end;
    if dn<main then left:=left+1;
    if dn>main then  rig:=rig+1;
    if h>maxlevel then maxlevel:=h;
  rn^.zed(h+1);
 end;
end;
procedure tree.print(k:word);
begin
  if not b then
   begin
     ln^.print(k+10);
     writeln(dn:k:2);
     rn^.print(k+10);
   end;
end;
procedure tree.del;
const x=5;
      y=7;
var   lev:real;

  procedure zam( var p:ptr);
  var p1,p2:ptr;
  begin
   p1:=p;
   while not p1^.rn^.b do
   p1:=p1^.rn;
   lev:=p1^.dn;
   if p1^.ln^.b then
     begin
       dispose(p1);
       p1^.b:=true;

     end;
   if not p1^.ln^.b then
     begin
      p2:=p1^.ln;
      dispose(p1);
      p1:=p;
      while not p1^.rn^.rn^.b do p1:=p1^.rn;
      p1^.rn:=p2;
     end;
  end;

  procedure dis( var t:ptr);
  var t1:ptr;
  begin
   if not t^.b then
   begin
     dis(t^.ln);
     if (x<t^.dn)and(t^.dn<y) then
     begin
       if (t^.ln^.b)and(t^.rn^.b) then
        begin dispose(t); t^.b:=true; end;
       if (not t^.ln^.b)and(not t^.rn^.b) then
        begin zam(t^.ln); t^.dn:=lev; end;

       if (not t^.ln^.b)and(t^.rn^.b) then
        begin t1:=t^.ln; dispose(t); t:=t1; end;
       if (t^.ln^.b)and(not t^.rn^.b) then
        begin t1:=t^.rn; dispose(t); t:=t1; end;
     end;
     dis(t^.rn);
   end;
  end;
Begin
 dis(ln);
 dis(rn);
 if (x<dn)and(dn<y)and(not ln^.b)and(not rn^.b) then
  begin
   zam(ln);
   dn:=lev;
  end;
 writeln('   delete elements in ( ',x,' , ',y,' )');
End;
destructor tree.done;
begin
 if b=false then
 begin
   dispose(ln,done);
   dispose(rn,done);
 end;
end;
BEGIN
grinit;
p.init;
p.put;
 main:=p.boss;
 level:=0;
 maxlevel:=0;
 maxel:=p.boss;
 rig:=0;
 left:=0;
p.print(k);
p.zed(h);
 writeln(level:3:1,' level');
 writeln(maxel:3:1,' max');
 writeln(rig:3:1,' rig');
 writeln(left:3:1,' left');
readln;
closegraph;
grinit;
p.del;
p.print(k);
readln;
p.done;
closegraph;
END.
