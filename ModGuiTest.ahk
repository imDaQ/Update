Menu, Tray, Icon, C:\script\favicon.ico, 1
{
buildscr = 1 ;версия для сравнения, если меньше чем в verlen.ini - обновляем
downlurl := "https://github.com/rqvm/Update/blob/master/updt.exe?raw=true"
downllen := "https://github.com/rqvm/Update/raw/master/verlef.ini"

Utf8ToAnsi(ByRef Utf8String, CodePage = 1251)
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
    desupd := Utf8ToAnsi(desupd)
    IniRead, updupd, %a_temp%/verlen.ini, UPD, upd
    updupd := Utf8ToAnsi(updupd)
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
    sleep, 2000
}
if buildupd > % buildscr
{
    IniRead, vupd, %a_temp%/verlen.ini, UPD, v
    SplashTextOn, , 60,Автообновление, Запуск скрипта. Ожидайте..`nОбнаружено обновление до версии %vupd%!
    sleep, 2000
    IniRead, desupd, %a_temp%/verlen.ini, UPD, des
    desupd := Utf8ToAnsi(desupd)
    IniRead, updupd, %a_temp%/verlen.ini, UPD, upd
    updupd := Utf8ToAnsi(updupd)
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
Gui, Add, Picture, x-8 y-1 w810 h810 , C:\script\6Pqj5LoJrJk1.jpg
Gui, Font, S25 CDefault, gabriola
Gui, Add, Button, x72 y439 w140 h30 gBanOskProjekt, Оск.Сервера
Gui, Add, Button, x212 y439 w100 h30 gBanOskAdm, /Админа
Gui, Add, Button, x312 y439 w90 h30 gBanAdm, Выдача
Gui, Add, Button, x72 y739 w140 h30 gBanIncor, Некорр.Ник
Gui, Add, Button, x292 y649 w80 h30 gBanObman, Обман
Gui, Add, Button, x62 y469 w200 h30 gBanAgit, Полит.Агитация
Gui, Add, Button, x12 y589 w190 h30 gSell, Продажа за реал.
Gui, Add, Button, x202 y589 w170 h30 gBanPered, Передача акка
Gui, Add, Button, x272 y679 w60 h30 gBanAsoc, Асоц
Gui, Add, Button, x182 y679 w90 h30 gBanAmor, Аморал
Gui, Add, Button, x212 y739 w200 h30 gBanPiar, Пиар др.Проекта
Gui, Add, Button, x32 y619 w210 h30 gBanProd, Продажа аккаунта
Gui, Add, Button, x22 y559 w150 h30 gIncorrSkin, Некорр.Скин
Gui, Add, Button, x172 y559 w110 h30 gBanPref, /Префикс
Gui, Add, Button, x32 y529 w160 h30 gBanNarko, Пропаг.Нарко
Gui, Add, Button, x192 y529 w120 h30 gBanNazi, /фашизма
Gui, Add, Button, x232 y499 w200 h30 gBanLink, Распр.вред.ссылок
Gui, Add, Button, x42 y499 w190 h30 gBanTryBro, Попытка взлома
Gui, Add, Button, x62 y679 w120 h30 gBanGrief, TeamGrief
Gui, Add, Button, x332 y679 w110 h30 gBanPomexa, Помеха
Gui, Add, Button, x372 y589 w90 h30 gBagouse, Багоюз
Gui, Add, Button, x162 y649 w130 h30 gBANSW, Тим на SW
Gui, Add, Button, x32 y649 w130 h30 gBANSW, Тим на BW
Gui, Add, Button, x312 y529 w150 h30 gMuteUpomin2, Упоминание
Gui, Add, Button, x612 y89 w190 h30 gMuteFloodSymb, Флуд Символами
Gui, Add, Button, x602 y59 w70 h30 gMuteFlood, Flood
Gui, Add, Button, x672 y59 w130 h30 gMuteFlood2, Flood+Caps
Gui, Add, Button, x582 y29 w80 h30 gMuteObm, Обман
Gui, Add, Button, x662 y29 w140 h30 gMuteGolosovanie, Голосование
Gui, Add, Button, x612 y-1 w80 h30 gMuteOsk, Оск.
Gui, Add, Button, x692 y-1 w110 h30 gMuteOskMat, Оск+Мат
Gui, Add, Button, x252 y409 w90 h30 gbanReklama, Реклама
Gui, Add, Button, x632 y119 w60 h30 gCaps, Caps
Gui, Add, Button, x662 y179 w140 h30 gMuteUpomin, Упоминание
Gui, Add, Button, x692 y119 w110 h30 gMuteAmor, Аморал
Gui, Add, Button, x692 y209 w110 h30 gMuteReklama, Реклама
Gui, Add, Button, x262 y469 w160 h30 gBanuser, Неуваж.Общ.
Gui, Add, Button, x282 y559 w200 h30 gBanIncor2, Префикс/Назв.Ги
Gui, Add, Button, x242 y619 w230 h30 gBanIncorr, Некорр.Постройка
Gui, Add, Button, x372 y649 w80 h30 gBanCheat, Читы
Gui, Add, Button, x662 y149 w140 h30 gMuteSpam, Спам в чате
Gui, Add, Button, x72 y709 w250 h30 gBanBagouse, Распространение бага
Gui, Add, Button, x322 y709 w100 h30 gBanCheat2, /Читов
Gui, Add, Button, x2 y109 w170 h30 gForum, Forum Reasons
Gui, Add, Button, x2 y79 w170 h30 gBans, In-Game Bans
Gui, Add, Button, x562 y679 w240 h30 gRuleMod, Правила для модеров
Gui, Add, Button, x552 y709 w250 h30 gRuleHelp, Правила для хелперов
Gui, Add, Button, x692 y239 w110 h30 gFlood, Флуд в лс
Gui, Add, Button, x2 y-1 w180 h40 gButtonHelp, Помощь по GUI
Gui, Add, Button, x2 y49 w200 h30 gMute, Муты(нужен ник)
Gui, Add, Button, x682 y569 w110 h30 gBButton vBButton, % Chr(0x2192)
Gui, Show, w800 h800 , Ban/Mute GUI Panel by RQVM(Requiem)

}

{ ;Слова-Исключения 
Gui, 2:+hwndhGui2 +owner1 -Caption +Border
Gui, 2:Font, S6 CGreen, arial black
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
Gui, 2:Add, Text,, Неудачник
Gui, 2:Add, Text,, Дрыщ
Gui, 2:Add, Text,, Дно
Gui, 2:Add, Text,, Противный
Gui, 2:Add, Text,, Отстой
Gui, 2:Add, Text,, Оболтус
Gui, 2:Add, Text,, Косой
Gui, 2:Add, Text,, Лузер
Gui, 2:Add, Text,, Изверг
Gui, 2:Add, Text,, Тормоз
Gui, 2:Add, Text,, хз
Gui, 2:Add, Text,, Лукодрочер
Gui, 2:Add, Text,, Жмот
Gui, 2:Add, Text,, Слабак
Gui, 2:Add, Text,, Гей/Лесбиянка
Gui, 2:Add, Text,, Биссексуал
Gui, 2:Add, Text,, Подлый
Gui, 2:Add, Text,, Бло
Gui, 2:Add, Text,, Пипидастр
Gui, 2:Add, Text,, Подсос
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
Gui, 5:Show, w400 h400 x20 y20
return


Forum:
Gui, 4:Hide 
Gui, 2:Hide
Gui, 5:Hide
Gui, 3:Show, w400 h400 x158 y70
Gui, 3:Add, Button, x170 y170 w140 h30, Оск.Сервера
Gui, 3:Add, Button, x2 y-1 w100 h30, Каво
Gui, 3:Add, Button, x102 y-1 w130 h30, Таво
VarSetCapacity(WI, 60)
Return
}

{ ;GUI In-Game Bans
Bans:
Gui, 3:Hide 
Gui, 2:Hide
Gui, 5:Hide
Gui, 4:Show, x70 y70 h449 w210
Gui, 4:Font, S10 CRed, cursive
Gui, 4:Add, Button, x-8 y-1 w120 h30 gBanOskProjekt, Оск.Сервера
Gui, 4:Add, Button, x112 y-1 w100 h30 , /Админа
Gui, 4:Add, Button, x-8 y29 w70 h30 , Выдача
Gui, 4:Add, Button, x62 y29 w150 h30 , Неуваж.Общение
Gui, 4:Add, Button, x-10 y59 w32 h0 , Некор.Ник
Gui, 4:Add, Button, x82 y59 w50 h30 , /Скин
Gui, 4:Add, Button, x132 y59 w80 h30 , /Префикс
Gui, 4:Add, Button, x-8 y59 w90 h30 , Некор.Ник
Gui, 4:Add, Button, x142 y89 w70 h30 , /Читов
Gui, 4:Add, Button, x102 y149 w110 h30 , Передача акка
Gui, 4:Add, Button, x82 y119 w130 h30 , Продажа за реал
Gui, 4:Add, Button, x132 y179 w80 h30 , /фашизма
Gui, 4:Add, Button, x-8 y89 w150 h30 , Распространен. бага
Gui, 4:Add, Button, x-8 y119 w90 h30 , TeamGrief
Gui, 4:Add, Button, x-8 y179 w140 h30 , Пропаганда нарко.
Gui, 4:Add, Button, x-8 y149 w110 h30 , Продажа акка
Gui, 4:Add, Button, x-8 y209 w170 h30 , Некорректн. постройка
Gui, 4:Add, Button, x162 y209 w50 h30 , Читы
Gui, 4:Add, Button, x-8 y239 w220 h30 , Некорр. название/Префикс Ги
Gui, 4:Add, Button, x122 y269 w90 h30 , Упоминание
Gui, 4:Add, Button, x-8 y269 w130 h30 , Пиар др.Проекта
Gui, 4:Add, Button, x-8 y299 w90 h30 gBANBWONE, Тим на BW
Gui, 4:Add, Button, x82 y299 w80 h30 gBANSWONE, Тим на SW
Gui, 4:Add, Button, x162 y299 w50 h30 , Асоц
Gui, 4:Add, Button, x152 y329 w60 h30 , Аморал
Gui, 4:Add, Button, x-8 y329 w160 h30 , Попытка взлома акка
Gui, 4:Add, Button, x-8 y359 w80 h30 , Реклама
Gui, 4:Add, Button, x72 y359 w140 h30 , Политич. Агитация
Gui, 4:Add, Button, x-8 y389 w220 h30 , Распространение вред. ссылок
Gui, 4:Add, Button, x152 y419 w60 h30 , Обман
Gui, 4:Add, Button, x-8 y419 w160 h30 , Помеха игр. процессу
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
}

{ ;Main GUI скрипты
BanOskProjekt:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,50
SendRaw 0 Оскорбление проекта.
return

BANBW:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,70
SendRaw 2880 Тим на BW.
return

BANSW:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,70
SendRaw 2880 Тим на SW.
return

Banuser:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,70
SendRaw Неуважительное общение с Администрацией.
return

Bagouse:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,70
SendRaw 10080 Багоюз.
return

IncorrSkin:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,70
SendRaw Некорректный скин.
return

Sell:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,70
SendRaw Продажа за реальные деньги/вимеры.
return

Caps:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,70
SendRaw 120 Капс.
return

Flood:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,70
SendRaw Флуд в личные сообщения.
return

MuteObm:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,70
SendRaw 240 Обман игроков.
return

MuteFloodSymb:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,70
SendRaw 120 Flood символами.
return

MuteFlood:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,70
SendRaw 120 Flood.
return


MuteFlood2:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,70
SendRaw 240 Flood+Caps.
return

MuteUpomin2:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,70
SendRaw 2880 Упоминание об ином проекте.
return

MuteUpomin:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,70
SendRaw 2880 Упоминание об ином проекте.
return

banReklama:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,70
SendRaw 1440 Реклама.
return

MuteReklama:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,70
SendRaw 1440 Реклама.
return

MuteSpam:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,70
SendRaw 44640 Спам.
return

MuteAmor:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,70
SendRaw 240 Аморальное поведение.
return

MuteOsk:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,70
SendRaw 480 Оскорбление.
return


MuteOskMat:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,70
SendRaw 720 Оскорбление+Мат.
return

MuteGolosovanie:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,70
SendRaw 30 Голосование.
return

BanAsoc:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,70
SendRaw 720 Асоциальное поведение.
return

BanAmor:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,70
SendRaw 720 Аморальное поведение.
return

BanTryBro:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,70
SendRaw 10080 Попытка взлома аккаунта.
return

BanIncorr:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,70
SendRaw 2880 Некорректная постройка.
return

BanAdm:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,70
SendRaw 10080 Выдача себя за Администрацию.
return

BanObman:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,70
SendRaw 2880 Обман игроков.
return

BanProd:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,70
SendRaw 0 Продажа аккаунта.
return

BanPered:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,70
SendRaw 0 Передача аккаунта.
return

BanAgit:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,70
SendRaw 0 Политическая агитация.
return

BanPiar:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,70
SendRaw 0 Реклама другого проекта.
return

BanNarko:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,70
SendRaw 10080 Пропаганда наркотиков.
return


BanNazi:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,70
SendRaw 10080 Пропаганда фашизма.
return

BanGrief:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,70
SendRaw 2880 Team Grief.
return

BanPomexa:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,70
SendRaw 2880 Помеха игровому процессу.
return

BanPref:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,70
SendRaw 10080 Некорректный префикс.
return

BanLink:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,70
SendRaw 0 Распространение вредоносных ссылок.
return

BanIncor2:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,70
SendRaw 10080 Некорректный префикс/Название Гильдии.
return

BanCheat2:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,70
SendRaw 0 Распространение Читов.
return

BanBagouse:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,70
SendRaw 0 Распространение бага.
return

BanSell:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,70
SendRaw 0 Продажа за реальные деньги/вимеры.
return

BanCheat:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,70
SendRaw 0 Использование читов.
return


BanOskAdm:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,70
SendRaw 0 Оскорбление Администрации.
return

BanIncor:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,70
SendRaw 0 некорректный никнейм.
return
}

{ ;Second GUI скрипты

BANBWONE:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,70
SendInput {sc14} 
sleep,70
SendRaw /ban 2880 Тим на BW.
sleep,70
SendInput {LEFT 16} {Space}
return

BANSWONE:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,70
SendInput {sc14} 
sleep,70
SendRaw /ban 2880 Тим на SW.
sleep,70
SendInput {LEFT 16}{Space}
return

Banuser1:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,70
SendInput {sc14} 
sleep,70
SendRaw /ban 0 Неуважительное общение с Администрацией.
sleep,70
SendInput {LEFT 43}{Space}
return

Bagouse1:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,70
SendInput {sc14} 
sleep,70
SendRaw /ban 10080 Багоюз.
sleep,70
SendInput {LEFT 14}{Space}
return

IncorrSkin1:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,70
SendInput {sc14} 
sleep,70
SendRaw /ban 1440 Некорректный скин.
sleep,70
SendInput {LEFT 24}{Space}
return

Sell1:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,70
SendInput {sc14} 
sleep,70
SendRaw /ban 0 Продажа за реальные деньги/вимеры.
sleep,70
SendInput {LEFT 37}{Space}
return


Caps1:
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

Flood1:
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

MuteObm1:
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

MuteFloodSymb1:
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

MuteFlood1:
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

MuteFlood3:
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

BanUpomin1:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,90
SendInput {sc14} 
sleep,70
SendRaw /ban 2880 Упоминание об ином проекте.
sleep,70
SendInput {LEFT 33}{Space}
sleep,70
return

MuteUpomin3:
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

banReklama1:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,90
SendInput {sc14} 
sleep,70
SendRaw /ban 1440 Реклама.
sleep,70
SendInput {LEFT 14}{Space}
sleep,70
return

MuteReklama1:
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

MuteSpam1:
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

MuteAmor1:
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

MuteOsk1:
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

MuteOskMat1:
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

MuteGolosovanie1:
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

BanAsoc1:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,90
SendInput {sc14} 
sleep,70
SendRaw /ban 720 Асоциальное поведение.
sleep,70
SendInput {LEFT 27}{Space}
sleep,70
return


BanAmor1:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,90
SendInput {sc14} 
sleep,70
SendRaw /ban 720 Аморальное поведение.
sleep,70
SendInput {LEFT 26}{Space}
sleep,70
return

BanTryBro1:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,90
SendInput {sc14} 
sleep,70
SendRaw /ban 10080 Попытка взлома аккаунта.
sleep,70
SendInput {LEFT 31}{Space}
sleep,70
return

BanIncorr1:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,90
SendInput {sc14} 
sleep,70
SendRaw /ban 2880 Некорректная постройка.
sleep,70
SendInput {LEFT 29}{Space}
sleep,70
return

BanAdm1:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,90
SendInput {sc14} 
sleep,70
SendRaw /ban 10080 Выдача себя за Администрацию.
sleep,70
SendInput {LEFT 36}{Space}
sleep,70
return

BanObman1:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,90
SendInput {sc14} 
sleep,70
SendRaw /ban 2880 Обман игроков.
sleep,70
SendInput {LEFT 20}{Space}
sleep,70
return

BanProd1:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,90
SendInput {sc14} 
sleep,70
SendRaw /ban 0 Продажа аккаунта.
sleep,70
SendInput, {LEFT 20}{Space}
sleep,70
return

BanPered1:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,90
SendInput {sc14} 
sleep,70
SendRaw /ban 0 Передача аккаунта.
sleep,70
SendInput {LEFT 21}{Space}
sleep,70
return

BanAgit1:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,90
SendInput {sc14} 
sleep,70
SendRaw /ban 0 Политическая агитация.
sleep,70
SendInput {LEFT 25}{Space}
sleep,70
return

BanPiar1:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,90
SendInput {sc14} 
sleep,70
SendRaw /ban 0 Реклама другого проекта.
sleep,70
SendInput {LEFT 27}{Space}
sleep,70
return

BanNarko1:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,90
SendInput {sc14} 
sleep,70
SendRaw /ban 10080 Пропаганда наркотиков.
sleep,70
SendInput {LEFT 29}{Space}
sleep,70
return

BanNazi1:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,90
SendInput {sc14} 
sleep,70
SendRaw /ban 10080 Пропаганда фашизма.
sleep,70
SendInput {LEFT 25}{Space}
sleep,70
return

BanGrief1:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,90
SendInput {sc14} 
sleep,70
SendRaw /ban 2880 Team Grief.
sleep,70
SendInput {LEFT 17}{Space}
sleep,70
return

BanPomexa1:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,90
SendInput {sc14} 
sleep,70
SendRaw /ban 2880 Помеха игровому процессу.
sleep,70
SendInput {LEFT 31}{Space}
sleep,70
return

BanPref1:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,90
SendInput {sc14} 
sleep,70
SendRaw /ban 10080 Некорректный префикс
sleep,70
SendInput {LEFT 28}{Space}
sleep,70
return

BanLink1:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,90
SendInput {sc14} 
sleep,70
SendRaw /ban 0 Распространение вредоносных ссылок.
sleep,70
SendInput {LEFT 38}{Space}
sleep,70
return

BanIncor1:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,90
SendInput {sc14} 
sleep,70
SendRaw /ban 10080 Некорректный префикс/Название Гильдии.
sleep,70
SendInput {LEFT 45}{Space}
sleep,70
return

BanCheat1:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,90
SendInput {sc14} 
sleep,70
SendRaw /ban 0 Распространение Читов.
sleep,70
SendInput {LEFT 25}{Space}
sleep,70
sleep,70
return

BanBagouse1:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,90
SendInput {sc14} 
sleep,70
SendRaw /ban 0 Распространение бага.
sleep,70
SendInput {LEFT 24}{Space}
sleep,70
return

BanSell1:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,90
SendInput {sc14} 
sleep,70
SendRaw /ban 0 Продажа за реальные деньги/вимеры.
sleep,70
SendInput {LEFT 36}{Space}
sleep,70
return

BanCheat3:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,90
SendInput {sc14} 
sleep,70
SendRaw /ban 0 Использование читов.
sleep,70
SendInput {LEFT 23}{Space}
sleep,70
return

BanOskProjekt1:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep 60
Gui, Hide
sleep,90
SendInput {sc14} 
sleep,70
SendRaw /ban 0 Оскорбление проекта.
sleep,70
SendInput {LEFT 23}{Space}
sleep,70
return

BanOskAdm1:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,90
SendInput {sc14} 
sleep,70
SendRaw /ban 0 Оскорбление Администрации.
sleep,70
SendInput {LEFT 29}{Space}
sleep,70
return

BanIncor3:
Gui, 5:Hide
Gui, 4:Hide
Gui, 3:Hide
Gui, 2:Hide
Gui, 1:Show, % (a := !a) ? "w800 h800" : "Hide"
sleep,90
SendInput {sc14} 
sleep,70
SendRaw /ban 0 некорректный никнейм.
sleep,70
SendInput {LEFT 24}{Space}
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

Gui,  Show, % (a := !a) ? "w800 h800" : "Hide"
   if !i {
      Return
   i := false
}
return
}

