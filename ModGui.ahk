IfnotExist, %A_temp%
FileCreateDir, %A_temp%
FileDelete, %a_temp%/verlen.ini
downlpic := "https://github.com/rqvm/Update/raw/master/6Pqj5LoJrJk1.jpg"
{
IfnotExist, %A_temp%\6Pqj5LoJrJk1.jpg
URLDownloadToFile, %downlpic%, %a_temp%/6Pqj5LoJrJk1.jpg
}

{ ;AutoUpdate
buildscr = 25 ;������ ��� ���������, ���� ������ ��� � verlen.ini - ���������
downlurl := "https://github.com/rqvm/Update/blob/master/updt.exe?raw=true"
downllen := "https://github.com/rqvm/Update/raw/master/verlef.ini"

Utf8ToAnsi1(ByRef Utf8String, CodePage = 1251)
{
If (NumGet(Utf8String) & 0xFFFFFF) = 0xBFBBEF
BOM = 3
Else
BOM = 0

UniSize := DllCall("MultiByteToWideChar", "UInt", 65001, "UInt", 0
, "UInt", &Utf8String + BOM, "Int", -1
, "Int", 0, "Int", 0)
VarSetCapacity(UniBuf, UniSize * 2)
DllCall("MultiByteToWideChar", "UInt", 65001, "UInt", 0
, "UInt", &Utf8String + BOM, "Int", -1
, "UInt", &UniBuf, "Int", UniSize)

AnsiSize := DllCall("WideCharToMultiByte", "UInt", CodePage, "UInt", 0
, "UInt", &UniBuf, "Int", -1
, "Int", 0, "Int", 0
, "Int", 0, "Int", 0)
VarSetCapacity(AnsiString, AnsiSize)
DllCall("WideCharToMultiByte", "UInt", CodePage, "UInt", 0
, "UInt", &UniBuf, "Int", -1
, "Str", AnsiString, "Int", AnsiSize
, "Int", 0, "Int", 0)
Return AnsiString
}
WM_HELP(){
IniRead, vupd, %a_temp%/verlen.ini, UPD, v
IniRead, desupd, %a_temp%/verlen.ini, UPD, des
IniRead, updupd, %a_temp%/verlen.ini, UPD, upd

msgbox, , ������ ��������� ������ %vupd%, %updupd%
return
}

OnMessage(0x53, "WM_HELP")
Gui +OwnDialogs

SplashTextOn, , 60,��������������, ������ �������. ��������..`n��������� ������� ����������.
URLDownloadToFile, %downllen%, %a_temp%/verlen.ini
IniRead, buildupd, %a_temp%/verlen.ini, UPD, build
if buildupd =
{
SplashTextOn, , 60,��������������, ������ �������. ��������..`n������. ��� ����� � ��������.
sleep, 1000
}
if buildupd > % buildscr
{
IniRead, vupd, %a_temp%/verlen.ini, UPD, v
SplashTextOn, , 60,��������������, ������ �������. ��������..`n���������� ���������� �� ������ %vupd%!
sleep, 1000
IniRead, desupd, %a_temp%/verlen.ini, UPD, des

IniRead, updupd, %a_temp%/verlen.ini, UPD, upd

SplashTextoff
msgbox, 16384, ���������� ������� �� ������ %vupd%, %desupd%
IfMsgBox OK
{
msgbox, 1, ���������� ������� �� ������ %vupd%, ������ �� �� ����������?
IfMsgBox OK
{
put2 := % A_ScriptFullPath
RegWrite, REG_SZ, HKEY_CURRENT_USER, Software\SAMP ,put2 , % put2
SplashTextOn, , 60,��������������, ����������. ��������..`n��������� ������ �� ������ %vupd%!
URLDownloadToFile, %downlurl%, %a_temp%/updt.exe
sleep, 1000
run, %a_temp%/updt.exe
exitapp
}
}
}
SplashTextoff
}

