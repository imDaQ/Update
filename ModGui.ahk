IfnotExist, %A_temp%
FileCreateDir, %A_temp%
FileDelete, %a_temp%/verlen.ini
downlpic := "https://github.com/rqvm/Update/raw/master/6Pqj5LoJrJk1.jpg"
{
IfnotExist, %A_temp%\6Pqj5LoJrJk1.jpg
URLDownloadToFile, %downlpic%, %a_temp%/6Pqj5LoJrJk1.jpg
}

{ ;AutoUpdate
buildscr = 25 ;версия для сравнения, если меньше чем в verlen.ini - обновляем
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

msgbox, , Список изменений версии %vupd%, %updupd%
return
}

OnMessage(0x53, "WM_HELP")
Gui +OwnDialogs

SplashTextOn, , 60,Автообновление, Запуск скрипта. Ожидайте..`nПроверяем наличие обновлений.
URLDownloadToFile, %downllen%, %a_temp%/verlen.ini
IniRead, buildupd, %a_temp%/verlen.ini, UPD, build
if buildupd =
{
SplashTextOn, , 60,Автообновление, Запуск скрипта. Ожидайте..`nОшибка. Нет связи с сервером.
sleep, 1000
}
if buildupd > % buildscr
{
IniRead, vupd, %a_temp%/verlen.ini, UPD, v
SplashTextOn, , 60,Автообновление, Запуск скрипта. Ожидайте..`nОбнаружено обновление до версии %vupd%!
sleep, 1000
IniRead, desupd, %a_temp%/verlen.ini, UPD, des

IniRead, updupd, %a_temp%/verlen.ini, UPD, upd

SplashTextoff
msgbox, 16384, Обновление скрипта до версии %vupd%, %desupd%
IfMsgBox OK
{
msgbox, 1, Обновление скрипта до версии %vupd%, Хотите ли Вы обновиться?
IfMsgBox OK
{
put2 := % A_ScriptFullPath
RegWrite, REG_SZ, HKEY_CURRENT_USER, Software\SAMP ,put2 , % put2
SplashTextOn, , 60,Автообновление, Обновление. Ожидайте..`nОбновляем скрипт до версии %vupd%!
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
Gui, Add, Button, x-8 y39 w130 h30 gMute, Мод. Серверы
Gui, Add, Button, x-8 y69 w130 h30 gBans, Out Game Bans
Gui, Font, S12 CDefault, Verdana
Gui, Add, Button, x-8 y-1 w150 h30 gButtonHelp, Помощь по GUI
Gui, Add, Button, x262 y299 w80 h30 gbanReklama, Реклама
Gui, Add, Button, x192 y359 w80 h30 gBanOskAdm, /Админа
Gui, Add, Button, x262 y389 w160 h30 gBanuser, Неуваж. общение
Gui, Add, Button, x272 y359 w70 h30 gBanAdm, Выдача
Gui, Add, Button, x72 y359 w120 h30 gBanOskProjekt, Оск. Сервера
Gui, Add, Button, x212 y449 w150 h30 gBanAgit, Полит. Агитация
Gui, Add, Button, x232 y329 w150 h30 gBanTryBro, Попытка взлома
Gui, Add, Button, x32 y449 w180 h30 gBanLink, Распр. вред. ссылок
Gui, Add, Button, x222 y539 w130 h30 gBanNarko, Пропаг. нарко
Gui, Add, Button, x142 y419 w100 h30 gBANSW, Тим на SW
Gui, Add, Button, x352 y539 w100 h30 gBanNazi, /фашизма
Gui, Add, Button, x242 y479 w200 h30 gBanIncor2, Префикс/Название Ги
Gui, Add, Button, x362 y449 w90 h30 gBanGrief, TeamGrief
Gui, Add, Button, x152 y479 w90 h30 gBanPref, /префикс
Gui, Add, Button, x332 y569 w60 h30 gBanObman, Обман
Gui, Add, Button, x402 y419 w60 h30 gBanCheat, Читы
Gui, Add, Button, x92 y569 w140 h30 gBanProd, Продажа акка
Gui, Add, Button, x32 y479 w120 h30 gIncorrSkin, Некорр. Скин
Gui, Add, Button, x42 y419 w100 h30 gBANBW, Тим на BW
Gui, Add, Button, x62 y389 w200 h30 gBanIncorr, Некорректн. постройка
Gui, Add, Button, x62 y539 w160 h30 gBanPiar, Пиар др. Проекта
Gui, Add, Button, x32 y509 w110 h30 gBanIncor, Некорр. Ник
Gui, Add, Button, x422 y509 w70 h30 gBanCheat2, /Читов
Gui, Add, Button, x222 y509 w200 h30 gBanBagouse, Распространение бага
Gui, Add, Button, x142 y509 w80 h30 gBanPomexa, Помеха
Gui, Add, Button, x342 y359 w70 h30 gBagouse, Багоюз
Gui, Font, S21 CDefault, Verdana
Gui, Add, Button, x702 y459 w100 h30 gBButton vBButton, % Chr(0x2192)
Gui, Font, S12 CDefault, Verdana
Gui, Add, Button, x712 y329 w90 h40 gReports, Reports
Gui, Add, Button, x702 y519 w100 h40 gReportChat, Репорт чат
Gui, Add, Button, x602 y559 w210 h30 gRuleMod, Правила для модеров
Gui, Add, Button, x602 y589 w200 h30 gRuleHelp, Правила для хелперов
Gui, Add, Button, x652 y-1 w60 h30 gMuteOsk, Оск.
Gui, Add, Button, x712 y-1 w90 h30 gMuteOskMat, Оск+Мат
Gui, Add, Button, x612 y29 w70 h30 gMuteObm, Обман
Gui, Add, Button, x682 y29 w120 h30 gMuteGolosovanie, Голосование
Gui, Add, Button, x602 y-1 w50 h30 gCaps, Caps
Gui, Add, Button, x642 y59 w50 h30 gMuteFlood, Flood
Gui, Add, Button, x692 y59 w110 h30 gMuteFlood2, Flood+Caps
Gui, Add, Button, x652 y89 w150 h30 gMuteFloodSymb, Флуд символами
Gui, Add, Button, x642 y119 w70 h30 gMuteAmor, Аморал
Gui, Add, Button, x712 y119 w90 h30 gMuteReklama, Реклама
Gui, Add, Button, x702 y219 w100 h30 gFlood, Флуд в лс
Gui, Add, Button, x692 y149 w110 h30 gMuteUpomin, Упоминание
Gui, Add, Button, x692 y179 w110 h30 gMuteSpam, Спам в чате
Gui, Add, Button, x632 y149 w60 h30 gMuteMat, Мат
Gui, Add, Button, x242 y419 w160 h30 gSell, Продажа за реал
Gui, Add, Button, x232 y569 w100 h30 gBanPered, /передача
}

