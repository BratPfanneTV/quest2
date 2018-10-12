@Echo off
::SokoBox
::Version: 1.4.2
::Author: Carlos Montiers A.
::Release: 2013,2018.
::Require BG v3.9 se
SetLocal EnableExtensions EnableDelayedExpansion
Cls
If Not Exist BG.exe (
Echo. BG.exe was not found.
Goto :Eof
)
Color 37
BG Font 6
BG Cursor 0
Mode Con Cols=40 Lines=32
Set "sokobox_file=!UserProfile!\sokobox.dat"
Set /a "S.M.X=2,S.M.Y=2"
Set "fb=\DB\DB\DB\DB"
Set "tb=\20\DB\DB\20"
Set "fs=\20\20\20\20"
Set "mc=\DB\20\20\DB"
Set "g.0=0 %fb%\n%fb%\n%fb%\n%fb%"
Set "g.1=88 %fb%\n%fb%\n%fb%\n%fb%"
Set "g.2=E %fs%\n\20\B1\B1\20\n\20\B1\B1\20\n%fs%"
Set "g.3=A %tb%\n\DB E \B1\B1 A \DB\n\DB E \B1\B1 A \DB\n%tb%"
Set "g.4=A %tb%\n%mc%\n%mc%\n%tb%"
Set "g.5=E \20 E0 \E4\E4 E \20\n%fb%\n%tb%\n%mc%"
Set "g.6=E \20 E0 \E4\E4 E \20\n%fb%\n A \DB"
Set "g.6=!g.6! E \DB\DB A \DB\n E \DB A \DB\DB E \DB"
Set "g.7=33 %fb%\n%fb%\n%fb%\n%fb%"
Set "g.8=0 %fb%\n%fb%\n%fb%\n%fb%"
Set /a "r.0=5,r.2=5,r.3=6,r.4=6,r.5=0,r.6=4"
Set /a "r.b.0=2,r.b.2=0,r.b.3=4,r.b.4=3"
Set /a "g22=0,g23=-1,g32=1,g33=0"
BG Print 9B "\FE SokoBox                              \FE\n"
BG Print 37 "Push all boxes to storage locations.\n"
BG Print 37 "A box cannot be pulled.\n\n"
BG Print 37 "For move: \18\19\1A\1B\nFor restart: Intro\n"
BG Print 37 "For quit: Esc twice\n\nPress any key for continue ..."
BG Kbd
:Menu
Set "sol_level=0"
If Not Exist "!sokobox_file!" Echo !sol_level!>"!sokobox_file!"
For /f "usebackq" %%# in (
"!sokobox_file!") do Set "sol_level=%%#"
Set /a "nlevel=1+!sol_level!"
Set "level=!nlevel!"
Set "limit_levels=!nlevel!"
Set "show_nlevel=!nlevel!"
If !nlevel! Gtr 170 (Set "level=0"
Set "limit_levels=170"
Set "show_nlevel=")
If !level! Lss 1 (Set index=0) Else If !level! Lss 10 (
Set index=1) Else If !level! Lss 100 (
Set index=2) Else (Set index=3)
:ChLevelM
Cls
BG Print 9B "\FE SokoBox                              \FE\n"
BG Print 37 "Choose Level [1-!limit_levels!]:!show_nlevel!"
:ChLevel
BG Kbd
Set "k=!ErrorLevel!"
Set /a "v=0"
For %%a in (8 13 48 49 50 51 52 53 54 55 56 57 27
) Do If %%a Equ !k! Set /a "v=1"
If !v! Equ 0 Goto ChLevel
If !k! Equ 8 (If !index! Gtr 0 (BG Print 37 "\8\20\8"
Set /a "index-=1,level/=10")
) Else If !k! Equ 13 (
If !level! Geq 1 If !level! Leq !limit_levels! Goto PlayLoop
) Else If !k! Equ 27 (Goto End
) Else If !index! Lss 3 (Set /a "k-=48"
Set /a "lev_c=!level!*10+(!k!)"
If !lev_c! Geq 1 If !lev_c! Leq !limit_levels! (
BG Print 37 "!k!"
Set /a "index+=1,level=!lev_c!"))
Goto ChLevel
:PlayLoop
Call:Play !level!
If !ErrorLevel! Equ 1 Goto PlayLoop
If !ErrorLevel! Equ 2 Goto Menu
If !level! Geq !nlevel! Echo !level!>"!sokobox_file!"
Set /a "s.x+=1"
BG Locate !s.x! 1
BG Print CE "Very Good\13"
BG Sleep 2000
If !level! Geq 170 (Cls
BG Print FC "Congratulations\13\nAll Levels Clear\13\n\n"
BG Print FC "Design of Levels: Jordi Domenech.\n\n"
BG Print FC "Programming: Carlos Montiers A.\n\n"
BG Print 0F "         \nGAME OVER\n         \n         "
For /L %%X in (5,1,28) do (BG FCPrint 9 %%X %g.5%
BG Sleep 75
BG FCPrint 9 %%X %g.8%)
For /L %%Y in (9,1,36) do (BG FCPrint %%Y 28 %g.5%
BG Sleep 75
BG FCPrint %%Y 28 %g.8%)
BG FCPrint 15 17 CF "Press any key for quit"
BG Kbd
Goto End)
Set /a "level+=1"
Goto PlayLoop
:Play
Set "self=%~f0"
Set /a "numlevel=%~1"
Set /a "n=111111111,o=11111111,p=1111111,q=111111,r=11111,s=1111"
For /f "tokens=2 delims== " %%a in (
'Findstr.exe /B "%1^=" "!self!"') do Call :SetLvl "%%a%"
For /F "tokens=1-8 delims=," %%a in ("!l.src!") do (Set l.d=%%h
Set /a "l.d.fw=%%a+1,l.d.w=%%a,l.d.h=%%b,l.d.g=%%c"
Set /a "l.p.v=%%d,l.p.i=%%e,l.p.r=%%f,l.p.c=%%g")
Set "extraspace=                    "
If !numlevel! Lss 10 Set "extraspace= !extraspace!"
If !numlevel! Lss 100 Set "extraspace= !extraspace!"
Cls &BG Print 9B "\FE SokoBox level !numlevel!!extraspace!\FE"
Set /a "s.x=S.M.X"
For /L %%r in (0,1,%l.d.h%) do (Set /a "s.y=S.M.Y"
For /L %%c in (0,1,%l.d.w%) do (Set /a "l.d.i=%%r*l.d.fw+%%c"
For %%i in (!l.d.i!) do Set "l.d.v=!l.d:~%%i,1!"
For %%v in (!l.d.v!) do (BG FCPrint !s.y! !s.x! !g.%%v!
Set /a s.y+=4))
Set /a s.x+=4)
:GetMov
Set /a "l.p.n.n.r=l.p.n.r=!l.p.r!,l.p.n.n.c=l.p.n.c=!l.p.c!"
BG Kbd
Set /a "k=!errorlevel!"
If !k! Equ 331 (Set /a "l.p.n.n.r=(l.p.n.r-=1)-1"
) Else If !k! Equ 333 (Set /a "l.p.n.n.r=(l.p.n.r+=1)+1"
) Else If !k! Equ 328 (Set /a "l.p.n.n.c=(l.p.n.c-=1)-1"
) Else If !k! Equ 336 (Set /a "l.p.n.n.c=(l.p.n.c+=1)+1"
) Else If !k! Equ 13 (Exit /b1) Else If !k! Equ 27 (
Exit /b2) Else Goto GetMov
If !l.p.n.r! Lss 0 Goto GetMov
If !l.p.n.r! Gtr %l.d.h% Goto GetMov
If !l.p.n.c! Lss 0 Goto GetMov
If !l.p.n.c! Gtr %l.d.w% Goto GetMov
Set /a "l.p.n.i=l.p.n.r*l.d.fw+l.p.n.c"
For %%i in (!l.p.n.i!) do Set "l.p.n.v=!l.d:~%%i,1!"
If !l.p.n.v! Equ 1 Goto GetMov
Set /a "p=0"
If !l.p.n.v! Equ 2 set /a "p=1"
If !l.p.n.v! Equ 3 set /a "p=1"
If !p! Equ 1 (Set /a "l.p.n.n.i=l.p.n.n.r*l.d.fw+l.p.n.n.c"
For %%i in (!l.p.n.n.i!) do Set "l.p.n.n.v=!l.d:~%%i,1!"
For %%v in (1 2 3) Do If !l.p.n.n.v! Equ %%v Goto GetMov)
Start /B BG Play sokobox_walk.wav
Call:B !l.p.i! !r.%l.p.v%! !l.p.r! !l.p.c!
Call:B !l.p.n.i! !r.%l.p.n.v%! !l.p.n.r! !l.p.n.c!
If !p! Equ 1 (
Start /B BG Play sokobox_push.wav
Call:B !l.p.n.n.i! !r.b.%l.p.n.n.v%! !l.p.n.n.r! !l.p.n.n.c!
Set /a l.d.g+=g%l.p.n.v%!r.b.%l.p.n.n.v%!)
Set /a "l.p.r=!l.p.n.r!,l.p.c=!l.p.n.c!,l.p.i=!l.p.n.i!"
Set "l.p.v=!r.%l.p.n.v%!"
If !l.d.g! Equ 0 (
Start /B BG Play sokobox_win.wav
Exit /b0)
Goto GetMov
:B
Set /a "z=%1+1"
If %1 Gtr 0 (Set "l.d=!l.d:~0,%1!%2!l.d:~%z%!"
) Else Set "l.d=%2!l.d:~1!"
Set /a "row=4*%3+S.M.X,col=4*%4+S.M.Y"
BG FCPrint !col! !row! !g.%2!
Goto :Eof
:End
Cls
Color 07
BG Cursor 1
BG Font 6
Mode Con Cols=80 Lines=300
Goto :Eof
:SetLvl
Set "l.src=%~1"
Goto :Eof
::Levels
1=5,4,2,5,9,1,3,7%p%45011022011400%p%7
2=5,4,2,5,16,2,4,%r%710001112035114420%p%
3=6,4,2,6,26,3,5,%r%77104011710020%s%002617%q%
4=7,4,2,6,11,1,3,771117771116%r%00220011000400%n%
5=6,4,2,5,23,3,2,77%o%0001102000114524%o%7
6=5,5,1,5,26,4,2,7%r%71000111000110231110504%p%
7=5,5,2,5,16,2,4,%r%71004111002511120017104017%r%
8=5,5,2,5,16,2,4,%r%71000111000511122011404%p%7
9=7,4,2,5,28,3,4,%q%7714000%s%02020011041500%n%
10=5,5,2,5,8,1,2,%r%71450171002111020411100017%r%
11=5,5,3,5,8,1,2,%p%051411220411420011000%p%7
12=7,4,2,5,17,2,1,%r%7771004%r%5202001110400017%p%
13=6,4,3,5,25,3,4,%q%710204111400201100254%o%
14=5,5,2,5,13,2,1,%p%040411522%s%00017100017%r%
15=7,4,2,5,30,3,6,%q%7710400%s%40220011000035%n%
16=6,4,3,5,22,3,1,7%o%042011002201154004%o%
17=5,5,2,5,8,1,2,%p%450011132411002011000%p%7
18=5,5,3,5,19,3,1,7%p%040110200115220114104%p%
19=6,4,3,5,11,1,4,%o%4015011220201140004%o%
20=5,5,3,6,13,2,1,%p%42001162001140201100%p%77
21=5,5,3,5,26,4,2,%p%004011020411122011450%p%7
22=7,4,2,5,20,2,4,777%n%000110025201104004%n%7
23=5,5,2,5,13,2,1,%r%714001115420110200%s%00177%s%
24=6,4,3,5,19,2,5,%o%002441100025110024%o%7
25=5,5,3,6,10,1,4,%p%402611120411002011000%p%7
26=5,5,3,5,22,3,4,77%p%00110200110425110424%p%
27=5,5,3,5,8,1,2,7%p%50411420411202011000%p%7
28=5,5,2,5,8,1,2,7%r%71504111223110040110000%p%
29=5,5,2,5,9,1,3,%r%71045171042111020011100017%r%
30=5,5,2,5,13,2,1,%r%714001715021110320114000%p%
31=6,5,2,5,19,2,5,%o%000341102235110004111000117%r%77
32=5,5,3,5,9,1,3,7%p%454110221110420110000%p%
33=7,4,2,5,26,3,2,777%n%4301102020011050040%n%
34=7,4,3,5,21,2,5,%n%4042401102025011000%n%777
35=6,5,3,5,33,4,5,77%r%711000111000011432211144025%o%
36=7,4,2,5,17,2,1,%n%00040011520200%q%4017777%s%
37=7,4,3,5,20,2,4,%r%7771024%r%00252011044000%n%
38=6,5,3,5,30,4,2,7%o%0400110220011420001145100%o%
39=6,5,2,6,15,2,1,%o%43000116120011020001100100%o%
40=6,5,3,6,33,4,5,%o%00100110004211002341100026%o%
41=5,5,2,5,19,3,1,%p%4300114200115200%s%00177%s%
42=5,5,3,5,13,2,1,%p%42001152441100201100%p%77
43=6,5,3,5,15,2,1,77%o%000115200411422001140100%o%
44=6,5,3,5,10,1,3,%r%771435%s%402201142000%s%000177%r%
45=6,5,3,5,23,3,2,7%r%711404171020%s%052001104200%o%
46=6,5,3,5,30,4,2,%o%0204011002001103214111500417%q%
47=6,5,3,5,19,2,5,%r%771440%s%2002511042001100100%o%
48=7,4,3,5,30,3,6,%r%7771040%r%02020011404205%n%
49=7,4,3,5,17,2,1,%n%4240001152200011401000%n%
50=6,5,2,5,22,3,1,%r%7714001771040%s%522001103000%o%
51=6,5,3,5,9,1,2,7%q%7150441112204110002011000%o%77
52=6,5,2,5,32,4,4,77%o%0001100000110322111443517%q%7
53=6,5,2,5,22,3,1,%o%0010411002341152000%s%000177%r%
54=6,5,3,5,29,4,1,%o%04440110223011000201150%o%777
55=6,5,1,5,15,2,1,777%o%00115200011033001143000%o%
56=6,5,3,5,32,4,4,%o%004201100220%s%0041771054177%r%
57=6,5,4,5,12,1,5,7%o%00051142220114420111040017%q%7
58=6,5,2,5,19,2,5,%o%04004113220511000%s%000177%r%77
59=6,5,3,5,32,4,4,%o%00024110002411001241100150%o%
60=6,5,2,5,22,3,1,777%s%711100111000011522001143040%o%
61=6,5,3,5,16,2,2,%r%771000%s%052001102034111024417%q%
62=6,5,3,5,26,3,5,%r%771400%s%0002011422051140100%o%
63=7,5,4,5,37,4,5,%n%000100110422001124300011440250%n%
64=6,5,1,6,12,1,5,%o%000261100330110000111001117%s%777
65=6,5,4,5,30,4,2,%o%0444011042201102200111510017%q%
66=6,5,2,5,32,4,4,%o%000301100220%s%0041771054177%r%
67=6,5,3,5,17,2,3,%r%7710401771405%s%022001102040%o%
68=6,5,2,5,26,3,5,%o%0042011003301102045%s%000177%r%
69=6,5,2,5,19,2,5,777%s%711100111022511040301104000%o%
70=6,5,3,5,17,2,3,%o%400201101520110020411400%o%77
71=6,5,1,6,8,1,1,%o%62000113330011000001100100%o%
72=6,5,1,5,30,4,2,77%o%000110200011033001145100%o%
73=7,5,1,5,33,4,1,7777%n%00110300001143320011530000%n%
74=6,5,3,5,29,4,1,%q%7141001114200011020201151400%o%
75=6,5,3,5,23,3,2,77%o%400110202011052001144100%o%
76=6,5,3,5,26,3,5,77%o%00011002001143425114020%o%7
77=7,5,3,5,36,4,4,1117%r%4111001104420011000220%r%5011777%s%7
78=7,5,4,5,25,3,1,%s%7777100%q%0010401152224011020044%n%
79=6,5,3,5,22,3,1,%r%7710401771040%s%522201104000%o%
80=6,5,3,5,15,2,1,%o%040001152220%s%0401771040177%r%
81=7,5,4,5,17,2,1,77%r%71110001115220001104220011434400%n%
82=7,5,5,5,38,4,6,%p%71400001114102201144220011040025%n%
83=6,5,3,5,22,3,1,777%s%711140111022011504201100400%o%
84=6,5,2,5,8,1,1,%o%53040%s%20011020301104000%o%
85=6,5,3,5,15,2,1,%o%03000115104411022001102040%o%
86=6,5,2,5,16,2,2,%o%004001105430111022017111001777%s%
87=7,5,3,5,38,4,6,7%n%002401100430011020020%q%4517777%s%
88=6,5,2,5,19,2,5,%o%04020110103511000231100040%o%
89=7,5,4,6,34,4,2,%n%41000011400020114322101116200017%p%
90=7,5,4,5,25,3,1,7%r%7771000%r%010401152224011020044%n%
91=7,5,4,5,17,2,1,7%n%00014115202041100202411000104%n%
92=7,5,1,5,38,4,6,77%q%7714000%r%0301100002311000035%n%
93=6,5,3,5,12,1,5,%o%004251140220110410111000017%q%7
94=7,5,4,5,36,4,4,7%n%0400011002000114222%r%0454177%q%7
95=7,5,2,5,10,1,2,7%n%5300011030200114020%s%4100177%q%77
96=6,5,3,5,33,4,5,%o%04020110000011410211100425%o%
97=7,5,4,5,38,4,6,7%r%771140017714420%s%02220011400035%n%
98=7,5,2,5,17,2,1,%n%001000115010201143300011034020%n%
99=7,5,4,5,38,4,6,%n%40010011000220114410201110402517%p%
100=7,5,4,5,17,2,1,%n%020040115201041102204011001004%n%
101=7,5,4,5,28,3,4,%n%40000011401200114325201140020%n%7
102=7,5,2,5,17,2,1,7%s%7771100%r%5200001100334011020040%n%
103=6,5,4,5,12,1,5,%o%04005112224011400101100240%o%
104=7,5,3,5,17,2,1,%r%7771404%r%54220011102000171110001777%r%
105=7,5,5,5,30,3,6,%n%414020110401001100222511440020%n%
106=7,5,4,5,37,4,5,7777%n%0011020200114002201144405%n%7
107=7,5,4,5,29,3,5,%n%441000110002201140215011040020%n%
108=7,5,4,5,34,4,2,77%s%7711100%s%0240201144322011054000%n%
109=7,5,5,6,11,1,3,77%n%6200114122001104020011440020%n%
110=7,5,3,5,36,4,4,7%n%004401102340011002200110015%n%77
111=7,5,4,5,30,3,6,7%n%0444411022000110020251100%n%7777
112=7,5,3,5,28,3,4,%n%40400011042020110235%q%0017777%s%77
113=7,5,3,5,17,2,1,77%s%771114017715420%s%0202001110400017%p%
114=7,5,5,5,14,1,6,7%n%4241511410020112020201104040%n%7
115=6,5,3,5,29,4,1,%o%02040114100011022001153400%o%
116=6,5,4,5,19,2,5,%o%04020114022511021011104004%o%
117=7,5,4,5,10,1,2,7%n%5204011020200114420%s%4100177%q%77
118=7,5,5,5,22,2,6,%q%7710000%s%4412251140002011442020%n%
119=6,5,3,5,26,3,5,%q%7100401714010111002251104020%o%
120=7,5,4,5,38,4,6,%q%771400017714102%s%40220011400025%n%
121=7,5,3,5,10,1,2,7%n%5440011022000110042%s%0300177%q%77
122=7,5,4,5,9,1,1,%n%520004111222041100001411000114%n%
123=7,5,4,6,9,1,1,%n%600100111201001140202011040204%n%
124=7,5,3,5,14,1,6,%n%004025114301211103002011400000%n%
125=7,5,2,5,17,2,1,7%n%000401152020011403101110300017%p%7
126=6,5,3,5,15,2,1,%o%004001154420111022017111001777%s%
127=7,5,4,5,22,2,6,%n%00010011410205114420201104020%n%7
128=7,5,3,5,17,2,1,%n%441000115022001103001011024000%n%
129=7,5,5,6,17,2,1,%n%042420116200001141120011420000%n%
130=7,5,4,5,21,2,5,%n%440100114221501103002011400020%n%
131=7,5,2,5,20,2,4,7777%n%0011003520110043201110040017%p%
132=7,5,5,6,17,2,1,%n%42040011612210112020401104000%n%7
133=7,5,3,5,22,2,6,%q%7710400%s%0012051120002011440100%n%
134=7,5,4,5,26,3,2,%n%4420201100200011451200110040%n%77
135=7,5,3,5,25,3,1,%n%4410001104202011530200%r%0001777%r%
136=7,5,3,5,9,1,1,%n%500104110102201140200011400%n%777
137=7,5,4,5,26,3,2,7%n%02004110202441105201411001000%n%
138=6,5,3,5,29,4,1,%o%00100110022011344201150400%o%
139=7,5,3,5,28,3,4,7%n%044001100432011002520%q%0017777%s%
140=7,5,3,5,33,4,1,%n%414000114300201102120011501000%n%
141=7,5,4,5,13,1,5,%n%44015011000220114010201110402017%p%
142=7,5,4,5,17,2,1,%n%024404115011211100200011024000%n%
143=7,5,2,5,14,1,6,%n%0001051141003011002420110000%n%77
144=7,5,3,5,20,2,4,7%n%00100110025201104332011040400%n%
145=7,5,4,5,34,4,2,%n%43000011402200114210001115240017%p%
146=7,5,3,5,12,1,4,77%s%7711105%s%0022001143430011420000%n%
147=7,5,4,5,30,3,6,%q%771044017714302%s%02020511000240%n%
148=7,5,4,5,30,3,6,%n%0020041104022011041025110040%n%77
149=7,5,3,5,9,1,1,%p%71520401713031011102020011400040%n%
150=7,5,5,6,33,4,1,%n%4200001142222011401000116400%n%77
151=7,5,2,5,13,1,5,%n%0001501141002011002430110000%n%77
152=7,5,5,5,12,1,4,%q%7714005%s%4410001142222011420000%n%
153=7,5,3,5,17,2,1,%n%0300001154220011441020110000%n%77
154=7,5,4,5,21,2,5,7%n%0040011022050110442%s%0204177%q%77
155=7,5,3,5,38,4,6,%n%0004201100234411020100%s%0005177%q%
156=7,5,4,5,19,2,3,7%n%00000110251241100202411001044%n%
157=7,5,2,5,13,1,5,%p%71000351714302%s%0002001110400017%p%
158=7,5,4,5,10,1,2,%n%450020114122001144021011030000%n%
159=7,5,4,5,25,3,1,%p%7102004171442101115202001114000017%p%
160=7,5,3,5,26,3,2,7%n%004001103420011052101110240017%p%7
161=7,5,4,5,17,2,1,7777%n%00115202001143420011424000%n%
162=7,5,4,5,26,3,2,77%q%7710420%s%2044110502201104000%n%7
163=7,5,3,5,38,4,6,%n%000000114310001143022111040025%n%
164=7,5,4,5,22,2,6,7%n%000001142120511402021114400017%p%7
165=7,5,5,5,17,2,1,%q%7714004%s%5212001124042011000024%n%
166=7,5,4,5,9,1,1,%p%71500401710304211142120011420000%n%
167=7,5,3,5,36,4,4,%n%0300001100220011041020114045%n%77
168=7,5,4,5,30,3,6,%n%04002411002430110020251104%n%7777
169=7,5,4,5,36,4,4,%n%4200001143120011420021114005017%p%7
170=7,5,4,5,37,4,5,%p%71040001714222211104103011400050%n%
::