{ ;Main GUI
Gui, +hwndhGui1
Gui, Show, h658 w800, Ban/Mute GUI Panel by RQVM(Requiem) Beta v1.25
Gui, Add, Picture, x2 y-1 w800 h660 , %a_temp%/6Pqj5LoJrJk1.jpg
Gui, Font, S10 CDefault, Verdana
Gui, Add, Button, x-8 y99 w130 h30 gForum, Forum Reasons
Gui, Add, Button, x-8 y39 w130 h30 gMute, ���. �������
Gui, Add, Button, x-8 y69 w130 h30 gBans, Out Game Bans
Gui, Font, S12 CDefault, Verdana
Gui, Add, Button, x-8 y-1 w150 h30 gButtonHelp, ������ �� GUI
Gui, Add, Button, x262 y299 w80 h30 gbanReklama, �������
Gui, Add, Button, x192 y359 w80 h30 gBanOskAdm, /������
Gui, Add, Button, x262 y389 w160 h30 gBanuser, ������. �������
Gui, Add, Button, x272 y359 w70 h30 gBanAdm, ������
Gui, Add, Button, x72 y359 w120 h30 gBanOskProjekt, ���. �������
Gui, Add, Button, x212 y449 w150 h30 gBanAgit, �����. ��������
Gui, Add, Button, x232 y329 w150 h30 gBanTryBro, ������� ������
Gui, Add, Button, x32 y449 w180 h30 gBanLink, �����. ����. ������
Gui, Add, Button, x222 y539 w130 h30 gBanNarko, ������. �����
Gui, Add, Button, x142 y419 w100 h30 gBANSW, ��� �� SW
Gui, Add, Button, x352 y539 w100 h30 gBanNazi, /�������
Gui, Add, Button, x242 y479 w200 h30 gBanIncor2, �������/�������� ��
Gui, Add, Button, x362 y449 w90 h30 gBanGrief, TeamGrief
Gui, Add, Button, x152 y479 w90 h30 gBanPref, /�������
Gui, Add, Button, x332 y569 w60 h30 gBanObman, �����
Gui, Add, Button, x402 y419 w60 h30 gBanCheat, ����
Gui, Add, Button, x92 y569 w140 h30 gBanProd, ������� ����
Gui, Add, Button, x32 y479 w120 h30 gIncorrSkin, ������. ����
Gui, Add, Button, x42 y419 w100 h30 gBANBW, ��� �� BW
Gui, Add, Button, x62 y389 w200 h30 gBanIncorr, ����������. ���������
Gui, Add, Button, x62 y539 w160 h30 gBanPiar, ���� ��. �������
Gui, Add, Button, x32 y509 w110 h30 gBanIncor, ������. ���
Gui, Add, Button, x422 y509 w70 h30 gBanCheat2, /�����
Gui, Add, Button, x222 y509 w200 h30 gBanBagouse, ��������������� ����
Gui, Add, Button, x142 y509 w80 h30 gBanPomexa, ������
Gui, Add, Button, x342 y359 w70 h30 gBagouse, ������
Gui, Font, S21 CDefault, Verdana
Gui, Add, Button, x702 y459 w100 h30 gBButton vBButton, % Chr(0x2192)
Gui, Font, S12 CDefault, Verdana
Gui, Add, Button, x712 y329 w90 h40 gReports, Reports
Gui, Add, Button, x702 y519 w100 h40 gReportChat, ������ ���
Gui, Add, Button, x602 y559 w210 h30 gRuleMod, ������� ��� �������
Gui, Add, Button, x602 y589 w200 h30 gRuleHelp, ������� ��� ��������
Gui, Add, Button, x652 y-1 w60 h30 gMuteOsk, ���.
Gui, Add, Button, x712 y-1 w90 h30 gMuteOskMat, ���+���
Gui, Add, Button, x612 y29 w70 h30 gMuteObm, �����
Gui, Add, Button, x682 y29 w120 h30 gMuteGolosovanie, �����������
Gui, Add, Button, x602 y-1 w50 h30 gCaps, Caps
Gui, Add, Button, x642 y59 w50 h30 gMuteFlood, Flood
Gui, Add, Button, x692 y59 w110 h30 gMuteFlood2, Flood+Caps
Gui, Add, Button, x652 y89 w150 h30 gMuteFloodSymb, ���� ���������
Gui, Add, Button, x642 y119 w70 h30 gMuteAmor, ������
Gui, Add, Button, x712 y119 w90 h30 gMuteReklama, �������
Gui, Add, Button, x702 y219 w100 h30 gFlood, ���� � ��
Gui, Add, Button, x692 y149 w110 h30 gMuteUpomin, ����������
Gui, Add, Button, x692 y179 w110 h30 gMuteSpam, ���� � ����
Gui, Add, Button, x632 y149 w60 h30 gMuteMat, ���
Gui, Add, Button, x242 y419 w160 h30 gSell, ������� �� ����
Gui, Add, Button, x232 y569 w100 h30 gBanPered, /��������
}

