{ ��-12, C�������� �.�. �.�13, ���.14, 03-07-02 }

program lab13;
{uses fifo;}

const MaxVertex = 30;                   { ����. �����. ���設 }
      MaxEdges  = 60;                   { ����. �����. ॡ��  }

type
    Edge = record From, Into : integer; end; { ॡ� � ���. � ���. ���設�� }
    Graf = object
        KolVertex:    0..MaxVertex;            { �����. ���設 }
        KolEdges:  0..MaxEdges;             { �����. ॡ��  }
        Edges:
          array [1..MaxEdges] of Edge;      { ���ᨢ ॡ��  }
        Used:
          array [1..MaxVertex] of boolean;  {��⪨ ���饭��� ���設}
        Numbers:
          array [1..MaxVertex] of integer;  {����� ������ ��-� � ��ॢ�}
        constructor Init (KV,KE:integer);
        procedure Print;
      end;

    constructor Graf.Init (KV,KE:integer);  { ���樠������ ��� }
        var i: integer;
        begin
          KolVertex:=KV;
          KolEdges:=KE;
          for i:=1 to KolVertex do
            begin
              Used[i]   :=false;
              Numbers[i]:=MaxInt;
            end;
        end;
 { ����� ॡ�� ���  }
    procedure Graf.Print;
        var i: integer;
        begin
          for i:=1 to KolEdges do
          write('(',Edges[i].From:2,Edges[i].Into:2,') ');
          writeLn;
        end;

  var Gra: Graf;

  { �⨫���.}

  function Another (NE,First:integer; var Second:integer): boolean;
           {�����頥� ����� "��㣮�" ���設� ॡ� � ����஬ NE}
   begin                         { ��� ���ਥ��஢����� ��䮢 }
    Another:=true;
    with Gra.Edges[NE] do
      if First=From then Second:=Into
                    else if First=Into then Second :=From
                                       else Another:=false;
   end;

  { 2� ᯮᮡ - �� �᭮�� ���᪠ � ��㡨��, ��. Depth.}
  { � ���ᨢ� Numbers - ����� ������ ��-� � ��ॢ� (��稭��� � 0).}
procedure Ostov2 (var Tree:Graf);

 procedure toDepth (Vertex:integer);
 var I,Neue: integer;
 begin
   with Tree do
   begin
      Numbers[Vertex]:=KolEdges;
      for I:=1 to Gra.KolEdges do
      if Another(I,Vertex,Neue) and (Numbers[Neue]=MaxInt) then
      begin
        inc(KolEdges);
        with Edges[KolEdges] do
         begin   {���塞 "�ਥ����" ॡ��}
          From:=Vertex;
          Another(I,Vertex,Into);
         end;
        toDepth(Neue);
      end;
   end;
 end;
  begin
    with Gra do Init(KolVertex,KolEdges);
    Tree.Init(Gra.KolVertex,0);
    toDepth(Gra.Edges[1].From);
  end;


{ ����஥��� ��⮢���� ��ॢ�.  �� �᭮�� ���᪠ � �ਭ�.}
procedure Ostov1 (var Tree:Graf);
 var I,J: integer;
 begin
  with Gra do
  begin
    Init(KolVertex,KolEdges);
    Tree.Init(KolVertex,0);
    for I:=1 to KolEdges do
      if (not Used[Edges[I].From]) or
         (not Used[Edges[I].Into])
      then  begin
          inc(Tree.KolEdges);
          Tree.Edges[Tree.KolEdges]:=Edges[I];
          Used[Edges[I].From]:=true;
          Used[Edges[I].Into]:=true;
        end;
  end;
 end;


const n=8;
    mas:array [1..2,1..8] of integer=((1,1,4,7,8,8,0,0),
                                      (3,4,5,1,5,3,3,0));
  sm:array[1..6,1..6] of integer=((0,1,1,1,1,0),
                                  (1,0,0,1,0,1),
                                  (1,0,0,1,0,1),
                                  (1,1,1,0,0,0),
                                  (1,0,0,0,0,1),
                                  (0,1,1,0,1,0));
var
 s:array[1..n,1..n] of integer;
 j,i1,i2,k:integer;
  I: integer;
  Tree,tree1: Graf;

BEGIN
 writeln;
{ writeln('----------------0-----------------------------------------');
 with Gra do  begin
      Init(6,8);
      Edges[1].From:=3; Edges[1].Into:=1;
      Edges[2].From:=1; Edges[2].Into:=2;
      Edges[3].From:=3; Edges[3].Into:=2;
      Edges[4].From:=3; Edges[4].Into:=4;
      Edges[5].From:=5; Edges[5].Into:=4;
      Edges[6].From:=2; Edges[6].Into:=6;
      Edges[7].From:=5; Edges[7].Into:=6;
      Edges[8].From:=6; Edges[8].Into:=5;
      writeln('��� ���ਥ��஢����:');
      Print;
    end;
  Ostov2(Tree);
  writeln('���.��ॢ�  �� �᭮�� ���᪠ � ��㡨�� :');
  Tree.Print;   }
writeln('----------------2-----------------------------------------');
   with Gra do
   begin
    Init(6,9);
    k:=1;
    For i:=1 to 6 do
      For j:=i to 6 do
        begin
          if sm[i,j]=1 then
            begin
              Edges[k].From:=i; Edges[k].Into:=j; k:=k+1;
            end;
        end;
      writeln('��� ���ਥ��஢����:');
      Print;
   end;
  Ostov2(Tree);
  writeln('���.��ॢ�  �� �᭮�� ���᪠ � ��㡨�� :');
  Tree.Print;
  writeln('----------------1-----------------------------------------');
 for j:=1 to n do
  begin
   for i1:=1 to n do
    for i2:=1 to n do
     begin
      if ((j=mas[1,i2])or(j=mas[2,i2]))   and
         ((i1=mas[1,i2])or(i1=mas[2,i2])) then
       begin
        s[j,i1]:=1;
        s[i1,j]:=1;
       end
      else
       begin
        s[i1,j]:=0;
        s[j,i1]:=0;
       end;
     end;
  end;
   with Gra do
   begin
    Init(5,7);
    k:=1;
    For i:=1 to 5 do
      For j:=i to 5 do
        begin
          if s[i,j]=1 then
            begin
              Edges[k].From:=i; Edges[k].Into:=j; k:=k+1;
            end;
        end;
      writeln('��� ���ਥ��஢����:');
      Print;
   end;
 ostov1(tree);
 writeln('���.��ॢ�  �� �᭮�� ���᪠ � �ਭ� :');
 Tree.Print;
{writeln('----------------2-----------------------------------------');
   with Gra do
   begin
    Init(6,9);
    k:=1;
    For i:=1 to 6 do
      For j:=i to 6 do
        begin
          if sm[i,j]=1 then
            begin
              Edges[k].From:=i; Edges[k].Into:=j; k:=k+1;
            end;
        end;
      writeln('��� ���ਥ��஢����:');
      Print;
   end;
  Ostov2(Tree);
  writeln('���.��ॢ�  �� �᭮�� ���᪠ � ��㡨�� :');
  Tree.Print;}
 readln;
End.
