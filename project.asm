include Irvine32.inc
ExitProcess PROTO, dwExitCode: DWORD
BUFFER_SIZE = 501
.data
maxrow dw 50
maxscore dd 9000
;-----------------------------Startup screeen----------------------
logo1 DB "/$$$$$$$   /$$$$$$   /$$$$$$  /$$      /$$  /$$$$$$  /$$   /$$ ",0
logo2 DB "| $$__  $$ /$$__  $$ /$$__  $$| $$$    /$$$ /$$__  $$| $$$ | $$",0
logo3 DB	"| $$  \ $$| $$  \ $$| $$  \__/| $$$$  /$$$$| $$  \ $$| $$$$| $$",0
logo4 DB	"| $$$$$$$/| $$$$$$$$| $$      | $$ $$/$$ $$| $$$$$$$$| $$ $$ $$",0
logo5 DB	"| $$____/ | $$__  $$| $$      | $$  $$$| $$| $$__  $$| $$  $$$$",0
logo6 DB	"| $$      | $$  | $$| $$    $$| $$\  $ | $$| $$  | $$| $$\  $$$",0
logo7 DB	"| $$      | $$  | $$|  $$$$$$/| $$ \/  | $$| $$  | $$| $$ \  $$",0
logo8 DB "|__/      |__/  |__/ \______/ |__/     |__/|__/  |__/|__/  \__/",0
;----------------------------LEVEL 1------------------------------------------
            ;0123456789

ring byte 50 DUP('0'),0
;----------------------------------Level1----------------------
frame1 byte "##################################################",0;0
       byte "##..............##.............##...............##",0;1
       byte "##...####.......##....######...##...............##",0;2
       byte "##...##.........##..................######......##",0;3
       byte "##...##                                 ##      ##",0;4
       byte "##...##......#####....###########.......##......##",0;5
       byte "##....................###########.......##......##",0;6
       byte "##...##...............###########...............##",0;7
       byte "##...##......#####......................##......##",0;8
       byte "##...##.................................##......##",0;9
       byte "##...####.......##..................######......##",0;10
       byte "##..............##..............##..............##",0;11
       byte "##################################################",0;12

;--------------------------------frame2----------------------
;------------------------level2----------------------

frame2 byte "##################################################",0
       byte "##...##.................##........##............##",0
       byte "##...##..###########....##........##...###########",0
       byte "##...##.................##......................##",0
       byte "##...##.................########.....#######....##",0
       byte "##.......##...............................##....##",0
       byte "##.......###########....##................##....##",0
       byte "##...##..##.............##..........########....##",0
       byte "##...##..##.........######..........##..........##",0
       byte "##......................##..........##.....#######",0
       byte "###############################.....###...########",0
       byte "##............................................####",0
       byte "##################################################",0

frame3 byte "##################################################",0
       byte "##                                              ##",0
       byte "##..######....#######################...##########",0
       byte "######.................####...................####",0
       byte "##..##.....#########..########....#########...####",0
       byte "##..##..#...##...........####.........######..####",0
       byte "##..################..############.##...####..####",0
       byte "##..............####..############.##...####..####",0
       byte "#####..####.....####........###....##.........####",0
       byte "##................##.......#####...########...####",0
       byte "##########...#######..###..######..#########..####",0
       byte "##                                         #######",0
       byte "##################################################",0
;--------------------------------------Messages--------------------
levels byte "Enter a for level1 and enter b for level 2 and enter c for level 3"
ghoststat byte 0
won byte "YOu have won the Game",0
p12 byte "You have PAUSED the GAme",0
pcr byte "                        ",0
died byte "You Have died ",0
welcome byte "Welcome to Pacman :)",0
entname byte "Enter Name",0
enter12 byte "Enter S to play",0
score byte "Your score:",0
instruction0 byte "INSTRUCTIONS:",0
instruction1 byte "Pac-Man, an iconic arcade game, challenges players to guide the titular character, ",0
instruction5 byte "Pac-Man, through a maze filled with dots while avoiding ghosts.",0
instruction2 byte "Controlled by arrow keys, players navigate Pac-Man to eat all the dots to advance through levels",0
instruction3 byte "The game introduces strategic elements as players strive to maximize points while dodging the unpredictable ghost movements.",0
instruction4 byte "With a limited number of lives, players must carefully maneuver to avoid collisions with ghosts,balance of risk and reward",0
scorecount dd 0
     ;------------------------------------Cordinatesssssssssssss
     ;-----------------------(5x,34y)
     ;---------------------------filename-----------------
     filename BYTE "scores.txt", 0