{ ;�����-���������� 
Gui, 2:+hwndhGui2 +owner1 -Caption +Border
Gui, 2:Font, S7 CGreen, arial black
Gui, 2:Add, Text,, ������� 
Gui, 2:Add, Text,, ���/���
Gui, 2:Add, Text,, �����
Gui, 2:Add, Text,, ������
Gui, 2:Add, Text,, ���/����
Gui, 2:Add, Text,, ������
Gui, 2:Add, Text,, ���
Gui, 2:Add, Text,, �����
Gui, 2:Add, Text,, ���������
Gui, 2:Add, Text,, ���
Gui, 2:Add, Text,, ���
Gui, 2:Add, Text,, ����
Gui, 2:Add, Text,, �����
Gui, 2:Add, Text,, �������
Gui, 2:Add, Text,, ���������/���
Gui, 2:Add, Text,, ����/������
Gui, 2:Add, Text,, ���/����������
Gui, 2:Add, Text,, ���������/���
Gui, 2:Add, Text,, ������/������
Gui, 2:Add, Text,, �������/����
Gui, 2:Add, Text,, �����/����������
Gui, 2:Add, Text,, �����/������
Gui, 2:Add, Text,, ���/���������
Gui, 2:Add, Text,, ������/������
Gui, 2:Add, Text,, ��/���������
Gui  2:show,Hide
VarSetCapacity(WI, 60)
}

{ ;��������� ���
Gui, 3:+hwndhGui3 +owner1 -Caption +Border
Gui, 4:+hwndhGui4 +owner1 -Caption +Border
Gui, 5:+hwndhGui5 +owner1 -Caption +Border
}