{ ;Слова-Исключения 
Gui, 2:+hwndhGui2 +owner1 -Caption +Border
Gui, 2:Font, S7 CGreen, arial black
Gui, 2:Add, Text,, Скулина 
Gui, 2:Add, Text,, Нуб/Рак
Gui, 2:Add, Text,, Бляха
Gui, 2:Add, Text,, Ссыкло
Gui, 2:Add, Text,, Хер/Хрен
Gui, 2:Add, Text,, Задрот
Gui, 2:Add, Text,, Лол
Gui, 2:Add, Text,, Лалка
Gui, 2:Add, Text,, Дальтоник
Gui, 2:Add, Text,, Ппц
Gui, 2:Add, Text,, Епт
Gui, 2:Add, Text,, Баба
Gui, 2:Add, Text,, Крыса
Gui, 2:Add, Text,, Выбоины
Gui, 2:Add, Text,, Неудачник/Бло
Gui, 2:Add, Text,, Дрыщ/Подлый
Gui, 2:Add, Text,, Дно/Биссексуал
Gui, 2:Add, Text,, Противный/Бло
Gui, 2:Add, Text,, Отстой/Слабак
Gui, 2:Add, Text,, Оболтус/Жмот
Gui, 2:Add, Text,, Косой/Лукодрочер
Gui, 2:Add, Text,, Лузер/Изверг
Gui, 2:Add, Text,, Гей/Лесбиянка
Gui, 2:Add, Text,, Тормоз/Подсос
Gui, 2:Add, Text,, хз/Пипидастр
Gui  2:show,Hide
VarSetCapacity(WI, 60)
}