;-----------Enter Name---------------
ennam byte ?
buffer BYTE BUFFER_SIZE DUP(?)
    stringLength DWORD ?
    bytesWritten DWORD ?
    fileHandle HANDLE ?
     ;-----------------------ghost1----------------------
directstats1 byte 0
ghostx1 byte 9
ghosty1 byte 42
ghostarrayx1 byte 4
ghostarrayy1 byte 8
;---------------------------ghost2------------------------
fruitx byte 6
fruitstat byte 0
fruity byte 50
directstats2 byte 0
ghostx2 byte  16
ghosty2 byte 36
ghostarrayx2 byte 11
ghostarrayy2 byte 2
;-------------------------ghost3----------------------------
directstats3 byte 0
ghostx3 byte 6
ghosty3 byte 36
ghostarrayx3 byte 1
ghostarrayy3 byte 2
;-------------------pacman cordinates---------------------------
xcord byte 9
ycord byte 36
xarray byte 4
yarray byte 2 
inputch byte ?
   .code
   main proc ;----------------------------MAIN BODY-----------------
   call clrscr
   mov al,white+(black*16)
   call settextcolor
   call startup
   call readchar
   mov inputch,al
   cmp inputch,"s"
   je Wlabel
   jmp exit1
   Wlabel:
   ;--------------------Wlabel(after Startup screeen)
   call clrscr
   call instructionpage
   call readchar
   mov inputch,al
   cmp inputch,"s"
   je W1label
   jmp exit1
   W1label:
   call clrscr
   ;---------------------------level selection 
   ;-------------------------name
   mov dh,10
   mov dl,34
   call gotoxy
   mov edx,OFFSET filename
   call CreateOutputFile
   mov fileHandle, eax
   mov edx,offset entname
   call writestring

   ;mov edx,offset entername
   mov ecx,BUFFER_SIZE
   mov edx, OFFSET buffer
   call readstring
   
   ;call ReadString
   mov stringLength, eax
    mov eax, fileHandle
    mov edx, OFFSET buffer
    mov ecx, stringLength
    call WriteToFile
    mov bytesWritten, eax
    call CloseFile

   ;------------------------levels-
   mov dh,10
   mov dl,34
   call gotoxy
   mov edx,offset levels
   call writestring
   call levelselect

   call createplayer
   cmp ghoststat,1
   je l43
   jmp l45
   l43:
   call ghost2
   call ghost3
   call fruit
   l45:
   call ghost1
   gameloop:

   call bonus
   call scoring
   cmp eax,maxscore
   je victory

;we getting the input from da user
call readchar
mov inputch,al
cmp inputch,"x"
je exit1
cmp inputch,"p"
je pauser
cmp inputch,"w"
je forward
cmp inputch,"s"
je downward
cmp inputch,"a"
je left
cmp inputch,"d"
je right

jmp gameloop