{ ;������ ����-����������
OnMessage(0x3, "WM_MOVE")
OnMessage(0x112, "WM_MOVE")   ; WM_SYSCOMMAND = 0x112
return


Button:
   DllCall("GetWindowInfo", Ptr, hGui1, Ptr, &WI)
   ((InStr(A_GuiControl, "Button") || (A_GuiControl = "Tab" && i)) && i := !i)
   Loop 4
      GuiControl,, BButton%A_Index%, % Chr(0x2190|(i ? 0 : 2))
   
   if i
      Gui, 2:Show, % "x" NumGet(WI, 12, "UInt") " y" NumGet(WI, 24, "UInt") 
                  . " h" NumGet(WI, 32, "UInt") - NumGet(WI, 24, "UInt") " hide"
   DllCall("AnimateWindow", Ptr, hGui2, UInt, 400, UInt, 0x40000|(i ? 1 : 0x10002))
   
   if (A_GuiControl = "Tab")  {  ; ���� �������� �������, ������ ���������� � ����
      GuiControlGet, Tab
      for k, v in Tabs
         if (Tab = v)
            break
      GuiControl, 2:, Info, % Texts[k]
   }
   return

BButton:
   DllCall("GetWindowInfo", Ptr, hGui1, Ptr, &WI)
   if i := !i
      Gui, 2:Show, % "x" NumGet(WI, 12, "UInt") " y" NumGet(WI, 24, "UInt") 
                  . " h" NumGet(WI, 32, "UInt") - NumGet(WI, 24, "UInt") " hide"
   DllCall("AnimateWindow", Ptr, hGui2, UInt, 400, UInt, 0x40000|(i ? 1 : 0x10002))
   GuiControl,, BButton, % Chr(0x2190|(i ? 0 : 2))
   return
   
   
WM_MOVE(wp, lp, msg, hwnd)
{
   global hGui1, WI, i
   static k
   if (msg = 0x112)
   {
      if (wp = 0xF020 && k := 1)   ; SC_MINIMIZE = 0xF020
         Gui, 2:Show, Hide
      
      if (wp = 0xF120 && !(k := 0) && i)   ; SC_RESTORE = 0xF120
         Gui, 2:Show
   }
   
   if (!i || hwnd != hGui1 || k = 1)
      return
   
   DllCall("GetWindowInfo", Ptr, hGui1, Ptr, &WI)
   Gui, 2:Show, % "x" NumGet(WI, 12, "UInt") " y" NumGet(WI, 24, "UInt") 
               . " h" NumGet(WI, 32, "UInt") - NumGet(WI, 24, "UInt") " NA"
}
    }

{ ;GUI � �����/�����
Mute:
Gui, 4:Hide 
Gui, 2:Hide
Gui, 3:Hide
Gui, 5:Show, x52 y167 h270 w337
Gui, 5:Font, S35 CBlue, fantasy
Gui, 5:Add, Text, x902 y249 w-820 h-160 , Text
Gui, 5:Add, Text, x32 y99 w290 h70 , Coming Soon

return


Forum:
Gui, 4:Hide 
Gui, 2:Hide
Gui, 5:Hide
Gui, 3:Show, x70 y70 h238 w250
Gui, 3:Add, Button, x-8 y-1 w260 h40 gMeriPrinyati, ���� �������
Gui, 3:Add, Button, x-8 y39 w260 h40 gNedostatochno, �� �� �����
Gui, 3:Add, Button, x-8 y79 w260 h40 gNedostatochno2, ��� �������
Gui, 3:Add, Button, x-8 y119 w260 h40 gNedostatochno3, �������� �� ��������
Gui, 3:Add, Button, x-8 y159 w260 h40 gNedostatochno4, ������������ ���������
Gui, 3:Add, Button, x-8 y199 w260 h40 gNedostatochno5, �� ����� �� ������
VarSetCapacity(WI, 60)
Return

}

{ ;Forum hotkeys

MeriPrinyati:
Gui, 5:Hide
Gui, 4:Hide 
Gui, 2:Hide
Gui, 3:Hide
Gui, 1:Hide
Sleep, 60
SendInput, [ok='���� �������.']������� �� ������.[/ok]
return

Nedostatochno:
Gui, 5:Hide
Gui, 4:Hide 
Gui, 2:Hide
Gui, 3:Hide
Gui, 1:Hide
Sleep, 60
SendInput, [info='�������.']�� �� �����.[/info]
return

Nedostatochno5:
Gui, 5:Hide
Gui, 4:Hide 
Gui, 2:Hide
Gui, 3:Hide
Gui, 1:Hide
Sleep, 60
SendInput, [info='�������.']�� ����� �� ���������� ���������.[/info]
return

Nedostatochno2:
Gui, 5:Hide
Gui, 4:Hide 
Gui, 2:Hide
Gui, 3:Hide
Gui, 1:Hide
Sleep, 60
SendInput, [info='�������.']��� �������.[/info]
return

Nedostatochno3:
Gui, 5:Hide
Gui, 4:Hide 
Gui, 2:Hide
Gui, 3:Hide
Gui, 1:Hide
Sleep, 60
SendInput, [info='�������.']�������� �� ��������.[/info]
return

Nedostatochno4:
Gui, 5:Hide
Gui, 4:Hide 
Gui, 2:Hide
Gui, 3:Hide
Gui, 1:Hide
Sleep, 60
SendInput, [info='�������.']������������ ���������.[/info]
return
}

