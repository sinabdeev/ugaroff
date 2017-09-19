
{   Проверка правильности расстановки скобок
  Дана последовательность символов в виде некоторого
  математического выражения, в котором встречаются круглые,
  квадратные и фигурные скобки.
  Определить, обладает ли эта последовательность свойством
  правильного скобочного выражения.
  Результат анализа, а также наибольшую обнаруженную глубину
  скобочного выражения поместить в файл (FOut). }
program lab9 ;
Type Rec1= record
               Nomer   : word;            {- номер записи в файле ---}
               Express : array[1..64] of char; {- последовательность-}
              end;
     Rec2= record
                 Nomer : word;      {- номер записи в файле --------}
                 Rez   : boolean;   {- результат анализа -----------}
                 Depth : integer;   {- глубина скобочного выражения }
              end;

var f:file of Rec1;
    g:file of Rec2;
    tf:Rec1;
    tg:Rec2;
    b:boolean;
    d,depth,sl,sg,ql,qg,i:integer;
    j:word;
    m,n: string;
const    z=['(' , ')' , '[' , ']' , '{' , '}'];
         l=['[' , '{' , '('];
         p=[']' , '}' , ')'];
procedure prov;
 var str,i:integer;
  begin str:=length(m);
  while sg>0 do
   begin
   for i:=1 to sg do
    begin
     if ((m[sl-sg+i]='{')and(m[sl+sg+1-i]<>'}'))or
        ((m[sl-sg+i]='[')and(m[sl+sg+1-i]<>']'))or
        ((m[sl-sg+i]='(')and(m[sl+sg+1-i]<>')'))
     then begin b:=false; delete(m,1,length(m)); sg:=0; break; end;
    end;
   if (m[sl-sg+1]='(')and(m[sl+sg]=')') then
   begin
   delete(m,sl-sg+1,1);
   delete(m,sl+sg-1,1);
   sl:=sl-1;
   sg:=sg-1;
   end;

   if (m[sl-sg+1]='[')and(m[sl+sg]=']') then
   begin
   delete(m,sl-sg+1,1);
   delete(m,sl+sg-1,1);
   sl:=sl-1;
   sg:=sg-1;
   end;

   if (m[sl-sg+1]='{')and(m[sl+sg]='}') then
   begin
   delete(m,sl-sg+1,1);
   delete(m,sl+sg-1,1);
   sl:=sl-1;
   sg:=sg-1;
   end;

  end;
  if str-length(m)=0  then b:=false;
 end;
procedure gl;
 var j:integer;
 begin sl:=0;
  for j:=1 to length(m) do
  if m[j] in l then sl:=sl+1 else break;
 end;
procedure gp;
 var j:integer;
 begin  sg:=0;
  for j:=sl+1 to length(m) do
  if m[j] in p then sg:=sg+1 else break;
 end;
procedure dl;
 var j:integer;
 begin ql:=0;
  for j:=1 to length(n) do
  if n[j] in l then ql:=ql+1 else break;
 end;
procedure dp;
 var j:integer;
 begin  qg:=0;
  for j:=ql+1 to length(n) do
  if n[j] in p then qg:=qg+1 else break;
 end;
Procedure  zed1;
Begin
  b:=true;
 if length(m)=0 then b:=false;
 while length(m)>0 do
  begin
  gl; gp;
  if sl<sg then
    begin
     b:=false;
     delete(m,1,sl+sg);
    end;
  if sg=0 then begin b:=false; delete(m,1,sl); end;
  if (sl>=sg)and(sg<>0) then prov;
  end;
End;
procedure  zed2;
Begin
 depth:=0;
 while length(n)>0 do
  begin
   dl; dp;
   if (qg=0)or(ql=0) then delete(n,1,length(n));
   if (ql>=qg)and(qg>0) then
    begin
     d:=0;
     for i:=1 to qg do
     begin
      if ((n[ql-qg+i]='{')and(n[ql+qg+1-i]='}'))or
         ((n[ql-qg+i]='[')and(n[ql+qg+1-i]=']'))or
         ((n[ql-qg+i]='(')and(n[ql+qg+1-i]=')'))
      then d:=d+1;
     end;
     if d>depth then depth:=d;
     delete(n,ql-qg+1,2*qg);
    end;

   if (qg>ql)and(ql>0) then
    begin
     d:=0;
     for i:=1 to ql do
      begin
       if ((n[ql-i+1]='{')and(n[ql+i]='}'))or
          ((n[ql-i+1]='[')and(n[ql+i]=']'))or
          ((n[ql-i+1]='(')and(n[ql+i]=')'))
       then d:=d+1;
      end;
     if d>depth then depth:=d;
     delete(n,1,2*ql);
    end;

  end;
End;
BEGIN
 writeln(' ');
 assign(f,'file1.pas');
 assign(g,'file2.pas');

 {$I-}
rewrite(g);
 {$I+}
if ioresult<>0 then begin write('error'); halt; end;

 {$I-}
reset(f);
 {$I+}
if ioresult<>0 then begin write('error'); halt; end;


 j:=1;
 while not(eof(f)) do
  begin
   read(f,tf);
   for i:=1 to length(tf.express) do
   if tf.express[i] in z then m:=m+tf.express[i];
   n:=m;
   writeln(tf.Nomer,' ',tf.express);
   zed1;
   zed2;
   tg.Rez:=b;
   tg.Depth:=depth;
   tg.Nomer:=j;
   j:=j+1;
   writeln(tg.nomer,' ',tg.rez,' ',tg.depth);
   write(g,tg)
  end;

 close(f);
 close(g);
 readln;
END.