{ ;Остальные гуи
Gui, 3:+hwndhGui3 +owner1 -Caption +Border
Gui, 4:+hwndhGui4 +owner1 -Caption +Border
Gui, 5:+hwndhGui5 +owner1 -Caption +Border
}

{ ;Кнопка слов-исключений
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
   
   if (A_GuiControl = "Tab")  {  ; если меняется вкладка, меняем информацию в окне
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

{ ;GUI с мутом/баном
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
Gui, 3:Add, Button, x-8 y-1 w260 h40 gMeriPrinyati, Меры Приняты
Gui, 3:Add, Button, x-8 y39 w260 h40 gNedostatochno, Не по форме
Gui, 3:Add, Button, x-8 y79 w260 h40 gNedostatochno2, Уже наказан
Gui, 3:Add, Button, x-8 y119 w260 h40 gNedostatochno3, Скриншот не работает
Gui, 3:Add, Button, x-8 y159 w260 h40 gNedostatochno4, Недостаточно нарушений
Gui, 3:Add, Button, x-8 y199 w260 h40 gNedostatochno5, Не тянет на Аморал
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
SendInput, [ok='Меры приняты.']Спасибо за жалобу.[/ok]
return

Nedostatochno:
Gui, 5:Hide
Gui, 4:Hide 
Gui, 2:Hide
Gui, 3:Hide
Gui, 1:Hide
Sleep, 60
SendInput, [info='Закрыто.']Не по форме.[/info]
return

Nedostatochno5:
Gui, 5:Hide
Gui, 4:Hide 
Gui, 2:Hide
Gui, 3:Hide
Gui, 1:Hide
Sleep, 60
SendInput, [info='Закрыто.']Не тянет на Аморальное поведение.[/info]
return

Nedostatochno2:
Gui, 5:Hide
Gui, 4:Hide 
Gui, 2:Hide
Gui, 3:Hide
Gui, 1:Hide
Sleep, 60
SendInput, [info='Закрыто.']Уже наказан.[/info]
return

Nedostatochno3:
Gui, 5:Hide
Gui, 4:Hide 
Gui, 2:Hide
Gui, 3:Hide
Gui, 1:Hide
Sleep, 60
SendInput, [info='Закрыто.']Скриншот не работает.[/info]
return

Nedostatochno4:
Gui, 5:Hide
Gui, 4:Hide 
Gui, 2:Hide
Gui, 3:Hide
Gui, 1:Hide
Sleep, 60
SendInput, [info='Закрыто.']Недостаточно нарушений.[/info]
return
}

{ ;GUI In-Game Bans
Bans:
Gui, 3:Hide 
Gui, 2:Hide
Gui, 5:Hide
Gui, 4:Show, x70 y70 h447 w210
Gui, 4:Font, S10 CRed, cursive
Gui, 4:Add, Button, x-8 y-1 w120 h30 gBanOskProjekt1, Оск.Сервера
Gui, 4:Add, Button, x112 y-1 w100 h30 gBanOskAdm1, /Админа
Gui, 4:Add, Button, x-8 y29 w70 h30 gBanAdm1, Выдача
Gui, 4:Add, Button, x62 y29 w150 h30 gBanuser1, Неуваж.Общение
Gui, 4:Add, Button, x-8 y59 w90 h30 gBanIncor, Некор.Ник
Gui, 4:Add, Button, x82 y59 w50 h30 gIncorrSkin1, /Скин
Gui, 4:Add, Button, x132 y59 w80 h30 gBanPref1, /Префикс
Gui, 4:Add, Button, x142 y89 w70 h30 gBanCheat1, /Читов
Gui, 4:Add, Button, x102 y149 w110 h30 gBanPered1, Передача акка
Gui, 4:Add, Button, x82 y119 w130 h30 gSell1, Продажа за реал
Gui, 4:Add, Button, x132 y179 w80 h30 gBanNazi1, /фашизма
Gui, 4:Add, Button, x-8 y89 w150 h30 gBanBagouse1, Распространен. бага
Gui, 4:Add, Button, x-8 y119 w90 h30 gBanGrief1, TeamGrief
Gui, 4:Add, Button, x-8 y179 w140 h30 gBanNarko1, Пропаганда нарко.
Gui, 4:Add, Button, x-8 y149 w110 h30 gBanProd1, Продажа акка
Gui, 4:Add, Button, x-8 y209 w170 h30 gBanIncorr1, Некорректн. постройка
Gui, 4:Add, Button, x162 y209 w50 h30 gBanCheat3, Читы
Gui, 4:Add, Button, x-8 y239 w220 h30 gBanIncor1, Некорр. название/Префикс Ги
Gui, 4:Add, Button, x122 y269 w90 h30 gBanUpomin1, Упоминание
Gui, 4:Add, Button, x-8 y269 w130 h30 gBanPiar1, Пиар др.Проекта
Gui, 4:Add, Button, x-8 y299 w90 h30 gBanuserBW, Тим на BW
Gui, 4:Add, Button, x82 y299 w80 h30 gBanuserSW, Тим на SW
Gui, 4:Add, Button, x162 y299 w50 h30 gBanAsoc1, Асоц
Gui, 4:Add, Button, x152 y329 w60 h30 gBanAmor1, Аморал
Gui, 4:Add, Button, x-8 y329 w160 h30 gBanTryBro1, Попытка взлома акка
Gui, 4:Add, Button, x-8 y359 w80 h30 gbanReklama1, Реклама
Gui, 4:Add, Button, x72 y359 w140 h30 gBanAgit1, Политич. Агитация
Gui, 4:Add, Button, x-8 y389 w150 h30 gBanLink1, Распр. вред. ссылок
Gui, 4:Add, Button, x142 y389 w70 h30 gBagouse1, Багоюз
Gui, 4:Add, Button, x152 y419 w60 h30 gBanObman1, Обман
Gui, 4:Add, Button, x-8 y419 w160 h30 gBanPomexa1, Помеха игр. процессу

VarSetCapacity(WI, 60)
Return
}

{ ;Кнопка помощи
ButtonHelp:
Msgbox, 1           ааа     фак                                                                                             2                                                                                                                          3                                                                                                                         4                                                                                                                        5                                                                                                                          6                                                                                                                        7                                                                    попу мял                                    8                                                                                                                        9                                                                                                                      10                                                                                                                      11                                                                                                                      12                                                                                                                      13                                                                                                                      14                                                                                                                      15                                                                                                                      16                                                                                                                      17                                                                                                                      18                                                                                                                      19

Return
}

{ ;Rules Link
RuleMod:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, Hide
Run, http://forum.vimeworld.ru/topic/175379-руководство-для-модераторов-update-23102018/
return

RuleHelp:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, Hide
Run, http://forum.vimeworld.ru/topic/18-руководство-для-хелперов-update-29032018/ 
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

{ ;Main GUI скрипты
BanOskProjekt:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 0 Оскорбление проекта.
return

BANBW:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw, 2880 Тим на BW.
return

BANSW:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw, 2880 Тим на SW.
return

Banuser:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 0 Неуважительное общение с Администрацией.
return

Bagouse:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 10080 Багоюз.
return

IncorrSkin:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 1440 Некорректный скин.
return

Sell:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 0 Продажа за реальные деньги/вимеры.
return

Caps:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 120 Капс.
return

Flood:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw Флуд в личные сообщения.
return

MuteObm:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 240 Обман игроков.
return

MuteFloodSymb:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 120 Flood символами.
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
SendRaw 2880 Упоминание об ином проекте.
return

BanReklama:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 1440 Реклама.
return

MuteMat:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 240 Мат.
return

MuteReklama:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 1440 Реклама.
return

MuteSpam:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 44640 Спам.
return

MuteAmor:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 240 Аморальное поведение.
return

MuteOsk:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 480 Оскорбление.
return


MuteOskMat:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 720 Оскорбление+Мат.
return

MuteGolosovanie:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 30 Голосование.
return

BanAsoc:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 720 Асоциальное поведение.
return

BanAmor:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 720 Аморальное поведение.
return

BanTryBro:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 10080 Попытка взлома аккаунта.
return

BanIncorr:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 2880 Некорректная постройка.
return

BanAdm:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 10080 Выдача себя за Администрацию.
return

BanObman:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 2880 Обман игроков.
return

BanProd:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 0 Продажа аккаунта.
return

BanPered:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 0 Передача аккаунта.
return

BanAgit:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 0 Политическая агитация.
return

BanPiar:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 0 Реклама другого проекта.
return

BanNarko:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 10080 Пропаганда наркотиков.
return


BanNazi:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 10080 Пропаганда фашизма.
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
SendRaw 2880 Помеха игровому процессу.
return

BanPref:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 10080 Некорректный префикс.
return

BanLink:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 0 Распространение вредоносных ссылок.
return

BanIncor2:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 10080 Некорректный префикс/Название Гильдии.
return

BanCheat2:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 0 Распространение Читов.
return

BanBagouse:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 0 Распространение бага.
return

BanSell:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 0 Продажа за реальные деньги/вимеры.
return

BanCheat:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 0 Использование читов.
return


BanOskAdm:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 0 Оскорбление Администрации.
return

BanIncor:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld
SendRaw 0 Некорректный никнейм.
return
}

{ ;Second GUI скрипты

BanuserBW:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld  
Send {sc14} 
sleep, 70
SendRaw /ban 2880 Тим на BW.
Send {LEFT 16}{Space}
return

BanuserSW:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld  
Send {sc14}
sleep 60
SendRaw /ban 2880 Тим на SW.
SendInput {LEFT 16}{Space}
return

Banuser1:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld  
SendInput {sc14} 
sleep, 70
SendRaw /ban 0 Неуважительное общение с Администрацией.
Send {LEFT 43}{Space}
return

Bagouse1:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld  
Send {sc14} 
sleep, 70
SendRaw /ban 10080 Багоюз. 
Send {LEFT 14}{Space}
return

IncorrSkin1:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld  
Send {sc14} 
sleep,70
SendRaw /ban 1440 Некорректный скин.
Send {LEFT 24}{Space}
return

Sell1:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld  
Send {sc14} 
sleep,70
SendRaw /ban 0 Продажа за реальные деньги/вимеры.
Send {LEFT 37}{Space}
return

BanUpomin1:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld  
Send {sc14} 
sleep,70
SendRaw /ban 2880 Упоминание об ином проекте.
Send {LEFT 33}{Space}
return

banReklama1:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld  
Send {sc14} 
sleep,70
SendRaw /ban 1440 Реклама.
Send {LEFT 14}{Space}
return

BanAsoc1:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld  
Send {sc14} 
sleep,70
SendRaw /ban 720 Асоциальное поведение.
Send {LEFT 27}{Space}
return


BanAmor1:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld  
Send {sc14} 
sleep,70
SendRaw /ban 720 Аморальное поведение.
Send {LEFT 26}{Space}
return

BanTryBro1:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld  
Send {sc14} 
sleep,70
SendRaw /ban 10080 Попытка взлома аккаунта.
Send {LEFT 31}{Space}
return

BanIncorr1:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld  
Send {sc14} 
sleep,70
SendRaw /ban 2880 Некорректная постройка.
Send {LEFT 29}{Space}
return

BanAdm1:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld  
Send {sc14} 
sleep,70
SendRaw /ban 10080 Выдача себя за Администрацию.
Send {LEFT 36}{Space}
return

BanObman1:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld  
Send {sc14} 
sleep,70
SendRaw /ban 2880 Обман игроков.
Send {LEFT 20}{Space}
return

BanProd1:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld  
Send {sc14} 
sleep,70
SendRaw /ban 0 Продажа аккаунта.
Send {LEFT 20}{Space}
return

BanPered1:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld  
Send {sc14} 
sleep,70
SendRaw /ban 0 Передача аккаунта.
Send {LEFT 21}{Space}
return

BanAgit1:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld  
Send {sc14} 
sleep,70
SendRaw /ban 0 Политическая агитация.
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
SendRaw /ban 0 Реклама другого проекта.
Send {LEFT 27}{Space}
return

BanNarko1:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld  
Send {sc14} 
sleep,70
SendRaw /ban 10080 Пропаганда наркотиков.
SendInput {LEFT 29}{Space}
return

BanNazi1:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld  
Send {sc14} 
sleep,70
SendRaw /ban 10080 Пропаганда фашизма.
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
SendRaw /ban 2880 Помеха игровому процессу.
Send {LEFT 31}{Space}
return

BanPref1:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld  
Send {sc14} 
sleep,70
SendRaw /ban 10080 Некорректный префикс.
Send {LEFT 28}{Space}
return

BanLink1:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld  
Send {sc14} 
sleep,70
SendRaw /ban 0 Распространение вредоносных ссылок.
Send {LEFT 38}{Space}
return

BanIncor1:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld  
Send {sc14} 
sleep,70
SendRaw /ban 10080 Некорректный префикс/Название Гильдии.
Send {LEFT 45}{Space}
return

BanCheat1:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld  
Send {sc14} 
sleep,70
SendRaw /ban 0 Распространение Читов.
Send {LEFT 25}{Space}
return

BanBagouse1:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld  
Send {sc14} 
sleep,70
SendRaw /ban 0 Распространение бага.
Send {LEFT 24}{Space}
return

BanSell1:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld  
Send {sc14} 
sleep,70
SendRaw /ban 0 Продажа за реальные деньги/вимеры.
Send {LEFT 36}{Space}
return

BanCheat3:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld  
Send {sc14} 
sleep,70
SendRaw /ban 0 Использование читов.
Send {LEFT 23}{Space}
return

BanOskProjekt1:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld  
Send {sc14} 
sleep,70
SendRaw /ban 0 Оскорбление проекта.
Send {LEFT 23}{Space}
return

BanOskAdm1:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld  
Send {sc14} 
sleep,70
SendRaw /ban 0 Оскорбление Администрации.
Send {LEFT 29}{Space}
return

BanIncor3:
Gui, 4:Hide
Gui, 2:Hide
Gui, 1:Hide
WinActivate, VimeWorld  
Send {sc14} 
sleep,70
SendRaw /ban 0 Некорректный никнейм.
Send {LEFT 24}{Space}
return
}

{ ;Юзлесс муты
Caps5:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,70
SendInput {sc14} 
sleep,70
SendRaw /mute 120 Капс.
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
SendRaw /kick Флуд в личные сообщения.
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
SendRaw /mute 240 Обман игроков.
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
SendRaw /mute 120 Flood символами.
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
SendRaw /mute 2880 Упоминание об ином проекте.
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
SendRaw /mute 1440 Реклама.
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
SendRaw /mute 44640 Спам.
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
SendRaw /mute 240 Аморальное поведение.
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
SendRaw /mute 480 Оскорбление.
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
SendRaw /mute 720 Оскорбление+Мат.
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
SendRaw /mute 30 Голосование.
sleep,70
SendInput {LEFT 16}{Space}
sleep,70
return
}

{ ; Бинды
Home::Reload ; перезагружает скрипт 
End::ExitApp ;закрывает скрипт
Insert::Suspend ;ставит скрипт на паузу
sc3E:: ;Клавиша для бинда, найти хоткеи для бинда можно тут http://prntscr.com/m3wyjv 
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