;----------------------------Victory------------------
victory:
call clrscr
mov dh,16
mov dl,34
call gotoxy
mov edx,offset won
call writestring
jmp exit1

   ;----------------------------PAUSE--------------------------------
   pauser:
   mov al,0
   lp:
   mov dh,0
   mov dl,30
   call gotoxy
   mov edx,offset p12
   call writestring
   call readchar
   mov inputch,al
   cmp inputch,"p"
   je lp2
   jmp lp
   lp2:
   mov dh,0
   mov dl,30
   call gotoxy
   mov edx,offset pcr
   call writestring
   jmp gameloop
   ;--------------------------PACMAN MOVEMENTS------------------------
   ;--------------------------------forward-------------------------------
   forward:
   cmp ghoststat,1
   je l123
   jmp l1232
   l123:
   call contactcheck2
   call ghostmove2
   call contactcheck3
   call ghostmove3
   l1232:
   call contactcheck
   call ghostmove
   mov bh,xarray
   mov bl,yarray
   dec bh
   call checkwall
   mov bx,0
   cmp eax,1
   je gamecont
   jmp changer
   gamecont:
   jmp gameloop
   changer:
   call prevplayer
   dec xarray
   dec xcord
   inc scorecount
   call createplayer
   jmp gameloop
   ;--------------------------------------------------downward-----------------
   downward:
   cmp ghoststat,1
   je l123a
   jmp l123a2
   l123a:
   call contactcheck2
   call ghostmove2
   call contactcheck3
   call ghostmove3
   l123a2:
   call contactcheck
   call ghostmove
   mov bh,xarray
   mov bl,yarray
   inc bh
   call checkwall
   mov bx,0
   cmp eax,1
   je gamecont1
   jmp changer1
   gamecont1:
   jmp gameloop
   changer1:
   call prevplayer
   inc xarray
   inc xcord
   inc scorecount 
  
   call createplayer
   jmp gameloop
   ;-----------------------------------left--------------------------
   left:
      cmp ghoststat,1
   je l123b
   jmp l123b2
   l123b:
   call contactcheck2
   call ghostmove2
   call contactcheck3
   call ghostmove3
   l123b2:
   call contactcheck
   call ghostmove
   mov bh,xarray
   mov bl,yarray
   dec bl
   call checkwall
   mov bx,0
   cmp eax,1
   je gamecont2
   jmp changer2
   gamecont2:
   jmp gameloop
   changer2:
   call prevplayer
   dec ycord
   dec yarray
   inc scorecount 
   call createplayer
   jmp gameloop
   ;---------------------------------------right-------------------------
   right:
      cmp ghoststat,1
   je l123c
   jmp l123c2
   l123c:
   call contactcheck2
   call ghostmove2
      call contactcheck3
   call ghostmove3
   l123c2:
   call contactcheck
   call ghostmove
   mov bh,xarray
   mov bl,yarray
   inc bl
      call checkwall
   mov bx,0
   cmp eax,1
   je gamecont3
   jmp changer3
   gamecont3:
   jmp gameloop
   changer3:
   call prevplayer
   inc yarray
   inc ycord
   inc scorecount 
   call createplayer
   jmp gameloop

   ;-----------------------------exit
   exit1:
   mov dh,17
   mov dl,34
   call gotoxy
   INVOKE ExitProcess,0
   main endp

   
   ;---------------------------------------prevplayer---------------------
   prevplayer proc