{ ;GUI In-Game Bans
Bans:
Gui, 3:Hide 
Gui, 2:Hide
Gui, 5:Hide
Gui, 4:Show, x70 y70 h447 w210
Gui, 4:Font, S10 CRed, cursive
Gui, 4:Add, Button, x-8 y-1 w120 h30 gBanOskProjekt1, ���.�������
Gui, 4:Add, Button, x112 y-1 w100 h30 gBanOskAdm1, /������
Gui, 4:Add, Button, x-8 y29 w70 h30 gBanAdm1, ������
Gui, 4:Add, Button, x62 y29 w150 h30 gBanuser1, ������.�������
Gui, 4:Add, Button, x-8 y59 w90 h30 gBanIncor, �����.���
Gui, 4:Add, Button, x82 y59 w50 h30 gIncorrSkin1, /����
Gui, 4:Add, Button, x132 y59 w80 h30 gBanPref1, /�������
Gui, 4:Add, Button, x142 y89 w70 h30 gBanCheat1, /�����
Gui, 4:Add, Button, x102 y149 w110 h30 gBanPered1, �������� ����
Gui, 4:Add, Button, x82 y119 w130 h30 gSell1, ������� �� ����
Gui, 4:Add, Button, x132 y179 w80 h30 gBanNazi1, /�������
Gui, 4:Add, Button, x-8 y89 w150 h30 gBanBagouse1, �������������. ����
Gui, 4:Add, Button, x-8 y119 w90 h30 gBanGrief1, TeamGrief
Gui, 4:Add, Button, x-8 y179 w140 h30 gBanNarko1, ���������� �����.
Gui, 4:Add, Button, x-8 y149 w110 h30 gBanProd1, ������� ����
Gui, 4:Add, Button, x-8 y209 w170 h30 gBanIncorr1, ����������. ���������
Gui, 4:Add, Button, x162 y209 w50 h30 gBanCheat3, ����
Gui, 4:Add, Button, x-8 y239 w220 h30 gBanIncor1, ������. ��������/������� ��
Gui, 4:Add, Button, x122 y269 w90 h30 gBanUpomin1, ����������
Gui, 4:Add, Button, x-8 y269 w130 h30 gBanPiar1, ���� ��.�������
Gui, 4:Add, Button, x-8 y299 w90 h30 gBanuserBW, ��� �� BW
Gui, 4:Add, Button, x82 y299 w80 h30 gBanuserSW, ��� �� SW
Gui, 4:Add, Button, x162 y299 w50 h30 gBanAsoc1, ����
Gui, 4:Add, Button, x152 y329 w60 h30 gBanAmor1, ������
Gui, 4:Add, Button, x-8 y329 w160 h30 gBanTryBro1, ������� ������ ����
Gui, 4:Add, Button, x-8 y359 w80 h30 gbanReklama1, �������
Gui, 4:Add, Button, x72 y359 w140 h30 gBanAgit1, �������. ��������
Gui, 4:Add, Button, x-8 y389 w150 h30 gBanLink1, �����. ����. ������
Gui, 4:Add, Button, x142 y389 w70 h30 gBagouse1, ������
Gui, 4:Add, Button, x152 y419 w60 h30 gBanObman1, �����
Gui, 4:Add, Button, x-8 y419 w160 h30 gBanPomexa1, ������ ���. ��������

VarSetCapacity(WI, 60)
Return
}

