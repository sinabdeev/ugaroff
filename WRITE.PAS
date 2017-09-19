Program s1;
type Rec1= record
               Nomer   : word;            {- номер записи в файле ---}
               Express : array[1..64] of char; {- последовательность-}
           end;

var f:file of Rec1;
    tf1,tf2,tf3,tf4:Rec1;
begin
 readln;
 tf1.nomer:=1;
 tf1.express[1]:='(';     {(2+2)*2}
 tf1.express[2]:='2';
 tf1.express[3]:='+';
 tf1.express[4]:='2';
 tf1.express[5]:=')';
 tf1.express[6]:='*';
 tf1.express[7]:='2';

 assign(f,'file1.pas');
 {$I-}
 rewrite(f);
 {$I+}
 if ioresult<>0 then begin write('error'); halt; end;

 write(f,tf1);
end.