mov dl,ycord
mov dh,xcord
call gotoxy
mov al," "
call writechar
ret
prevplayer endp
;--------------------------------prevghost1----------------------
prevghost1 proc
mov dl,ghosty1
mov dh,ghostx1
call gotoxy
mov al," "
call writechar
ret
prevghost1 endp
;-------------------------------------prevghost2--------------------
prevghost2 proc
mov dl,ghosty2
mov dh,ghostx2
call gotoxy
mov al," "
call writechar
ret
prevghost2 endp
;---------------------------------------prevghost3------------------------
prevghost3 proc
mov dl,ghosty3
mov dh,ghostx3
call gotoxy
mov al," "
call writechar
ret
prevghost3 endp
   ;--------------------------PROCCCSS---------------------------------
   ;-----------------------------fruit-----------------------
   fruit proc
   mov dh,fruitx
   mov dl,fruity
   call gotoxy
   mov al,'F'
   call writechar
   fruit endp
   ;-----------------------------levelselect0------------------------
   levelselect proc
   call readchar
   mov inputch,al
   cmp inputch,"a"
   je lvl1
   cmp inputch,"b"
   je lvl2
   cmp inputch,"c"
   je lvl3
   ret
   lvl3:
   call clrscr
   mov edi,offset frame3
   call createwall3
   mov ghoststat,1
   ret
   lvl2:
   call clrscr
   mov edi,offset frame2
    call createwall2
    mov ghoststat,1
    ret
   lvl1:
   call clrscr
   mov edi,offset frame1
   mov ghoststat,0
    call createwall
    ret
   levelselect endp
   ;-----------------------------instructionpage--------------------
   instructionpage proc
   mov dh,9
   mov dl,30
   call gotoxy
   mov edx,offset instruction0
   call writestring

   mov dh,10
   mov dl,0
   call gotoxy
   mov edx,offset instruction1
   call writestring

    mov dh,11
   mov dl,0
   call gotoxy
   mov edx,offset instruction5
   call writestring

      mov dh,12
   mov dl,0
   call gotoxy
   mov edx,offset instruction2
   call writestring

      mov dh,13
   mov dl,0
   call gotoxy
   mov edx,offset instruction3
   call writestring

   mov dh,14
   mov dl,0
   call gotoxy
   mov edx,offset instruction4
   call writestring
   ret
   instructionpage endp

   ;-------------------------------startup---------------------------
   startup proc

   mov dh,10
   mov dl,35
   call gotoxy
  ;          mov eax,white+(black*16)
   ;call settextcolor
   mov edx,offset logo1
   call writestring

   mov dh,11
   mov dl,35
   call gotoxy
 ;        mov eax,white+(black*16)
  ; call settextcolor
   mov edx,offset logo2
   call writestring

   mov dh,12
   mov dl,35
   call gotoxy
   mov edx,offset logo3
   call writestring

   mov dh,13
   mov dl,35
   call gotoxy
   mov edx,offset logo4
   call writestring

   mov dh,14
   mov dl,35
   call gotoxy
   mov edx,offset logo5
   call writestring

   mov dh,15
   mov dl,35
   call gotoxy
   mov edx,offset logo6
   call writestring

   mov dh,16
   mov dl,35
   call gotoxy
   mov edx,offset logo7
   call writestring

   mov dh,17
   mov dl,35
   call gotoxy
   mov edx,offset logo8
   call writestring

   mov dh,19
   mov dl,50
   call gotoxy
   mov edx,offset welcome
   call writestring

   mov dh,20
   mov dl,50
   call gotoxy
   mov edx,offset enter12
   call writestring


   ret

   startup endp
   ;---------------------------Score count-----------------------------
   bonus proc

   mov cl,fruitx
   cmp cl,xcord
   je b1
   ret
   b1:
   mov ch,fruity
   cmp ch,ycord
   je b2
   ret
   b2:
   add scorecount,100
   ret
   bonus endp
   scoring proc
   mov dh,0
   mov dl,0
   call gotoxy
  ;       mov al,green+(black*16)
   ;call settextcolor
   mov edx,offset score
   call writestring
   mov eax,scorecount
   call writeint

   ret
   scoring endp

   ;-----------------------------Ghost-Pacman collision check----------
   ;---------------------------ghost3----------------------------------
   contactcheck3 proc
   mov ax,0
   mov ah,ghostarrayx3
   mov al,xarray
   mov bx,0
   mov bh,ghostarrayy3
   mov bl,yarray
   mov dl,ghostx3
   mov dh,xcord
   cmp dh,dl
   je cchek3
   cmp ah,al
   je checkmate3
   ret

   cchek3:
   mov bl,ycord
   mov bh,ghosty3
   cmp bh,bl
   je checkmatev223
   checkmate3:
   cmp bh,bl
   je checkmatev223
   ret
   checkmatev223:
   call delay
   call ClrScr
   mov dh,10
   mov dl,50
   call gotoxy
  ; call updatescore
   mov edx,offset died
   call writestring
   mov dh,13
   mov dl,50
   call gotoxy
   mov edx,offset buffer ;------------------------------------
   call writestring
      mov edx,offset score
   call writestring
   mov eax,scorecount
   call writeint
   INVOKE ExitProcess,0
   ret

   contactcheck3 endp

   ;-------------------------updatescore---------------------
   ;updatescore proc
    ; mov edx,OFFSET filename
   ;all CreateOutputFile
   ;mov fileHandle, eax


    ;mov eax, fileHandle
    ;mov edx, scorecount
    ;call WriteToFile
    ;mov bytesWritten, eax
    ;call CloseFile
    ;ret

   ;updatescore endp
   ;---------------------------ghost2-----------------------------------
      contactcheck2 proc
   mov ax,0
   mov ah,ghostarrayx2
   mov al,xarray
   mov bx,0
   mov bh,ghostarrayy2
   mov bl,yarray
   mov dl,ghostx2
   mov dh,xcord
   cmp dh,dl
   je cchek2
   cmp ah,al
   je checkmate2
   ret

   cchek2:
   mov bl,ycord
   mov bh,ghosty2
   cmp bh,bl
   je checkmatev22
   checkmate2:
   cmp bh,bl
   je checkmatev22
   ret
   checkmatev22:
   call delay
   call ClrScr
   mov dh,10
   mov dl,50
   call gotoxy
   ;call updatescore
   mov edx,offset died
   call writestring
   mov dh,13
   mov dl,50
   call gotoxy
      mov edx,offset buffer
   call writestring
      mov edx,offset score
   call writestring
   mov eax,scorecount
   call writeint
   INVOKE ExitProcess,0
   ret

   contactcheck2 endp
   ;---------------------------ghost1-----------------------------------
   contactcheck proc
   mov ax,0
   mov ah,ghostarrayx1
   mov al,xarray
   mov bx,0
   mov bh,ghostarrayy1
   mov bl,yarray
   mov dl,ghostx1
   mov dh,xcord
   cmp dh,dl
   je cchek
   cmp ah,al
   je checkmate
   ret

   cchek:
   mov bl,ycord
   mov bh,ghosty1
   cmp bh,bl
   je checkmatev2
   checkmate:
   cmp bh,bl
   je checkmatev2
   ret
   checkmatev2:
   call delay
   call ClrScr
   mov dh,10
   mov dl,50
   call gotoxy
  ; call updatescore
   mov edx,offset died
   call writestring
   mov dh,13
   mov dl,50
   call gotoxy
      mov edx,offset buffer
   call writestring
   mov edx,offset score
   call writestring
   mov eax,scorecount
   call writeint
   INVOKE ExitProcess,0
   ret

   contactcheck endp
   ;---------------------------Ghost move-----------------------------
   ;-------------------------------ghost3-----------------------------
   ghostmove3 proc
   cmp directstats3,1
   je changedirect3
   changedirect10123:
   mov directstats3,0
   mov bh,ghostarrayx3
   mov bl,ghostarrayy3
   inc bl
   call checkwall
   mov bx,0
   cmp eax,1
   je changedirect3

   call prevghost3 ;-----------------------prevghost2
   inc ghosty3
   inc ghostarrayy3
   call ghost3 ;------------------------------ghost2
   ret
   changedirect3:
   mov directstats3,1
   mov bh,ghostarrayx3
   mov bl,ghostarrayy3
   dec bl
   call checkwall
   mov bx,0
   cmp eax,1
   je changedirect10123
   call prevghost3
   dec ghosty3
   dec ghostarrayy3
   call ghost3
   ret
   ghostmove3 endp
   ;-------------------------------ghost2------------------------------
   ghostmove2 proc
   cmp directstats2,1
   je changedirect2
   changedirect1012:
   mov directstats2,0
   mov bh,ghostarrayx2
   mov bl,ghostarrayy2
   inc bl
   call checkwall
   mov bx,0
   cmp eax,1
   je changedirect2

   call prevghost2 ;-----------------------prevghost2
   inc ghosty2
   inc ghostarrayy2
   call ghost2 ;------------------------------ghost2
   ret
   changedirect2:
   mov directstats2,1
   mov bh,ghostarrayx2
   mov bl,ghostarrayy2
   dec bl
   call checkwall
   mov bx,0
   cmp eax,1
   je changedirect1012
   call prevghost2
   dec ghosty2
   dec ghostarrayy2
   call ghost2
   ret
   ghostmove2 endp
   ;------------------------------ghost1-----------------------------
   ghostmove proc
   cmp directstats1,1
   je changedirect
   changedirect101:
   mov directstats1,0
   mov bh,ghostarrayx1
   mov bl,ghostarrayy1
   inc bl
   call checkwall
   mov bx,0
   cmp eax,1
   je changedirect

   call prevghost1 ;-----------------------prevghost1
   inc ghosty1
   inc ghostarrayy1
   call ghost1 ;------------------------------ghost1
   ret
   changedirect:
   mov directstats1,1
   mov bh,ghostarrayx1
   mov bl,ghostarrayy1
   dec bl
   call checkwall
   mov bx,0
   cmp eax,1
   je changedirect101
   call prevghost1
   dec ghosty1
   dec ghostarrayy1
   call ghost1
   ret
   ghostmove endp

   ;---------------------------check wall-----------------------------
   checkwall proc
   mov eax,0
   mov ecx,0
   mov al,bh ;x
   mov cl,bl ;y
   mov bl,51 ;total col
   imul bl ;rowxtotal columns
   add ax,cx ;plus col
   ;mov esi,offset frame1
   mov bl,[edi+eax]
   cmp bl,'#'
   je wallyes
   ret
   wallyes:
   mov eax,1
   ret

   checkwall endp
   ;------------------------------createghost3------------------------
   ghost3 proc
   mov dh,ghostx3
   mov dl,ghosty3
   call gotoxy
   mov al,'G'
   call writechar
   ghost3 endp
   ;------------------------------createghost2------------------------
   ghost2 proc
   mov dh,ghostx2
   mov dl,ghosty2
   call gotoxy
   mov al,'G'
   call writechar
   ghost2 endp
   ;---------------------------CReate Ghost----------------------------
   ghost1 proc
  ;    mov al,blue+(black*16)
   ;call settextcolor
   mov dh,ghostx1
   mov dl,ghosty1
   call gotoxy
   mov al,'G'
   call writechar
   ghost1 endp
   ;---------------------------CREATE PLAYER---------------------------
   createplayer proc
  ; mov al,yellow+(black*16)
   ;call settextcolor
   mov dh,xcord
   mov dl,ycord
   call gotoxy

   mov al,'P'
   call writechar

   ret
    
   createplayer endp
   ;---------------------------Ccreate wall levl2---------------------
   createwall2 proc
      ;--------first wall
   mov dh,5
   mov dl,34
   call gotoxy
   mov esi,offset frame2
   mov ecx,51
   mov bl,0
   l1:
   mov eax,[esi]
   inc esi
   call writechar
   loop l1
   ;-----------second wall
   mov ecx,0
   mov eax,0
   mov dh,6
   mov dl,34
   call gotoxy
   mov ecx,51
   l2:
   mov eax,[esi]
   inc esi
   call writechar
   loop l2
   ;-----------------third wall
   mov ecx,0
   mov eax,0
   mov dh,7
   mov dl,34
   call gotoxy
   mov ecx,51
   l3:
   mov eax,[esi]
   inc esi
   call writechar
   loop l3
   ;------------------fourth wall
   mov ecx,0
   mov eax,0
   mov dh,8
   mov dl,34
   call gotoxy
   mov ecx,51
   l4:
   mov eax,[esi]
   inc esi
   call writechar
   loop l4