{ ;������ ������
ButtonHelp:
Msgbox, 1           ���     ���                                                                                             2                                                                                                                          3                                                                                                                         4                                                                                                                        5                                                                                                                          6                                                                                                                        7                                                                    ���� ���                                    8                                                                                                                        9                                                                                                                      10                                                                                                                      11                                                                                                                      12                                                                                                                      13                                                                                                                      14                                                                                                                      15                                                                                                                      16                                                                                                                      17                                                                                                                      18                                                                                                                      19

Return
}

{ ;Rules Link
RuleMod:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, Hide
Run, http://forum.vimeworld.ru/topic/175379-�����������-���-�����������-update-23102018/
return

RuleHelp:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, Hide
Run, http://forum.vimeworld.ru/topic/18-�����������-���-��������-update-29032018/ 
return

ReportChat:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, Hide
Run, https://cp.vimeworld.ru/moder/reports
return

Reports:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
Send {sc14} 
sleep,70
SendRaw /rs
Send {Enter}
return

}

{ ;Main GUI �������
BanOskProjekt:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 0 ����������� �������.
return

BANBW:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw, 2880 ��� �� BW.
return

BANSW:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw, 2880 ��� �� SW.
return

Banuser:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 0 �������������� ������� � ��������������.
return

Bagouse:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 10080 ������.
return

IncorrSkin:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 1440 ������������ ����.
return

Sell:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 0 ������� �� �������� ������/������.
return

Caps:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 120 ����.
return

Flood:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw ���� � ������ ���������.
return

MuteObm:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 240 ����� �������.
return

MuteFloodSymb:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 120 Flood ���������.
return

MuteFlood:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 120 Flood.
return


MuteFlood2:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 240 Flood+Caps.
return


MuteUpomin:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 2880 ���������� �� ���� �������.
return

BanReklama:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 1440 �������.
return

MuteMat:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 240 ���.
return

MuteReklama:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 1440 �������.
return

MuteSpam:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 44640 ����.
return

MuteAmor:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 240 ���������� ���������.
return

MuteOsk:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 480 �����������.
return


MuteOskMat:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 720 �����������+���.
return

MuteGolosovanie:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 30 �����������.
return

BanAsoc:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 720 ����������� ���������.
return

BanAmor:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 720 ���������� ���������.
return

BanTryBro:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 10080 ������� ������ ��������.
return

BanIncorr:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 2880 ������������ ���������.
return

BanAdm:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 10080 ������ ���� �� �������������.
return

BanObman:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 2880 ����� �������.
return

BanProd:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 0 ������� ��������.
return

BanPered:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 0 �������� ��������.
return

BanAgit:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 0 ������������ ��������.
return

BanPiar:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 0 ������� ������� �������.
return

BanNarko:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 10080 ���������� ����������.
return


BanNazi:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 10080 ���������� �������.
return

BanGrief:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 2880 Team Grief.
return

BanPomexa:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 2880 ������ �������� ��������.
return

BanPref:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 10080 ������������ �������.
return

BanLink:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 0 ��������������� ����������� ������.
return

BanIncor2:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 10080 ������������ �������/�������� �������.
return

BanCheat2:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 0 ��������������� �����.
return

BanBagouse:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 0 ��������������� ����.
return

BanSell:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 0 ������� �� �������� ������/������.
return

BanCheat:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 0 ������������� �����.
return


BanOskAdm:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 0 ����������� �������������.
return

BanIncor:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 0 ������������ �������.
return
}

