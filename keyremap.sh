#!/bin/bash
#use xev to get keycode and action

if [ "$1" == "original" ]
then
    echo "map keys to original meaning"
# Super_L           (Windows)
    xmodmap -e "keycode 133 = Super_L NoSymbol Super_L"
# Print             (Druck)
    xmodmap -e "keycode 107 = Print Sys_Req Print Sys_Req"
# Return            (Enter)
    xmodmap -e "keycode 36 = Return NoSymbol Return"
# BackSpace         (Backspace)
    xmodmap -e "keycode 22 = BackSpace BackSpace BackSpace BackSpace"
# ISO_Level3_Shift  (AltGr)
    xmodmap -e "keycode 108 = ISO_Level3_Shift NoSymbol ISO_Level3_Shift"
# Control_R         (Strg_R)
    xmodmap -e "keycode 105 = Control_R NoSymbol Control_R"
# Alt_L             (Alt)
    xmodmap -e "keycode 64 = Alt_L Meta_L Alt_L Meta_L"
# dead_circumflex   (^/°)
    xmodmap -e "keycode 49 = dead_circumflex degree dead_circumflex degree U2032 U2033 U2032"
# plus              (Plus/Mal/Tilde)
    xmodmap -e "keycode 35 = plus asterisk plus asterisk asciitilde macron asciitilde"
# odiaeresis        (oe)
    xmodmap -e "keycode 47 = odiaeresis Odiaeresis odiaeresis Odiaeresis dead_doubleacute dead_belowdot dead_doubleacute"
    xmodmap -e "remove shift = odiaeresis"
# adiaeresis        (ae)
    xmodmap -e "keycode 48 = adiaeresis Adiaeresis adiaeresis Adiaeresis dead_circumflex dead_caron dead_circumflex"
# numbersign        (#)
    xmodmap -e "keycode 51 = numbersign apostrophe numbersign apostrophe rightsinglequotemark dead_breve rightsinglequotemark"
# Shift_R           (Umschalt_Rechts)
    xmodmap -e "keycode 62 = Shift_R NoSymbol Shift_R"
# uediaresis        (ue)
    xmodmap -e "keycode 34 = udiaeresis Udiaeresis udiaeresis Udiaeresis dead_diaeresis dead_abovering dead_diaeresis"
fi

if [ "$1" == "custom" ]
then

    echo "map keys to custom preferences"
# alt       -> backspace
    xmodmap -e "keycode 64 = BackSpace BackSpace BackSpace BackSpace"
    xmodmap -e "remove mod1 = BackSpace"
# altgr     -> return
    xmodmap -e "keycode 108 = Return NoSymbol Return"
# ^/°       -> altgr
    xmodmap -e "keycode 49 = ISO_Level3_Shift NoSymbol ISO_Level3_Shift"
# ue        -> plus
    xmodmap -e "keycode 34 = plus asterisk plus asterisk udiaeresis"
# ae        -> #
    xmodmap -e "keycode 48 = numbersign apostrophe numbersign apostrophe adiaeresis"
# oe        -> Umschalt_R
    xmodmap -e "keycode 47 = Shift_R NoSymbol Shift_R NoSymbol odiaeresis"
    xmodmap -e "add shift = Shift_R"
    xset -r 47
# druck     -> alt
    xmodmap -e "keycode 107 = Alt_L Meta_L Alt_L Meta_L"
fi

if [ "$1" == "custom2" ]
then
    echo "map keys to custom2 preferences -> deaktivate double-meanings"
# alt       -> backspace
    xmodmap -e "keycode 64 = BackSpace BackSpace BackSpace BackSpace"
    xmodmap -e "remove mod1 = BackSpace"
# altgr     -> return
    xmodmap -e "keycode 108 = Return NoSymbol Return"
# ^/°       -> altgr
    xmodmap -e "keycode 49 = ISO_Level3_Shift NoSymbol ISO_Level3_Shift"
# ue        -> plus
    xmodmap -e "keycode 34 = plus asterisk plus asterisk udiaeresis"
# ae        -> #
    xmodmap -e "keycode 48 = numbersign apostrophe numbersign apostrophe adiaeresis"
# oe        -> Umschalt_R
    xmodmap -e "keycode 47 = Shift_R NoSymbol Shift_R NoSymbol odiaeresis"
    xmodmap -e "add shift = Shift_R"
    xset -r 47