;--------------fifth wall
   mov ecx,0
   mov dh,9
   mov dl,34
   call gotoxy
   mov ecx,51
   l5:
   mov eax,[esi]
   inc esi
   call writechar
   loop l5

   ;----------------------sixth wall
   mov ecx,0
   mov dh,10
   mov dl,34
   call gotoxy
   mov ecx,51
   l6:
   mov eax,[esi]
   inc esi
   call writechar
   loop l6

   ;---------------seventh wall
   mov ecx,0
   mov dh,11
   mov dl,34
   call gotoxy
   mov ecx,51
   l7:
   mov eax,[esi]
   inc esi
   call writechar
   loop l7

;------------------eighth wall
   mov ecx,0
   mov eax,0
   mov dh,12
   mov dl,34
   call gotoxy
   mov ecx,51
   l8:
   mov eax,[esi]
   inc esi
   call writechar
   loop l8
;-----------------ninth wall
   mov ecx,0
   mov eax,0
   mov dh,13
   mov dl,34
   call gotoxy
   mov ecx,51
   l9:
   mov eax,[esi]
   inc esi
   call writechar
   loop l9
   ;-----------tenthwall
   mov ecx,0
   mov eax,0
   mov dh,14
   mov dl,34
   call gotoxy
   mov ecx,51
   l10:
   mov eax,[esi]
   inc esi
   call writechar
   loop l10
  ;--------------eleventh wall
   mov ecx,0
   mov eax,0
   mov dh,15
   mov dl,34
   call gotoxy
   mov ecx,51
   l11:
   mov eax,[esi]
   inc esi
   call writechar
   loop l11
   ;---------------twelvth wallllllll
   mov ecx,0
   mov eax,0
   mov dh,16
   mov dl,34
   call gotoxy
   mov ecx,51
   l12:
   mov eax,[esi]
   inc esi
   call writechar
   loop l12
   ;---------------thirtheenth walllll
   mov ecx,0
   mov eax,0
   mov dh,17
   mov dl,34
   call gotoxy
   mov ecx,51
   l13:
   mov eax,[esi]
   inc esi
   call writechar
   loop l13
   ret
   createwall2 endp

   ;---------------------------CREATE WALL-----------------------------
   createwall proc
   ;--------first wall
   mov dh,5
   mov dl,34
   call gotoxy
   mov esi,offset frame1
   mov ecx,51
   mov bl,0
   l1:
   mov eax,[esi]
   inc esi
   call writechar
   loop l1
   ;-----------second wall
   mov ecx,0
   mov eax,0
   mov dh,6
   mov dl,34
   call gotoxy
   mov ecx,51
   l2:
   mov eax,[esi]
   inc esi
   call writechar
   loop l2
   ;-----------------third wall
   mov ecx,0
   mov eax,0
   mov dh,7
   mov dl,34
   call gotoxy
   mov ecx,51
   l3:
   mov eax,[esi]
   inc esi
   call writechar
   loop l3
   ;------------------fourth wall
   mov ecx,0
   mov eax,0
   mov dh,8
   mov dl,34
   call gotoxy
   mov ecx,51
   l4:
   mov eax,[esi]
   inc esi
   call writechar
   loop l4
