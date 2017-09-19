
{ Заменить в файле каждое вхождение указанной цепочки на заданную
 другую (возможно дpугой длины) в группе из K строк, начиная со
 строки N.
 На экран дисплея вывести количество замененных цепочек. }
program lab8;
{uses ;}
var f,g:text;
    st,bf,bc:string;
    k,n,i,s:integer;

procedure zamena( var st:string );
var str:string;
    i,t:integer;
 begin
  str:='';
  t:=0;
  while pos(bf,st)<>0 do
   begin
    for i:=1 to (pos(bf,st)-1) do str:=str+st[i];
    delete(st,1,pos(bf,st)-1+length(bf));
    t:=t+1;
    str:=str+bc;
   end;
  str:=str+st;
  s:=s+t;
  st:=str;
 end;
BEGIN
 {clrscr;}
 s:=0;
 write('Введите  n=');         readln(n);
 write('Введите  k=');         readln(k);
 write('Укажите цепочку');     readln(bf);
 write('Задайте др. цепочку'); readln(bc);
 assign(f,'C:\1\Vitali\Pascal\Infor\L08\file1.pas');
 assign(g,'C:\1\Vitali\Pascal\Infor\L08\file2.pas');
 {$I-}
 reset(f);
 {$I+}
 if ioresult<>0 then begin write('error'); halt; end;
 {$I-}
 rewrite(g);
 {$I+}
 if ioresult<>0 then begin write('error'); halt; end;
 i:=0;
 while not(eof(f)) do
  begin
   i:=i+1;
   readln(f,st);
   if (i<n)or(i>=(n+k))and(n>0)and(k>0) then writeln(g,st);
   if (i>=n)and(i<(n+k))and(n>0)and(k>0) then
    begin
     zamena(st);
     writeln(g,st);
    end;
  end;
 close(f);
 close(g);
 writeln(s);
 readln;
END.