###### ue        -> plus
#####    xmodmap -e "keycode 34 = plus asterisk plus asterisk asciitilde macron asciitilde"
###### ae        -> #
#####    xmodmap -e "keycode 48 = numbersign apostrophe numbersign apostrophe rightsinglequotemark dead_breve rightsinglequotemark"
###### oe        -> Umschalt_R
#####    xmodmap -e "keycode 47 = Shift_R NoSymbol Shift_R"
#####    xmodmap -e "add shift = Shift_R"
#####    xset -r 47
# druck     -> alt
    xmodmap -e "keycode 107 = Alt_L Meta_L Alt_L Meta_L"
# backspace -> None
    xmodmap -e "keycode 22 = "
# return    -> None
    xmodmap -e "keycode 36 = "
# plus      -> None
    xmodmap -e "keycode 35 = "
# #         -> None
    xmodmap -e "keycode 51 = "
# Umsch_R   -> None
    xmodmap -e "keycode 62 = "
fi



#keycode   8 =
#keycode   9 = Escape NoSymbol Escape
#keycode  10 = 1 exclam 1 exclam onesuperior exclamdown onesuperior
#keycode  11 = 2 quotedbl 2 quotedbl twosuperior oneeighth twosuperior
#keycode  12 = 3 section 3 section threesuperior sterling threesuperior
#keycode  13 = 4 dollar 4 dollar onequarter currency onequarter
#keycode  14 = 5 percent 5 percent onehalf threeeighths onehalf
#keycode  15 = 6 ampersand 6 ampersand notsign fiveeighths notsign
#keycode  16 = 7 slash 7 slash braceleft seveneighths braceleft
#keycode  17 = 8 parenleft 8 parenleft bracketleft trademark bracketleft
#keycode  18 = 9 parenright 9 parenright bracketright plusminus bracketright
#keycode  19 = 0 equal 0 equal braceright degree braceright
#keycode  20 = ssharp question ssharp question backslash questiondown U1E9E
#keycode  21 = dead_acute dead_grave dead_acute dead_grave dead_cedilla dead_ogonek dead_cedilla
#keycode  22 = BackSpace BackSpace BackSpace BackSpace
#keycode  23 = Tab ISO_Left_Tab Tab ISO_Left_Tab
#keycode  24 = q Q q Q at Greek_OMEGA at
#keycode  25 = w W w W lstroke Lstroke lstroke
#keycode  26 = e E e E EuroSign EuroSign EuroSign
#keycode  27 = r R r R paragraph registered paragraph
#keycode  28 = t T t T tslash Tslash tslash
#keycode  29 = z Z z Z leftarrow yen leftarrow
#keycode  30 = u U u U downarrow uparrow downarrow
#keycode  31 = i I i I rightarrow idotless rightarrow
#keycode  32 = o O o O oslash Oslash oslash
#keycode  33 = p P p P thorn THORN thorn
#keycode  34 = udiaeresis Udiaeresis udiaeresis Udiaeresis dead_diaeresis dead_abovering dead_diaeresis
#keycode  35 = plus asterisk plus asterisk asciitilde macron asciitilde
#keycode  36 = Return NoSymbol Return
#keycode  37 = Control_L NoSymbol Control_L
#keycode  38 = a A a A ae AE ae
#keycode  39 = s S s S U017F U1E9E U017F
#keycode  40 = d D d D eth ETH eth
#keycode  41 = f F f F dstroke ordfeminine dstroke
#keycode  42 = g G g G eng ENG eng
#keycode  43 = h H h H hstroke Hstroke hstroke
#keycode  44 = j J j J dead_belowdot dead_abovedot dead_belowdot
#keycode  45 = k K k K kra ampersand kra
#keycode  46 = l L l L lstroke Lstroke lstroke
#keycode  47 = odiaeresis Odiaeresis odiaeresis Odiaeresis dead_doubleacute dead_belowdot dead_doubleacute
#keycode  48 = adiaeresis Adiaeresis adiaeresis Adiaeresis dead_circumflex dead_caron dead_circumflex
#keycode  49 = dead_circumflex degree dead_circumflex degree U2032 U2033 U2032
#keycode  50 = Shift_L NoSymbol Shift_L
#keycode  51 = numbersign apostrophe numbersign apostrophe rightsinglequotemark dead_breve rightsinglequotemark
#keycode  52 = y Y y Y guillemotright U203A guillemotright
#keycode  53 = x X x X guillemotleft U2039 guillemotleft
#keycode  54 = c C c C cent copyright cent
#keycode  55 = v V v V doublelowquotemark singlelowquotemark doublelowquotemark
#keycode  56 = b B b B leftdoublequotemark leftsinglequotemark leftdoublequotemark
#keycode  57 = n N n N rightdoublequotemark rightsinglequotemark rightdoublequotemark
#keycode  58 = m M m M mu masculine mu
#keycode  59 = comma semicolon comma semicolon periodcentered multiply periodcentered
#keycode  60 = period colon period colon U2026 division U2026
#keycode  61 = minus underscore minus underscore endash emdash endash
#keycode  62 = Shift_R NoSymbol Shift_R
#keycode  63 = KP_Multiply KP_Multiply KP_Multiply KP_Multiply KP_Multiply KP_Multiply XF86ClearGrab
#keycode  64 = Alt_L Meta_L Alt_L Meta_L
#keycode  65 = space NoSymbol space
#keycode  66 = Caps_Lock NoSymbol Caps_Lock
#keycode  67 = F1 F1 F1 F1 F1 F1 XF86Switch_VT_1
#keycode  68 = F2 F2 F2 F2 F2 F2 XF86Switch_VT_2
#keycode  69 = F3 F3 F3 F3 F3 F3 XF86Switch_VT_3
#keycode  70 = F4 F4 F4 F4 F4 F4 XF86Switch_VT_4
#keycode  71 = F5 F5 F5 F5 F5 F5 XF86Switch_VT_5
#keycode  72 = F6 F6 F6 F6 F6 F6 XF86Switch_VT_6
#keycode  73 = F7 F7 F7 F7 F7 F7 XF86Switch_VT_7
#keycode  74 = F8 F8 F8 F8 F8 F8 XF86Switch_VT_8
#keycode  75 = F9 F9 F9 F9 F9 F9 XF86Switch_VT_9
#keycode  76 = F10 F10 F10 F10 F10 F10 XF86Switch_VT_10
#keycode  77 = Num_Lock NoSymbol Num_Lock
#keycode  78 = Scroll_Lock NoSymbol Scroll_Lock
#keycode  79 = KP_Home KP_7 KP_Home KP_7
#keycode  80 = KP_Up KP_8 KP_Up KP_8
#keycode  81 = KP_Prior KP_9 KP_Prior KP_9
#keycode  82 = KP_Subtract KP_Subtract KP_Subtract KP_Subtract KP_Subtract KP_Subtract XF86Prev_VMode
#keycode  83 = KP_Left KP_4 KP_Left KP_4
#keycode  84 = KP_Begin KP_5 KP_Begin KP_5
#keycode  85 = KP_Right KP_6 KP_Right KP_6
#keycode  86 = KP_Add KP_Add KP_Add KP_Add KP_Add KP_Add XF86Next_VMode
#keycode  87 = KP_End KP_1 KP_End KP_1
#keycode  88 = KP_Down KP_2 KP_Down KP_2
#keycode  89 = KP_Next KP_3 KP_Next KP_3
#keycode  90 = KP_Insert KP_0 KP_Insert KP_0
#keycode  91 = KP_Delete KP_Separator KP_Delete KP_Separator
#keycode  92 = ISO_Level3_Shift NoSymbol ISO_Level3_Shift
#keycode  93 =
#keycode  94 = less greater less greater bar brokenbar bar
#keycode  95 = F11 F11 F11 F11 F11 F11 XF86Switch_VT_11
#keycode  96 = F12 F12 F12 F12 F12 F12 XF86Switch_VT_12
#keycode  97 =
#keycode  98 = Katakana NoSymbol Katakana
#keycode  99 = Hiragana NoSymbol Hiragana
#keycode 100 = Henkan_Mode NoSymbol Henkan_Mode
#keycode 101 = Hiragana_Katakana NoSymbol Hiragana_Katakana
#keycode 102 = Muhenkan NoSymbol Muhenkan
#keycode 103 =
#keycode 104 = KP_Enter NoSymbol KP_Enter
#keycode 105 = Control_R NoSymbol Control_R
#keycode 106 = KP_Divide KP_Divide KP_Divide KP_Divide KP_Divide KP_Divide XF86Ungrab
#keycode 107 = Print Sys_Req Print Sys_Req
#keycode 108 = ISO_Level3_Shift NoSymbol ISO_Level3_Shift
#keycode 109 = Linefeed NoSymbol Linefeed
#keycode 110 = Home NoSymbol Home
#keycode 111 = Up NoSymbol Up
#keycode 112 = Prior NoSymbol Prior
#keycode 113 = Left NoSymbol Left
#keycode 114 = Right NoSymbol Right
#keycode 115 = End NoSymbol End
#keycode 116 = Down NoSymbol Down
#keycode 117 = Next NoSymbol Next
#keycode 118 = Insert NoSymbol Insert
#keycode 119 = Delete NoSymbol Delete
#keycode 120 =
#keycode 121 = XF86AudioMute NoSymbol XF86AudioMute
#keycode 122 = XF86AudioLowerVolume NoSymbol XF86AudioLowerVolume
#keycode 123 = XF86AudioRaiseVolume NoSymbol XF86AudioRaiseVolume
#keycode 124 = XF86PowerOff NoSymbol XF86PowerOff
#keycode 125 = KP_Equal NoSymbol KP_Equal
#keycode 126 = plusminus NoSymbol plusminus
#keycode 127 = Pause Break Pause Break
#keycode 128 = XF86LaunchA NoSymbol XF86LaunchA
#keycode 129 = KP_Decimal KP_Decimal KP_Decimal KP_Decimal
#keycode 130 = Hangul NoSymbol Hangul
#keycode 131 = Hangul_Hanja NoSymbol Hangul_Hanja
#keycode 132 =
#keycode 133 = Super_L NoSymbol Super_L
#keycode 134 = Super_R NoSymbol Super_R
#keycode 135 = Menu NoSymbol Menu
#keycode 136 = Cancel NoSymbol Cancel
#keycode 137 = Redo NoSymbol Redo
#keycode 138 = SunProps NoSymbol SunProps
#keycode 139 = Undo NoSymbol Undo
#keycode 140 = SunFront NoSymbol SunFront
#keycode 141 = XF86Copy NoSymbol XF86Copy
#keycode 142 = XF86Open NoSymbol XF86Open
#keycode 143 = XF86Paste NoSymbol XF86Paste
#keycode 144 = Find NoSymbol Find
#keycode 145 = XF86Cut NoSymbol XF86Cut
#keycode 146 = Help NoSymbol Help
#keycode 147 = XF86MenuKB NoSymbol XF86MenuKB
#keycode 148 = XF86Calculator NoSymbol XF86Calculator
#keycode 149 =
#keycode 150 = XF86Sleep NoSymbol XF86Sleep
#keycode 151 = XF86WakeUp NoSymbol XF86WakeUp
#keycode 152 = XF86Explorer NoSymbol XF86Explorer
#keycode 153 = XF86Send NoSymbol XF86Send
#keycode 154 =
#keycode 155 = XF86Xfer NoSymbol XF86Xfer
#keycode 156 = XF86Launch1 NoSymbol XF86Launch1
#keycode 157 = XF86Launch2 NoSymbol XF86Launch2
#keycode 158 = XF86WWW NoSymbol XF86WWW
#keycode 159 = XF86DOS NoSymbol XF86DOS
#keycode 160 = XF86ScreenSaver NoSymbol XF86ScreenSaver
#keycode 161 = XF86RotateWindows NoSymbol XF86RotateWindows
#keycode 162 = XF86TaskPane NoSymbol XF86TaskPane
#keycode 163 = XF86Mail NoSymbol XF86Mail
#keycode 164 = XF86Favorites NoSymbol XF86Favorites
#keycode 165 = XF86MyComputer NoSymbol XF86MyComputer
#keycode 166 = XF86Back NoSymbol XF86Back
#keycode 167 = XF86Forward NoSymbol XF86Forward
#keycode 168 =
#keycode 169 = XF86Eject NoSymbol XF86Eject
#keycode 170 = XF86Eject XF86Eject XF86Eject XF86Eject
#keycode 171 = XF86AudioNext NoSymbol XF86AudioNext
#keycode 172 = XF86AudioPlay XF86AudioPause XF86AudioPlay XF86AudioPause
#keycode 173 = XF86AudioPrev NoSymbol XF86AudioPrev
#keycode 174 = XF86AudioStop XF86Eject XF86AudioStop XF86Eject
#keycode 175 = XF86AudioRecord NoSymbol XF86AudioRecord
#keycode 176 = XF86AudioRewind NoSymbol XF86AudioRewind
#keycode 177 = XF86Phone NoSymbol XF86Phone
#keycode 178 =
#keycode 179 = XF86Tools NoSymbol XF86Tools
#keycode 180 = XF86HomePage NoSymbol XF86HomePage
#keycode 181 = XF86Reload NoSymbol XF86Reload
#keycode 182 = XF86Close NoSymbol XF86Close
#keycode 183 =
#keycode 184 =
#keycode 185 = XF86ScrollUp NoSymbol XF86ScrollUp
#keycode 186 = XF86ScrollDown NoSymbol XF86ScrollDown
#keycode 187 = parenleft NoSymbol parenleft
#keycode 188 = parenright NoSymbol parenright
#keycode 189 = XF86New NoSymbol XF86New
#keycode 190 = Redo NoSymbol Redo
#keycode 191 = XF86Tools NoSymbol XF86Tools
#keycode 192 = XF86Launch5 NoSymbol XF86Launch5
#keycode 193 = XF86Launch6 NoSymbol XF86Launch6
#keycode 194 = XF86Launch7 NoSymbol XF86Launch7
#keycode 195 = XF86Launch8 NoSymbol XF86Launch8
#keycode 196 = XF86Launch9 NoSymbol XF86Launch9
#keycode 197 =
#keycode 198 = XF86AudioMicMute NoSymbol XF86AudioMicMute
#keycode 199 = XF86TouchpadToggle NoSymbol XF86TouchpadToggle
#keycode 200 = XF86TouchpadOn NoSymbol XF86TouchpadOn
#keycode 201 = XF86TouchpadOff NoSymbol XF86TouchpadOff
#keycode 202 =
#keycode 203 = Mode_switch NoSymbol Mode_switch
#keycode 204 = NoSymbol Alt_L NoSymbol Alt_L
#keycode 205 = NoSymbol Meta_L NoSymbol Meta_L
#keycode 206 = NoSymbol Super_L NoSymbol Super_L
#keycode 207 = NoSymbol Hyper_L NoSymbol Hyper_L
#keycode 208 = XF86AudioPlay NoSymbol XF86AudioPlay
#keycode 209 = XF86AudioPause NoSymbol XF86AudioPause
#keycode 210 = XF86Launch3 NoSymbol XF86Launch3
#keycode 211 = XF86Launch4 NoSymbol XF86Launch4
#keycode 212 = XF86LaunchB NoSymbol XF86LaunchB
#keycode 213 = XF86Suspend NoSymbol XF86Suspend
#keycode 214 = XF86Close NoSymbol XF86Close
#keycode 215 = XF86AudioPlay NoSymbol XF86AudioPlay
#keycode 216 = XF86AudioForward NoSymbol XF86AudioForward
#keycode 217 =
#keycode 218 = Print NoSymbol Print
#keycode 219 =
#keycode 220 = XF86WebCam NoSymbol XF86WebCam
#keycode 221 =
#keycode 222 =
#keycode 223 = XF86Mail NoSymbol XF86Mail
#keycode 224 = XF86Messenger NoSymbol XF86Messenger
#keycode 225 = XF86Search NoSymbol XF86Search
#keycode 226 = XF86Go NoSymbol XF86Go
#keycode 227 = XF86Finance NoSymbol XF86Finance
#keycode 228 = XF86Game NoSymbol XF86Game
#keycode 229 = XF86Shop NoSymbol XF86Shop
#keycode 230 =
#keycode 231 = Cancel NoSymbol Cancel
#keycode 232 = XF86MonBrightnessDown NoSymbol XF86MonBrightnessDown
#keycode 233 = XF86MonBrightnessUp NoSymbol XF86MonBrightnessUp
#keycode 234 = XF86AudioMedia NoSymbol XF86AudioMedia
#keycode 235 = XF86Display NoSymbol XF86Display
#keycode 236 = XF86KbdLightOnOff NoSymbol XF86KbdLightOnOff
#keycode 237 = XF86KbdBrightnessDown NoSymbol XF86KbdBrightnessDown
#keycode 238 = XF86KbdBrightnessUp NoSymbol XF86KbdBrightnessUp
#keycode 239 = XF86Send NoSymbol XF86Send
#keycode 240 = XF86Reply NoSymbol XF86Reply
#keycode 241 = XF86MailForward NoSymbol XF86MailForward
#keycode 242 = XF86Save NoSymbol XF86Save
#keycode 243 = XF86Documents NoSymbol XF86Documents
#keycode 244 = XF86Battery NoSymbol XF86Battery
#keycode 245 = XF86Bluetooth NoSymbol XF86Bluetooth
#keycode 246 = XF86WLAN NoSymbol XF86WLAN
#keycode 247 =
#keycode 248 =
#keycode 249 =
#keycode 250 =
#keycode 251 =
#keycode 252 =
#keycode 253 =
#keycode 254 =
#keycode 255 =