;--------------fifth wall
   mov ecx,0
   mov dh,9
   mov dl,34
   call gotoxy
   mov ecx,51
   l5:
   mov eax,[esi]
   inc esi
   call writechar
   loop l5

   ;----------------------sixth wall
   mov ecx,0
   mov dh,10
   mov dl,34
   call gotoxy
   mov ecx,51
   l6:
   mov eax,[esi]
   inc esi
   call writechar
   loop l6

   ;---------------seventh wall
   mov ecx,0
   mov dh,11
   mov dl,34
   call gotoxy
   mov ecx,51
   l7:
   mov eax,[esi]
   inc esi
   call writechar
   loop l7

;------------------eighth wall
   mov ecx,0
   mov eax,0
   mov dh,12
   mov dl,34
   call gotoxy
   mov ecx,51
   l8:
   mov eax,[esi]
   inc esi
   call writechar
   loop l8
;-----------------ninth wall
   mov ecx,0
   mov eax,0
   mov dh,13
   mov dl,34
   call gotoxy
   mov ecx,51
   l9:
   mov eax,[esi]
   inc esi
   call writechar
   loop l9
   ;-----------tenthwall
   mov ecx,0
   mov eax,0
   mov dh,14
   mov dl,34
   call gotoxy
   mov ecx,51
   l10:
   mov eax,[esi]
   inc esi
   call writechar
   loop l10
  ;--------------eleventh wall
   mov ecx,0
   mov eax,0
   mov dh,15
   mov dl,34
   call gotoxy
   mov ecx,51
   l11:
   mov eax,[esi]
   inc esi
   call writechar
   loop l11
   ;---------------twelvth wallllllll
   mov ecx,0
   mov eax,0
   mov dh,16
   mov dl,34
   call gotoxy
   mov ecx,51
   l12:
   mov eax,[esi]
   inc esi
   call writechar
   loop l12
   ;---------------thirtheenth walllll
   mov ecx,0
   mov eax,0
   mov dh,17
   mov dl,34
   call gotoxy
   mov ecx,51
   l13:
   mov eax,[esi]
   inc esi
   call writechar
   loop l13
   ret
   createwall endp

   ;-------------------------level three---------------------------
   createwall3 proc
   ;--------first wall
   mov dh,5
   mov dl,34
   call gotoxy
   mov esi,offset frame3
   mov ecx,51
   mov bl,0
   l1:
   mov eax,[esi]
   inc esi
   call writechar
   loop l1
   ;-----------second wall
   mov ecx,0
   mov eax,0
   mov dh,6
   mov dl,34
   call gotoxy
   mov ecx,51
   l2:
   mov eax,[esi]
   inc esi
   call writechar
   loop l2
   ;-----------------third wall
   mov ecx,0
   mov eax,0
   mov dh,7
   mov dl,34
   call gotoxy
   mov ecx,51
   l3:
   mov eax,[esi]
   inc esi
   call writechar
   loop l3
   ;------------------fourth wall
   mov ecx,0
   mov eax,0
   mov dh,8
   mov dl,34
   call gotoxy
   mov ecx,51
   l4:
   mov eax,[esi]
   inc esi
   call writechar
   loop l4