{ ;Second GUI �������

BanuserBW:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld  
Send {sc14} 
sleep, 70
SendRaw /ban 2880 ��� �� BW.
Send {LEFT 16}{Space}
return

BanuserSW:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld  
Send {sc14}
sleep 60
SendRaw /ban 2880 ��� �� SW.
SendInput {LEFT 16}{Space}
return

Banuser1:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld  
SendInput {sc14} 
sleep, 70
SendRaw /ban 0 �������������� ������� � ��������������.
Send {LEFT 43}{Space}
return

Bagouse1:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld  
Send {sc14} 
sleep, 70
SendRaw /ban 10080 ������. 
Send {LEFT 14}{Space}
return

IncorrSkin1:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld  
Send {sc14} 
sleep,70
SendRaw /ban 1440 ������������ ����.
Send {LEFT 24}{Space}
return

Sell1:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld  
Send {sc14} 
sleep,70
SendRaw /ban 0 ������� �� �������� ������/������.
Send {LEFT 37}{Space}
return

BanUpomin1:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld  
Send {sc14} 
sleep,70
SendRaw /ban 2880 ���������� �� ���� �������.
Send {LEFT 33}{Space}
return

banReklama1:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld  
Send {sc14} 
sleep,70
SendRaw /ban 1440 �������.
Send {LEFT 14}{Space}
return

BanAsoc1:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld  
Send {sc14} 
sleep,70
SendRaw /ban 720 ����������� ���������.
Send {LEFT 27}{Space}
return


BanAmor1:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld  
Send {sc14} 
sleep,70
SendRaw /ban 720 ���������� ���������.
Send {LEFT 26}{Space}
return

BanTryBro1:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld  
Send {sc14} 
sleep,70
SendRaw /ban 10080 ������� ������ ��������.
Send {LEFT 31}{Space}
return

BanIncorr1:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld  
Send {sc14} 
sleep,70
SendRaw /ban 2880 ������������ ���������.
Send {LEFT 29}{Space}
return

BanAdm1:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld  
Send {sc14} 
sleep,70
SendRaw /ban 10080 ������ ���� �� �������������.
Send {LEFT 36}{Space}
return

BanObman1:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld  
Send {sc14} 
sleep,70
SendRaw /ban 2880 ����� �������.
Send {LEFT 20}{Space}
return

BanProd1:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld  
Send {sc14} 
sleep,70
SendRaw /ban 0 ������� ��������.
Send {LEFT 20}{Space}
return

BanPered1:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld  
Send {sc14} 
sleep,70
SendRaw /ban 0 �������� ��������.
Send {LEFT 21}{Space}
return

BanAgit1:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld  
Send {sc14} 
sleep,70
SendRaw /ban 0 ������������ ��������.
sleep,70
Send {LEFT 25}{Space}
return

BanPiar1:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld  
Send {sc14} 
sleep,70
SendRaw /ban 0 ������� ������� �������.
Send {LEFT 27}{Space}
return

BanNarko1:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld  
Send {sc14} 
sleep,70
SendRaw /ban 10080 ���������� ����������.
SendInput {LEFT 29}{Space}
return

BanNazi1:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld  
Send {sc14} 
sleep,70
SendRaw /ban 10080 ���������� �������.
sleep,70
Send {LEFT 26}{Space}
return

BanGrief1:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld  
Send {sc14} 
sleep,70
SendRaw /ban 2880 Team Grief.
Send {LEFT 17}{Space}
return

BanPomexa1:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld  
Send {sc14} 
sleep,70
SendRaw /ban 2880 ������ �������� ��������.
Send {LEFT 31}{Space}
return

BanPref1:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld  
Send {sc14} 
sleep,70
SendRaw /ban 10080 ������������ �������.
Send {LEFT 28}{Space}
return

BanLink1:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld  
Send {sc14} 
sleep,70
SendRaw /ban 0 ��������������� ����������� ������.
Send {LEFT 38}{Space}
return

BanIncor1:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld  
Send {sc14} 
sleep,70
SendRaw /ban 10080 ������������ �������/�������� �������.
Send {LEFT 45}{Space}
return

BanCheat1:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld  
Send {sc14} 
sleep,70
SendRaw /ban 0 ��������������� �����.
Send {LEFT 25}{Space}
return

BanBagouse1:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld  
Send {sc14} 
sleep,70
SendRaw /ban 0 ��������������� ����.
Send {LEFT 24}{Space}
return

BanSell1:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld  
Send {sc14} 
sleep,70
SendRaw /ban 0 ������� �� �������� ������/������.
Send {LEFT 36}{Space}
return

BanCheat3:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld  
Send {sc14} 
sleep,70
SendRaw /ban 0 ������������� �����.
Send {LEFT 23}{Space}
return

BanOskProjekt1:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld  
Send {sc14} 
sleep,70
SendRaw /ban 0 ����������� �������.
Send {LEFT 23}{Space}
return

BanOskAdm1:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld  
Send {sc14} 
sleep,70
SendRaw /ban 0 ����������� �������������.
Send {LEFT 29}{Space}
return

BanIncor3:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld  
Send {sc14} 
sleep,70
SendRaw /ban 0 ������������ �������.
Send {LEFT 24}{Space}
return
}