;--------------fifth wall
   mov ecx,0
   mov dh,9
   mov dl,34
   call gotoxy
   mov ecx,51
   l5:
   mov eax,[esi]
   inc esi
   call writechar
   loop l5

   ;----------------------sixth wall
   mov ecx,0
   mov dh,10
   mov dl,34
   call gotoxy
   mov ecx,51
   l6:
   mov eax,[esi]
   inc esi
   call writechar
   loop l6

   ;---------------seventh wall
   mov ecx,0
   mov dh,11
   mov dl,34
   call gotoxy
   mov ecx,51
   l7:
   mov eax,[esi]
   inc esi
   call writechar
   loop l7

;------------------eighth wall
   mov ecx,0
   mov eax,0
   mov dh,12
   mov dl,34
   call gotoxy
   mov ecx,51
   l8:
   mov eax,[esi]
   inc esi
   call writechar
   loop l8
;-----------------ninth wall
   mov ecx,0
   mov eax,0
   mov dh,13
   mov dl,34
   call gotoxy
   mov ecx,51
   l9:
   mov eax,[esi]
   inc esi
   call writechar
   loop l9
   ;-----------tenthwall
   mov ecx,0
   mov eax,0
   mov dh,14
   mov dl,34
   call gotoxy
   mov ecx,51
   l10:
   mov eax,[esi]
   inc esi
   call writechar
   loop l10
  ;--------------eleventh wall
   mov ecx,0
   mov eax,0
   mov dh,15
   mov dl,34
   call gotoxy
   mov ecx,51
   l11:
   mov eax,[esi]
   inc esi
   call writechar
   loop l11
   ;---------------twelvth wallllllll
   mov ecx,0
   mov eax,0
   mov dh,16
   mov dl,34
   call gotoxy
   mov ecx,51
   l12:
   mov eax,[esi]
   inc esi
   call writechar
   loop l12
   ;---------------thirtheenth walllll
   mov ecx,0
   mov eax,0
   mov dh,17
   mov dl,34
   call gotoxy
   mov ecx,51
   l13:
   mov eax,[esi]
   inc esi
   call writechar
   loop l13
   ret
   createwall3 endp
 
 

   end main