{ ;������ ����
Caps5:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,70
SendInput {sc14} 
sleep,70
SendRaw /mute 120 ����.
sleep,70
SendInput {LEFT 10}{Space}
return

Flood5:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,70
SendInput {sc14} 
sleep,70
SendRaw /kick ���� � ������ ���������.
sleep,70
SendInput {LEFT 25}{Space}
return

MuteObm5:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,70
SendInput {sc14} 
sleep,70
SendRaw /mute 240 ����� �������.
sleep,70
SendInput {LEFT 19}{Space}
return

MuteFloodSymb5:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,70
SendInput {sc14} 
sleep,70
SendRaw /mute 120 Flood ���������.
sleep,70
SendInput {LEFT 21}{Space}
sleep,70
return

MuteFlood6:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,70
SendInput {sc14} 
sleep,70
SendRaw /mute 120 Flood.
sleep,70
SendInput {LEFT 11}{Space}
sleep,70
return

MuteFlood5:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,70
SendInput {sc14} 
sleep,70
SendRaw /mute 240 Flood+Caps.
sleep,70
SendInput {LEFT 16}{Space}
sleep,70
return

MuteUpomin5:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,90
SendInput {sc14} 
sleep,70
SendRaw /mute 2880 ���������� �� ���� �������.
sleep,70
SendInput {LEFT 33}{Space}
sleep,70
return

MuteReklama5:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,90
SendInput {sc14} 
sleep,70
SendRaw /mute 1440 �������.
sleep,70
SendInput {LEFT 14}{Space}
sleep,70
return

MuteSpam5:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,90
SendInput {sc14} 
sleep,70
SendRaw /mute 44640 ����.
sleep,70
SendInput {LEFT 12}{Space}
sleep,70
return

MuteAmor5:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,90
SendInput {sc14} 
sleep,70
SendRaw /mute 240 ���������� ���������.
sleep,70
SendInput {LEFT 26}{Space}
sleep,70
return

MuteOsk5:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,90
SendInput {sc14} 
sleep,70
SendRaw /mute 480 �����������.
sleep,70
SendInput {LEFT 17}{Space}
sleep,70
return

MuteOskMat5:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,90
SendInput {sc14} 
sleep,70
SendRaw /mute 720 �����������+���.
sleep,70
SendInput {LEFT 21}{Space}
sleep,70
return

MuteGolosovanie5:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,90
SendInput {sc14} 
sleep,70
SendRaw /mute 30 �����������.
sleep,70
SendInput {LEFT 16}{Space}
sleep,70
return
}

{ ; �����
Home::Reload ; ������������� ������ 
End::ExitApp ;��������� ������
Insert::Suspend ;������ ������ �� �����
sc3E:: ;������� ��� �����, ����� ������ ��� ����� ����� ��� http://prntscr.com/m3wyjv 
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui,  Show, % (a := !a) ? "h658 w800" : "Hide"
   if !i {
      Return
   i := false
}
return
}
