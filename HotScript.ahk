/*
There should be no reason to edit this file directly.

Press Ctrl-Win-H for the help screen.
Press Win-4 to edit HotScriptKeys.ahk to add user-defined HotKeys.
Press Win-5 to edit HotScriptStrings.ahk to add user-defined HotStrings.
Press Win-6 to edit HotScriptVariables.ahk to add user-defined variables.
Press Win-7 to edit HotScriptFunctions.ahk to add user-defined functions.
Press Win-8 to edit HotScriptUser.ini
Press Win-9 to edit HotScriptDefault.ini
To override any default settings, copy the section header and value(s) from HotScriptDefault.ini to HotScriptUser.ini

For further information, assistance or bug-reporting, please contact support at: hotscript.help@gmail.com

HotScript is copyrighted 2013-2016.
*/

#Include %A_ScriptDir%
#Hotstring EndChars `(`)`[`]`{`}`<`>`~`!`@`#`$`%`^`&`*`_`=`+`\`|`;`:`'`"`,`.`/`? `n`t
#MaxHotkeysPerInterval 200
#NoEnv
#SingleInstance force
#Warn All
#Warn UseUnsetGlobal, OutputDebug
#Warn UseUnsetLocal, OutputDebug
Autotrim, off
ListLines, off
SetBatchLines -1
SetKeyDelay, -1
SetTitleMatchMode, Regex
SetWinDelay, 0
StringCaseSense On

;__________________________________________________
;Initialization
global hs := {}
global $ := ""
#Include *i HotScriptVariables.ahk
#Include *i HotScriptFunctions.ahk
init()

;__________________________________________________
;Includes
#Include *i HotScriptStrings.ahk
#Include *i HotScriptKeys.ahk

;__________________________________________________
; Auto initialization processing stops here because when either a HotKey or HotString
; is defined using the AHK-style registration, all initialization processing stops.

; Why is this not configurable and part of external definitions?
;   - because any hotkey/hotstring subroutine whose very first line is Suspend (except Suspend On)
;     will be exempt from suspension, so it can act as a toggle.
#pause:: ;; toggles suspension of this script
    Suspend
    addHotKey()
    toggleSuspend()
    return

;__________________________________________________
;wrapper functions
ClipWait(seconds:=0.5, mode:="") {
    ClipWait, %seconds%, %mode%
}

ControlGet(cmd, value:="", control:="", winTitle:="", winText:="", excludeTitle:="", excludeText:="") {
    v := ""
    ControlGet, v, %cmd%, %value%, %control%, %winTitle%, %winText%, %excludeTitle%, %excludeText%
    return v
}

ControlGetFocus(winTitle:="", winText:="", excludeTitle:="", excludeText:="") {
    v := ""
    ControlGetFocus, v, %winTitle%, %winText%, %excludeTitle%, %excludeText%
    return v
}

ControlGetText(control:="", winTitle:="", winText:="", excludeTitle:="", excludeText:="") {
    v := ""
    ControlGetText, v, %control%, %winTitle%, %winText%, %excludeTitle%, %excludeText%
    return v
}

CoordMode(param1, param2:="") {
    CoordMode, %param1%, %param2%
}

DriveGet(cmd, value:="") {
    v := ""
    DriveGet, v, %cmd%, %value%
    return v
}

DriveSpaceFree(path) {
    v := ""
    DriveSpaceFree, v, %path%
    return v
}

EnvGet(envVarName) {
    v := ""
    EnvGet, v, %envVarName%
    return v
}

FileAppend(text, file, encoding:="") {
    FileAppend, %text%, %file%, %encoding%
}

FileCreateShortCut(target, lnkFile, workDir:="", args:="", desc:="", iconFile:="", shortcut:="", iconNum:="", runState:="") {
    FileCreateShortcut, %target%, %lnkFile%, %workDir%, %args%, %desc%, %iconFile%, %shortcut%, %iconNum%, %runState%
}

FileDelete(FilePattern:="") {
    FileDelete, %FilePattern%
}

FileGetAttrib(filename:="") {
    v := ""
    FileGetAttrib, v, %filename%
    return v
}

FileGetShortcut(linkFile, ByRef outTarget:="", ByRef outDir:="", ByRef outArgs:="", ByRef outDescription:="", ByRef outIcon:="", ByRef outIconNum:="", ByRef outRunState:="") {
    FileGetShortcut, %linkFile%, outTarget, outDir, outArgs, outDescription, outIcon, outIconNum, outRunState
}

FileGetSize(filename:="", units:="") {
    v := ""
    FileGetSize, v, %filename%, %units%
    return v
}

FileGetTime(filename:="", whichTime:="") {
    v := ""
    FileGetTime, v, %filename%, %whichTime%
    return v
}

FileGetVersion(filename:="") {
    v := ""
    FileGetVersion, v, %filename%
    return v
}

FileRead(filename) {
    v := ""
    FileRead, v, %filename%
    return v
}

FileReadLine(filename, lineNum) {
    v := ""
    FileReadLine, v, %filename%, %lineNum%
    return v
}

FileSelectFile(options:="", rootDir:="", prompt:="", filter:="") {
    v := ""
    FileSelectFile, v, %options%, %rootDir%, %prompt%, %filter%
    return v
}

FileSelectFolder(startingFolder:="", options:="", prompt:="") {
    v := ""
    FileSelectFolder, v, %startingFolder%, %options%, %prompt%
    return v
}

FormatTime(YYYYMMDDHH24MISS:="", format:="") {
    v := ""
    FormatTime, v, %YYYYMMDDHH24MISS%, %format%
    return v
}

GroupActivate(groupName, R:="R") {
    GroupActivate, %groupName%, %R%
}

GuiControlGet(subCommand:="", controlID:="", param4:="") {
    v := ""
    GuiControlGet, v, %subcommand%, %controlID%, %param4%
    return v
}

ImageSearch(ByRef outputX, ByRef outputY, x1, y1, x2, y2, imageFile) {
    ImageSearch, outputX, outputY, %x1%, %y1%, %x2%, %y2%, %imageFile%
}

IniDelete(filename, section, key:="") {
    IniDelete, %filename%, %section%, %key%
}

IniRead(filename, section:="", key:="", default:="") {
    v := ""
    IniRead, v, %filename%, %section%, %key%, %default%
    return v
}

IniWrite(filename, section, key, value) {
    IniWrite, %value%, %filename%, %section%, %key%
}

Input(options:="", endKeys:="", matchList:="") {
    v := ""
    Input, v, %options%, %endKeys%, %matchList%
    return v
}

InputBox(title:="", prompt:="", hide:="", width:="", height:="", x:="", y:="", font:="", timeout:="", default:="") {
    v := ""
    InputBox, v, %title%, %prompt%, %hide%, %width%, %height%, %x%, %y%, , %timeout%, %default%
    v := (ErrorLevel == 1 ? "" : v)
    return v
}

KeyWait(key) {
    KeyWait, %key%
}

MouseClickDrag(button, x1, y1, x2, y2, speed, R:="R") {
    MouseClickDrag, %button%, %x1%, %y1%, %x2%, %y2%, %speed%, %R%
}

MouseGetPos(ByRef outputX:="", ByRef outputY:="", ByRef outputWin:="", ByRef outputControl:="", mode:="") {
    MouseGetPos, outputX, outputY, outputWin, outputControl, %mode%
}

MouseMove(x, y, speed:=0, R:="R") {
    MouseMove, %x%, %y%, %speed%, %R%
}

PixelGetColor(x, y, rgb:="") {
    v := ""
    PixelGetColor, v, %x%, %y%, %rgb%
    return v
}

PixelSearch(ByRef outputX, ByRef outputY, x1, y1, x2, y2, colorID, variation:="", mode:="") {
    PixelSearch, outputX, outputY, %x1%, %y1%, %x2%, %y2%, %colorID%, %variation%, %mode%
}

Process(cmd, pidOrName, param3:="") {
    Process, %cmd%, %pidOrName%, %param3%
}

Progress(param1, subText:="", mainText:="", winTitle:="", fontName:="") {
    Progress, %param1%, %subText%, %mainText%, %winTitle%, %fontName%
}

Random(min:="", max:="") {
    v := ""
    Random, v, %min%, %max%
    return v
}

RegRead(rootKey, subKey, valueName:="") {
    v := ""
    RegRead, v, %rootKey%, %subKey%, %valueName%
    return v
}

RegWrite(rootKey, subKey, valueName:="", value:="", valueType:="REG_SZ") {
    RegWrite, %valueType%, %rootKey%, %subKey%, %valueName%, %value%
}

Run(target, workingDir:="", mode:="") {
    Run, %target%, %workingDir%, %mode%, v
    return v
}

SetTimer(label:="", mode:="", priority:=0) {
    SetTimer, %label%, %mode%, %priority%
}

Sleep(millis:=0) {
    Sleep, %millis%
}

Sort(ByRef VarName, Options) {
    Sort, VarName, %Options%
}

SoundGet(componentType:="", controlType:="", deviceNumber:="") {
    v := ""
    SoundGet, v, %componentType%, %controlType%, %deviceNumber%
    return v
}

SoundGetWaveVolume(deviceNumber:="") {
    v := ""
    SoundGetWaveVolume, v, %deviceNumber%
    return v
}

SplashImage(imageFile, options:="", subText:="", mainText:="", winTitle:="", fontName:="") {
    SplashImage, %imageFile%, %options%, %subText%, %mainText%, %winTitle%, %fontName%
}

SplitPath(inputVar, ByRef outFileName:="", ByRef outDir:="", ByRef outExtension:="", ByRef outNameNoExt:="", ByRef outDrive:="") {
   SplitPath, inputVar, outFileName, outDir, OutExtension, outNameNoExt, outDrive
}

StatusBarGetText(part:="", winTitle:="", winText:="", excludeTitle:="", excludeText:="") {
    v := ""
    StatusBarGetText, v, %part%, %winTitle%, %winText%, %excludeTitle%, %excludeText%
    return v
}

StringGetPos(inputVar, searchText, mode:="", offset:="") {
    if (inputVar == "") {
        v := ""
    }
    else {
        StringGetPos, v, inputVar, %searchText%, %mode%, %offset%
    }
    return v
}

StringLeft(inputVar, count) {
    if (inputVar == "") {
        v := ""
    }
    else {
        StringLeft, v, inputVar, %count%
    }
    return v
}

StringLen(inputVar) {
    if (inputVar == "") {
        v := ""
    }
    else {
        StringLen, v, inputVar
    }
    return v
}

StringLower(inputVar, t:="") {
    if (inputVar == "") {
        v := ""
    }
    else {
        StringLower, v, inputVar, %t%
    }
    return v
}

StringMid(inputVar, startChar, count , l:="") {
    if (inputVar == "") {
        v := ""
    }
    else {
        StringMid, v, inputVar, %startChar%, %count%, %l%
    }
    return v
}

StringReplace(InputVar, searchText, replaceText:="", all:="") {
    if (inputVar == "") {
        v := ""
    }
    else {
        StringReplace, v, InputVar, %searchText%, %replaceText%, %all%
    }
    return v
}

StringRight(inputVar, count) {
    if (inputVar == "") {
        v := ""
    }
    else {
        StringRight, v, inputVar, %count%
    }
    return v
}

StringTrimLeft(inputVar, count) {
    if (inputVar == "") {
        v := ""
    }
    else {
        StringTrimLeft, v, inputVar, %count%
    }
    return v
}

StringTrimRight(inputVar, count) {
    if (inputVar == "") {
        v := ""
    }
    else {
        StringTrimRight, v, inputVar, %count%
    }
    return v
}

StringUpper(inputVar, t:="") {
    if (inputVar == "") {
        v := ""
    }
    else {
        StringUpper, v, inputVar, %t%
    }
    return v
}

Transform(cmd, value1, value2:="") {
    v := ""
    Transform, v, %cmd%, %value1%, %value2%
    return v
}

WinGet(cmd:="", winTitle:="", winText:="", excludeTitle:="", excludeText:="") {
    v := ""
    WinGet, v, %cmd%, %winTitle%, %winText%, %excludeTitle%, %excludeText%
    return v
}

WinGetActiveTitle() {
    v := ""
    WinGetActiveTitle, v
    return v
}

WinGetClass(winTitle:="", winText:="", excludeTitle:="", excludeText:="") {
    v := ""
    WinGetClass, v, %winTitle%, %winText%, %excludeTitle%, %excludeText%
    return v
}

WinGetText(winTitle:="", winText:="", excludeTitle:="", excludeText:="") {
    v := ""
    WinGetText, v, %winTitle%, %winText%, %excludeTitle%, %excludeText%
    return v
}

WinGetTitle(winTitle:="", winText:="", excludeTitle:="", excludeText:="") {
    v := ""
    WinGetTitle, v, %winTitle%, %winText%, %excludeTitle%, %excludeText%
    return v
}

;__________________________________________________
;hotkey functions
hkActionAlwaysOnTop() {
    toggleAlwaysOnTop()
}

hkActionCalculator() {
    findOrRunByExe("calc")
}

hkActionClickThrough() {
    toggleClickThrough()
}

hkActionCharacterMap() {
    findOrRunByExe("charmap")
}

hkActionControlPanel() {
    runTarget("Control Panel")
}

hkActionDosPrompt() {
    runDos()
}

hkActionDosPromptInExplorer() {
    runDos(getExplorerPath())
}

hkActionEditor() {
    runEditor()
}

hkActionGoogleSearch() {
    runSelectedText()
}

hkActionQuickLookup() {
    runQuickLookup()
}

hkActionStartupFolder() {
    runTarget("explore " . A_AppData . "\Microsoft\Windows\Start Menu\Programs\Startup")
}

hkActionToggleDesktopIcons() {
    toggleDesktopIcons()
}

hkActionWindowsExplorer() {
    exeStr := "ahk_exe explorer.exe"
    if (WinExist(exeStr) && !WinActive(exeStr)) {
        WinActivate
    }
    else {
        runTarget("explore " . EnvGet("SystemDrive") . "\")
    }
}

hkActionWindowsServices() {
    runServices()
}

hkActionWindowsSnip() {
    snip := findOnPath("SnippingTool.exe")
    if (snip == "") {
        winVer := RegRead("HKEY_LOCAL_MACHINE", "SOFTWARE\Microsoft\Windows NT\CurrentVersion", "ProductName")
        msg := ""
        if (contains(winVer, "2008", "2012")) {
            msg := "`n`nFor Windows Server 2008 or 2012, you need to install 'Themes' or 'Desktop Experience' to get the SnippingTool."
        }
        MsgBox, 48, File not found, Unable to locate SnippingTool on the PATH.%msg%
    }
    else {
        Run(snip)
    }
}

hkDosCdParent() {
    SendInput, cd..{Enter}
}

hkDosCopy() {
    SendInput, copy{Space}
}

hkDosDeleteToEol() {
    SendInput, {Delete 300}
}

hkDosDownloads() {
    SendInput, pushd `%USERPROFILE`%\Downloads{Enter}
}

hkDosExit() {
    SendInput, exit{Enter}
}

hkDosMove() {
    SendInput, move{Space}
}

hkDosPageDown() {
    scrollWindow("pgdn")
}

hkDosPageUp() {
    scrollWindow("pgup")
}

hkDosPaste() {
    SendInput, {RAW}%ClipBoard%
}

hkDosPopd() {
    SendInput, popd{Enter}
}

hkDosPushd() {
    SendInput, pushd{Space}
}

hkDosRoot() {
    SendInput, cd\{Enter}
}

hkDosScrollTop() {
    scrollWindow("top")
}

hkDosScrollBottom() {
    scrollWindow("bottom")
}

hkDosType() {
    SendInput, type{Space}
}

hkEppDeleteToEol() {
    SendInput, ^+{Delete}
}

hkEppDeleteWord() {
    SendInput, ^{Delete}
}

hkEppGoToLine() {
    SendInput, !g
}

hkEppNextFile() {
    SendInput, {F6}
}

hkEppPrevFile() {
    SendInput, +{F6}
}

hkHotScriptAutoHotKeyHelp() {
    runAhkHelp()
}

hkHotScriptEditDefaultIni() {
    runEditor(hs.config.default.file)
}

hkHotScriptEditHotScript() {
    runEditor(A_ScriptFullPath)
}

hkHotScriptEditUserIni() {
    runEditor(hs.config.user.file)
}

hkHotScriptEditUserFunctions() {
    runEditor(hs.file.USER_FUNCTIONS)
}

hkHotScriptEditUserKeys() {
    runEditor(hs.file.USER_KEYS)
}

hkHotScriptEditUserStrings() {
    runEditor(hs.file.USER_STRINGS)
}

hkHotScriptEditUserVariables() {
    runEditor(hs.file.USER_VARIABLES)
}

hkHotScriptExit() {
    stop()
}

hkHotScriptHome() {
    Run(hs.vars.url[hs.TITLE].home)
}

hkHotScriptFolder() {
    runTarget("explore " . A_ScriptDir)
}

hkHotScriptQuickHelp() {
    showQuickHelp(true)
}

hkHotScriptQuickHelpToggle() {
    showQuickHelp(false)
}

hkHotScriptReload() {
    selfReload()
}

hkHotScriptRunDebugView() {
    exe := "DbgView.exe"
    exeStr := "ahk_exe " . exe
    if (WinExist(exeStr) && !WinActive(exeStr)) {
        WinActivate
    }
    else {
        dvExe := findOnPath(exe)
        if (dvExe == "") {
            msg := "Unable to locate DebugView on the PATH.`n`nDebugView displays Windows debug messages, which HotScript`n(and many other programs) can generate.`n`nClick the 'Download' button to go to the website for DebugView."
            SetTimer, ChangeButtons, 30
            ; 1 + 48 + 256 = 305
            MsgBox, 305, File Not Found, % msg
            IfMsgBox, OK
                Run("https://technet.microsoft.com/en-us/sysinternals/debugview.aspx")
            return

            ChangeButtons:
                IfWinNotExist, File Not Found
                    return  ; Keep waiting.
                SetTimer, ChangeButtons, off
                WinActivate
                ControlSetText, Button1, &Download
                ControlSetText, Button2, &Close
                return
        }
        else {
            Run(dvExe)
        }
    }

}

hkHotScriptShowVariable() {
    showVariable()
}

hkMiscCreateFile() {
    if (WinActive("ahk_group ExplorerGroup")) {
        createNewInExplorer("file")
    }
    else if (WinActive("ahk_group DesktopGroup")) {
        createNewOnDesktop("file")
    }
    else {
        SendInput, %A_ThisHotKey%
    }
}

hkMiscCreateFolder() {
    if (WinActive("ahk_group ExplorerGroup")) {
        createNewInExplorer("folder")
    }
    else if (WinActive("ahk_group DesktopGroup")) {
        createNewOnDesktop("folder")
    }
    else {
        SendInput, %A_ThisHotKey%
    }
}

hkMiscCopyAppend() {
    origClipboard := Clipboard
    Clipboard := ""
    SendInput, ^c
    ClipWait(1, 1)
    Sleep(50)
    newClipboard := (ErrorLevel ? "" : Clipboard)
    Clipboard := origClipboard . newClipboard
    Sleep(50)
    origClipboard := ""
    newClipboard := ""
}

hkMiscCutAppend() {
    origClipboard := Clipboard
    Clipboard := ""
    SendInput, ^x
    ClipWait(1, 1)
    Sleep(50)
    newClipboard := (ErrorLevel ? "" : Clipboard)
    Clipboard := origClipboard . newClipboard
    Sleep(50)
    origClipboard := ""
    newClipboard := ""
}

hkMiscDragMouseDown() {
    MouseClickDrag("Left", 0, 0, 0, 1, 0)
}

hkMiscDragMouseLeft() {
    MouseClickDrag("Left", 0, 0, -1, 0, 0)
}

hkMiscDragMouseRight() {
    MouseClickDrag("Left", 0, 0, 1, 0, 0)
}

hkMiscDragMouseUp() {
    MouseClickDrag("Left", 0, 0, 0, -1, 0)
}

hkMiscMouseDown() {
    MouseMove(0, 1)
}

hkMiscMouseLeft() {
    MouseMove(-1, 0)
}

hkMiscMouseRight() {
    MouseMove(1, 0)
}

hkMiscMouseUp() {
    MouseMove(0, -1)
}

hkMiscPasteClipboardAsText() {
    sendText(ClipBoard)
}

hkMiscPasteEnter() {
    sendText(hs.const.EOL_WIN)
}

hkMiscPasteTab() {
    sendText(A_Tab)
}

hkMiscPreviewClipboard() {
    showClipboard()
}

hkMiscSwapToClipboard() {
    origClipboard := Clipboard
    Clipboard :=
    SendInput, ^c
    ClipWait(1, 1)
    Sleep(50)
    pasteText(origClipboard)
}

hkMiscZoomWindow() {
    zoomStart()
}

hkTextDeleteCurrentLine() {
    if (WinActive("ahk_exe i)EditPadPro\d*\.exe")) {
        SendInput, ^!y
    }
    else {
        deleteCurrentLine()
    }
}

hkTextDeleteToEol() {
    if (hs.config.user.enableHkEpp && WinActive("ahk_exe i)EditPadPro\d*\.exe")) {
        hkEppDeleteToEol()
    }
    else if (hs.config.user.enableHkDos && isActiveDos()) {
        hkDosDeleteToEol()
    }
    else {
        SendInput, ^{Delete}
    }
}

hkTextDuplicateCurrentLine() {
    if (WinActive("ahk_exe i)EditPadPro\d*\.exe")) {
        SendInput, ^+{Up}
    }
    else {
        duplicateCurrentLine()
    }
}

hkTextMoveCurrentLineDown() {
    if (WinActive("ahk_exe i)EditPadPro\d*\.exe")) {
        SendInput, ^!+{Down}
    }
    else {
        moveCurrentLineDown()
    }
}

hkTextMoveCurrentLineUp() {
    if (WinActive("ahk_exe i)EditPadPro\d*\.exe")) {
        SendInput, ^!+{Up}
    }
    else if (isActiveDos()) {
        hkDosCdParent()
    }
    else {
        moveCurrentLineUp()
    }
}

hkTransformEncrypt() {
    cryptSelected()
}

hkTransformEscape() {
    escapeText()
}

hkTransformInvertCase() {
    transformSelected("I")
}

hkTransformLowerCase() {
    if (WinActive("ahk_exe i)EditPadPro\d*\.exe")) {
        SendInput, ^+l
    }
    else {
        transformSelected("L")
    }
}

hkTransformNumberPrepend() {
    numberSelected()
}

hkTransformNumberPrependPrompt() {
    numberSelectedPrompt()
}

hkTransformNumberStrip() {
    numberRemoveSelected()
}

hkTransformOracleUpper() {
    upperCaseOracle()
}

hkTransformReverseText() {
    transformSelected("R")
}

hkTransformSentenceCase() {
    transformSelected("S")
}

hkTransformSortAscending() {
    sortSelected("a", false)
}

hkTransformSortAscendingNoCase() {
    sortSelected("a", true)
}

hkTransformSortDescending() {
    sortSelected("d", false)
}

hkTransformSortDescendingNoCase() {
    sortSelected("d", true)
}

hkTransformTagify() {
    tagifySelected()
}

hkTransformTitleCase() {
    if (WinActive("ahk_class Chrome_WidgetWin_1") || WinActive("ahk_class MozillaWindowClass")) {
        SendInput, ^+t
    }
    else {
        transformSelected("T")
    }
}

hkTransformUnwrapText() {
    lineUnwrapSelected()
}

hkTransformUpperCase() {
    if (WinActive("ahk_exe i)EditPadPro\d*\.exe")) {
        SendInput, ^+u
    }
    else {
        transformSelected("U")
    }
}

hkTransformWrapEachInBrackets() {
    wrapSelectedEach("[", "]")
}

hkTransformWrapEachInCurlys() {
    wrapSelectedEach("{", "}")
}

hkTransformWrapEachInParenthesis() {
    wrapSelectedEach("(", ")")
}

hkTransformWrapEachInDoubleQuotes() {
    wrapSelectedEach("""", """")
}

hkTransformWrapEachInSingleQuotes() {
    wrapSelectedEach("'", "'")
}

hkTransformWrapEachInTags() {
    wrapSelectedEach("<", ">")
}

hkTransformWrapInBrackets() {
    wrapSelected("[", "]")
}

hkTransformWrapInCurlys() {
    wrapSelected("{", "}")
}

hkTransformWrapInParenthesis() {
    wrapSelected("(", ")")
}

hkTransformWrapInDoubleQuotes() {
    wrapSelected("""", """")
}

hkTransformWrapInSingleQuotes() {
    wrapSelected("'", "'")
}

hkTransformWrapInTags() {
    wrapSelected("<", ">")
}

hkTransformWrapText() {
    lineWrapSelected()
}

hkWindowCenter() {
    centerWindow()
}

hkWindowDecreaseTransparency() {
    setTransparency(false)
}

hkWindowHide() {
    hideWindow()
}

hkWindowIncreaseTransparency() {
    setTransparency(true)
}

hkWindowLeft() {
    moveToMonitor("A", -1)
}

hkWindowMaximize() {
    maximize()
}

hkWindowMinimize() {
    minimize()
}

hkWindowMoveToEdgeBottom() {
    moveToEdge("B")
}

hkWindowMoveToEdgeLeft() {
    moveToEdge("L")
}

hkWindowMoveToEdgeRight() {
    moveToEdge("R")
}

hkWindowMoveToEdgeTop() {
    moveToEdge("T")
}

hkWindowPageDown() {
    SendInput, {PgDn}
}

hkWindowPageUp() {
    SendInput, {PgUp}
}

hkWindowResize() {
    runQuickResolution()
}

hkWindowResizeToAnchor() {
    direction := ""
    if (GetKeyState("up", "p")) {
        direction .= "T"
    }
    else if (GetKeyState("down", "p")) {
        direction .= "B"
    }
    if (GetKeyState("left", "p")) {
        direction .= "L"
    }
    else if (GetKeyState("right", "p")) {
        direction .= "R"
    }
    resizeTo(direction)
}

hkWindowResizeToCompass() {
    direction := ""
    key := setCase(A_ThisHotKey, "L")
    if (containsIgnoreCase(key, "NumPad1", "NumPadEnd")) {
        direction := "SW"
    }
    else if (containsIgnoreCase(key, "NumPad2", "NumPadDown")) {
        direction := "S"
    }
    else if (containsIgnoreCase(key, "NumPad3", "NumPadPgDn")) {
        direction := "SE"
    }
    else if (containsIgnoreCase(key, "NumPad4", "NumPadLeft")) {
        direction := "W"
    }
    else if (containsIgnoreCase(key, "NumPad5", "NumPadClear")) {
        direction := "C"
    }
    else if (containsIgnoreCase(key, "NumPad6", "NumPadRight")) {
        direction := "E"
    }
    else if (containsIgnoreCase(key, "NumPad7", "NumPadHome")) {
        direction := "NW"
    }
    else if (containsIgnoreCase(key, "NumPad8", "NumPadUp")) {
        direction := "N"
    }
    else if (containsIgnoreCase(key, "NumPad9", "NumPadPgUp")) {
        direction := "NE"
    }
    resizeTo(direction)
}

hkWindowRestoreHidden() {
    restoreHiddenWindows()
}

hkWindowRight() {
    moveToMonitor("A", 1)
}

hkWindowToggleMinimized() {
    toggleMinimized()
}

hkWindowToggleTransparency() {
    toggleTransparency()
}

;__________________________________________________
;hotstring functions
hsAliasBackInX() {
    sendText("Back in " . $.value(1) . " minutes...")
}

hsCodeBlock() {
    SendInput, ^{Left}
    indent := getIndent()
    indent1 := getIndent1(indent)
    template =
    (LTrim
        `) {
        %indent%%indent1%
        %indent%}
    )
    sendText(template, "{Up 2}{End}{Left 3}")
}

hsCodeElseIf() {
    indent := getIndent()
    indent1 := getIndent1(indent)
    template =
    (LTrim
        else if `(`) {
        %indent%%indent1%
        %indent%}
    )
    sendText(template, "{Up 2}{End}{Left 3}")
}

hsCodeFunction() {
    trigger := StrReplace($.value(0), "func", "function")
    indent := getIndent()
    indent1 := getIndent1(indent)
    template =
    (LTrim
        %trigger%`) {
        %indent%%indent1%
        %indent%}
    )
    sendText(template, "{Up 2}{End}{Left 3}")
}

hsCodeIfElse() {
    indent := getIndent()
    indent1 := getIndent1(indent)
    template =
    (LTrim
        if `(`) {
        %indent%%indent1%
        %indent%}
        %indent%else {
        %indent%%indent1%
        %indent%}
    )
    sendText(template, "{Up 5}{End}{Left 3}")
}

hsCodeStringFormat() {
    sendText("String.format("""", )", "{Left 4}")
}

hsCodeSwitch() {
    SendInput, ^{Left}
    indent := getIndent()
    indent1 := getIndent1(indent)
    template =
    (LTrim
        `) {
        %indent%%indent1%case x:
        %indent%%indent1%%indent1%break;
        %indent%%indent1%default:
        %indent%%indent1%%indent1%break;
        %indent%}
    )
    sendText(template, "{Up 5}{End}{Left 3}")
}

hsCodeSysOut() {
    sendText("System.out.println("""");", "{Left 3}")
}

hsCommentHeaderHtml() {
    line := hs.const.COMMENT_HEADER_LINE
    indent := getIndent()
    template =
    (LTrim
        <!--%line%
        %indent%%indent%
        %indent%%line%--->
    )
    sendText(template, "{Up}{End}")
}

hsCommentHeaderJava() {
    indent := getIndent()
    template =
    (LTrim
        /**
        %indent% *%A_Space%
        %indent% */
    )
    sendText(template, "{Up}{End}")
}

hsCommentHeaderPerl() {
    line := hs.const.COMMENT_HEADER_LINE
    indent := getIndent()
    template =
    (LTrim
        # %line%
        %indent%#%indent%
        %indent%# %line%
    )
    sendText(template, "{Up}{End}")
}

hsCommentHeaderSql() {
    line := hs.const.COMMENT_HEADER_LINE
    indent := getIndent()
    template =
    (LTrim
        -- %line%
        %indent%--%indent%
        %indent%-- %line%
    )
    sendText(template, "{Up}{End}")
}

hsHtmlA() {
    sendText("href=""""></a>", "{Left 4}")
}

hsHtmlComment() {
    SendInput, ^{Left}
    indent := getIndent()
    indent1 := getIndent1(indent)
    template =
    (LTrim
        -
        %indent%%indent1%
        %indent%-->
    )
    sendText(template, "{Up}{End}")
}

hsHtmlHeader() {
    sendText("></h" . $.value(1) . ">", "{Left 5}")
}

hsHtmlHtml() {
    triggerLen := StrLen($.value(0))
    SendInput, {Left %triggerLen%}
    indent := getIndent()
    indent1 := getIndent1(indent)
    template =
    (LTrim
        >
        %indent%%indent1%<body>
        %indent%%indent1%%indent1%
        %indent%%indent1%</body>
        %indent%</html>
    )
    sendText(template, "{Up 2}{End}")
}

hsHtmlInput() {
    sendText(" type="""" id="""" value=""""/>", "{End}{Left 18}")
}

hsHtmlLink() {
    sendText(" rel=""stylesheet"" type=""text/css"" href=""""/>", "{Left 3}")
}

hsHtmlList() {
    triggerLen := StrLen($.value(0))
    tag := $.value(1)
    SendInput, {Left %triggerLen%}
    indent := getIndent()
    indent1 := getIndent1(indent)
    template =
    (LTrim
        >
        %indent%%indent1%<li></li>
        %indent%</%tag%>
    )
    sendText(template, "{Up}{End}{Left 5}")
}

hsHtmlOptGroup() {
    triggerLen := StrLen($.value(0))
    SendInput, {Left %triggerLen%}
    indent := getIndent()
    indent1 := getIndent1(indent)
    template =
    (LTrim
        roup>
        %indent%%indent1%<option></option>
        %indent%</optgroup>
    )
    sendText(template, "{Up}{End}{Left 9}")
}

hsHtmlSelect() {
    triggerLen := StrLen($.value(0))
    SendInput, {Left %triggerLen%}
    indent := getIndent()
    indent1 := getIndent1(indent)
    template =
    (LTrim
        %A_Space%id="">
        %indent%%indent1%<option></option>
        %indent%</select>
    )
    sendText(template, "{Up}{End}{Left 9}")
}

hsHtmlSource() {
    sendText(" type="""" src=""""/>", "{Left 3}")
}

hsHtmlStyle() {
    triggerLen := StrLen($.value(0))
    SendInput, {Left %triggerLen%}
    indent := getIndent()
    indent1 := getIndent1(indent)
    template =
    (LTrim
        %A_Space%type="text/css">
        %indent%%indent1%
        %indent%</style>
    )
    sendText(template, "{Up}{End}")
}

hsHtmlTable() {
    triggerLen := StrLen($.value(0))
    SendInput, {Left %triggerLen%}
    indent := getIndent()
    indent1 := getIndent1(indent)
    template =
    (LTrim
        >
        %indent%%indent1%<tr>
        %indent%%indent1%%indent1%<td>
        %indent%%indent1%%indent1%%indent1%
        %indent%%indent1%%indent1%</td>
        %indent%%indent1%</tr>
        %indent%</table>
    )
    sendText(template, "{Up 3}{End}")
}

hsHtmlTagAbbr() {
    tag := $.value(1)
    if (tag == "but") {
        extra := "ton"
    }
    else if (tag == "cap") {
        extra := "tion"
    }
    else if (tag == "field") {
        extra := "set"
    }
    else if (tag == "foot") {
        extra := "er"
    }
    else if (tag == "opti") {
        extra := "on"
    }
    else if (tag == "sum") {
        extra := "mary"
    }
    tag .= extra
    sendText(extra . "></" . tag . ">", "{Left " . (StrLen(tag) + 3) . "}")
}

hsHtmlTagBlock() {
    triggerLen := StrLen($.value(0))
    tag := $.value(1)
    SendInput, {Left %triggerLen%}
    indent := getIndent()
    indent1 := getIndent1(indent)
    template =
    (LTrim
        >
        %indent%%indent1%
        %indent%</%tag%>
    )
    sendText(template, "{Up}{End}")
}


hsHtmlTagFor() {
    tag := $.value(1)
    sendText(" for=""""/>", "{Left 3}")
}

hsHtmlTagNoEndChar() {
    tag := $.value(1)
    SendInput, {BS}
    sendText("></" . tag . ">", "{Left " . (StrLen(tag) + 3) . "}")
}

hsHtmlTagSimple() {
    tag := $.value(1)
    sendText("></" . tag . ">", "{Left " . (StrLen(tag) + 3) . "}")
}

hsHtmlTagSrc() {
    tag := $.value(1)
    sendText(" src=""""></" . tag . ">", "{Left " . (StrLen(tag) + 3) . "}")
}

hsHtmlTextarea() {
    triggerLen := StrLen($.value(0))
    SendInput, {Left %triggerLen%}
    indent := getIndent()
    indent1 := getIndent1(indent)
    template =
    (LTrim
        rea rows="" cols="">
        %indent%%indent1%
        %indent%</textarea>
    )
    sendText(template, "{Up}{End}")
}

hsHtmlTr() {
    triggerLen := StrLen($.value(0))
    SendInput, {Left %triggerLen%}
    indent := getIndent()
    indent1 := getIndent1(indent)
    template =
    (LTrim
        >
        %indent%%indent1%<td>
        %indent%%indent1%%indent1%
        %indent%%indent1%</td>
        %indent%</tr>
    )
    sendText(template, "{Up 2}{End}")
}

hsJiraCode(type) {
    if (startsWith(type, "{")) {
        type := SubStr(type, 2)
    }
    type1 := setCase(type, "L")
    type2 := setCase(type, "S")
    if (type == "code") {
        type1 := ""
    }
    else if (type == "js") {
        type2 := "JavaScript"
        type1 := setCase(type2, "L")
    }
    else if (type == "sql" || type == "xml") {
        type2 := setCase(type2, "U")
    }
    template =
    (LTrim
        {code:{type1}title={type2} snippet|{format}}
        {code}
    )
    tokens := {type1:type1 . (type1 == "" ? "" : "|"), type2:type2, format:hs.config.user.jiraPanels.format}
    pasteTemplate(template, tokens, "{Home}")
}

hsJiraColor() {
    sendText(":}{color}", "{Left 8}")
}

hsJiraNoFormat() {
    template =
    (LTrim
        ormat}
        {noformat}
    )
    sendText(template, "{Home}")
}

hsJiraPanel(type) {
    if (startsWith(type, "{")) {
        type := SubStr(type, 2)
    }
    if (type == "pan") {
        panelFormat := hs.config.user.jiraPanels.format
    }
    else {
        color := SubStr(type, 1, 1)
        if (color == "b") {
            color := "Blue"
        }
        else if (color == "g") {
            color := "Green"
        }
        else if (color == "r") {
            color := "Red"
        }
        else if (color == "y") {
            color := "Yellow"
        }
        panel := "format" . color
        panelFormat := hs.config.user.jiraPanels[panel]
    }
    template =
    (LTrim
        {panel:title=Title|{format}}
        {panel}
    )
    tokens := {format:panelFormat}
    pasteTemplate(template, tokens, "{Home}")
}

hsJiraQuote() {
    template =
    (LTrim
        te}
        {quote}
    )
    sendText(template, "{Home}")
}

hsJiraSpecialPanel(type) {
    if (startsWith(type, "{")) {
        type := SubStr(type, 2)
    }
    template =
    (LTrim
        :title={title} Title}
        {{type}}
    )
    tokens := {type:type, title:setCase(type, "S")}
    pasteTemplate(template, tokens, "{Home}")
}

hsJiraTable() {
    template =
    (LTrim
        || Column1 || Column2 || Column3 || Column4 || Column5 ||
        | Row1_1 | Row1_2 | Row1_3 | Row1_4 | Row1_5 |
    )
    template := RegExReplace(template, hs.const.EOL_NIX, hs.const.EOL_WIN)
    pasteTemplate(template, "", "{Home}{Up}{Right 3}^+{Right}")
}

;__________________________________________________
;internal functions
addHotKey() {
    hs.config.user.hkSessionCount++
    hs.config.user.hkTotalCount++
    value := hs.config.user.hkTotalCount
    file := hs.config.user.file
    IniWrite(hs.config.user.file, "config", "hkTotalCount" . hs.vars.uniqueId, value)
}

addHotString() {
    hs.config.user.hsSessionCount++
    hs.config.user.hsTotalCount++
    value := hs.config.user.hsTotalCount
    file := hs.config.user.file
    IniWrite(hs.config.user.file, "config", "hsTotalCount" . hs.vars.uniqueId, value)
}

addMissingVariables() {
    varAppend := ""
    FileRead, hsVars, % hs.file.USER_VARIABLES
    quote := chr(34)
    for key, value in hs.vars.defaultMyVars {
        if (!contains(hsVars, "global MY_" . key)) {
            tmpQ := (contains(value, quote) ? "" : quote)
            comment := ""
            if (key == "PASSWORD") {
                comment := "  `; this is encrypted using CtrlShift-E (delete this comment after editing the value)"
            }
            varAppend .= hs.const.EOL_WIN . "global MY_" . key . " := " . tmpQ . value . tmpQ . comment
        }
    }
    if (varAppend != "") {
        FileAppend(varAppend . hs.const.EOL_WIN, hs.file.USER_VARIABLES)
        selfReload(true)
    }
}


arrayToList(arr, delim:=",", trim:="") {
    delim := (delim == "" ? "," : delim)
    arrList := ""
    for key, val in arr {
        arrList .= val . delim
    }
    return StringTrimRight(arrList, 1)
}

ask(title, prompt, width:=250, height:=125, defaultValue:="") {
    orig_hWnd := WinExist("A")
    coord := getCenter(width, height)
    value := Trim(InputBox(title, prompt,, width, height, coord.x, coord.y,,, defaultValue))
    WinActivate, ahk_id %orig_hWnd%
    return value
}

between(value, low, high) {
    return value >= low && value <= high
}

binToHex(ByRef bytes, num:=0) {
    result := ""
    len := StrLen(bytes)
    mem := VarSetCapacity(result, len * 2)
    if (num < 1 || num > mem) {
        num := len
    }
    origFormat := A_FormatInteger
    SetFormat Integer, Hex
    addr := &bytes
    Loop, % num
    {
        b := *addr
        StringTrimLeft b, b, 2
        b := "0" . b
        StringRight b, b, 2
        result .= b
        addr += 2
    }
    SetFormat Integer, %origFormat%
    return result
}

boolToStr(value) {
    return (toBool(value) ? "true" : "false")
}

centerWindow(title:="A") {
    WinGetPos, winX, winY, winW, winH, %title%
    coord := getCenter(winW, winH)
    WinMove, %title%,, coord.x, coord.y
}

checkVersions() {
    if (hs.config.user.enableVersionCheck) {
        ahkAvailable := urlToVar(hs.vars.url.ahk.version)
        if (ahkAvailable == "") {
            debug("Unable to obtain AutoHotKey version information from:`n    " . hs.vars.url.ahk.version)
            return
        }
        else if (ahkAvailable > A_AhkVersion) {
            doUpdate := false
            if (hs.config.user.enableAutoUpdate) {
                doUpdate := true
            }
            else {
                msg =
                    (LTrim
                        The version of AutoHotKey in use is out-dated.

                        %A_Tab%Current`t: %A_AhkVersion%
                        %A_Tab%Latest`t: %ahkAvailable%

                        Would you like to download the new version and install it?
                    )
                MsgBox, 36, % hs.TITLE . ": New AHK version available", % msg, 30
                IfMsgBox, Yes
                {
                    doUpdate := true
                }
            }
            if (doUpdate) {
                ver := RegexReplace(ahkAvailable, "\.", "")
                exe := StrReplace(hs.vars.url.ahk.install, "{version}", ver)
                dlFile := hs.vars.url.ahk.download . exe
                fullPath := A_ScriptDir . "\" . exe
                UrlDownloadToFile, % dlFile, % fullPath
                if (ErrorLevel == 0) {
                    Run(fullPath)
                }
                else {
                    message("Failed to download AutoHotKey installer from:`n" . dlFile . "`n`nError: " . ErrorLevel)
                }
            }
        }
        else {
            path := A_ScriptDir . "\AutoHotkey*_Install.exe"
            Loop, Files, % path
            {
                FileDelete(A_LoopFileLongPath)
            }
        }
        hsAvailable := urlToVar(hs.vars.url[hs.TITLE].version)
        if (hsAvailable == "") {
            debug("Unable to obtain " . hs.TITLE . " version information from:`n    " . hs.vars.url[hs.TITLE].version)
            return
        }
        else if (hsAvailable > hs.VERSION) {
            doUpdate := false
            if (hs.config.user.enableAutoUpdate) {
                doUpdate := true
            }
            else {
                msg := "
                    (LTrim
                        The version of " . hs.TITLE . " in use is out-dated.

                        " . A_Tab . "Current`t: " . hs.VERSION . "
                        " . A_Tab . "Latest`t: " . hsAvailable . "

                        Would you like to download the new version and install it?
                    )"
                MsgBox, 36, % hs.TITLE . ": New " . hs.TITLE . " version available", % msg, 30
                IfMsgBox, Yes
                {
                    doUpdate := true
                }
            }
            if (doUpdate) {
                ver := RegexReplace(ahkAvailable, "\.", "")
                dlFile := hs.vars.url[hs.TITLE].download
                fullPath := A_ScriptDir . "\" . hs.TITLE . ".ahk"
                UrlDownloadToFile, % dlFile, % fullPath
                if (ErrorLevel == 0) {
                    selfReload()
                }
                else {
                    message("Failed to download " . hs.TITLE . " from:`n`n" . dlFile . "`n`nError: " . ErrorLevel)
                }
            }
        }
    }
}

cleanup20131211_2() {
    oldCount := IniRead(hs.config.user.file, "config", "hkTotalCount", 0)
    if (oldCount > 0) {
        hs.config.user.hkTotalCount += oldCount
        IniWrite(hs.config.user.file, "config", "hkTotalCount" . hs.vars.uniqueId, hs.config.user.hkTotalCount)
        IniDelete(hs.config.user.file, "config", "hkTotalCount")
    }
    oldCount := IniRead(hs.config.user.file, "config", "hsTotalCount", 0)
    if (oldCount > 0) {
        hs.config.user.hsTotalCount += oldCount
        IniWrite(hs.config.user.file, "config", "hsTotalCount" . hs.vars.uniqueId, hs.config.user.hsTotalCount)
        IniDelete(hs.config.user.file, "config", "hsTotalCount")
    }
    IniDelete(hs.config.user.file, "config", "enableHsSql")
}

cleanupDeprecated() {
    cleanup20131211_2()
}

compareStrAsc(a, b) {
    return compareStr(a, b, "A")
}

compareStrAscNoCase(a, b) {
    a := setCase(a, "l")
    b := setCase(b, "l")
    return compareStrAsc(a, b)
}

compareStrDesc(a, b) {
    return compareStr(a, b, "D")
}

compareStrDescNoCase(a, b) {
    a := setCase(a, "l")
    b := setCase(b, "l")
    return compareStrDesc(a, b)
}

compareStr(a, b, direction:="A") {
    static regexComp := "(\d+|\D+)(.*)"
    result := 0
    direction := (setCase(direction, "U") == "D" ? "D" : "A")
    a := stripEol(a)
    b := stripEol(b)
    if (RegExMatch(a, regexComp, a) + RegExMatch(b, regexComp, b)) {
        if (direction == "A") {
            result := a1 > b1 ? 1 : a1 < b1 ? -1 : compareStr(a2, b2, direction)
        }
        else {
            result := a1 > b1 ? -1 : a1 < b1 ? 1 : compareStr(a2, b2, direction)
        }
    }
    return result
}

contains(str, values*) {
    result := false
    useCase := toBool(A_StringCaseSense)
    for index, value in values {
        if (IsObject(value)) {
            for key, val in value {
                if (InStr(str, val, useCase)) {
                    result := true
                    break
                }
            }
        }
        else {
            if (InStr(str, value, useCase)) {
                result := true
                break
            }
        }
    }
    return result
}

containsIgnoreCase(str, values*) {
    origCase := A_StringCaseSense
    StringCaseSense Off
    result := contains(str, values*)
    StringCaseSense %origCase%
    return result
}

createIcon() {
    iconData1 =
    (LTrim Join
        000001000400101000000000200068040000460000002020000000002000A8100000AE040000
        3030000000002000A825000056150000404000000000200028420000FE3A0000280000001000
        0000200000000100200000000000400400000000000000000000000000000000000000000015
        01000B470300288D040029A3030026AF030025B7030024BB030024BD030024BD030024BB0300
        25B7030027AF040029A30400298B01000B430000001304003131070049ED080056FF090058FF
        090058FF090058FF090058FF090058FF090058FF090058FF090058FF090058FF090058FF0800
        55FF070049EB0400302F06004EA908005FFF090067FF090067FF090067FF090067FF090067FF
        090067FF090067FF090067FF090067FF090067FF090067FF090067FF08005FFF06004EA70700
        5CCD080069FF08006BFF08006BFF08006BFF08006BFF08006BFF08006BFF08006BFF08006BFF
        08006BFF08006BFF08006BFF08006BFF080069FF07005CCB070062CD08016EFF454090FF3B35
        8CFF0C0571FF08016FFF08016FFF08016FFF08016FFF08016FFF08016FFF08016FFF08016FFF
        08016FFF08016EFF070162CB060066CD070172FF7371A2FFF7F7F7FFF0F0F6FFAAA7CDFF5955
        A0FF120C79FF070173FF070174FF070174FF070174FF070174FF070174FF070172FF060166CB
        05016BCD060177FF060178FF514E93FFF3F2F3FFFFFFFFFFFFFFFFFFF7F7FAFFBCBBD9FF7370
        B1FF191482FF060179FF060179FF060179FF060177FF05016BCB04016FCD05027CFF05027EFF
        05027EFF444190FFB8B8CAFFF8F8F8FFFFFFFFFFFFFFFFFFFFFFFFFFEEEDF5FF201D8AFF0502
        7EFF05027EFF05027CFF05016FCB040174CD050281FF050283FF050283FF050283FF413F91FF
        A1A0BEFFF3F3F4FFFFFFFFFFFFFFFFFFFAFAFBFF2D2B94FF050283FF050283FF050281FF0401
        74CB030179CD040287FF040288FF040288FF040288FF040288FF7978AEFF9797C0FFD2D2DCFF
        FDFDFDFFD3D3E3FF6B6AB6FF040288FF040288FF040287FF030179CB03027DCD03038CFF0303
        8DFF03038DFF03038DFF03038DFF07078CFFACACC8FF6767B2FFE7E7EEFF9897BDFF9696BDFF
        3D3DA5FF2A2A97FF03038CFF03027DCB020281CD020391FF020392FF020392FF020392FF0203
        92FF020392FF090A90FF6464ABFF4243A2FF121393FF0A0B8FFF4C4DA2FF4B4CA6FF020390FF
        020281CB010286CD020395FF030497FF020497FF020397FF020397FF020397FF020397FF0203
        97FF020397FF020397FF020397FF030497FF030497FF020395FF010286CB020492C1090B9DFF
        1012A0FF0F11A0FF0E10A0FF0D10A0FF0D10A0FF0D10A0FF0D10A0FF0D10A0FF0D10A0FF0E10
        A0FF0F11A0FF1012A0FF090B9DFF020492BF1C1FA261292CADFF2D30AFFF2A2CADFF282BADFF
        282BADFF282BADFF282BADFF282BADFF282BADFF282BADFF282BADFF2A2DADFF2D30AFFF282B
        ADFF1C1EA25FFFFFFF01494CB8655A5CC1C76062C3D56164C4D56264C4D56264C4D56264C4D5
        6264C4D56264C4D56264C4D56164C4D56062C3D55A5CC0C7494CB863FFFFFF010000FFFF0000
        FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
        0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF280000002000000040000000010020000000
        00008010000000000000000000000000000000000000000000070000000D0000001700000023
        00000033000000430000004F0000005B000000650000006D00000075000000790000007D0000
        007F000000810000008100000081000000810000007F0000007D00000079000000730000006D
        00000063000000590000004D0000003F0000002F00000021000000150000000B000000050000
        00150000002B0000004B0200169304002ED3050037EB050038F1050038F3050037F5050037F5
        050037F7050037F7050036F7050036F7050036F7050036F7050036F7050036F7050036F70500
        36F7050037F7050037F7050037F5050037F5050038F3050038F1050037EB04002ED10200168F
        000000470000002900000015000000090000041D050035B5070048FF07004DFF080050FF0800
        51FF080052FF080052FF080052FF080052FF080052FF080052FF080052FF080052FF080052FF
        080052FF080052FF080052FF080052FF080052FF080052FF080052FF080052FF080052FF0800
        51FF080050FF07004DFF070048FD050034B30000021F000000090000000305003D9907004CFF
        080055FF09005BFF09005EFF09005FFF09005FFF09005FFF09005FFF09005FFF09005FFF0900
        5FFF09005FFF09005FFF09005FFF09005FFF09005FFF09005FFF09005FFF09005FFF09005FFF
        09005FFF09005FFF09005FFF09005FFF09005EFF09005BFF080055FF07004CFF05003C930000
        000304002F2D07004EFB080057FF090060FF090065FF090066FF090066FF090066FF090066FF
        090066FF090066FF090066FF090066FF090066FF090066FF090066FF090066FF090066FF0900
        66FF090066FF090066FF090066FF090066FF090066FF090066FF090066FF090066FF090065FF
        090060FF080057FF07004DF904002D290600487B070057FF080060FF090066FF090068FF0900
        68FF090068FF090068FF090068FF090068FF090068FF090068FF090068FF090068FF090068FF
        090068FF090068FF090068FF090068FF090068FF090068FF090068FF090068FF090068FF0900
        68FF090068FF090068FF090068FF090066FF080060FF070057FF060048750700529B08005EFF
        080066FF090069FF09006AFF09006AFF09006AFF09006AFF09006AFF09006AFF09006AFF0900
        6AFF09006AFF09006AFF09006AFF09006AFF09006AFF09006AFF09006AFF09006AFF09006AFF
        09006AFF09006AFF09006AFF09006AFF09006AFF09006AFF09006AFF090069FF080066FF0800
        5EFF070052950600579D070163FF080169FF08016BFF08016CFF08016CFF08016CFF08016CFF
        08016CFF08016CFF08016CFF08016CFF08016CFF08016CFF08016CFF08016CFF08016CFF0801
        6CFF08016CFF08016CFF08016CFF08016CFF08016CFF08016CFF08016CFF08016CFF08016CFF
        08016CFF08016BFF080169FF070163FF0601579706005A9D070166FF08016BFF08016EFF0801
        6EFF08016EFF08016EFF08016EFF08016EFF08016EFF08016EFF08016EFF08016EFF08016EFF
        08016EFF08016EFF08016EFF08016EFF08016EFF08016EFF08016EFF08016EFF08016EFF0801
        6EFF08016EFF08016EFF08016EFF08016EFF08016EFF08016BFF070166FF0601599706005C9D
        070168FF08016EFF080170FF5F5C9BFFA6A3C9FF8784B8FF55509BFF1A1479FF08016FFF0801
        70FF080170FF080170FF080170FF080170FF080170FF080170FF080170FF080170FF080170FF
        080170FF080170FF080170FF080170FF080170FF080170FF080170FF080170FF080170FF0801
        6EFF070168FF06015C9705005E9D07016AFF070170FF070172FF7D7C9BFFF2F2F2FFFFFFFFFF
        FFFFFFFFFBFBFDFFC9C7DEFF7D7AB3FF2D2886FF070172FF070172FF070172FF070172FF0701
        72FF070172FF070172FF070172FF070172FF070172FF070172FF070172FF070172FF070172FF
        070172FF070172FF070172FF070170FF07016AFF06015D970500609D06016CFF070172FF0701
        75FF080373FF565386FFE1E1E1FFFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFD3D2E5FF
        8380B8FF322E8BFF080274FF070175FF070175FF070175FF070175FF070175FF070175FF0701
        75FF070175FF070175FF070175FF070175FF070175FF070175FF070172FF06016CFF05016097
        0500619D06016FFF070175FF070177FF070177FF070177FF39357DFFD7D7D8FFFEFEFEFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFE0DFEDFF9C9AC7FF5854A1FF16107EFF
        070177FF070177FF070177FF070177FF070177FF070177FF070177FF070177FF070177FF0701
        77FF070175FF06016FFF050162970401649D050171FF060177FF06017AFF06017AFF06017AFF
        06017AFF2F2C7CFFCFCFD2FFFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFF9F9FBFFB6B5D6FF514D9FFF07027AFF06017AFF06017AFF06017AFF
        06017AFF06017AFF06017AFF06017AFF060177FF050171FF040163970401669D050274FF0602
        7AFF06027CFF06027CFF06027CFF06027CFF06027CFF27247CFFC5C4CAFFE6E5EBFFEEEEEEFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBBBA
        D9FF0F0B80FF06027CFF06027CFF06027CFF06027CFF06027CFF06027CFF06027AFF050273FF
        040165970401689D050276FF05027CFF05027FFF05027FFF05027FFF05027FFF05027FFF0502
        7FFF1E1C7DFF9998B1FF7473A0FFE6E6E6FFFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6765AEFF05027FFF05027FFF05027FFF05027FFF0502
        7FFF05027FFF05027CFF050276FF0401689703016B9D050278FF05027FFF050281FF050282FF
        050282FF050282FF050282FF050282FF050282FF201D7FFFACACBFFF6D6CA0FFDCDCDEFFFEFE
        FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFF6261ABFF050282FF
        050282FF050282FF050282FF050282FF050281FF05027FFF050278FF03016A9703016C9D0502
        7BFF050281FF050284FF050284FF050284FF050284FF050284FF050284FF050284FF050284FF
        323084FFD0D0DAFF6A69A3FFD0D0D4FFFDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFEDEDF2FF49479EFF050284FF050284FF050284FF050284FF050284FF050284FF050281FF
        05027BFF03016C9703016E9D04027DFF040284FF040287FF040287FF040287FF040287FF0402
        87FF040287FF040287FF040287FF040287FF5F5E94FFE9E9EFFF6363A4FFB0B0BDFFFAFAFAFF
        FFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFAEAECCFFD8D8E6FF040286FF040287FF040287FF0402
        87FF040287FF040287FF040284FF04027DFF03016E970301719D040280FF040287FF040289FF
        040289FF040289FF040289FF040289FF040289FF040289FF040289FF040289FF060587FF9595
        AEFFF4F4F8FF5654A5FF73729BFFDEDEDEFFFAFAFAFFFFFFFFFFE8E8F0FFB9B9D3FFCECEE5FF
        040289FF040289FF040289FF040289FF040289FF040289FF040287FF04027FFF030170970302
        739D030382FF030389FF03038CFF03038CFF03038CFF03038CFF03038CFF03038CFF03038CFF
        03038CFF03038CFF03038CFF141487FFC4C4CBFFF6F6FAFF4242A6FF1B1B85FFD1D1DBFFFEFE
        FEFFACABCBFFAEAEC1FFD8D8E1FF3838A1FF03038CFF03038CFF04038CFF04048CFF03038CFF
        030389FF030382FF030273970202759D030384FF03038CFF03038EFF03038FFF03038FFF0303
        8FFF03038FFF03038FFF03038FFF03038FFF03038FFF03038FFF03038FFF28288AFFCECED2FF
        E2E2F0FF5E5EABFFFCFCFCFFD1D1E1FFACACCBFF59599DFF7D7D9FFFCACAD4FFA6A6D3FF4A4A
        ACFF5E5EB0FF424294FF03038EFF03038CFF030384FF020275970202769D030386FF03038EFF
        030391FF030391FF030391FF030391FF030391FF030391FF030391FF030391FF030391FF0303
        91FF030391FF030391FF20208BFFA1A1B3FFD8D8DEFFC2C2D2FF3F3F95FF404096FF05058FFF
        04048EFF232389FF6E6F9FFFBEBEC4FFCBCBCFFF5E5EA5FF030390FF03038EFF030386FF0202
        77970102789D020389FF020391FF020393FF020393FF020393FF020393FF020393FF020393FF
        020393FF020393FF020393FF020393FF020393FF020393FF020393FF030491FF14148BFF0607
        90FF020393FF020393FF020393FF020393FF020393FF020393FF020391FF020391FF020393FF
        020393FF020391FF020389FF0102799701027B9D02038BFF020393FF020395FF020395FF0203
        95FF020395FF020395FF020395FF020395FF020395FF020395FF020395FF020395FF020395FF
        020395FF020395FF020395FF020395FF020395FF020395FF020395FF020395FF020395FF0203
        95FF020395FF020395FF020395FF020395FF020393FF02038BFF01027A9701027E9D02038EFF
        020395FF020498FF040599FF050699FF040599FF030498FF020498FF020498FF020398FF0204
        98FF020498FF020498FF020498FF020498FF020498FF020498FF020498FF020498FF020498FF
        020398FF020498FF020498FF030498FF040599FF050699FF040599FF020398FF020395FF0203
        8EFF01027E9700028497010393FF020499FF090A9DFF0B0D9EFF0C0E9EFF0B0D9EFF0A0C9DFF
        090B9DFF090B9DFF090B9DFF090B9DFF090B9DFF090B9DFF090B9DFF090B9DFF090B9DFF090B
        9DFF090B9DFF090B9DFF090B9DFF090B9DFF090B9DFF090B9DFF0A0C9DFF0B0D9EFF0C0E9EFF
        0B0D9EFF080A9DFF010399FF010393FF0102849101048C6F04069CFF080B9EFF1315A3FF1417
        A3FF1417A3FF1416A3FF1315A3FF1215A2FF1214A2FF1214A2FF1214A2FF1214A2FF1214A2FF
        1214A2FF1214A2FF1214A2FF1214A2FF1214A2FF1214A2FF1214A2FF1214A2FF1214A2FF1315
        A2FF1315A3FF1416A3FF1417A3FF1417A3FF1215A3FF070A9EFF04069CFF01048C690A0D7E1B
        171AA5F51A1CA7FF2225AAFF2225AAFF2023A9FF1F21A9FF1E20A8FF1D20A8FF1D1FA8FF1D1F
        A8FF1D1FA8FF1D1FA8FF1D1FA8FF1D1FA8FF1D1FA8FF1D1FA8FF1D1FA8FF1D1FA8FF1D1FA8FF
        1D1FA8FF1D1FA8FF1D1FA8FF1D20A8FF1E20A8FF1F21A9FF2023A9FF2224AAFF2124AAFF191C
        A7FF171AA4F30A0C7919FFFFFF012A2CA5733234B2FF373AB4FF3C3FB5FF383BB4FF3539B3FF
        3438B3FF3437B3FF3437B3FF3437B3FF3437B3FF3437B3FF3437B3FF3437B3FF3437B3FF3437
        B3FF3437B3FF3437B3FF3437B3FF3437B3FF3437B3FF3437B3FF3437B3FF3438B3FF3639B3FF
        383BB4FF3B3EB5FF3538B3FF3234B2FF292CA46FFFFFFF01FFFFFF01FFFFFF014245B2794C4F
        BCF95557C0FF5B5DC2FF5B5EC2FF5B5EC2FF5B5EC2FF5B5EC2FF5B5EC2FF5B5EC2FF5B5EC2FF
        5B5EC2FF5B5EC2FF5B5EC2FF5B5EC2FF5B5EC2FF5B5EC2FF5B5EC2FF5B5EC2FF5B5EC2FF5B5E
        C2FF5B5EC2FF5B5EC2FF5B5EC2FF5A5DC2FF5456BFFF4C4FBCF74144B175FFFFFF01FFFFFF01
        FFFFFF01FFFFFF01FFFFFF015154B1215C5EBF796163C2A56668C4AB696BC5AB6B6DC6AB6B6E
        C6AB6B6EC6AB6B6EC6AB6B6EC6AB6B6EC6AB6B6EC6AB6B6EC6AB6B6EC6AB6B6EC6AB6B6EC6AB
        6B6EC6AB6B6EC6AB6B6EC6AB6B6DC6AB6B6DC6AB696BC5AB6568C4AB6063C2A55C5EBF795153
        B01FFFFFFF01FFFFFF01FFFFFF01000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000028000000300000006000
        0000010020000000000080250000000000000000000000000000000000000000000500000007
        0000000B00000011000000150000001B000000250000002D000000330000003B000000410000
        00470000004F00000053000000570000005D0000005F00000063000000670000006700000069
        0000006B0000006B0000006B0000006B0000006B000000690000006900000067000000650000
        00630000005F0000005B00000057000000510000004D000000450000003F000000390000002F
        000000290000002100000019000000130000000D0000000900000007000000030000000F0000
        001700000021000000310000003F00000053000006750100138F020019A102001AAB020019B3
        020018B7020017BD020017C1020016C5020016C9020015CB020015CB020015CF020015CF0200
        15CF020015D1020015D1020015D1020015D1020015D1020015D1020015CF020015CF020015CF
        020015CB020015CB020016C9020016C5020017C1020017BD020018B7020019B102001AAB0200
        199F0100138D000006710000004F0000003B0000002D0000001D000000150000000D00000015
        00000021000000310000004901000875030022B7050038E506003DF106003FF506003FF70600
        3FF9060040F9060040F906003FFB06003FFB06003FFB06003FFB06003FFB06003FFB06003FFB
        06003FFB06003FFB06003FFB06003FFB06003FFB06003FFB06003FFB06003FFB06003FFB0600
        3FFB06003FFB06003FFB06003FFB06003FFB06003FFB060040F9060040F906003FF906003FF7
        06003FF506003DF1050039E5030022B300000771000000450000002D0000001F000000130000
        000B00000011000002230300258506003EE7070047FF07004BFF07004DFF08004EFF08004FFF
        080050FF080050FF080050FF080050FF080050FF080050FF080050FF080050FF080050FF0800
        50FF080050FF080050FF080050FF080050FF080050FF080050FF080050FF080050FF080050FF
        080050FF080050FF080050FF080050FF080050FF080050FF080050FF080050FF080050FF0800
        4FFF08004EFF07004DFF07004BFF070047FF06003DE50300258300000123000000110000000B
        000000030000010B04002F61060044ED07004BFF07004FFF080054FF080056FF080058FF0900
        59FF090059FF090059FF090059FF090059FF090059FF090059FF090059FF090059FF090059FF
        090059FF090059FF090059FF090059FF090059FF090059FF090059FF080059FF090059FF0900
        59FF080059FF090059FF090059FF080059FF090059FF090059FF080059FF090059FF090059FF
        080059FF080058FF080056FF080054FF07004FFF07004BFF060044EB04002D5D000000090000
        00030000000304002D39060044CF07004CFF080052FF080058FF09005CFF09005FFF090060FF
        090060FF090060FF090060FF090060FF090060FF090060FF090060FF090060FF090060FF0900
        60FF090060FF090060FF090060FF090060FF090060FF090060FF090060FF090060FF090060FF
        090060FF090060FF090060FF090060FF090060FF090060FF090060FF090060FF090060FF0900
        60FF090060FF090060FF09005EFF09005CFF080057FF080052FF07004CFF060043CB04002B35
        00000003030025110600429B07004DFD080054FF08005BFF090060FF090064FF090065FF0900
        65FF090065FF090066FF090066FF090066FF090066FF090066FF090066FF090066FF090066FF
        090066FF090066FF090066FF090066FF090066FF090066FF090066FF090066FF090066FF0900
        66FF090066FF090066FF090066FF090066FF090066FF090066FF090066FF090066FF090066FF
        090066FF090065FF090065FF090065FF090064FF090060FF08005BFF080054FF06004DFB0600
        42970300231104003B3106004BD3070053FF08005AFF080061FF080064FF090067FF090067FF
        090067FF090067FF090067FF090067FF090067FF090067FF090067FF090067FF090067FF0900
        67FF090067FF090067FF090067FF090067FF090067FF090067FF090067FF090067FF080067FF
        090067FF090067FF080067FF090067FF090067FF080067FF090067FF090067FF080067FF0900
        67FF090067FF080067FF090067FF090067FF080067FF090064FF080061FF08005AFF070053FF
        06004BCF05003B2D0500404F070053F5070059FF080060FF080065FF090067FF090068FF0900
        68FF090068FF090068FF090068FF090068FF090068FF090068FF090068FF090068FF090068FF
        090068FF090068FF090068FF090068FF090068FF090068FF090068FF090068FF090068FF0900
        68FF090068FF090068FF090068FF090068FF090068FF090068FF090068FF090068FF090068FF
        090068FF090068FF090068FF090068FF090068FF090068FF090067FF080064FF080060FF0700
        58FF070053F1050040490600486708005AFF08005EFF080064FF090068FF090069FF09006AFF
        09006AFF09006AFF09006AFF09006AFF09006AFF090069FF09006AFF09006AFF090069FF0900
        6AFF09006AFF090069FF09006AFF09006AFF090069FF09006AFF09006AFF09006AFF080069FF
        09006AFF09006AFF080069FF09006AFF09006AFF080069FF09006AFF09006AFF080069FF0900
        6AFF09006AFF080069FF09006AFF09006AFF080069FF09006AFF090069FF080068FF080064FF
        08005EFF08005AFD0600476106004C6B08015EFF080162FF090167FF09016AFF08016AFF0901
        6BFF09016AFF09016BFF09016BFF09016AFF09016BFF09016BFF09016BFF09016BFF09016BFF
        09016BFF09016BFF09016BFF09016BFF09016BFF09016BFF09016BFF09016BFF09016AFF0901
        6BFF08016BFF09016AFF09016BFF08016BFF09016AFF09016BFF08016BFF09016AFF09016BFF
        08016BFF09016AFF09016BFF08016BFF09016AFF09016BFF08016BFF09016AFF090169FF0801
        67FF080162FF08015EFF06004B6506004E6B070161FF070164FF080169FF08016BFF08016BFF
        08016CFF08016CFF08016CFF08016CFF08016CFF08016CFF08016CFF08016BFF08016CFF0801
        6CFF08016BFF08016CFF08016CFF08016BFF08016CFF08016CFF08016BFF08016CFF08016CFF
        08016CFF08016CFF08016CFF08016CFF08016CFF08016CFF08016CFF08016CFF08016CFF0801
        6CFF08016CFF08016CFF08016CFF08016CFF08016CFF08016CFF08016CFF08016BFF08016BFF
    )

    iconData2 =
    (LTrim Join
        080169FF070164FF070160FF06014E650500506B070163FF070166FF08016AFF08016DFF0801
        6EFF08016EFF08016EFF08016EFF08016EFF08016EFF08016EFF08016EFF08016EFF08016EFF
        08016EFF08016EFF08016EFF08016EFF08016EFF08016EFF08016EFF08016EFF08016EFF0801
        6EFF08016EFF08016EFF08016EFF08016EFF08016EFF08016EFF08016EFF08016EFF08016EFF
        08016EFF08016EFF08016EFF08016EFF08016EFF08016EFF08016EFF08016EFF08016EFF0801
        6DFF08016AFF070166FF060162FF05014F650500516B070164FF070168FF08016CFF08016EFF
        08016FFF0E0771FF26207EFF282280FF140E75FF09026FFF08016EFF08016FFF08016FFF0801
        6FFF08016FFF08016FFF08016FFF08016FFF08016FFF08016FFF08016FFF08016FFF08016FFF
        08016FFF08016FFF08016FFF08016FFF08016FFF08016FFF08016FFF08016FFF08016FFF0801
        6FFF08016FFF08016FFF08016FFF08016FFF08016FFF08016FFF08016FFF08016FFF08016FFF
        08016EFF08016CFF070167FF070164FF050151650500526B070165FF070169FF08016EFF0801
        70FF080170FF5F5C97FFCAC9DCFFD1D0E3FFC3C1DAFFA3A1C8FF706CAAFF2D2884FF0B0571FF
        08016FFF080170FF080170FF080170FF080170FF080170FF080170FF080170FF080170FF0801
        70FF080170FF080170FF080170FF080170FF080170FF080170FF080170FF080170FF080170FF
        080170FF080170FF080170FF080170FF080170FF080170FF080170FF080170FF080170FF0801
        70FF080170FF08016EFF070169FF070165FF050152650500536B060167FF07016BFF07016FFF
        070171FF070171FF757395FFE0E0E1FFFAFAFAFFFFFFFFFFFFFFFFFFFFFFFFFFFCFCFDFFDEDE
        EBFFA09EC6FF534F9AFF2E2986FF150F79FF070172FF070172FF070172FF070172FF070172FF
        070172FF070172FF070172FF070172FF070172FF070172FF070172FF070172FF070172FF0701
        72FF070172FF070172FF070172FF070172FF070172FF070172FF070172FF070172FF070172FF
        070172FF070171FF07016FFF07016BFF060166FF050153650400556B050168FF06016CFF0601
        70FF070173FF060174FF211D74FF717093FFCACACEFFFAFAFAFFFFFFFFFFFEFEFEFFFFFFFFFF
        FFFFFFFFFEFEFEFFF7F6FAFFD1D0E3FF9E9BC6FF615EA4FF2F2A88FF0C0675FF060173FF0701
        73FF060174FF070174FF070174FF060174FF070174FF070174FF060174FF070174FF070174FF
        060174FF070174FF070174FF060174FF070174FF070174FF060174FF070174FF070174FF0601
        74FF070174FF070173FF060171FF06016CFF050168FF040154650400566B050169FF06016DFF
        060172FF070174FF060175FF070175FF120D74FF49467FFFC8C8C8FFF7F7F7FFFEFEFEFFFFFF
        FFFFFEFEFEFFFFFFFFFFFFFFFFFFFEFEFEFFFEFEFEFFEEEDF5FFD4D3E6FFACAACFFF57539FFF
        1A157DFF070174FF070175FF070175FF070175FF070175FF070175FF070175FF070175FF0701
        75FF070175FF070175FF070175FF070175FF070175FF070175FF070175FF070175FF070175FF
        070175FF070175FF070174FF070172FF06016DFF060169FF040155650400576B05016BFF0601
        6FFF070174FF070176FF070177FF070177FF070177FF070176FF353179FFA6A5B3FFEEEEEEFF
        FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFE
        FEFFF4F3F8FFC4C3DDFF7976B3FF464297FF2B2689FF120C7CFF070177FF070177FF070177FF
        060177FF070177FF070177FF060177FF070177FF070177FF060177FF070177FF070177FF0601
        77FF070177FF070177FF060176FF070174FF06016FFF05016BFF040157650400586B05016DFF
        060171FF060176FF060178FF060178FF060178FF060179FF060179FF090477FF332F7CFF9E9D
        AEFFF3F3F3FFFEFEFEFFFEFEFEFFFFFFFFFFFFFFFFFFFEFEFEFFFFFFFFFFFFFFFFFFFEFEFEFF
        FFFFFFFFFFFFFFFFFEFEFEFFFEFEFEFFF0F0F6FFCBCAE1FF9593C3FF6562A9FF2F2B8CFF0702
        78FF060178FF060179FF060179FF060178FF060179FF060179FF060178FF060179FF060179FF
        060178FF060179FF060179FF060178FF060175FF060170FF05016DFF040158650401596B0501
        6EFF050172FF060177FF06017AFF06017AFF06017AFF06017AFF06017AFF06017AFF080479FF
        28247AFFADACB4FFF1F1F1FFFEFEFEFFFFFFFFFFFEFEFEFFFFFFFFFFFFFFFFFFFEFEFEFFFFFF
        FFFFFFFFFFFFFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDFFEFEFF6FFD4D4E7FF
        8B88BEFF2A268BFF06027AFF06017AFF06017AFF06017AFF06017AFF06017AFF06017AFF0601
        7AFF06017AFF06017AFF06017AFF06017AFF060177FF050172FF05016EFF0401586504015B6B
        050270FF050274FF060279FF06027BFF06027CFF06027CFF06027CFF06027CFF06027CFF0602
        7CFF06027CFF221F7AFF8E8DA4FFE4E4E5FFF6F6F7FFE9E9EBFFF9F9F9FFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFFFFFFFFFFFFFFFFFFEFEFEFFFFFF
        FFFFFFFFFFFFEEEDF5FF7F7DB9FF0C087FFF05027CFF06027CFF06027CFF05027CFF06027CFF
        06027CFF05027CFF06027CFF06027CFF05027BFF060279FF050274FF05026FFF04015A650401
        5C6B050272FF050276FF05027AFF05027DFF05027EFF05027DFF06027EFF05027EFF05027DFF
        06027EFF05027EFF06027CFF23207CFF82829EFFCCCCD7FF8D8CAFFFC9C8CFFFFAFAFAFFFFFF
        FFFFFEFEFEFFFFFFFFFFFFFFFFFFFEFEFEFFFFFFFFFFFFFFFFFFFEFEFEFFFFFFFFFFFFFFFFFF
        FEFEFEFFFFFFFFFFFFFFFFFFF7F7FAFF504EA1FF05027DFF05027EFF05027EFF05027DFF0502
        7EFF05027EFF05027DFF05027EFF05027EFF05027DFF05027BFF050275FF050271FF04015B65
        03015D6B040273FF050277FF05027CFF05027FFF05027FFF05027FFF05027FFF05027FFF0502
        7FFF05027FFF05027FFF05027FFF05027EFF18167CFF89899FFF908FB6FF666598FFD1D1D2FF
        F8F8F8FFFEFEFEFFFFFFFFFFFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA1A0CBFF06037FFF05027FFF05027FFF05027FFF
        05027FFF05027FFF05027FFF05027FFF05027FFF05027FFF05027CFF050277FF040273FF0301
        5D6503015F6B040275FF050279FF05027EFF050280FF050281FF050281FF050281FF050281FF
        050281FF050281FF050281FF050281FF050281FF050281FF19177EFF8686A1FFA5A4C5FF615F
        98FFB4B4C0FFF0F0F0FFFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFF9C9BC7FF050280FF050281FF050281FF0502
        81FF050281FF050281FF050281FF050281FF050281FF050280FF05027EFF050279FF040274FF
        03015E650301606B040276FF05027BFF040280FF050282FF050283FF050283FF050283FF0502
        83FF050283FF050283FF050283FF050283FF040283FF050283FF050282FF252381FF9A9AAEFF
        AFAECFFF6B6AA1FFA9A8B9FFF3F3F3FFFEFEFEFFFFFFFFFFFEFEFEFFFFFFFFFFFFFFFFFFFEFE
        FEFFFFFFFFFFFFFFFFFFFEFEFEFFFFFFFFFFFBFBFBFF5A58A5FF050282FF050283FF040283FF
        050283FF050283FF040283FF050283FF050283FF040283FF050282FF050280FF04027AFF0402
        76FF03015F650301616B040278FF05027CFF050281FF040284FF050284FF050284FF050284FF
        050284FF050284FF050284FF050284FF040284FF050284FF050284FF040284FF060383FF312F
        81FFC8C8CBFFBFBEDAFF59589CFFB1B1BAFFEEEEEEFFFEFEFEFFFFFFFFFFFEFEFEFFFEFEFEFF
        FFFFFFFFFEFEFEFFFEFEFEFFFFFFFFFFFEFEFEFFDBDBE6FF6D6BACFF1B198EFF040284FF0502
        84FF050284FF040284FF050284FF050284FF040284FF050284FF050284FF040281FF05027CFF
        040277FF030160650301636B040279FF04027EFF040283FF040285FF040287FF040287FF0402
        87FF040287FF040287FF040287FF040287FF040287FF040287FF040287FF040287FF040287FF
        040286FF53528CFFD3D3D6FFE1E1EEFF54539DFF8383A2FFD7D6DAFFFBFBFBFFFEFEFEFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFF1F1F5FF9897C0FFE0E0E9FF5E5DAEFF040286FF
        040287FF040287FF040287FF040287FF040287FF040287FF040287FF040285FF040283FF0402
        7EFF040279FF030162650301636B04027AFF04027FFF040285FF040287FF040288FF040288FF
        040288FF040288FF040288FF040288FF040288FF040288FF040288FF040288FF040288FF0402
        88FF040288FF131185FF7A7AA0FFE6E6E7FFD0CFE6FF5D5CA4FF636195FFC9C9CCFFF2F2F2FF
        FDFDFDFFFEFEFEFFFFFFFFFFFFFFFFFFFDFDFDFFC3C2DAFFB5B4CEFFECECF3FF5F5EAFFF0402
        88FF040288FF040288FF040288FF040288FF040288FF040288FF040288FF040287FF040285FF
        04027FFF04027BFF030163650301656B04027CFF040281FF040287FF040289FF040289FF0402
        89FF040289FF040289FF040289FF040289FF040289FF040289FF040289FF040289FF040289FF
        040289FF040289FF040289FF232286FFA0A0B2FFF8F8F9FFD3D3E9FF4A48A1FF403F8AFF9A99
        A9FFD8D8D8FFF4F4F4FFFDFDFDFFFEFEFEFFEFEFF4FFA8A7C9FFDCDCE7FFE4E4F1FF4C4BA8FF
        040289FF040289FF040289FF040289FF040289FF040289FF040289FF040289FF040289FF0402
        86FF040280FF04027CFF030164650302666B03037EFF030383FF030388FF03038BFF03038CFF
        03038CFF03038CFF03038CFF03038CFF03038CFF03038CFF03038CFF03038CFF03038CFF0303
        8CFF03038CFF03038CFF03038CFF03038BFF292983FFC4C4C9FFF9F9F9FFECECF5FF3C3BA2FF
        0C0B86FF2E2E82FFB2B2C4FFFBFBFBFFFEFEFEFFC8C8DCFFA1A1C3FFCACAD3FFE2E2E9FF7B7B
        BEFF151492FF03038CFF03038CFF03038CFF03038CFF04038CFF04038CFF03038CFF03038BFF
        030388FF030382FF03037EFF030265650202686B02027FFF030384FF03038AFF03038DFF0303
        8DFF03038DFF03038DFF03038DFF03038DFF03038DFF03038DFF03038DFF02028DFF03038DFF
        03038DFF02028DFF03038DFF03038DFF02028DFF03038CFF595992FFCECED1FFFAFAFAFFC4C4
        E2FF2C2C9DFF2F2F97FFE5E5EBFFFEFEFEFFF3F3F4FF9494BFFF7B7BB3FF515197FF9B9BB7FF
        C9C9D8FF9999CBFF3B3BA4FF0A0A8FFF03038DFF09098EFF2A2A92FF20208EFF02028DFF0303
        8DFF03038AFF020284FF030380FF020267650202696B030381FF030385FF03038BFF03038EFF
        03038FFF03038FFF03038FFF03038FFF03038FFF03038FFF03038FFF02028FFF03038FFF0303
        8FFF02028FFF03038FFF03038FFF02028FFF03038FFF03038FFF0F0F8BFF626295FFD0D0D3FF
        F5F5F8FF8383C4FF9595C1FFFCFCFCFFF9F9F9FFA8A8CBFFB7B7D0FF9D9DBEFF6C6C9CFF7777
        96FF9898ABFFC6C6D1FFD3D3E6FFA3A3D3FF6060B5FF6A6AB7FF7171B5FF414193FF03038EFF
        02028EFF03038BFF030385FF020281FF0202686502026A6B030382FF030387FF03038DFF0303
        8FFF030391FF030391FF030391FF030391FF030391FF030391FF030391FF030391FF030391FF
        030391FF030391FF030391FF030391FF030391FF030391FF030391FF030391FF06068DFF4141
        88FFB1B1BEFFD3D3DCFFE8E8ECFFE4E4E9FF9393BEFF585894FF6C6C9EFF262690FF05058FFF
        03038EFF121287FF3D3D86FF8686A5FFBDBDC9FFDDDDDEFFE4E4E5FFBEBED2FF6565A7FF0303
        8FFF03038FFF03038DFF030387FF030382FF0202696502026B6B020284FF020389FF02038FFF
        020391FF020392FF020392FF020392FF020392FF020392FF020392FF020392FF020392FF0202
        92FF020392FF020392FF020292FF020392FF020392FF020292FF020392FF020392FF020292FF
        030490FF2A2A8AFF5E5E9AFF7C7CA8FF5B5CA2FF1A1A94FF05068EFF030490FF020392FF0203
        92FF020292FF020392FF020391FF0E0F8BFF2D2E8CFF4C4C95FF53549AFF383895FF0D0D91FF
        020292FF020391FF02038FFF020288FF020384FF01026A6501026C6B020385FF02038AFF0203
        90FF020393FF020393FF020393FF020393FF020393FF020393FF020393FF020393FF020293FF
        020393FF020393FF020293FF020393FF020393FF020293FF020393FF020393FF020293FF0203
        93FF020393FF020393FF060790FF0B0C8FFF040591FF020293FF020393FF020393FF020293FF
        020393FF020393FF020293FF020393FF020393FF020293FF020392FF020392FF020293FF0203
        93FF020393FF020293FF020390FF02038AFF020285FF01026B6501026E6B020387FF02038CFF
        020392FF020394FF020395FF020395FF020395FF020395FF020395FF020395FF020395FF0203
        95FF020395FF020395FF020395FF020395FF020395FF020395FF020395FF020395FF020395FF
        020395FF020395FF020395FF020295FF020395FF020395FF020295FF020395FF020395FF0202
        95FF020395FF020395FF020295FF020395FF020395FF020395FF020395FF020395FF020395FF
        020395FF020395FF020294FF020392FF02038CFF020286FF01026D6501026F6B020289FF0203
        8DFF020393FF020396FF020396FF020396FF030497FF030497FF020396FF020397FF020397FF
        020397FF020397FF020397FF020397FF020397FF020397FF020397FF020397FF020397FF0203
        97FF020397FF020397FF020397FF020397FF020397FF020397FF020397FF020397FF020397FF
        020397FF020397FF020397FF020397FF020397FF020397FF020397FF030497FF030497FF0304
        97FF020397FF020396FF020395FF020393FF02038DFF020388FF01026E650102726B02028BFF
        02038FFF020395FF020397FF030499FF040699FF050699FF050699FF040699FF040599FF0304
        98FF020498FF020498FF020498FF020398FF020498FF020498FF020498FF020498FF020498FF
        020498FF020498FF020498FF020498FF020498FF020498FF020498FF020498FF020498FF0204
        98FF020498FF020398FF020498FF020498FF020498FF030498FF040599FF040699FF050699FF
        050699FF040699FF030498FF020397FF020395FF02038FFF02028BFF01027065000276670103
        8FFF010393FF010398FF04069AFF080A9CFF0A0C9DFF0B0D9DFF0B0D9DFF0A0C9DFF090B9DFF
        090B9CFF080A9CFF080A9CFF080A9CFF080A9CFF080A9CFF080A9CFF080A9CFF080A9CFF080A
        9CFF080A9CFF080A9CFF080A9CFF080A9CFF080A9CFF080A9CFF080A9CFF080A9CFF080A9CFF
        080A9CFF080A9CFF080A9CFF080A9CFF080A9CFF080A9CFF090B9CFF090B9DFF0A0C9DFF0B0D
        9DFF0B0D9DFF0A0C9DFF080A9CFF03059AFF010398FF010393FF01028FFD0102756100027B53
        010294F9010398FF02059BFF090B9EFF0E10A0FF0F11A0FF1012A1FF1012A1FF0F11A0FF0F11
        A0FF0E10A0FF0E10A0FF0E10A0FF0E10A0FF0E10A0FF0E10A0FF0E10A0FF0E10A0FF0E10A0FF
        0E10A0FF0E10A0FF0E10A0FF0E10A0FF0E10A0FF0E10A0FF0E10A0FF0E10A0FF0E10A0FF0E10
        A0FF0E10A0FF0E10A0FF0E10A0FF0E10A0FF0E10A0FF0E10A0FF0E10A0FF0F11A0FF0F12A0FF
        1012A1FF1012A1FF0F11A0FF0D0FA0FF080A9EFF02049BFF010398FF010394F700027B4F0204
        8537030698E305089DFF080B9FFF1012A1FF1517A4FF1518A4FF1518A4FF1518A4FF1517A4FF
        1417A3FF1416A3FF1316A3FF1316A3FF1315A3FF1315A3FF1315A3FF1315A3FF1315A3FF1315
        A3FF1315A3FF1315A3FF1315A3FF1315A3FF1315A3FF1315A3FF1315A3FF1315A3FF1315A3FF
        1315A3FF1315A3FF1315A3FF1315A3FF1315A3FF1316A3FF1416A3FF1416A3FF1417A3FF1517
        A4FF1518A4FF1518A4FF1518A4FF1417A4FF0E11A1FF080B9FFF05089DFF030697DF02048733
        0A0D841311149BA11619A4FD1619A5FF1B1EA7FF2023A9FF2023A9FF1F21A9FF1E21A8FF1D1F
        A8FF1C1FA7FF1C1EA7FF1B1DA7FF1B1DA7FF1B1DA7FF1A1DA7FF1B1DA7FF1A1DA7FF1A1DA7FF
        1B1DA7FF1A1DA7FF1A1DA7FF1B1DA7FF1A1DA7FF1B1DA7FF1A1DA7FF1B1DA7FF1B1DA7FF1A1D
        A7FF1B1DA7FF1B1DA7FF1A1DA7FF1B1DA7FF1B1DA7FF1B1DA7FF1B1EA7FF1C1EA7FF1C1FA7FF
        1D1FA8FF1E21A8FF1F21A8FF2022A9FF1F22A9FF1A1CA7FF1619A5FF1618A4FD11149B9B0A0C
        7F1108093C031B1D9A4D2326A9E32628ACFF272AADFF2D30AFFF2E31AFFF2C2FAFFF2A2DAEFF
        282BADFF282BADFF272AADFF262AACFF2729ADFF2729ADFF2629ACFF2729ADFF2729ADFF2629
        ACFF2729ADFF2729ADFF2629ACFF2729ADFF2729ADFF2729ADFF2729ACFF2729ADFF2729ADFF
        2729ACFF2729ADFF2729ADFF2729ACFF2729ADFF2729ADFF2729ACFF272AADFF272AADFF282B
        ADFF292BADFF2A2DAEFF2C2FAFFF2D30AFFF2C2EAFFF2729ADFF2528ACFF2326A9E11B1D9949
        06072C03FFFFFF011D1E860B2C2FA67F3538B3FF3638B3FF3B3EB5FF3F42B7FF3E41B6FF3B3E
        B5FF393DB5FF383CB4FF383BB4FF383BB4FF383BB4FF383BB4FF383BB4FF383BB4FF383BB4FF
        383BB4FF383BB4FF383BB4FF383BB4FF383BB4FF383BB4FF383BB4FF383BB4FF383BB4FF383B
        B4FF383BB4FF383BB4FF383BB4FF383BB4FF383BB4FF383BB4FF383BB4FF383BB4FF383BB4FF
        393CB4FF393DB5FF3B3EB5FF3E41B6FF3E41B7FF393CB5FF3538B3FF3538B3FF2C2EA5791C1E
        820BFFFFFF01FFFFFF01FFFFFF01121339033F42B081474AB9E74B4DBBFD5254BFFF5659C0FF
        5759C0FF5659C0FF5558C0FF5558C0FF5558C0FF5558C0FF5558C0FF5558C0FF5558C0FF5558
        C0FF5558C0FF5558C0FF5558C0FF5558C0FF5558C0FF5558C0FF5558C0FF5558C0FF5558C0FF
        5558C0FF5558C0FF5558C0FF5558C0FF5558C0FF5558C0FF5558C0FF5558C0FF5558C0FF5558
        C0FF5658C0FF5659C0FF5759C0FF5558C0FF5153BEFF494CBCFD4749B9E53E41AF7D0D0E2903
        FFFFFF01FFFFFF01FFFFFF01FFFFFF01FFFFFF013F42A00D4B4EB5535356BCA9595CC1ED5F61
        C4FD6365C5FF6769C7FF696BC7FF6A6CC8FF6B6DC8FF6B6EC8FF6B6EC9FF6B6EC9FF6B6EC8FF
        6B6EC9FF6B6EC9FF6B6EC8FF6B6EC9FF6B6EC9FF6B6EC8FF6B6EC9FF6B6EC9FF6B6EC8FF6B6E
        C9FF6B6EC9FF6B6EC8FF6B6EC9FF6B6EC9FF6B6EC8FF6B6EC9FF6B6EC9FF6B6DC8FF6B6DC8FF
        6A6CC8FF686BC7FF6669C7FF6265C5FF5E60C3FD585BC0EB5355BCA74B4EB4513E419D0DFFFF
        FF01FFFFFF01FFFFFF01FFFFFF01FFFFFF01FFFFFF01FFFFFF013C3F89035255B417595CBB3D
        5D5FBD616062BF7B6365C1836466C1836668C2836769C2836769C283676AC283676AC283676A
        C283676AC283676AC283676AC283676AC283676AC283676AC283676AC283676AC283676AC283
        676AC283676AC283676AC283676AC283676AC283676AC283676AC2836769C2836769C2836769
        C2836668C2836466C1836365C1836062BF7B5D5FBD61595CBA3D5254B4173B3D8403FFFFFF01
        FFFFFF01FFFFFF01FFFFFF01000000000000FFFF000000000000FFFF000000000000FFFF0000
        00000000FFFF000000000000FFFF000000000000FFFF000000000000FFFF000000000000FFFF
        000000000000FFFF000000000000FFFF000000000000FFFF000000000000FFFF000000000000
        FFFF000000000000FFFF000000000000FFFF000000000000FFFF000000000000FFFF00000000
        0000FFFF000000000000FFFF000000000000FFFF000000000000FFFF000000000000FFFF0000
        00000000FFFF000000000000FFFF000000000000FFFF000000000000FFFF000000000000FFFF
        000000000000FFFF000000000000FFFF000000000000FFFF000000000000FFFF000000000000
        FFFF000000000000FFFF000000000000FFFF000000000000FFFF000000000000FFFF00000000
        0000FFFF000000000000FFFF000000000000FFFF000000000000FFFF000000000000FFFF0000
        00000000FFFF000000000000FFFF000000000000FFFF000000000000FFFF000000000000FFFF
        000000000000FFFF000000000000FFFF28000000400000008000000001002000000000000042
        0000000000000000000000000000000000000000000300000005000000050000000700000009
        0000000D0000000F00000013000000170000001B0000001F00000023000000270000002B0000
        002F00000033000000370000003B0000003F000000410000004500000047000000490000004D
        0000004F0000004F000000510000005100000053000000530000005300000053000000530000
        00530000005300000051000000510000004F0000004F0000004D0000004B0000004900000047
        00000043000000410000003D0000003900000035000000310000002D00000029000000230000
        001F0000001B0000001700000013000000110000000D00000009000000070000000500000005
        00000003FFFFFF01000000090000000D00000013000000190000002100000029000000310000
        003B00000047000000530000005F0000006B000000730000007B00000083000000890000008F
        00000095000000990000009D000000A1000000A5000000A7000000A9000000AB000000AD0000
        00AF000000AF000000B1000000B1000000B1000000B1000000B1000000B1000000B1000000B1
        000000AF000000AF000000AD000000AB000000A9000000A7000000A5000000A10000009D0000
    )

    iconData3 =
    (LTrim Join
        0099000000930000008F00000089000000810000007900000071000000670000005B0000004F
        00000041000000370000002D000000250000001D00000015000000110000000B000000090000
        001100000019000000230000002F0000003B0000004B0000005B0000007500000497020016BB
        030022D3040027DD040028E1040027E5040027E7040026E9040026E9040026EB040026ED0400
        26ED040025EF040025EF040025EF040025EF040025F1040025F1040025F1040025F1040025F1
        040025F1040025F1040025F1040025F1040025F1040025F1040025F1040025F1040025F10400
        25F1040025F1040025EF040025EF040025EF040025EF040026ED040026ED040026EB040026EB
        040026E9040027E7040027E5040028E1040027DD030022D1020016B900000495000000710000
        005700000045000000370000002900000021000000170000000F000000130000001B00000027
        0000003500000045000000610200109F05002FDF070042FB070046FF070047FF070047FF0700
        47FF070047FF070048FF070048FF070048FF070048FF070048FF070048FF070048FF070048FF
        070048FF070048FF070048FF070048FF070048FF070048FF070048FF070048FF070048FF0700
        48FF070048FF070048FF070048FF070048FF070048FF070048FF070048FF070048FF070048FF
        070048FF070048FF070048FF070048FF070048FF070048FF070048FF070048FF070048FF0700
        47FF070047FF070047FF070047FF070046FF070042FB05002FDD01000F9B0000005F00000041
        00000033000000270000001B000000130000000B0000001100000017000000230000024D0400
        2CBF070045FD070047FF070049FF07004AFF08004CFF08004DFF08004DFF08004EFF08004EFF
        08004EFF08004EFF08004EFF08004EFF08004EFF08004EFF08004EFF08004EFF08004EFF0800
        4EFF08004EFF08004EFF08004EFF08004EFF08004EFF08004EFF08004EFF08004EFF08004EFF
        08004EFF08004EFF08004EFF08004EFF08004EFF08004EFF08004EFF08004EFF08004EFF0800
        4EFF08004EFF08004EFF08004EFF08004EFF08004EFF08004EFF08004EFF08004DFF08004DFF
        08004CFF07004AFF070049FF070047FF070044FB04002BBB0000014B00000025000000190000
        00110000000B0000000300000005000000090100093506003ACD070048FF07004AFF08004DFF
        080050FF080052FF080054FF090055FF090056FF090056FF090056FF090056FF090056FF0900
        56FF090056FF090056FF090056FF090056FF090056FF090056FF090056FF090056FF090056FF
        090056FF090056FF090056FF090056FF090056FF090056FF090056FF090056FF090056FF0900
        56FF090056FF090056FF090056FF090056FF090056FF090056FF090056FF090056FF090056FF
        090056FF090056FF090056FF090056FF090056FF090056FF090055FF080054FF080052FF0800
        50FF08004DFF07004AFF070048FF060039C701000733000000090000000500000003FFFFFF01
        FFFFFF010000021B06003CC1070049FF08004CFF080050FF080054FF090057FF09005AFF0900
        5BFF09005CFF09005DFF09005DFF09005DFF09005DFF09005DFF09005DFF09005DFF09005DFF
        09005DFF09005DFF09005DFF09005DFF09005DFF09005DFF09005DFF09005DFF09005DFF0900
        5DFF09005DFF09005DFF09005DFF09005DFF09005DFF09005DFF09005DFF09005DFF09005DFF
        09005DFF09005DFF09005DFF09005DFF09005DFF09005DFF09005DFF09005DFF09005DFF0900
        5DFF09005DFF09005DFF09005DFF09005CFF09005BFF09005AFF090057FF080054FF080050FF
        08004CFF070049FF06003AB900000119FFFFFF01FFFFFF01FFFFFF0100000007050032870700
        4AFF08004DFF080051FF090056FF09005BFF09005EFF090060FF0A0061FF0A0062FF0A0062FF
        0A0062FF0A0062FF0A0062FF0A0062FF0A0062FF0A0062FF0A0062FF0A0062FF0A0062FF0A00
        62FF0A0062FF0A0062FF0A0062FF0A0062FF0A0062FF0A0062FF0A0062FF0A0062FF0A0062FF
        0A0062FF0A0062FF0A0062FF0A0062FF0A0062FF0A0062FF0A0062FF0A0062FF0A0062FF0A00
        62FF0A0062FF0A0062FF0A0062FF0A0062FF0A0062FF0A0062FF0A0062FF0A0062FF0A0062FF
        0A0062FF0A0062FF0A0061FF090060FF09005DFF09005AFF090056FF080051FF08004DFF0700
        4AFF0500307F00000007FFFFFF01FFFFFF010200132D070049EF07004EFF080052FF080058FF
        09005DFF090060FF090063FF0A0064FF0A0065FF0A0065FF0A0065FF0A0066FF0A0066FF0A00
        66FF0A0066FF0A0066FF0A0066FF0A0066FF0A0066FF0A0066FF0A0066FF0A0066FF0A0066FF
        0A0066FF0A0066FF0A0066FF0A0066FF0A0066FF0A0066FF0A0066FF0A0066FF0A0066FF0A00
        66FF0A0066FF0A0066FF0A0066FF0A0066FF0A0066FF0A0066FF0A0066FF0A0066FF0A0066FF
        0A0066FF0A0066FF0A0066FF0A0066FF0A0066FF0A0066FF0A0066FF0A0065FF0A0065FF0A00
        65FF0A0064FF090063FF090060FF09005CFF080058FF080052FF07004EFF070048EB01000F27
        FFFFFF010000000305003A8507004FFF070052FF080057FF08005DFF090061FF090064FF0900
        66FF090067FF090067FF090067FF090067FF090067FF090067FF090067FF090067FF090067FF
        090067FF090067FF090067FF090067FF090067FF090067FF090067FF090067FF090067FF0900
        67FF090067FF090067FF090067FF090067FF090067FF090067FF090067FF090067FF090067FF
        090067FF090067FF090067FF090067FF090067FF090067FF090067FF090067FF090067FF0900
        67FF090067FF090067FF090067FF090067FF090067FF090067FF090067FF090067FF090066FF
        090064FF090061FF08005DFF080057FF070052FF07004FFF0500387D000000030000000D0600
        49CD070053FF080057FF08005CFF080061FF090065FF090067FF090068FF090068FF090068FF
        090068FF090068FF090068FF090068FF090068FF090068FF090068FF090068FF090068FF0900
        68FF090068FF090068FF090068FF090068FF090068FF090068FF090068FF090068FF090068FF
        090068FF090068FF090068FF090068FF090068FF090068FF090068FF090068FF090068FF0900
        68FF090068FF090068FF090068FF090068FF090068FF090068FF090068FF090068FF090068FF
        090068FF090068FF090068FF090068FF090068FF090068FF090068FF090066FF090065FF0800
        61FF08005CFF080057FF070053FF060048C50000000B01000F1F070053F3080057FF08005BFF
        080060FF090065FF090067FF090068FF090069FF090069FF090069FF090069FF090069FF0900
        69FF090069FF090069FF090069FF090069FF090069FF090069FF090069FF090069FF090069FF
        090069FF090069FF090069FF090069FF090069FF090069FF090069FF090069FF090069FF0900
        69FF090069FF090069FF090069FF090069FF090069FF090069FF090069FF090069FF090069FF
        090069FF090069FF090069FF090069FF090069FF090069FF090069FF090069FF090069FF0900
        69FF090069FF090069FF090069FF090069FF090068FF090067FF090064FF080060FF08005BFF
        080057FF070052EF0100081904002A33080058FD08005BFF08005FFF080063FF090067FF0900
        69FF09006AFF09006AFF09006AFF09006AFF09006AFF09006AFF09006AFF09006AFF09006AFF
        09006AFF09006AFF09006AFF09006AFF09006AFF09006AFF09006AFF09006AFF09006AFF0900
        6AFF09006AFF09006AFF09006AFF09006AFF09006AFF09006AFF09006AFF09006AFF09006AFF
        09006AFF09006AFF09006AFF09006AFF09006AFF09006AFF09006AFF09006AFF09006AFF0900
        6AFF09006AFF09006AFF09006AFF09006AFF09006AFF09006AFF09006AFF09006AFF09006AFF
        09006AFF09006AFF09006AFF090069FF090067FF080063FF08005FFF08005BFF080058FB0300
        252B0500333B08015CFF08015EFF080162FF090166FF090169FF09016AFF09016AFF09016AFF
        09016AFF09016AFF09016AFF09016AFF09016AFF09016AFF09016AFF09016AFF09016AFF0901
        6AFF09016AFF09016AFF09016AFF09016AFF09016AFF09016AFF09016AFF09016AFF09016AFF
        09016AFF09016AFF09016AFF09016AFF09016AFF09016AFF09016AFF09016AFF09016AFF0901
        6AFF09016AFF09016AFF09016AFF09016AFF09016AFF09016AFF09016AFF09016AFF09016AFF
        09016AFF09016AFF09016AFF09016AFF09016AFF09016AFF09016AFF09016AFF09016AFF0901
        6AFF09016AFF090168FF090166FF080162FF08015EFF08015BFF04002E310500353B08015EFF
        080161FF080164FF090168FF09016AFF09016BFF09016CFF09016CFF09016CFF09016CFF0901
        6CFF09016CFF09016CFF09016CFF09016CFF09016CFF09016CFF09016CFF09016CFF09016CFF
        09016CFF09016CFF09016CFF09016CFF09016CFF09016CFF09016CFF09016CFF09016CFF0901
        6CFF09016CFF09016CFF09016CFF09016CFF09016CFF09016CFF09016CFF09016CFF09016CFF
        09016CFF09016CFF09016CFF09016CFF09016CFF09016CFF09016CFF09016CFF09016CFF0901
        6CFF09016CFF09016CFF09016CFF09016CFF09016CFF09016CFF09016CFF09016BFF09016AFF
        090168FF080164FF080161FF08015EFF04012F310400363B070160FF070163FF080166FF0801
        69FF08016BFF08016CFF08016CFF08016CFF08016CFF08016CFF08016CFF08016CFF08016CFF
        08016CFF08016CFF08016CFF08016CFF08016CFF08016CFF08016CFF08016CFF08016CFF0801
        6CFF08016CFF08016CFF08016CFF08016CFF08016CFF08016CFF08016CFF08016CFF08016CFF
        08016CFF08016CFF08016CFF08016CFF08016CFF08016CFF08016CFF08016CFF08016CFF0801
        6CFF08016CFF08016CFF08016CFF08016CFF08016CFF08016CFF08016CFF08016CFF08016CFF
        08016CFF08016CFF08016CFF08016CFF08016CFF08016CFF08016BFF080169FF080166FF0701
        62FF070160FF040130310400373B070162FF070164FF080167FF08016AFF08016CFF08016EFF
        08016EFF08016EFF08016EFF08016EFF08016EFF08016EFF08016EFF08016EFF08016EFF0801
        6EFF08016EFF08016EFF08016EFF08016EFF08016EFF08016EFF08016EFF08016EFF08016EFF
        08016EFF08016EFF08016EFF08016EFF08016EFF08016EFF08016EFF08016EFF08016EFF0801
        6EFF08016EFF08016EFF08016EFF08016EFF08016EFF08016EFF08016EFF08016EFF08016EFF
        08016EFF08016EFF08016EFF08016EFF08016EFF08016EFF08016EFF08016EFF08016EFF0801
        6EFF08016EFF08016EFF08016EFF08016CFF08016AFF080167FF070164FF070161FF04013031
        0400373B070163FF070165FF080168FF08016CFF08016DFF08016FFF08016FFF08016FFF0801
        6EFF08016EFF08016EFF08016FFF08016FFF08016FFF08016FFF08016FFF08016FFF08016FFF
        08016FFF08016FFF08016FFF08016FFF08016FFF08016FFF08016FFF08016FFF08016FFF0801
        6FFF08016FFF08016FFF08016FFF08016FFF08016FFF08016FFF08016FFF08016FFF08016FFF
        08016FFF08016FFF08016FFF08016FFF08016FFF08016FFF08016FFF08016FFF08016FFF0801
        6FFF08016FFF08016FFF08016FFF08016FFF08016FFF08016FFF08016FFF08016FFF08016FFF
        08016FFF08016DFF08016CFF080168FF070165FF070162FF040131310400383B070164FF0701
        66FF08016AFF08016DFF08016FFF080170FF080170FF09026FFF363186FF545098FF464190FF
        292380FF0D0770FF08016EFF08016FFF08016FFF080170FF080170FF080170FF080170FF0801
        70FF080170FF080170FF080170FF080170FF080170FF080170FF080170FF080170FF080170FF
        080170FF080170FF080170FF080170FF080170FF080170FF080170FF080170FF080170FF0801
        70FF080170FF080170FF080170FF080170FF080170FF080170FF080170FF080170FF080170FF
        080170FF080170FF080170FF080170FF080170FF080170FF080170FF080170FF08016FFF0801
        6CFF080169FF070166FF070164FF040132310400393B070165FF070167FF08016BFF08016EFF
        080170FF080171FF080170FF514E8AFFEFEFEFFFFFFFFFFFFFFFFFFFFDFDFDFFECECF3FFC1BF
        D9FF8481B6FF484493FF120C74FF08016FFF080170FF080171FF080171FF080171FF080171FF
        080171FF080171FF080171FF080171FF080171FF080171FF080171FF080171FF080171FF0801
        71FF080171FF080171FF080171FF080171FF080171FF080171FF080171FF080171FF080171FF
        080171FF080171FF080171FF080171FF080171FF080171FF080171FF080171FF080171FF0801
        71FF080171FF080171FF080171FF080171FF080171FF080170FF08016EFF08016AFF070167FF
        070165FF040132310400393B070166FF070168FF08016CFF08016FFF080171FF080172FF0801
        71FF6B698AFFE5E5E5FFFDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        F2F2F7FFB6B4D3FF706CAAFF282281FF080170FF080171FF080172FF080172FF080172FF0801
        72FF080172FF080172FF080172FF080172FF080172FF080172FF080172FF080172FF080172FF
        080172FF080172FF080172FF080172FF080172FF080172FF080172FF080172FF080172FF0801
        72FF080172FF080172FF080172FF080172FF080172FF080172FF080172FF080172FF080172FF
        080172FF080172FF080172FF080171FF08016FFF08016CFF070168FF070165FF040133310300
        3A3B060167FF060169FF07016DFF070170FF070172FF070173FF070173FF211D6DFF868690FF
        D6D6D6FFF9F9F9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFBFBFCFFCBCAE0FF7B78B1FF2C2785FF080272FF070173FF070173FF070173FF070173FF
        070173FF070173FF070173FF070173FF070173FF070173FF070173FF070173FF070173FF0701
        73FF070173FF070173FF070173FF070173FF070173FF070173FF070173FF070173FF070173FF
        070173FF070173FF070173FF070173FF070173FF070173FF070173FF070173FF070173FF0701
        73FF070172FF070170FF07016DFF060169FF060167FF0301333103003B3B060168FF06016AFF
        07016EFF070171FF070173FF070175FF070175FF070174FF0E096FFF5D5C7AFFBEBEBEFFF2F2
        F2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFCFCFDFFD0CFE3FF807DB5FF302B88FF070173FF070174FF070174FF070175FF0701
        75FF070175FF070175FF070175FF070175FF070175FF070175FF070175FF070175FF070175FF
        070175FF070175FF070175FF070175FF070175FF070175FF070175FF070175FF070175FF0701
        75FF070175FF070175FF070175FF070175FF070175FF070175FF070175FF070173FF070171FF
        07016EFF06016AFF060168FF0301343103003B3B060169FF06016BFF07016FFF070172FF0701
        74FF070176FF070176FF070176FF070175FF070173FF373470FFA8A8A9FFECECECFFFEFEFEFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFEFEFEFFD7D6E7FF8683B9FF37338DFF0B0575FF070174FF070175FF070176FF
        070176FF070176FF070176FF070176FF070176FF070176FF070176FF070176FF070176FF0701
        76FF070176FF070176FF070176FF070176FF070176FF070176FF070176FF070176FF070176FF
        070176FF070176FF070176FF070176FF070176FF070174FF070172FF07016FFF06016BFF0601
        69FF0301353103003C3B06016AFF06016DFF070170FF070174FF070176FF070177FF070177FF
        070177FF070177FF070177FF070176FF25216FFF9B9A9FFFE8E8E8FFFEFEFEFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFEFEFEFFE3E2EEFFA19FC9FF5D59A3FF1D1880FF080275FF070176FF0701
        77FF070177FF070177FF070177FF070177FF070177FF070177FF070177FF070177FF070177FF
        070177FF070177FF070177FF070177FF070177FF070177FF070177FF070177FF070177FF0701
        77FF070177FF070177FF070176FF070173FF070170FF06016DFF06016AFF0301353103003C3B
        06016BFF06016EFF070171FF070175FF070177FF070178FF070178FF070178FF070178FF0701
        78FF070178FF070177FF1E1970FF919198FFE5E5E5FFFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFAFAFBFFCBCAE0FF8784BAFF403B94FF0C0678FF070177FF
        070178FF070178FF070178FF070178FF070178FF070178FF070178FF070178FF070178FF0701
        78FF070178FF070178FF070178FF070178FF070178FF070178FF070178FF070178FF070178FF
        070177FF070175FF070171FF06016EFF06016BFF0301363103003D3B05016DFF05016FFF0601
        73FF060176FF060178FF06017AFF06017AFF06017AFF06017AFF06017AFF06017AFF06017AFF
        060179FF181471FF898993FFE1E1E1FFFDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFE8E8F1FF9B99C6FF423F96FF090479FF0601
        79FF06017AFF06017AFF06017AFF06017AFF06017AFF06017AFF06017AFF06017AFF06017AFF
        06017AFF06017AFF06017AFF06017AFF06017AFF06017AFF06017AFF060178FF060176FF0601
        72FF05016FFF05016CFF0301363103013E3B05026DFF050270FF060274FF060277FF06027AFF
        06027BFF06027BFF06027BFF06027BFF06027BFF06027BFF06027BFF06027BFF06027AFF1511
        73FF83828FFFDEDEDEFFFDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFD3D2E5FF6360A8FF0B077BFF06027AFF
        06027BFF06027BFF06027BFF06027BFF06027BFF06027BFF06027BFF06027BFF06027BFF0602
        7BFF06027BFF06027BFF06027BFF06027BFF06027AFF060277FF060273FF050270FF05026DFF
        0301363103013F3B05026FFF050271FF060275FF060279FF06027BFF06027CFF06027CFF0602
        7CFF06027CFF06027CFF06027CFF06027CFF06027CFF06027CFF06027CFF110E75FF7A798AFF
        D9D9D9FFFBFBFBFFFEFEFEFFF8F8F8FFFAFAFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD2D1E5FF322F90FF06027CFF06027CFF0602
        7CFF06027CFF06027CFF06027CFF06027CFF06027CFF06027CFF06027CFF06027CFF06027CFF
        06027CFF06027CFF06027BFF060279FF060275FF050271FF05026EFF0301373103013F3B0502
        70FF050273FF060277FF06027AFF06027CFF06027DFF06027DFF06027DFF06027DFF06027DFF
        06027DFF06027DFF06027DFF06027DFF06027DFF06027DFF0E0A76FF6E6D84FFD2D2D2FFF8F8
        F8FFAAA9BEFFCCCCCCFFF6F6F6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFEBEBF3FF2A278DFF06027DFF06027DFF06027DFF06027DFF
        06027DFF06027DFF06027DFF06027DFF06027DFF06027DFF06027DFF06027DFF06027DFF0602
        7CFF06027AFF060276FF050273FF05026FFF030138310301403B050271FF050274FF060278FF
        06027BFF06027DFF06027FFF06027FFF06027FFF06027FFF06027FFF06027FFF06027FFF0602
        7FFF06027FFF06027FFF06027FFF06027EFF0A0779FF626280FFCECECEFF6A68ABFF555388FF
        C2C2C2FFF3F3F3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFAAA9CFFF06027DFF06027FFF06027FFF06027FFF06027FFF06027FFF0602
        7FFF06027FFF06027FFF06027FFF06027FFF06027FFF06027FFF06027DFF06027BFF060277FF
        050274FF050271FF030138310201403B040272FF050275FF050279FF05027CFF05027FFF0502
        80FF050280FF050280FF050280FF050280FF050280FF050280FF050280FF050280FF050280FF
        050280FF050280FF050280FF08057BFF5F5F7FFFCDCDCEFF7574B3FF454484FFB8B8B9FFEFEF
        EFFFFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE4E4
        EDFF08057FFF050280FF050280FF050280FF050280FF050280FF050280FF050280FF050280FF
        050280FF050280FF050280FF050280FF05027FFF05027CFF050279FF050275FF040272FF0201
        39310201413B040274FF050276FF05027AFF05027DFF050280FF050281FF050281FF050281FF
    )

    iconData4 =
    (LTrim Join
        050281FF050281FF050281FF050281FF050281FF050281FF050281FF050281FF050281FF0502
        81FF050281FF09067CFF676783FFD5D5D5FF8786BEFF393782FFB0AFB2FFEBEBEBFFFEFEFEFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDDDDE7FF070480FF050281FF
        050281FF050281FF050281FF050281FF050281FF050281FF050281FF050281FF050281FF0502
        81FF050281FF050280FF05027DFF05027AFF050276FF040273FF020139310201423B040275FF
        050277FF05027BFF05027FFF050281FF050282FF050283FF050283FF050283FF050283FF0502
        83FF050283FF050283FF050283FF050283FF050283FF050283FF050283FF050283FF050282FF
        0B087CFF76768AFFE0E0E0FF9D9CCAFF2F2E82FFA4A4AAFFE6E6E6FFFEFEFEFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFA2A1C6FF050281FF050283FF050283FF050283FF0502
        83FF050283FF050283FF050283FF050283FF050283FF050283FF050283FF050282FF050281FF
        05027FFF05027BFF050277FF040274FF02013A310201423B040276FF050279FF05027DFF0502
        80FF050282FF050284FF050284FF050284FF050284FF050284FF050284FF050284FF050284FF
        050284FF050284FF050284FF050284FF050284FF050284FF050284FF050283FF110F7BFF9090
        99FFECECECFFB0AFD5FF2A2884FF9998A3FFE1E1E1FFFDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFF7F7F7FF4D4B9EFF050283FF050284FF050284FF050284FF050284FF050284FF050284FF
        050284FF050284FF050284FF050284FF050284FF050284FF050282FF050280FF05027CFF0502
        79FF040276FF02013B310201433B040277FF05027AFF05027EFF050281FF050284FF050285FF
        050285FF050285FF050285FF050285FF050285FF050285FF050285FF050285FF050285FF0502
        85FF050285FF050285FF050285FF050285FF050285FF050285FF24227AFFB0B0B2FFF6F6F6FF
        C0BFDEFF272687FF8C8C9CFFD8D8D8FFFAFAFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFC3C2D7FF9291BBFF
        42409EFF050285FF050285FF050285FF050285FF050285FF050285FF050285FF050285FF0502
        85FF050285FF050285FF050285FF050284FF050281FF05027EFF05027AFF040276FF02013B31
        0201443B040278FF04027BFF04027FFF040283FF040285FF040286FF040287FF040287FF0402
        87FF040287FF040287FF040287FF040287FF040287FF040287FF040287FF040287FF040287FF
        040287FF040287FF040287FF040287FF040285FF43427CFFCACACAFFFBFBFBFFCFCFE6FF2625
        8BFF6F6F8EFFC9C9C9FFF6F6F6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5F5F5FF7574AEFFEAEAEBFFB3B3D6FF040285FF0402
        87FF040287FF040287FF040287FF040287FF040287FF040287FF040287FF040287FF040287FF
        040286FF040285FF040283FF04027FFF04027BFF040278FF02013C310201443B040279FF0402
        7CFF040280FF040284FF040286FF040288FF040288FF040288FF040288FF040288FF040288FF
        040288FF040288FF040288FF040288FF040288FF040288FF040288FF040288FF040288FF0402
        88FF040288FF040288FF060484FF6C6B87FFDFDFDFFFFEFEFEFFD6D6E9FF24238FFF4E4D82FF
        B6B5B6FFEDEDEDFFFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFEFEFEFFB5B4CFFF9C9BC0FFFBFBFBFFC9C9DFFF040286FF040288FF040288FF040288FF
        040288FF040288FF040288FF040288FF040288FF040288FF040288FF040287FF040286FF0402
        84FF040280FF04027CFF040279FF02013D310201453B04027AFF04027DFF040282FF040285FF
        040288FF040289FF040289FF040289FF040289FF040289FF040289FF040289FF040289FF0402
        89FF040289FF040289FF040289FF040289FF040289FF040289FF040289FF040289FF040289FF
        040289FF0F0E80FF92929BFFEDEDEDFFFFFFFFFFDDDDEDFF272595FF2B2A7CFF919198FFD7D7
        D7FFF7F7F7FFFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3F3F4FF6665A8FF
        E9E9EAFFFFFFFFFFADADD1FF040288FF040289FF040289FF040289FF040289FF040289FF0402
        89FF040289FF040289FF040289FF040289FF040289FF040288FF040285FF040281FF04027DFF
        04027AFF02013D310201463B04027CFF04027EFF040283FF040287FF040289FF04028AFF0402
        8AFF04028AFF04028AFF04028AFF04028AFF04028AFF04028AFF04028AFF04028AFF04028AFF
        04028AFF04028AFF04028AFF04028AFF04028AFF04028AFF04028AFF04028AFF04028AFF2524
        7DFFB2B2B4FFF7F7F7FFFFFFFFFFDFDFEFFF272596FF0E0C81FF56557FFFABABACFFD8D8D8FF
        EEEEEEFFFCFCFCFFFFFFFFFFFFFFFFFFFEFEFEFFB3B2D0FF9B9BC0FFFBFBFBFFFFFFFFFF8E8D
        C5FF040289FF04028AFF04028AFF04028AFF04028AFF04028AFF04028AFF04028AFF04028AFF
        04028AFF04028AFF04028AFF040289FF040286FF040282FF04027EFF04027BFF02013D310202
        463B04037DFF040380FF040384FF040388FF04038AFF04038BFF04038CFF04038CFF04038CFF
        04038CFF04038CFF04038CFF04038CFF04038CFF04038CFF04038CFF04038CFF04038CFF0403
        8CFF04038CFF04038CFF04038CFF04038CFF04038CFF04038CFF04038AFF47477EFFCDCDCDFF
        FCFCFCFFFFFFFFFFDEDEEEFF212096FF040389FF16157FFF464680FF8E8EA9FFF5F5F5FFFFFF
        FFFFFFFFFFFFF5F5F5FF7170AFFFDFDFE0FFEAEAEAFFFAFAFAFFBAB9DCFF06058AFF04038BFF
        04038CFF04038CFF04038CFF04038CFF04038CFF04038CFF04038CFF04038CFF04038CFF0403
        8BFF04038AFF040388FF040383FF040380FF04037CFF02023E310202473B03037EFF030381FF
        030385FF030389FF03038CFF03038DFF03038DFF03038DFF03038DFF03038DFF03038DFF0303
        8DFF03038DFF03038DFF03038DFF03038DFF03038DFF03038DFF03038DFF03038DFF03038DFF
        03038DFF03038DFF03038DFF03038DFF03038DFF050589FF6D6D88FFDBDBDBFFFDFDFDFFFFFF
        FFFFD3D3E9FF131391FF03038CFF0F0F8CFFC4C4D4FFFDFDFDFFFFFFFFFFFCFCFCFFABABCBFF
        9F9FC0FF8080ADFF70708FFFC3C3C3FFEBEBEBFFB4B4D8FF242498FF03038CFF03038DFF0303
        8DFF03038DFF03038DFF05058CFF07078CFF03038CFF03038DFF03038DFF03038CFF030389FF
        030385FF030381FF03037EFF02023F310202483B03037FFF030382FF030386FF03038AFF0303
        8DFF03038EFF03038EFF03038EFF03038EFF03038EFF03038EFF03038EFF03038EFF03038EFF
        03038EFF03038EFF03038EFF03038EFF03038EFF03038EFF03038EFF03038EFF03038EFF0303
        8EFF03038EFF03038EFF03038EFF0D0D85FF808090FFE0E0E0FFFDFDFDFFFFFFFFFF9898CDFF
        03038CFF6F6FAAFFF7F7F7FFFFFFFFFFFEFEFEFFE3E3E7FF6E6EAFFFBABAD0FF14148FFF3939
        9BFF58589BFFA1A1BAFFE6E6E6FFECECF1FF9090C9FF212198FF03038DFF03038EFF03038DFF
        333397FF6B6B9AFF2D2D8EFF03038EFF03038EFF03038DFF03038AFF030386FF030382FF0303
        7FFF020240310202483B030380FF030383FF030387FF03038BFF03038EFF03038FFF030390FF
        030390FF030390FF030390FF030390FF030390FF030390FF030390FF030390FF030390FF0303
        90FF030390FF030390FF030390FF030390FF030390FF030390FF030390FF030390FF030390FF
        030390FF03038FFF111185FF818190FFDBDBDBFFFBFBFBFFF8F8FBFF34349EFFD4D4DBFFFEFE
        FEFFFFFFFFFFF0F0F0FF7474B1FFCFCFDBFFB9B9D3FFA6A6B4FF747497FF787891FF858597FF
        9090A8FFC9C9D3FFF2F2F2FFF6F6F9FFB3B3DAFF6F6FBBFF6F6FBAFFD6D6E5FF252598FF4D4D
        93FF04048EFF03038FFF03038EFF03038BFF030387FF030383FF030380FF020240310202493B
        030381FF030384FF030388FF03038CFF03038FFF030390FF030391FF030391FF030391FF0303
        91FF030391FF030391FF030391FF030391FF030391FF030391FF030391FF030391FF030391FF
        030391FF030391FF030391FF030391FF030391FF030391FF030391FF030391FF030391FF0303
        90FF0D0D87FF6D6D87FFC7C7C7FFF1F1F1FFD1D1E7FFFBFBFBFFFDFDFDFFEBEBEBFF7D7DACFF
        707091FFA2A2AAFF575794FF0E0E8BFF03038FFF03038EFF080889FF272780FF5F5F85FF9D9D
        A5FFD1D1D2FFEDEDEDFFF8F8F8FFFBFBFBFFF7F7F7FFBCBCD3FF6B6BA4FF03038FFF030390FF
        03038FFF03038CFF030388FF030384FF030381FF020240310202493B030382FF030385FF0303
        8AFF03038EFF030390FF030392FF030392FF030392FF030392FF030392FF030392FF030392FF
        030392FF030392FF030392FF030392FF030392FF030392FF030392FF030392FF030392FF0303
        92FF030392FF030392FF030392FF030392FF030392FF030392FF030392FF030391FF06068DFF
        3C3C7FFF929298FFC2C2C2FFD4D4D4FFC3C3C5FF5F5F9CFF06068FFF0B0B88FF07078CFF0303
        91FF030392FF030392FF030392FF030392FF030391FF030390FF0F1086FF3E3E81FF75758DFF
        A0A0A1FFAAAAABFF9191A1FF4B4C91FF07078FFF030392FF030391FF030390FF03038EFF0303
        89FF030385FF030382FF0102403101024A3B020383FF020386FF02038BFF02038FFF020392FF
        020393FF020393FF020393FF020393FF020393FF020393FF020393FF020393FF020393FF0203
        93FF020393FF020393FF020393FF020393FF020393FF020393FF020393FF020393FF020393FF
        020393FF020393FF020393FF020393FF020393FF020393FF020393FF020392FF06078CFF2020
        82FF2D2D82FF121389FF020392FF020393FF020393FF020393FF020393FF020393FF020393FF
        020393FF020393FF020393FF020393FF020393FF020392FF020391FF04058DFF05068CFF0203
        91FF020392FF020393FF020393FF020393FF020392FF02038FFF02038BFF020386FF020383FF
        0102413101024B3B020384FF020387FF02038CFF020390FF020393FF020394FF020394FF0203
        94FF020394FF020394FF020394FF020394FF020394FF020394FF020394FF020394FF020394FF
        020394FF020394FF020394FF020394FF020394FF020394FF020394FF020394FF020394FF0203
        94FF020394FF020394FF020394FF020394FF020394FF020394FF020394FF020394FF020394FF
        020394FF020394FF020394FF020394FF020394FF020394FF020394FF020394FF020394FF0203
        94FF020394FF020394FF020394FF020394FF020394FF020394FF020394FF020394FF020394FF
        020394FF020394FF020393FF020390FF02038CFF020387FF020384FF0102423101024C3B0203
        86FF020389FF02038DFF020391FF020394FF020395FF020395FF020395FF020395FF020395FF
        020395FF020395FF020395FF020395FF020395FF020395FF020395FF020395FF020395FF0203
        95FF020395FF020395FF020395FF020395FF020395FF020395FF020395FF020395FF020395FF
        020395FF020395FF020395FF020395FF020395FF020395FF020395FF020395FF020395FF0203
        95FF020395FF020395FF020395FF020395FF020395FF020395FF020395FF020395FF020395FF
        020395FF020395FF020395FF020395FF020395FF020395FF020395FF020395FF020395FF0203
        94FF020391FF02038DFF020388FF020385FF0102433101024C3B020387FF02038AFF02038EFF
        020392FF020395FF020396FF020396FF020396FF030496FF030496FF030496FF030496FF0203
        96FF020396FF020396FF020396FF020396FF020396FF020396FF020396FF020396FF020396FF
        020396FF020396FF020396FF020396FF020396FF020396FF020396FF020396FF020396FF0203
        96FF020396FF020396FF020396FF020396FF020396FF020396FF020396FF020396FF020396FF
        020396FF020396FF020396FF020396FF020396FF020396FF020396FF020396FF030496FF0304
        96FF030496FF030496FF020396FF020396FF020396FF020396FF020395FF020392FF02038EFF
        02038AFF020386FF0102433101024D3B020389FF02038BFF020390FF020393FF020396FF0203
        97FF020398FF030498FF040598FF040598FF040598FF030498FF030498FF030498FF020398FF
        020398FF020398FF020398FF020398FF020398FF020398FF020398FF020398FF020398FF0203
        98FF020398FF020398FF020398FF020398FF020398FF020398FF020398FF020398FF020398FF
        020398FF020398FF020398FF020398FF020398FF020398FF020398FF020398FF020398FF0203
        98FF020398FF020398FF020398FF020398FF030498FF030498FF040598FF040598FF040598FF
        040598FF030498FF020398FF020397FF020396FF020393FF02038FFF02038BFF020388FF0102
        443101024F3B02038BFF02038DFF020391FF020395FF020397FF020499FF04069AFF05079AFF
        06079AFF06079AFF06079AFF05079AFF05069AFF040699FF040599FF030599FF030599FF0305
        99FF030599FF030499FF030499FF030599FF030599FF030599FF030599FF030599FF030599FF
        030599FF030599FF030599FF030599FF030599FF030599FF030599FF030599FF030599FF0305
        99FF030599FF030599FF030599FF030599FF030499FF030499FF030599FF030599FF030599FF
        030599FF040599FF040699FF05069AFF05079AFF06079AFF06079AFF06079AFF05079AFF0405
        99FF020498FF020397FF020395FF020391FF02038DFF02038AFF010245310002513901038EFF
        010390FF010394FF010397FF020499FF05079BFF080A9CFF090B9DFF0A0C9DFF0A0C9DFF0A0C
        9DFF090B9DFF090B9DFF080A9CFF080A9CFF07099CFF07099CFF07099CFF07099CFF07099CFF
        07099CFF07099CFF07099CFF07099CFF07099CFF07099CFF07099CFF07099CFF07099CFF0709
        9CFF07099CFF07099CFF07099CFF07099CFF07099CFF07099CFF07099CFF07099CFF07099CFF
        07099CFF07099CFF07099CFF07099CFF07099CFF07099CFF07099CFF07099CFF080A9CFF080A
        9CFF090B9DFF090B9DFF0A0C9DFF0A0C9DFF0A0C9DFF090B9DFF080A9CFF05079BFF010399FF
        010397FF010394FF010390FF01038DFD0102482F01024A2B010391FD010394FF010397FF0103
        99FF04069BFF0A0C9EFF0D0E9FFF0D0F9FFF0E10A0FF0E10A0FF0E10A0FF0E10A0FF0D0F9FFF
        0D0E9FFF0C0E9FFF0C0E9FFF0C0E9FFF0C0E9FFF0C0E9FFF0C0E9FFF0C0E9FFF0C0E9FFF0C0E
        9FFF0C0E9FFF0C0E9FFF0C0E9FFF0C0E9FFF0C0E9FFF0C0E9FFF0C0E9FFF0C0E9FFF0C0E9FFF
        0C0E9FFF0C0E9FFF0C0E9FFF0C0E9FFF0C0E9FFF0C0E9FFF0C0E9FFF0C0E9FFF0C0E9FFF0C0E
        9FFF0C0E9FFF0C0E9FFF0C0E9FFF0C0E9FFF0C0E9FFF0C0E9FFF0D0F9FFF0D0F9FFF0E10A0FF
        0E10A0FF0E10A0FF0E10A0FF0D0F9FFF0C0E9FFF090B9EFF03059BFF010399FF010397FF0103
        94FF010391F901013F2300001911010394ED010399FF01049BFF02059CFF080B9EFF0F11A1FF
        1114A2FF1214A2FF1215A2FF1215A2FF1215A2FF1214A2FF1214A2FF1113A2FF1113A2FF1113
        A1FF1013A1FF1012A1FF1012A1FF1012A1FF1012A1FF1012A1FF1012A1FF1012A1FF1012A1FF
        1012A1FF1012A1FF1012A1FF1012A1FF1012A1FF1012A1FF1012A1FF1012A1FF1012A1FF1012
        A1FF1012A1FF1012A1FF1012A1FF1012A1FF1012A1FF1012A1FF1012A1FF1012A1FF1012A1FF
        1012A1FF1113A1FF1113A2FF1113A2FF1113A2FF1214A2FF1215A2FF1215A2FF1215A2FF1215
        A2FF1214A2FF1113A2FF0E11A1FF07099EFF02059CFF01049BFF010399FF010392E70000090D
        00000005030691B906099EFF080B9FFF090CA0FF0F11A1FF1518A4FF171AA5FF171AA5FF171A
        A5FF171AA5FF171AA5FF1719A5FF1619A5FF1618A4FF1518A4FF1518A4FF1518A4FF1517A4FF
        1517A4FF1517A4FF1517A4FF1417A4FF1417A4FF1417A4FF1417A4FF1417A4FF1417A4FF1417
        A4FF1417A4FF1417A4FF1417A4FF1417A4FF1417A4FF1417A4FF1417A4FF1417A4FF1417A4FF
        1417A4FF1417A4FF1417A4FF1517A4FF1517A4FF1517A4FF1517A4FF1517A4FF1518A4FF1518
        A4FF1518A4FF1618A4FF1619A5FF1719A5FF171AA5FF171AA5FF171AA5FF171AA5FF1619A5FF
        1417A4FF0D10A1FF090CA0FF080B9FFF06099EFF030690AF00000003FFFFFF010B0E87611114
        A3FF1417A4FF1316A4FF1619A5FF1D1FA8FF1E21A8FF1E21A8FF1D20A8FF1D1FA8FF1C1FA7FF
        1C1EA7FF1B1EA7FF1B1DA7FF1A1DA7FF1A1CA7FF1A1CA7FF1A1CA7FF191CA7FF191CA6FF191C
        A6FF191CA6FF191CA6FF191CA6FF191CA6FF191CA6FF191CA6FF191CA6FF191CA6FF191CA6FF
        191CA6FF191CA6FF191CA6FF191CA6FF191CA6FF191CA6FF191CA6FF191CA6FF191CA6FF191C
        A6FF191CA6FF191CA6FF191CA6FF191CA7FF1A1CA7FF1A1CA7FF1A1CA7FF1A1DA7FF1B1DA7FF
        1B1EA7FF1C1EA7FF1C1FA7FF1D1FA8FF1D20A8FF1E20A8FF1E21A8FF1C1EA7FF1417A5FF1316
        A4FF1417A4FF1114A3FF0B0D8355FFFFFF01FFFFFF0108093C0D1B1EA3D92023AAFF2022AAFF
        1F22A9FF2629ACFF282BADFF282BADFF2729ACFF2528ACFF2427ABFF2326ABFF2325ABFF2224
        AAFF2224AAFF2124AAFF2124AAFF2123AAFF2123AAFF2123AAFF2123AAFF2123AAFF2123AAFF
        2123AAFF2123AAFF2123AAFF2123AAFF2123AAFF2123AAFF2123AAFF2123AAFF2123AAFF2123
        AAFF2123AAFF2123AAFF2123AAFF2123AAFF2123AAFF2123AAFF2123AAFF2123AAFF2123AAFF
        2123AAFF2123AAFF2123AAFF2124AAFF2124AAFF2224AAFF2225AAFF2325ABFF2326ABFF2427
        ABFF2528ACFF2629ACFF282AADFF282AADFF2527ACFF1E21A9FF2022AAFF2022AAFF1B1EA2D1
        06072C0BFFFFFF01FFFFFF01FFFFFF012021914D2B2DAEFD2D2FAFFF2B2DAFFF3032B1FF3437
        B2FF3538B3FF3437B2FF3235B2FF3033B1FF2F32B0FF2E32B0FF2E31B0FF2D31B0FF2D30B0FF
        2D30B0FF2D30B0FF2D30B0FF2D30B0FF2D30B0FF2D30B0FF2D30B0FF2D30B0FF2D30B0FF2D30
        B0FF2D30B0FF2D30B0FF2D30B0FF2D30B0FF2D30B0FF2D30B0FF2D30B0FF2D30B0FF2D30B0FF
        2D30B0FF2D30B0FF2D30B0FF2D30B0FF2D30B0FF2D30B0FF2D30B0FF2D30B0FF2D30B0FF2D30
        B0FF2D30B0FF2D30B0FF2D31B0FF2E31B0FF2F32B0FF2F32B0FF3033B1FF3235B2FF3437B2FF
        3437B2FF3336B2FF2E30B0FF2B2DAFFF2D2FAFFF2A2DAEFB1F218E45FFFFFF01FFFFFF01FFFF
        FF01FFFFFF01000001032F32A483383BB5FF393CB5FF393CB5FF4043B8FF4346B9FF4447B9FF
        4144B8FF3F42B7FF3D41B7FF3D40B6FF3C40B6FF3C3FB6FF3C3FB6FF3C3FB6FF3C3FB6FF3C3F
        B6FF3C3FB6FF3C3FB6FF3C3FB6FF3C3FB6FF3C3FB6FF3C3FB6FF3C3FB6FF3C3FB6FF3C3FB6FF
        3C3FB6FF3C3FB6FF3C3FB6FF3C3FB6FF3C3FB6FF3C3FB6FF3C3FB6FF3C3FB6FF3C3FB6FF3C3F
        B6FF3C3FB6FF3C3FB6FF3C3FB6FF3C3FB6FF3C3FB6FF3C3FB6FF3C3FB6FF3C3FB6FF3C3FB6FF
        3C3FB6FF3C40B6FF3D40B6FF3D41B7FF3F42B7FF4144B8FF4346B9FF4245B9FF3E41B7FF383B
        B5FF393CB5FF383BB5FF2F31A27B00000003FFFFFF01FFFFFF01FFFFFF01FFFFFF01FFFFFF01
        121339053C3FAC874548BAFF474ABBFF494BBBFF4F52BEFF5456BFFF5457C0FF5355BFFF5154
        BEFF5053BEFF5053BEFF5052BEFF5052BEFF5052BEFF5052BEFF5052BEFF5052BEFF5052BEFF
        5052BEFF5052BEFF5052BEFF5052BEFF5052BEFF5052BEFF5052BEFF5052BEFF5052BEFF5052
        BEFF5052BEFF5052BEFF5052BEFF5052BEFF5052BEFF5052BEFF5052BEFF5052BEFF5052BEFF
        5052BEFF5052BEFF5052BEFF5052BEFF5052BEFF5052BEFF5052BEFF5052BEFF5053BEFF5153
        BEFF5154BEFF5355BFFF5457C0FF5355BFFF4E51BDFF474ABBFF474ABBFF4548BAFD3B3EAA7F
        0D0E2905FFFFFF01FFFFFF01FFFFFF01FFFFFF01FFFFFF01FFFFFF01FFFFFF01020206034447
        AB595053BCE55457C0FF5659C1FF5B5EC2FF6163C5FF6567C6FF6769C7FF6769C7FF676AC7FF
        676AC7FF676AC7FF676AC7FF676AC7FF676AC7FF676AC7FF676AC7FF676AC7FF676AC7FF676A
        C7FF676AC7FF676AC7FF676AC7FF676AC7FF676AC7FF676AC7FF676AC7FF676AC7FF676AC7FF
        676AC7FF676AC7FF676AC7FF676AC7FF676AC7FF676AC7FF676AC7FF676AC7FF676AC7FF676A
        C7FF676AC7FF676AC7FF676AC7FF676AC7FF676AC7FF676AC7FF6769C7FF6669C7FF6467C6FF
        6063C4FF5A5CC2FF5558C0FF5457C0FF5052BCE34346A95301010303FFFFFF01FFFFFF01FFFF
        FF01FFFFFF01FFFFFF01FFFFFF01FFFFFF01FFFFFF01FFFFFF01FFFFFF013C3F89115457B773
        5B5EC0CF5F61C4FB6163C5FF6466C6FF6769C7FF6A6CC8FF6C6EC9FF6E70CAFF6F71CAFF7072
        CBFF7072CBFF7073CBFF7073CBFF7073CBFF7073CBFF7073CBFF7073CBFF7073CBFF7073CBFF
        7073CBFF7073CBFF7073CBFF7073CBFF7073CBFF7073CBFF7073CBFF7073CBFF7073CBFF7073
    )

    iconData5 =
    (LTrim Join
        CBFF7073CBFF7073CBFF7073CBFF7073CBFF7073CBFF7073CBFF7073CBFF7072CBFF7072CBFF
        7072CBFF6F71CAFF6E70CAFF6C6EC9FF696CC8FF6769C7FF6366C6FF6163C5FF5F61C4FB5B5E
        BFCD5456B66F3B3D850FFFFFFF01FFFFFF01FFFFFF01FFFFFF01FFFFFF01FFFFFF01FFFFFF01
        FFFFFF01FFFFFF01FFFFFF01FFFFFF01FFFFFF01FFFFFF01FFFFFF01080811034F51A01B5B5D
        B6415E60BA555F61BB595F61BB595F61BB595F61BB595F61BB596062BB596062BB596062BB59
        6062BB596062BB596062BB596062BB596062BB596062BB596062BB596062BB596062BB596062
        BB596062BB596062BB596062BB596062BB596062BB596062BB596062BB596062BB596062BB59
        6062BB596062BB596062BB596062BB596062BB596062BB596062BB596062BB595F61BB595F61
        BB595F61BB595F61BB595F61BB595E60BA535B5DB6414E509F1904040803FFFFFF01FFFFFF01
        FFFFFF01FFFFFF01FFFFFF01FFFFFF01FFFFFF01FFFFFF010000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000000000000000
        00000000
    )
    iconData := iconData1 . iconData2 . iconData3 . iconData4 . iconData5
    hexToBin(iconBin, iconData)
    fileIco := FileOpen(hs.BASENAME . ".ico", "w")
    fileIco.RawWrite(iconBin, StrLen(iconData) / 2)
    fileIco.close()
}

createNewInExplorer(type:="file") {
;    debug("type = " . type)
    folder := getExplorerPath()
;    debug("folder = " . folder)
    if (folder != "") {
        type := StringLower(type)
        name := getUniqueNewName(folder, type)
;        debug("name = " . name)
        fullName := folder . name
;        debug("fullName = " . fullName)
        if (type == "folder") {
            FileCreateDir, %fullName%
        }
        else {
            FileAppend("", fullName)
        }
        if (!FileExist(fullName)) {
            message("Unable to create " . type . ": " . fullName)
        }
        ctrl := "DirectUIHWND" . (WinActive("ahk_class #32770") ? "2" : "3")
        ControlFocus, %ctrl%, A
        selectInExplorer(name)
        Sleep(50)
        SendInput, {F2}
    }
}

createNewOnDesktop(type:="file") {
    folder := A_Desktop
    type := StringLower(type)
    name := getUniqueNewName(folder, type)
    fullName := folder . name
    if (type == "folder") {
        FileCreateDir, %fullName%
    }
    else {
        FileAppend("", fullName)
    }
    selectOnDesktop(name)
    Sleep(50)
    SendInput, {F2}
}

createStartupLink() {
    lnkFile := A_Startup . "\" . hs.TITLE . ".lnk"
    if (hs.config.user.enableAutoStart) {
        target := hs.BASENAME . ".ahk"
        workDir := A_ScriptDir
        args := ""
        desc := "Changing the way you use Windows through better efficiencies!"
        iconFile := hs.BASENAME . ".ico"
        shortcut := ""
        iconNum := 1
        runState := 1
        FileCreateShortcut(target, lnkFile, workDir, args, desc, iconFile, shortcut, iconNum, runState)
    }
    else {
        FileDelete(lnkFile)
    }
}

createUserFiles() {
    file := hs.file.USER_FUNCTIONS
    if (FileExist(file) == "") {
        contents =
        (LTrim
            ; All user-defined functions should be declared below.
            ; Functions defined here can be used referenced by HotScriptKeys.ahk or HotScriptStrings.ahk.
            ; Any functions defined within HotScript itself can be called by functions created here.

            /*
            simpleFunction`(someVar`) {
            %A_Space%   ; do something here...
            }

            userInit() {
            %A_Space%   ; this is a special function that will be executed whenever HotScript is loaded.
            }
            */

        )
        FileAppend(contents, file)
    }
    file := hs.file.USER_KEYS
    if (FileExist(file) == "") {
        contents =
        (LTrim
            ; All user-defined hotkeys should be declared below.
            ; Functions defined in HotScript are available for use here.

            /*
            %A_Space%   #  - Win
            %A_Space%   !  - Alt
            %A_Space%   ^  - Control
            %A_Space%   +  - Shift
            %A_Space%   <  - left key
            %A_Space%   >  - right key
            %A_Space%   *  - wild card `(fire even if extra modifier keys are pressed`)
            %A_Space%   ~  - do not block native key function
            %A_Space%   UP - fire upon key release instead of key press
            */

            /*
            Key Names and Symbols
            ---------------------
            '
            ,
            -
            .
            /
            0
            1
            2
            3
            4
            5
            6
            7
            8
            9
            ;
            =
            [
            \
            ]
            ``
            A
            Alt
            AppsKey
            B
            Backspace
            Break
            Browser_Back
            Browser_Favorites
            Browser_Forward
            Browser_Home
            Browser_Refresh
            Browser_Search
            Browser_Stop
            Bs
            C
            CapsLock
            Control
            Ctrl
            CtrlBreak
            D
            Del
            Delete
            Down
            E
            End
            Enter
            Esc
            Escape
            F
            F1
            F2
            F3
            F4
            F5
            F6
            F7
            F8
            F9
            F10
            F11
            F12
            F13
            F14
            F15
            F16
            F17
            F18
            F19
            F20
            F21
            F22
            F23
            F24
            G
            H
            Help
            Home
            I
            Ins
            Insert
            J
            Joy1
            Joy2
            Joy3
            Joy4
            Joy5
            Joy6
            Joy7
            Joy8
            Joy9
            Joy10
            Joy11
            Joy12
            Joy13
            Joy14
            Joy15
            Joy16
            Joy17
            Joy18
            Joy19
            Joy20
            Joy21
            Joy22
            Joy23
            Joy24
            Joy25
            Joy26
            Joy27
            Joy28
            Joy29
            Joy30
            Joy31
            Joy32
            K
            L
            LAlt
            Launch_App1
            Launch_App2
            Launch_Mail
            Launch_Media
            LButton
            LControl
            LCtrl
            Left
            LShift
            LWin
            M
            MButton
            Media_Next
            Media_Play_Pause
            Media_Prev
            Media_Stop
            N
            NumLock
            Numpad0
            Numpad1
            Numpad2
            Numpad3
            Numpad4
            Numpad5
            Numpad6
            Numpad7
            Numpad8
            Numpad9
            NumpadAdd
            NumpadClear
            NumpadDel
            NumpadDiv
            NumpadDot
            NumpadDown
            NumpadEnd
            NumpadEnter
            NumpadHome
            NumpadIns
            NumpadLeft
            NumpadMult
            NumpadPgDn
            NumpadPgUp
            NumpadRight
            NumpadSub
            NumpadUp
            O
            P
            Pause
            PgDn
            PgUp
            PrintScreen
            Q
            R
            RAlt
            RButton
            RControl
            RCtrl
            Return
            Right
            RShift
            RWin
            S
            SCnnn
            ScrollLock
            Shift
            Sleep
            Space
            T
            Tab
            U
            Up
            V
            VKnn
            Volume_Down
            Volume_Mute
            Volume_Up
            W
            WheelDown
            WheelLeft
            WheelRight
            WheelUp
            X
            XButton1
            XButton2
            Y
            Z
            */

            /*
            Each hotkey should use the following format:

            ^!+m:: ;; a simple test key defined in an external file
            %A_Space%   addHotKey`(`)
            %A_Space%   showSplash`("This hotkey was defined by an external script!"`)
            %A_Space%   return
            */

        )
        FileAppend(contents, file)
    }
    file := hs.file.USER_STRINGS
    if (FileExist(file) == "") {
        contents =
        (LTrim
            ; All user-defined HotStrings should be declared below.
            ; Functions defined in HotScript are available for use here.

            /*
            %A_Space%   HotStrings configured through AutoHotKey
            %A_Space%   ----------------------------------------
            %A_Space%   * `(asterisk`): An ending character `(e.g. space, period, or enter`) is not required to trigger the hotstring.

            %A_Space%   ? `(question mark`): The hotstring will be triggered even when it is inside another word; that is, when the character typed immediately before it is alphanumeric.

            %A_Space%   B0 `(B followed by a zero`): Automatic backspacing is not done to erase the abbreviation you type.

            %A_Space%   C: Case-sensitive

            %A_Space%   C1: Do not conform to typed case.
            %A_Space%   Use this option to make auto-replace HotStrings case insensitive and prevent them from conforming to the case of the characters you actually type.
            %A_Space%   Case-conforming HotStrings `(which are the default`) produce their replacement text in all caps if you type the abbreviation in all caps.
            %A_Space%   If you type only the first letter in caps, the first letter of the replacement will also be capitalized `(if it is a letter`).
            %A_Space%   If you type the case in any other way, the replacement is sent exactly as defined.

            %A_Space%   O: Omit the ending character of auto-replace HotStrings when the replacement is produced.
            %A_Space%   This is useful when you want a hotstring to be kept unambiguous by still requiring an ending character, but don't actually want the ending character to be shown on the screen.

            %A_Space%   R: Send the replacement text raw; that is, exactly as it appears rather than translating {Enter} to an ENTER keystroke, ^c to Control-C, etc.
            %A_Space%   This option is put into effect automatically for hotstrings that have a continuation section. Use R0 to turn this option back off.

            %A_Space%   SI or SP or SE: Sets the method by which auto-replace hotstrings send their keystrokes. These options are mutually exclusive: only one can be in effect at a time.
            %A_Space%   The following describes each option:

            %A_Space%   - SI stands for SendInput, which typically has superior speed and reliability than the other modes.
            %A_Space%   - SP stands for SendPlay, which may allow hotstrings to work in a broader variety of games.
            %A_Space%   - SE stands for SendEvent, which is the default in versions older than 1.0.43.

            %A_Space%   Z: This rarely-used option resets the hotstring recognizer after each triggering of the hotstring. In other words, the script will begin waiting for an entirely new
            %A_Space%   hotstring, eliminating from consideration anything you previously typed. This can prevent unwanted triggerings of hotstrings.

            %A_Space%   You can use the built-in variable A_EndChar to reference the ending character that was typed.
            */

            /*
            Each hotstring should use the following format:

            :*:hw.:: ;; Hello World.
            %A_Space%   addHotString`(`)
            %A_Space%   sendText`("Hello World."`)
            %A_Space%   return
            */

            /*
            %A_Space%   Dynamic HotStrings configured through Hotscript
            %A_Space%   -----------------------------------------------
            %A_Space%   hotString`(trigger, replace, mode, clearTrigger, cond`)
            %A_Space%       trigger   - string or regex to trigger the action
            %A_Space%       replace   - string to replace trigger, OR function to call, OR label to go to
            %A_Space%                       - passing a blank value will delete any existing hotstring for the specified trigger
            %A_Space%                       - this can be useful to allow a hotstring to trigger until some conditional has been met
            %A_Space%       mode      - the operating mode of the trigger
            %A_Space%                       - 1 = case insensitive `(default`)
            %A_Space%                       - 2 = case sensitive
            %A_Space%                       - 3 = regex
            %A_Space%       clear     - true if the trigger should be erased `(default = true`)
            %A_Space%       condition - function name that should return true/false is the action should be executed

            %A_Space%   Only the first two parameters are required.
            %A_Space%       - The "mode" defaults to case-insentive (1), if not specified.
            %A_Space%       - The "clear" defaults to true, if not specified.
            %A_Space%       - The "condition" is optional.

            %A_Space%   Unlike using the method defined by AutoHotKey `(above`), there is no need to manually call addHotString`(`).

            %A_Space%   hotString`("hw", "Hello World."`)
            %A_Space%   hotString`("hw", ""`)
            %A_Space%       - the hotstring for "hw" is now deleted
            %A_Space%   hotString`("@math", "myMath"`)
            %A_Space%       - if "myMath" exists as a function, it is called
            %A_Space%       - if "myMath" exists as a label, it is called
            %A_Space%       - otherwise the text "myMath" will be used
            %A_Space%   hotString`("gett", "ing much more efficient, with HotScript!", 1, false`)
            %A_Space%   hotString`("myTest", "Conditional testing worked!", 1, true, "myTestFunc"`)
            %A_Space%       - if myTestFunc exists, it is called
            %A_Space%           - if it returns true, the hotstring will be triggered
            %A_Space%           - if it returns false, the hotstring will be ignored
            %A_Space%       - if myTestFunc does not exist, the hotstring will be triggered
            %A_Space%   hotString`("aBc", "This is case-sensitive!", 2`)
            %A_Space%   hotString`("\w{3}\d{3}", "Three letters and three numbers...", 3`)
            */

        )
        FileAppend(contents, file)
    }
    file := hs.file.USER_VARIABLES
    if (FileExist(file) == "") {
        contents =
        (LTrim
            ; All user-defined variables should be declared below.
            ; Variables defined here can be used referenced by HotScriptFunctions.ahk, HotScriptKeys.ahk or HotScriptStrings.ahk.
            ; All variables should be declared with "global" to make them easily accessible by other HotScript scripts and functions.

        )
        FileAppend(contents, file)
    }
}

crypt(text) {
    result := ""
    Loop, Parse, text
    {
        ascii := Asc(A_LoopField)
        if (ascii < 32) {
            result .= A_LoopField
        }
        else {
            result .= Chr(Asc(A_LoopField) ^ 129)
        }
    }
    return result
}

cryptSelected() {
    selText := getSelectedText()
    if (selText != "") {
        replaceSelected(crypt(selText))
    }
}

debug(str) {
    OutputDebug % " --> " . str
}

deleteCurrentLine() {
    selText := getCurrentLine()
    SendInput, {Delete}
}

duplicateCurrentLine() {
    selText := getCurrentLine()
    eol := getEol(selText)
    hasEol := endsWith(selText, eol)
    if (hasEol) {
        SendInput, {Up}
    }
    else {
        SendInput, {Home}
    }
    sendText(selText)
    if (hasEol) {
        SendInput, {Up}
    }
    else {
        SendInput, {Enter}{Home}{Up}
    }
}

endsWith(str, value, caseInsensitive:="") {
    if (toBool(caseInsensitive)) {
        str := setCase(str, "L")
        value := setCase(value, "L")
    }
    tmp := StringRight(str, StrLen(value))
    return (tmp == value)
}

findOnPath(filename) {
    target := ""
    if (FileExist(filename) != "") {
        target := filename
    }
    else {
        SplitPath(filename, findName)
        paths := EnvGet("Path")
        StringSplit, pathArray, paths, `;
        Loop, % pathArray0
        {
            file := StringReplace(pathArray%A_Index% . "\", "\\", "\", "All") . findName
            if (FileExist(file) != "") {
                target := file
                break
            }
        }
    }
    return target
}

escapeText(text:="") {
    isSelected := false
    if (text == "") {
        text := getSelectedText()
        isSelected := true
    }
    if (text != "") {
        text := StrReplace(text, "``", "````")
        text := StrReplace(text, "%", "``%")
        text := StrReplace(text, "(", "``(")
        text := StrReplace(text, ")", "``)")
        if (isSelected) {
            replaceSelected(text)
        }
    }
    if (!isSelected) {
        return text
    }
}

findOrRunByExe(name) {
    exe := name . ".exe"
    regExe := "i)" . exe
    if (WinExist("ahk_exe " . regExe)) {
        WinActivate
    }
    else {
        runTarget(exe)
    }
}

getActiveMonitor(hWnd:="A") {
    hWnd := setCase(Trim(hWnd), "U")
    if (hWnd == "" || hWnd == "A") {
        hWnd := WinExist("A")
    }
    monIdx := 1
    VarSetCapacity(monInfo, 40)
    NumPut(40, monInfo)

    if (monitorHandle := DllCall("MonitorFromWindow", "uint", hWnd, "uint", 0x2))
        && DllCall("GetMonitorInfo", "uint", monitorHandle, "uint", &monInfo) {
        monitorLeft   := NumGet(monInfo,  4, "Int")
        monitorTop    := NumGet(monInfo,  8, "Int")
        monitorRight  := NumGet(monInfo, 12, "Int")
        monitorBottom := NumGet(monInfo, 16, "Int")
        workLeft      := NumGet(monInfo, 20, "Int")
        workTop       := NumGet(monInfo, 24, "Int")
        workRight     := NumGet(monInfo, 28, "Int")
        workBottom    := NumGet(monInfo, 32, "Int")
        isPrimary     := NumGet(monInfo, 36, "Int") & 1
        SysGet, monitorCount, MonitorCount
        Loop, % monitorCount
        {
            SysGet, curMon, Monitor, %A_Index%
            if (monitorLeft == curMonLeft && monitorTop == curMonTop && monitorRight == curMonRight && monitorBottom == curMonBottom) {
                monIdx := A_Index
                break
            }
        }
    }
    return monIdx
}

getActiveProcessID() {
    WinGet, procName, ProcessName, A
    if (procName == "ApplicationFrameHost.exe") {
        ControlGet, hwnd, Hwnd,, Windows.UI.Core.CoreWindow1, A
        if (hwnd) {
            WinGet, procPID, PID, ahk_id %hwnd%
        }
    }
    else {
        WinGet, procPID, PID, A
    }
    return procPID
}

getActiveProcessName() {
    WinGet, procName, ProcessName, A
    if (procName == "ApplicationFrameHost.exe") {
        ControlGet, hwnd, Hwnd,, Windows.UI.Core.CoreWindow1, A
        if (hwnd) {
            WinGet, procName, ProcessName, ahk_id %hwnd%
        }
    }
    return procName
}

getCenter(winW, winH, monitor:="A") {
    if (monitor == "A") {
        monitor := getActiveMonitor()
    }
    else {
        if (monitor < hs.vars.monitors.count) {
            monitor := 1
        }
        else if (monitor > hs.vars.monitors.count) {
            monitor := hs.vars.monitors.count
        }
    }
    coord := new Coords
    targetMon := hs.vars.monitors[monitor]
    newX := targetMon.left + (targetMon.workWidth / 2) - (winW / 2)
    newY := targetMon.top + (targetMon.workHeight / 2) - (winH / 2)
    coord.x := newX
    coord.y := newY
    return coord
}

getCurrentLine() {
    selectCurrentLine()
    return getSelectedText()
}

getDateString() {
    return A_MM . "/" . A_DD . "/" . A_YYYY
}

getDayString() {
    return A_DDDD
}

getDddString() {
    return A_DDD
}

getDefaultHotKeyDefs(type) {
    hk := {}
    if (type == "hkAction") {
        hk["hkActionAlwaysOnTop"] := "#a"
        hk["hkActionCalculator"] := "#c"
        hk["hkActionCharacterMap"] := "#m"
        hk["hkActionClickThrough"] := "^#a"
        hk["hkActionControlPanel"] := "^rctrl"
        hk["hkActionDosPrompt"] := "#d"
        hk["hkActionDosPromptInExplorer"] := "!#d"
        hk["hkActionEditor"] := "#e"
        hk["hkActionGoogleSearch"] := "#g"
        hk["hkActionQuickLookup"] := "#q"
        hk["hkActionStartupFolder"] := "!#s"
        hk["hkActionToggleDesktopIcons"] := "!appskey"
        hk["hkActionWindowsExplorer"] := "#x"
        hk["hkActionWindowsServices"] := "#s"
        hk["hkActionWindowsSnip"] := "#printscreen"
    }
    else if (type == "hkDos") {
        hk["hkDosCdParent-1"] := "!."
        hk["hkDosCdParent-2"] := "!up"
        hk["hkDosCopy"] := "!c"
        hk["hkDosDownloads"] := "!d"
        hk["hkDosExit"] := "!x"
        hk["hkDosMove"] := "!m"
        hk["hkDosPageDown-1"] := "+pgdn"
        hk["hkDosPageDown-2"] := "^pgdn"
        hk["hkDosPageDown-3"] := "!pgdn"
        hk["hkDosPageUp-1"] := "+pgup"
        hk["hkDosPageUp-2"] := "^pgup"
        hk["hkDosPageUp-3"] := "!pgup"
        hk["hkDosPaste-1"] := "^v"
        hk["hkDosPaste-2"] := "+insert"
        hk["hkDosPopd"] := "^p"
        hk["hkDosPushd"] := "!p"
        hk["hkDosRoot"] := "!r"
        hk["hkDosScrollTop"] := "^home"
        hk["hkDosScrollBottom"] := "^end"
        hk["hkDosType"] := "!t"
    }
    else if (type == "hkEpp") {
        hk["hkEppDeleteWord"] := "^d"
        hk["hkEppGoToLine"] := "^g"
        hk["hkEppNextFile"] := "xbutton2"
        hk["hkEppPrevFile"] := "xbutton1"
    }
    else if (type == "hkHotScript") {
        hk["hkHotScriptAutoHotKeyHelp"] := "#1"
        hk["hkHotScriptEditDefaultIni"] := "#9"
        hk["hkHotScriptEditHotScript"] := "#3"
        hk["hkHotScriptEditUserIni"] := "#8"
        hk["hkHotScriptEditUserFunctions"] := "#7"
        hk["hkHotScriptEditUserKeys"] := "#4"
        hk["hkHotScriptEditUserStrings"] := "#5"
        hk["hkHotScriptEditUserVariables"] := "#6"
        hk["hkHotScriptExit"] := "#f12"
        hk["hkHotScriptHome"] := "#0"
        hk["hkHotScriptFolder"] := "!#h"
        hk["hkHotScriptQuickHelp"] := "#h"
        hk["hkHotScriptQuickHelpToggle"] := "^#h"
        hk["hkHotScriptReload"] := "#2"
        hk["hkHotScriptRunDebugView"] := "#``"
        hk["hkHotScriptShowVariable"] := "^#f12"
    }
    else if (type == "hkMisc") {
        hk["hkMiscCopyAppend"] := "^!a"
        hk["hkMiscCreateFile"] := "^!f"
        hk["hkMiscCreateFolder"] := "^!d"
        hk["hkMiscCutAppend"] := "^!x"
        hk["hkMiscDragMouseDown"] := "^!#down"
        hk["hkMiscDragMouseLeft"] := "^!#left"
        hk["hkMiscDragMouseRight"] := "^!#right"
        hk["hkMiscDragMouseUp"] := "^!#up"
        hk["hkMiscMouseDown"] := "!#down"
        hk["hkMiscMouseLeft"] := "!#left"
        hk["hkMiscMouseRight"] := "!#right"
        hk["hkMiscMouseUp"] := "!#up"
        hk["hkMiscPasteClipboardAsText"] := "^!v"
        hk["hkMiscPasteEnter"] := "#enter"
        hk["hkMiscPasteTab"] := "#tab"
        hk["hkMiscPreviewClipboard"] := "#v"
        hk["hkMiscSwapToClipboard"] := "^!c"
        hk["hkMiscZoomWindow"] := "#z"
    }
    else if (type == "hkText") {
        hk["hkTextDeleteCurrentLine"] := "!delete"
        hk["hkTextDeleteToEol"] := "^delete"
        hk["hkTextDuplicateCurrentLine"] := "^+up"
        hk["hkTextMoveCurrentLineDown"] := "!down"
        hk["hkTextMoveCurrentLineUp"] := "!up"
    }
    else if (type == "hkTransform") {
        hk["hkTransformEncrypt"] := "^+e"
        hk["hkTransformEscape"] := "^+``"
        hk["hkTransformInvertCase"] := "^+i"
        hk["hkTransformLowerCase"] := "$^+l"
        hk["hkTransformNumberPrepend"] := "^+n"
        hk["hkTransformNumberPrependPrompt"] := "^!+n"
        hk["hkTransformNumberStrip"] := "^!n"
        hk["hkTransformOracleUpper"] := "^+o"
        hk["hkTransformReverseText"] := "^+r"
        hk["hkTransformSentenceCase"] := "^+s"
        hk["hkTransformSortAscending"] := "^!+a"
        hk["hkTransformSortAscendingNoCase"] := "^+a"
        hk["hkTransformSortDescending"] := "^!+d"
        hk["hkTransformSortDescendingNoCase"] := "^+d"
        hk["hkTransformTagify1"] := "!+,"
        hk["hkTransformTagify2"] := "!+."
        hk["hkTransformTitleCase"] := "$^+t"
        hk["hkTransformUnwrapText"] := "^!w"
        hk["hkTransformUpperCase"] := "$^+u"
        hk["hkTransformWrapEachInBrackets-1"] := "#!["
        hk["hkTransformWrapEachInBrackets-2"] := "#!]"
        hk["hkTransformWrapEachInCurlys-1"] := "#+["
        hk["hkTransformWrapEachInCurlys-2"] := "#+]"
        hk["hkTransformWrapEachInParenthesis-1"] := "#+9"
        hk["hkTransformWrapEachInParenthesis-2"] := "#+0"
        hk["hkTransformWrapEachInDoubleQuotes"] := "#+'"
        hk["hkTransformWrapEachInSingleQuotes"] := "#!'"
        hk["hkTransformWrapEachInTags-1"] := "#+,"
        hk["hkTransformWrapEachInTags-2"] := "#+."
        hk["hkTransformWrapInBrackets-1"] := "^!["
        hk["hkTransformWrapInBrackets-2"] := "^!]"
        hk["hkTransformWrapInCurlys-1"] := "^+["
        hk["hkTransformWrapInCurlys-2"] := "^+]"
        hk["hkTransformWrapInParenthesis-1"] := "^+9"
        hk["hkTransformWrapInParenthesis-2"] := "^+0"
        hk["hkTransformWrapInDoubleQuotes"] := "^+'"
        hk["hkTransformWrapInSingleQuotes"] := "^!'"
        hk["hkTransformWrapInTags-1"] := "^+,"
        hk["hkTransformWrapInTags-2"] := "^+."
        hk["hkTransformWrapText"] := "^+w"
    }
    else if (type == "hkWindow") {
        hk["hkWindowCenter"] := "#home"
        hk["hkWindowDecreaseTransparency-1"] := "#-"
        hk["hkWindowDecreaseTransparency-2"] := "#numpadsub"
        hk["hkWindowDecreaseTransparency-3"] := "#wheeldown"
        hk["hkWindowHide"] := "#delete"
        hk["hkWindowIncreaseTransparency-1"] := "#="
        hk["hkWindowIncreaseTransparency-2"] := "#numpadadd"
        hk["hkWindowIncreaseTransparency-3"] := "#wheelup"
        hk["hkWindowLeft-1"] := "wheelleft"
        hk["hkWindowLeft-2"] := "#left"
        hk["hkWindowMaximize"] := "#up"
        hk["hkWindowMinimize"] := "#down"
        hk["hkWindowMoveToEdgeBottom"] := "^#down"
        hk["hkWindowMoveToEdgeLeft"] := "^#left"
        hk["hkWindowMoveToEdgeRight"] := "^#right"
        hk["hkWindowMoveToEdgeTop"] := "^#up"
        hk["hkWindowPageDown"] := "!wheeldown"
        hk["hkWindowPageUp"] := "!wheelup"
        hk["hkWindowResize"] := "^#r"
        hk["hkWindowResizeToAnchor-1"] := "+#down"
        hk["hkWindowResizeToAnchor-2"] := "+#left"
        hk["hkWindowResizeToAnchor-3"] := "+#right"
        hk["hkWindowResizeToAnchor-4"] := "+#up"
        hk["hkWindowResizeToCompass-1"] := "#numpad1"
        hk["hkWindowResizeToCompass-10"] := "#numpadend"
        hk["hkWindowResizeToCompass-11"] := "#numpaddown"
        hk["hkWindowResizeToCompass-12"] := "#numpadpgdn"
        hk["hkWindowResizeToCompass-13"] := "#numpadleft"
        hk["hkWindowResizeToCompass-14"] := "#numpadclear"
        hk["hkWindowResizeToCompass-15"] := "#numpadright"
        hk["hkWindowResizeToCompass-16"] := "#numpadhome"
        hk["hkWindowResizeToCompass-17"] := "#numpadup"
        hk["hkWindowResizeToCompass-18"] := "#numpadpgup"
        hk["hkWindowResizeToCompass-2"] := "#numpad2"
        hk["hkWindowResizeToCompass-3"] := "#numpad3"
        hk["hkWindowResizeToCompass-4"] := "#numpad4"
        hk["hkWindowResizeToCompass-5"] := "#numpad5"
        hk["hkWindowResizeToCompass-6"] := "#numpad6"
        hk["hkWindowResizeToCompass-7"] := "#numpad7"
        hk["hkWindowResizeToCompass-8"] := "#numpad8"
        hk["hkWindowResizeToCompass-9"] := "#numpad9"
        hk["hkWindowRestoreHidden"] := "#insert"
        hk["hkWindowRight-1"] := "wheelright"
        hk["hkWindowRight-2"] := "#right"
        hk["hkWindowToggleMinimized"] := "^#m"
        hk["hkWindowToggleTransparency"] := "#t"
    }
    return hk
}

getDtmsString() {
    return getDtsString() . "_" . getTmsString()
}

getDtsString() {
    return A_YYYY . A_MM . A_DD
}

getEol(text) {
    if (InStr(text, hs.const.EOL_WIN)) {
        ; check this first because it may contain both
        eol := hs.const.EOL_WIN
    }
    else if (InStr(text, hs.const.EOL_NIX)) {
        eol := hs.const.EOL_NIX
    }
    else if (InStr(text, hs.const.EOL_MAC)) {
        eol := hs.const.EOL_MAC
    }
    else {
        ; otherwise, default to Windows
        eol := hs.const.EOL_WIN
    }
    return eol
}

getExplorerPath() {
    xPath := ""
    if (WinActive("ahk_group ExplorerGroup")) {
        hwnd := WinExist("A")
;        debug("hwnd = " . hwnd)
        url := ""
        if (WinActive("ahk_class #32770")) {
            /*
            debug("Checking dialog...")
            ;url := ControlGetText("ToolbarWindow322", "ahk_id %hwnd%")
            ControlGetText, url, ToolbarWindow322, Open ahk_class #32770
            debug("url = " . url)
            ; TODO - is this an issue for non-paths? Such as current user or "My Documents'?
            ; TODO - is this an issue for open dialog, too
            pos := InStr(url, ":\") - 1
            xPath := SubStr(url, pos)
            debug("xPath = " . xPath)
            */
            message("Unable to determine current path from a dialog...")
            centerWindow()
        }
        else {
;            debug("Checking windows...")
            for item in ComObjCreate("Shell.Application").Windows {
                if (url == "" && item.hwnd == hwnd) {
                    url := item.LocationURL
                }
            }
            if (url != "") {
                VarSetCapacity(xPath, pathSize := 2084, 0)
                DllCall("shlwapi\PathCreateFromUrl" . (A_IsUnicode ? "W" : "A"), Str, url, Str, xPath, UIntP, pathSize, UInt, 0)
            }
        }
    }
    return xPath
}

getIndent() {
    if (isActiveDos()) {
        result := hs.const.INDENT
    }
    else {
        SendInput, +{Home}
        ; TODO - before trying to getSelectedText(), test if we are at position 1 already by using Ctrl-C
        ; if the buffer is empty, we are at pos 1, so no indent!
        result := getSelectedText()
        if (!RegexMatch(result, "^[ \t]*$")) {
            SendInput, +{Home}
            result2 := getSelectedText()
            if (StrLen(result2) > StrLen(result)) {
                result := result2
            }
            tmp := result
            result := ""
            isBlank := true
            Loop, Parse, tmp
            {
                if (isBlank) {
                    if (isBlank && RegexMatch(A_LoopField, "[ \t]")) {
                        result .= A_LoopField
                    }
                    else {
                        isBlank := false
                    }
                }
            }
        }
        SendInput, {End}
    }
    return result
}

getIndent1(indent) {
    result := ""
    if (indent != "") {
        result := (contains(indent, A_Tab) ? A_Tab : hs.const.INDENT)
    }
    return result
}

getListSize(list, delim:="") {
    delim := (delim == "" ? hs.const.EOL_WIN : delim)
    tmpCount := 0
    Loop, Parse, list, %delim%
    {
        tmpCount++
    }
    return tmpCount
}

getMmmString() {
    return A_MMM
}

getMonthString() {
    return A_MMMM
}

getNowString() {
    return getDateString() . " at " . getTimeString()
}

getSelectedText() {
    prevClipboard := ClipboardAll
    Clipboard := ""
    Sleep(50)
    SendInput, ^c
    ClipWait()
    selText := (ErrorLevel ? "" : Clipboard)
    Clipboard := prevClipboard
    prevClipboard := ""
    return selText
}

getSelectedTextOrPrompt(title) {
    selText := getSelectedText()
    if (selText == "") {
        hWnd := WinExist("A")
        selText := ask(title, "Please enter a phrase or value...", 500)
        WinActivate, ahk_id %hWnd%
    }
    return selText
}

getSize(value) {
    size := 0
    if (IsObject(value)) {
        for key, val in value {
            size++
        }
    }
    else {
        size := is(value, "number") ? value : StrLen(value)
    }
    return size
}

getTimeString() {
    return A_Hour . ":" . A_Min . ":" . A_Sec
}

getTmsString() {
    return A_Hour . A_Min . A_Sec
}

getUniqueNewName(ByRef path, type:="file") {
    if (!endsWith(path, "\")) {
        path .= "\"
    }
    type := StringLower(type)
    if (type != "folder") {
        type := "file"
    }
    name :=  "New " . type
    result := name
    i := 2
    while (FileExist(path . result)) {
        result := Format("{1} ({2})", name, i)
        i++
    }
    return result
}

getVar(name) {
    keyArray := StrSplit(name, ".")
    varName := keyArray.RemoveAt(1)
    tmp := %varName%
    if (IsObject(tmp)) {
        tmpName := varName
        for idx, key in keyArray
        {
            if (!ObjHasKey(tmp, key)) {
                throw, Exception("The object '" . tmpName . "' does not contain the key '" . key . "'.")
            }
            tmpName .= "." . key
            if (!IsObject(tmp[key])) {
                if (idx != keyArray.Length()) {
                    throw, Exception("The requested object '" . tmpName . "' is a simple value not an object.")
                }
            }
            tmp := tmp[key]
        }
    }
    return tmp
}

getVarType(obj) {
    if (isFunc(obj)) {
        result := "Function"
    }
    else if (isLabel(obj)) {
        result := "Label"
    }
    else if (isObject(obj)) {
        result := "Object"
    }
    else {
        if (is(obj, "number")) {
            result := "Number"
        }
        else {
            result := "String"
        }
    }
    return result
}

hexToBin(ByRef bytes, hex, num:=0)
{
    needed := Ceil(StrLen(hex) / 2)
    if (num < 1 || num > needed) {
        num := needed
    }
    alloc := VarSetCapacity(bytes, num, 1)
    if (alloc < num) {
       ErrorLevel = Mem=%Granted%
       MsgBox % "hexToBin() allocated " . alloc . " memory, but needed " . needed
       return
    }
    StringLeft bytes, bytes, num
    addr := &bytes
    Loop, % num
    {
       StringLeft ch, hex, 2
       StringTrimLeft hex, hex, 2
       DllCall("RtlFillMemory", "UInt", addr, "UInt", 1, "UChar", "0x" . ch)
       addr++
    }
}

hideWindow(title:="A") {
    hWnd := WinExist(title)
    if (IsWindow(hWnd)) {
        hs.vars.hiddenWindows .= (hs.vars.hiddenWindows ? "|" : "") . hWnd
        WinHide, ahk_id %hWnd%
        GroupActivate("AllWindows")
    }
}

/*
hotString(trigger, replace, mode, clear, condition)
    trigger    - string or regex to trigger the action
    replace    - string to replace trigger, OR label to go to, OR function to call, OR object containing function name and optional parameters
    mode       - NORMAL (case-insensitive), CASE (case-sensitive), REGEX (regular expression) (default = NORMAL)
    clear      - true if the trigger should be erased (default = true)
    condition  - function name that should return true/false is the action should be executed
TODO
    - make "replace" support being text/label/function/object
    - "replace" should support being able to reevaluate itself (such as A_Hour)
    - when "replace" is an object, it (may) contain all necessary parameters
        - mode
        - clearTrigger
        - condition
        - function
        - functionParameters
        - keys (after replacing the text)
        - text
        - evalText
    - how to handle block / template replacement
        - maybe function call?
    - how to handle multi-text with keys after each (cannot use template because the cursor needs to move after each "text")
        - add keys as a final parameter?
    - how to capture/set A_EndChar
        - hs.EndChar
        - could be added to "replace", if it is an object
*/
hotString(trigger, replace, mode:=1, clearTrigger:=true, condition:= "") {
    static keysBound := false
    static hotkeyPrefix := "~$"
    static hotstrings := {}
    static typed := ""
    static keys := {
        (LTrim Join
            symbols: "!""#$%&'()*+,-./:;<=>?@[\]^_``{|}~",
            num: "0123456789",
            alpha: "abcdefghijklmnopqrstuvwxyz",
            other: "BS,Return,Tab,Space",
            breakKeys: "Left,Right,Up,Down,Home,End,RButton,LButton,LControl,RControl,LAlt,RAlt,AppsKey,Lwin,Rwin,WheelDown,WheelUp,f1,f2,f3,f4,f5,f6,f7,f8,f9,f6,f7,f9,f10,f11,f12",
            numpad: "Numpad0,Numpad1,Numpad2,Numpad3,Numpad4,Numpad5,Numpad6,Numpad7,Numpad8,Numpad9,NumpadDot,NumpadDiv,NumpadMult,NumpadAdd,NumpadSub,NumpadEnter"
        )}
    static effect := {
        (LTrim Join
            Return: "`n",
            Tab: A_Tab,
            Space: A_Space,
            Enter: "`n",
            Dot: ".",
            Div: "/",
            Mult: "*",
            Add: "+",
            Sub: "-"
        )}
    if (!keysBound) {
        ;Binds the keys to watch for triggers
        for k, v in ["symbols", "num", "alpha"]
        {
            ;alphanumeric/symbols
            v := keys[v]
            Loop, Parse, v
            {
                Hotkey, %hotkeyPrefix%%A_LoopField%, __hotstring
            }
        }

        v := keys.alpha
        Loop, Parse, v
        {
            Hotkey, %hotkeyPrefix%+%A_Loopfield%, __hotstring
        }
        for k, v in ["other", "breakKeys", "numpad"]
        {
            ;comma separated values
            v := keys[v]
            Loop, Parse, v, `,
            {
                Hotkey, %hotkeyPrefix%%A_LoopField%, __hotstring
            }
        }
        ;keysBound is a static variable, so now the keys won't be bound twice
        keysBound := true
    }
    if (mode == hs.const.replaceMode.CALLBACK) {
        ;Callback for the hotkeys
        Hotkey := SubStr(A_ThisHotkey, 3)
        if (StrLen(Hotkey) == 2 && Substr(Hotkey, 1, 1) == "+" && Instr(keys.alpha, Substr(Hotkey, 2, 1))) {
            Hotkey := Substr(Hotkey, 2)
            if (!GetKeyState("Capslock", "T")) {
                StringUpper, Hotkey, Hotkey
            }
        }
        shiftState := GetKeyState("Shift", "P")
        uppercase := GetKeyState("Capslock", "T") ? !shiftState : shiftState
        ;if capslock is down, shift's function is reversed (pressing shift and a key while capslock is on will provide the lowercase key)
        if (uppercase && Instr(keys.alpha, Hotkey)) {
            StringUpper, Hotkey, Hotkey
        }
        if (Instr("," . keys.breakKeys . ",", "," . Hotkey . ",")) {
            typed := ""
            return
        }
        else if Hotkey in Return,Tab,Space
        {
            typed .= effect[Hotkey]
        }
        else if (Hotkey == "BS") {
            ;trim typed var if Backspace was pressed
            typed := StringTrimRight(typed, 1)
            return
        }
        else if (RegExMatch(Hotkey, "Numpad(.+?)", numKey)) {
            if (numkey1 ~= "\d") {
                typed .= numkey1
            }
            else {
                typed .= effect[numKey1]
            }
        }
        else {
            typed .= Hotkey
        }
        matched := false
        for k, v in hotstrings
        {
            matchRegex := (v.mode == 1 ? "Oi)" : "") . (v.mode == 3 ? RegExReplace(v.trigger, "\$$", "") : "\Q" . v.trigger . "\E") . "$"
            if (v.mode == 3) {
                if (matchRegex ~= "^[^\s\)\(\\]+?\)") {
                    matchRegex := "O" . matchRegex
                }
                else {
                    matchRegex := "O)" . matchRegex
                }
            }
            if (RegExMatch(typed, matchRegex, local$)) {
                matched := true
                if (v.mode == 2) {
                    returnValue := (local$ == "" ? local$.value(0) : local$)
                }
                else {
                    returnValue := (local$.count > 0 ? local$ : local$.value(0))
                }
                if (v.condition != "" && IsFunc(v.condition)) {
                    ;if hotstring has a condition function
                    conditionalFunc := Func(v.condition)
                    if (conditionalFunc.minParams >= 1) {
                        ;if the function has at least 1 parameters
                        conditionalValue := conditionalFunc.(returnValue)
                    }
                    else {
                        conditionalValue := conditionalFunc.()
                    }
                    if (!toBool(conditionalValue)) {
                        matched := false
                        typed := ""
                        continue
                    }
                }
                addHotString()
                if (v.clearTrigger) {
                    triggerStr := (v.mode == 3 && local$.count > 0 ? local$.value(0) : returnValue)
                    StringRight, lastChar, triggerStr, 1
                    if (lastChar == A_Tab) {
                        tmpTrigger := StringTrimRight(triggerStr, 1)
                        len := StrLen(tmpTrigger)
                        SendInput, +{Left %len%}
                        while (!startsWith(getSelectedText(), tmpTrigger)) {
                            SendInput, +{Left}
                        }
                    }
                    else {
                        SendInput % "{BS " . StrLen(triggerStr) . "}"
                    }
                }
                if (IsFunc(v.replace)) {
                    $ := local$
                    callbackFunc := Func(v.replace)
                    ; TODO - add support for sending parameters to the function
                    if (callbackFunc.minParams >= 1) {
                        funcResult := callbackFunc.(returnValue)
                    }
                    else {
                        funcResult := callbackFunc.()
                    }
                    if (funcResult != "") {
                        pasteText(funcResult)
                    }
                }
                else if (IsLabel(v.replace)) {
                    $ := returnValue
                    gosub, % v.replace
                }
                else {
                    str := v.replace
                    ;working out the back-references
                    if (local$.count() == 0) {
                        StringReplace, str, str, % "$0", % local$.value(0), All
                    }
                    Loop, % local$.count()
                    {
                        StringReplace, str, str, % "$" . A_Index, % local$.value(A_Index), All
                    }
                    pasteText(str)
                }
            }
        }
        if (matched) {
            typed := ""
        }
        else if (StrLen(typed) > 350) {
            typed := StringTrimLeft(typed, 200)
        }
    }
    else {
        if (hotstrings.HasKey(trigger) && replace == "") {
            hotstrings.remove(trigger)
        }
        else {
            hotstrings[trigger] := {
                (LTrim Join
                    trigger: trigger,
                    replace: replace,
                    mode: mode,
                    clearTrigger: clearTrigger,
                    condition: condition
                )}
        }
    }
    return

    __hotstring:
        ;this label is triggered every time a key is pressed
        hotString("", "", hs.const.replaceMode.CALLBACK)
        return
}

hsDivPercent() {
    sendText(Round(($.value(1) / $.value(2)) * 100) . "%")
}

hsPercentOf() {
    result := ($.value(1) / 100) * $.value(2)
    while (endsWith(result, "0")) {
        result := StringTrimRight(result, 1)
    }
    if (endsWith(result, ".")) {
        result := StringTrimRight(result, 1)
    }
    sendText(result)
}

init() {
    ;debug("DBGVIEWCLEAR")
    initInternalVars()
    GroupAdd, DesktopGroup, ahk_class Progman
    GroupAdd, DesktopGroup, ahk_class WorkerW
    GroupAdd, ExplorerGroup, ahk_class CabinetWClass
    GroupAdd, ExplorerGroup, ahk_class ExploreWClass
    GroupAdd, ExplorerGroup, ahk_class #32770
    refreshMonitors()
    SetTimer("refreshMonitors", 30000)
    createUserFiles()
    loadConfig()
    cleanupDeprecated()
    createStartupLink()
    updateRegistry()
    addMissingVariables()
    icon := hs.BASENAME . ".ico"
    tip := hs.TITLE . " v" . hs.VERSION . " (AHK v" . A_AhkVersion . ") - enabled"
    Menu, Tray, Icon, %icon%,, 1
    Menu, Tray, Tip, % tip
    Menu, Tray, NoStandard
    Menu, Tray, Add, Pause, customTrayMenu
    Menu, Tray, Add, Reload, customTrayMenu
    Menu, Tray, Add, Window Spy, customTrayMenu
    Menu, Tray, Add
    Menu, Tray, Add, Home Page, customTrayMenu
    Menu, Tray, Add, Historical changes, customTrayMenu
    Menu, Tray, Add, Help, customTrayMenu
    Menu, Tray, Add
    Menu, Tray, Add, Exit, customTrayMenu
    initHotStrings()
    if (!toBool(DEV_MODE)) {
        checkVersions()
    }
    if (FileExist(hs.config.user.editor) == "") {
        if (findOnPath(hs.config.user.editor) = "") {
            msg := "The configured editor cannot be found: " . hs.config.user.editor . "`n`nTo change this, edit the " . hs.config.user.file . " file and add the 'editor' value in the [config] section."
            MsgBox, 48,, %msg%
        }
    }
    if (isFunc("userInit")) {
        userFunc := Func("userInit")
        userFunc.()
    }
    return

    customTrayMenu:
        if (A_ThisMenuItem == "Pause" || A_ThisMenuItem == "Resume") {
            Suspend
            toggleSuspend()
        }
        else if (A_ThisMenuItem == "Reload") {
            selfReload()
        }
        else if (A_ThisMenuItem == "Window Spy") {
            ahkDir := RegRead("HKEY_LOCAL_MACHINE", "SOFTWARE\AutoHotkey", "InstallDir")
            runTarget(ahkDir . "\AU3_Spy.exe")
        }
        else if (A_ThisMenuItem == "Home Page") {
            hkHotScriptHome()
        }
        else if (A_ThisMenuItem == "Historical changes") {
            Run(hs.vars.url[hs.TITLE].history)
        }
        else if (A_ThisMenuItem == "Help") {
            showQuickHelp(false)
        }
        else if (A_ThisMenuItem == "Exit") {
            stop()
        }
        return
}

initHotStrings() {
    endChars := hs.const.END_CHARS_REGEX
    mode := hs.const.replaceMode
    if (toBool(hs.config.user.enableHsAlias)) {
        hotString("\bbbl", "be back later", mode.REGEX)
        hotString("\bbbs", "be back soon", mode.REGEX)
        hotString("\bbi(\d+)" . endChars, "hsAliasBackInX", mode.REGEX)
        hotString("\bbrb", "be right back", mode.REGEX)
        hotString("\bbrt", "be right there", mode.REGEX)
        hotString("\bg2g", "Good to go!", mode.REGEX)
        hotString("\bgtg", "Got to go...", mode.REGEX)
        hotString("\bidk", "I don't know.", mode.REGEX)
        hotString("\blmc", "Let me check on that...", mode.REGEX)
        hotString("\blmk", "Let me know ", mode.REGEX)
        hotString("\bnm" . endChars, "never mind...", mode.REGEX)
        hotString("\bnmif", "Never mind, I found it.", mode.REGEX)
        hotString("\bnp" . endChars, "no problem$1", mode.REGEX)
        hotString("\bnw", "no worries", mode.REGEX)
        hotString("\bokt", "OK, thanks...", mode.REGEX)
        hotString("\bthok", "That's OK...", mode.REGEX)
        hotString("\bthx", "thanks", mode.REGEX)
        hotString("\bty" . endChars, "Thank you$1", mode.REGEX)
        hotString("\bvg" . endChars, "very good$1", mode.REGEX)
        hotString("\byw" . endChars, "You're welcome$1", mode.REGEX)
        hotString("\bwyb", "Please let me know when you are back...", mode.REGEX)
    }
    if (toBool(hs.config.user.enableHsAutoCorrect)) {
        hotString("@ip", A_IPAddress1, mode.CASE)
        hotString("(\d+)\/(\d+)%", "hsDivPercent", mode.REGEX)
        hotString("(\d+)%(\d+)" . endChars, "hsPercentOf", mode.REGEX)
        hotString("\b1\/8" . endChars, chr(8539), mode.REGEX, , "isCalculatorNotActive")
        hotString("\b1\/6" . endChars, chr(8537), mode.REGEX, , "isCalculatorNotActive")
        hotString("\b1\/5" . endChars, chr(8533), mode.REGEX, , "isCalculatorNotActive")
        hotString("\b1\/4" . endChars, chr(188), mode.REGEX, , "isCalculatorNotActive")
        hotString("\b2\/8" . endChars, chr(188), mode.REGEX, , "isCalculatorNotActive")
        hotString("\b1\/3" . endChars, chr(8531), mode.REGEX, , "isCalculatorNotActive")
        hotString("\b2\/6" . endChars, chr(8531), mode.REGEX, , "isCalculatorNotActive")
        hotString("\b3\/8" . endChars, chr(8540), mode.REGEX, , "isCalculatorNotActive")
        hotString("\b2\/5" . endChars, chr(8534), mode.REGEX, , "isCalculatorNotActive")
        hotString("\b1\/2" . endChars, chr(189), mode.REGEX, , "isCalculatorNotActive")
        hotString("\b2\/4" . endChars, chr(189), mode.REGEX, , "isCalculatorNotActive")
        hotString("\b3\/6" . endChars, chr(189), mode.REGEX, , "isCalculatorNotActive")
        hotString("\b4\/8" . endChars, chr(189), mode.REGEX, , "isCalculatorNotActive")
        hotString("\b3\/5" . endChars, chr(8535), mode.REGEX, , "isCalculatorNotActive")
        hotString("\b5\/8" . endChars, chr(8541), mode.REGEX, , "isCalculatorNotActive")
        hotString("\b2\/3" . endChars, chr(8532), mode.REGEX, , "isCalculatorNotActive")
        hotString("\b4\/6" . endChars, chr(8532), mode.REGEX, , "isCalculatorNotActive")
        hotString("\b3\/4" . endChars, chr(190), mode.REGEX, , "isCalculatorNotActive")
        hotString("\b6\/8" . endChars, chr(190), mode.REGEX, , "isCalculatorNotActive")
        hotString("\b4\/5" . endChars, chr(8536), mode.REGEX, , "isCalculatorNotActive")
        hotString("\b5\/6" . endChars, chr(8538), mode.REGEX, , "isCalculatorNotActive")
        hotString("\b7\/8" . endChars, chr(8542), mode.REGEX, , "isCalculatorNotActive")
        hotString("\b([a-z])L", "$1:", mode.REGEX)
    }
    if (toBool(hs.config.user.enableHsCode)) {
        hotString("@html", "templateHtml", mode.CASE)
        hotString("@java", "templateJava", mode.CASE)
        hotString("@perl", "templatePerl", mode.CASE)
        hotString("@sql", "templateSql", mode.CASE)
        hotString("chh", "hsCommentHeaderHtml", mode.CASE)
        hotString("chj", "hsCommentHeaderJava", mode.CASE)
        hotString("chp", "hsCommentHeaderPerl", mode.CASE)
        hotString("chs", "hsCommentHeaderSql", mode.CASE)
        hotString("\b(for|if|while) ?\(", "hsCodeBlock", mode.REGEX, false)
        hotString("\belif", "hsCodeElseIf", mode.REGEX)
        hotString("\bfunc ?\(", "hsCodeFunction", mode.REGEX)
        hotString("\bifel", "hsCodeIfElse", mode.REGEX)
        hotString("\bswitch ?\(", "hsCodeSwitch", mode.REGEX, false)
        hotString("sf.", "hsCodeStringFormat", mode.CASE)
        hotString("sysout", "hsCodeSysOut", mode.CASE)
    }
    if (toBool(hs.config.user.enableHsDates)) {
        hotString("\bdtms", "getDtmsString", mode.REGEX)
        hotString("\bdts", "getDtsString", mode.REGEX)
        hotString("\btms", "getTmsString", mode.REGEX)
        hotString("@date", "getDateString", mode.CASE)
        hotString("@day", "getDayString", mode.CASE)
        hotString("@ddd", "getDddString", mode.CASE)
        hotString("@mmm", "getMmmString", mode.CASE)
        hotString("@month", "getMonthString", mode.CASE)
        hotString("@now", "getNowString", mode.CASE)
        hotString("@time", "getTimeString", mode.CASE)
    }
    if (toBool(hs.config.user.enableHsDos)) {
        hotString("\bcd ", "/d ", mode.REGEX, false, "isActiveDos")
    }
    if (toBool(hs.config.user.enableHsHtml)) {
        ; single
        hotString("<!-", "hsHtmlComment", mode.REGEX, false)
        hotString("<a" . endChars, "hsHtmlA", mode.REGEX, false)
        hotString("<[bh]r", "/>", mode.REGEX, false)
        hotString("<h([1-6])", "hsHtmlHeader", mode.REGEX, false)
        hotString("<html", "hsHtmlHtml", , false)
        hotString("<input", "hsHtmlInput", , false)
        hotString("<link", "hsHtmlLink", , false)
        hotString("<([o|u]l)", "hsHtmlList", mode.REGEX, false)
        hotString("<optg", "hsHtmlOptGroup", , false)
        hotString("<select", "hsHtmlSelect", , false)
        hotString("<source", "hsHtmlSource", , false)
        hotString("<style", "hsHtmlStyle", , false)
        hotString("<table", "hsHtmlTable", , false)
        hotString("<texta", "hsHtmlTextarea", , false)
        hotString("<tr", "hsHtmlTr", , false)
        hotString("<xml", " version='1.0' encoding='UTF-8'?>", , false)
        ; reusable
        hotString("<(b|head|i|li|p|q|th|u)" . endChars, "hsHtmlTagNoEndChar", mode.REGEX, false)
        hotString("<(big|code|del|em|legend|pre|small|span|strong|sub|sup|td|title)", "hsHtmlTagSimple", mode.REGEX, false)
        hotString("<(block|body|div|form|header|hgroup|script|section|tbody|tfoot|thead)", "hsHtmlTagBlock", mode.REGEX, false)
        hotString("<(but|cap|field|foot|opti|sum)", "hsHtmlTagAbbr", mode.REGEX, false)
        hotString("<(iframe|img)", "hsHtmlTagSrc", mode.REGEX, false)
        hotString("<(label)", "hsHtmlTagFor", mode.REGEX, false)
    }
    if (toBool(hs.config.user.enableHsJira)) {
        ; code
        hotString("{code", "hsJiraCode")
        hotString("{java", "hsJiraCode")
        hotString("{js", "hsJiraCode")
        hotString("{sql", "hsJiraCode")
        hotString("{xml", "hsJiraCode")
        ; color
        hotString("{color", "hsJiraColor", , false)
        ; noformat
        hotString("{nof", "hsJiraNoFormat", , false)
        ; panel
        hotString("{bpan", "hsJiraPanel")
        hotString("{gpan", "hsJiraPanel")
        hotString("{pan", "hsJiraPanel")
        hotString("{rpan", "hsJiraPanel")
        hotString("{ypan", "hsJiraPanel")
        ; quote
        hotString("{quo", "hsJiraQuote", , false)
        ; special panel
        hotString("{info", "hsJiraSpecialPanel", , false)
        hotString("{note", "hsJiraSpecialPanel", , false)
        hotString("{tip", "hsJiraSpecialPanel", , false)
        hotString("{warn", "hsJiraSpecialPanel", , false)
        ; table
        hotString("{table", "hsJiraTable")
    }
    if (toBool(hs.config.user.enableHsVariables)) {
        if (MY_EMAIL != "") {
            hotString("@@", MY_EMAIL)
        }
        if (MY_PHONE != "") {
            hotString("@#", MY_PHONE)
        }
        if (MY_ADDRESS != "") {
            hotString("@addr", MY_ADDRESS, mode.CASE)
        }
        if (MY_DOB != "") {
            hotString("@dob", MY_DOB, mode.CASE)
        }
        if (MY_NAME != "") {
            hotString("@me", MY_NAME, mode.CASE)
        }
        if (MY_PASSWORD != "") {
            hotString("@pw", crypt(MY_PASSWORD), mode.CASE)
        }
        if (MY_SIGNATURE != "") {
            hotString("@sig", MY_SIGNATURE, mode.CASE)
        }
        if (MY_WORK_EMAIL != "") {
            hotString("@w", MY_WORK_EMAIL, mode.CASE)
        }
    }
}

initInternalVars() {
    hs.VERSION := "1.20160406.1"
    hs.TITLE := "HotScript"
    hs.BASENAME := A_ScriptDir . "\" . hs.TITLE

    quote := chr(34)
    markers := {
        (LTrim Join
            always_on_top: chr(5826) . chr(160),
            click_through: chr(5822) . chr(160),
            pinned: chr(4968) . chr(160),
            transparent: chr(8801) . chr(160)
        )}

    ; mode
    mode := {
        (LTrim Join
            NORMAL: 1,
            CASE: 2,
            REGEX: 3,
            CALLBACK: "!CALLBACK!"
        )}
    ; const
    hs.const := {
        (LTrim Join Comments
            COMMENT_HEADER_LINE: repeatStr("-", 70),
            END_CHARS_REGEX: "([``~!@#$%^&*()\-_=+[\]{}\\|;:'" . chr(34) . ",.<>/?\s\t\r\n])",
            EOL_MAC: "`r",
            EOL_NIX: "`n",
            EOL_WIN: "`r`n",
            EOL_REGEX: "(\r\n|\n|\r)",
            INDENT: "    ",
            LINE_SEP: repeatStr(chr(183), 157),
            MARKER: markers,
            MENU_SEP: "-",
            replaceMode: mode,
            VIRTUAL_SPACE: chr(160)
        )}
    ; file
    hs.file := {
        (LTrim Join
            CONFIG_DEFAULT: hs.BASENAME . "Default.ini",
            CONFIG_USER: hs.BASENAME . "User.ini",
            USER_FUNCTIONS: hs.BASENAME . "Functions.ahk",
            USER_KEYS: hs.BASENAME . "Keys.ahk",
            USER_STRINGS: hs.BASENAME . "Strings.ahk",
            USER_VARIABLES: hs.BASENAME . "Variables.ahk"
        )}
    ; vars
    urls := {}
    urls.ahk := {
        (LTrim Join
            download: "http://ahkscript.org/download/1.1/",
            install: "AutoHotkey{version}_Install.exe"
        )}
    urls.ahk.version := urls.ahk.download . "version.txt"
    urls[hs.TITLE] := {
        (LTrim Join
            home: "https://github.com/mviens/hotscript"
        )}
    homeRaw := urls[hs.TITLE].home . "/raw/release/"
    urls[hs.TITLE].download := homeRaw . hs.TITLE . ".ahk"
    urls[hs.TITLE].history := homeRaw . "changes.txt"
    urls[hs.TITLE].version := homeRaw . "version.txt"

    myVars := {
        (LTrim Join
            ADDRESS: "123 Main Street",
            DOB: "01/01/1980",
            EMAIL: "firstlast@mail.com",
            NAME: "First Last",
            PASSWORD: "ΡΑ₯₯φ±σεΎ",
            PHONE: "789-456-0123",
            SIGNATURE: quote . "Sincerely,``n" . quote . " . MY_NAME",
            WORK_EMAIL: "firstlast@work.com"
        )}
    hs.vars := {
        (LTrim Join Comments
            defaultMyVars: myVars,
            hiddenWindows: "",   ; TODO - this should persist, because if windows were hidden and the script was reloaded, they would be lost
            monitors: {},
            uniqueId: "_" . A_Year . "_" . A_ComputerName,
            url: urls
        )}
    ; config
    hs.config := {
        (LTrim Join
            default: new OldConfig(hs.TITLE),
            user: new OldConfig
        )}
    hs.config.default.file := hs.file.CONFIG_DEFAULT
    hs.config.user.file := hs.file.CONFIG_USER
}

is(value, type) {
    result := false
    if value is %type%
    {
        result := true
    }
    return result
}

isActiveDos() {
    return (WinActive("ahk_class ConsoleWindowClass") || WinActive("ahk_exe cmd.exe"))
}

isDirectory(text) {
    return (InStr(FileExist(text), "D") > 0)
}

isFile(text) {
    return ((FileExist(text) != "") && !isDirectory(text))
}

isUNC(text) {
    return RegexMatch(text, "\\\\[\\~`!@#$%^&\(\)\-_=+\[\]\{\};',.\d\w ]+")
}

isCalculatorNotActive() {
    procName := SetCase(getActiveProcessName(), "L")
    ; this is negated because hotString()'s "condition" parameter can only run a function, not negate it
    return (procName != "calc.exe" && procName != "calculator.exe")
}

isUrl(text) {
    ; this does not support mailto urls
    pos := RegExMatch(text, "i)^(?:\b[a-z\d.-]+://[^<>\s]+|\b(?:(?:(?:[^\s!@#$%^&*()_=+[\]{}\|;:'"",.<>/?]+)\.)+(?:ac|ad|aero|ae|af|ag|ai|al|am|an|ao|aq|arpa|ar|asia|as|at|au|aw|ax|az|ba|bb|bd|be|bf|bg|bh|biz|bi|bj|bm|bn|bo|br|bs|bt|bv|bw|by|bz|cat|ca|cc|cd|cf|cg|ch|ci|ck|cl|cm|cn|coop|com|co|cr|cu|cv|cx|cy|cz|de|dj|dk|dm|do|dz|ec|edu|ee|eg|er|es|et|eu|fi|fj|fk|fm|fo|fr|ga|gb|gd|ge|gf|gg|gh|gi|gl|gm|gn|gov|gp|gq|gr|gs|gt|gu|gw|gy|hk|hm|hn|hr|ht|hu|id|ie|il|im|info|int|in|io|iq|ir|is|it|je|jm|jobs|jo|jp|ke|kg|kh|ki|km|kn|kp|kr|kw|ky|kz|la|lb|lc|li|lk|lr|ls|lt|lu|lv|ly|ma|mc|md|me|mg|mh|mil|mk|ml|mm|mn|mobi|mo|mp|mq|mr|ms|mt|museum|mu|mv|mw|mx|my|mz|name|na|nc|net|ne|nf|ng|ni|nl|no|np|nr|nu|nz|om|org|pa|pe|pf|pg|ph|pk|pl|pm|pn|pro|pr|ps|pt|pw|py|qa|re|ro|rs|ru|rw|sa|sb|sc|sd|se|sg|sh|si|sj|sk|sl|sm|sn|so|sr|st|su|sv|sy|sz|tc|td|tel|tf|tg|th|tj|tk|tl|tm|tn|to|tp|travel|tr|tt|tv|tw|tz|ua|ug|uk|um|us|uy|uz|va|vc|ve|vg|vi|vn|vu|wf|ws|xn--0zwm56d|xn--11b5bs3a9aj6g|xn--80akhbyknj4f|xn--9t4b11yi5a|xn--deba0ad|xn--g6w251d|xn--hgbk6aj7f53bba|xn--hlcj6aya9esc7a|xn--jxalpdlp|xn--kgbechtv|xn--zckzah|ye|yt|yu|za|zm|zw)|(?:(?:[0-9]|[1-9]\d|1\d{2}|2[0-4]\d|25[0-5])\.){3}(?:[0-9]|[1-9]\d|1\d{2}|2[0-4]\d|25[0-5]))(?:[;/][^#?<>\s]*)?(?:\?[^#<>\s]*)?(?:#[^<>\s]*)?(?!\w))$", matchStr)
    return (pos == 1)
}

isWindow(hWnd) {
    WinGet, s, Style, ahk_id %hWnd%
    return (s & 0xC00000 ? (s & 0x80000000 ? false : true) : false)
}

lineUnwrapSelected() {
    selText := getSelectedText()
    selText := StrReplace(selText, A_Space . hs.const.EOL_WIN, A_Space)
    pasteText(selText)
}

lineWrapSelected() {
    selText := getSelectedText()
    static width := 80
    tmpWidth := ask("Enter Width", "Maximum number of characters per line:", width)
    if (ErrorLevel) {
        return
    }
    width := tmpWidth
    tmpWidth := "(?=.{" . width + 1 . ",})(.{1," . width - 1 . "}[^ ]) +"
    regexReplaceStr := "$1 " . getEol(selText)
    selText := RegExReplace(selText, tmpWidth, regexReplaceStr)
    pasteText(selText)
}

listToArray(list, delim:="", doTrim:=false) {
    delim := (delim == "" ? hs.const.EOL_WIN : delim)
    arr := {}
    Loop, Parse, list, %delim%
    {
        item := (toBool(doTrim) ? Trim(A_LoopField) : A_LoopField)
        arr[A_Index] := item
    }
    return arr
}

loadConfig() {
    file := hs.config.default.file
    saveDefault := false
    if (FileExist(hs.config.default.file) == "") {
        saveDefault := true
        hs.config.default.version := hs.VERSION
    }
    else {
        ; check version in default
        hs.config.default.version := IniRead(hs.config.default.file, "config", "version")
        if (hs.config.default.version != hs.VERSION) {
            ; different version so need to delete it
            FileDelete(file)
            saveDefault := true
            hs.config.default.version := hs.VERSION
        }
    }
    ; load from default config first
    hs.config.default.editor := IniRead(hs.config.default.file, "config", "editor", hs.config.default.editor)
    hs.config.default.enableAutoStart := IniRead(hs.config.default.file, "config", "enableAutoStart", toBool(hs.config.default.enableAutoStart))
    hs.config.default.enableAutoUpdate := IniRead(hs.config.default.file, "config", "enableAutoUpdate", toBool(hs.config.default.enableAutoUpdate))
    hs.config.default.enableHkAction := IniRead(hs.config.default.file, "config", "enableHkAction", toBool(hs.config.default.enableHkAction))
    hs.config.default.enableHkDos := IniRead(hs.config.default.file, "config", "enableHkDos", toBool(hs.config.default.enableHkDos))
    hs.config.default.enableHkEpp := IniRead(hs.config.default.file, "config", "enableHkEpp", toBool(hs.config.default.enableHkEpp))
    hs.config.default.enableHkMisc := IniRead(hs.config.default.file, "config", "enableHkMisc", toBool(hs.config.default.enableHkMisc))
    hs.config.default.enableHkText := IniRead(hs.config.default.file, "config", "enableHkText", toBool(hs.config.default.enableHkText))
    hs.config.default.enableHkTransform := IniRead(hs.config.default.file, "config", "enableHkTransform", toBool(hs.config.default.enableHkTransform))
    hs.config.default.enableHkWindow := IniRead(hs.config.default.file, "config", "enableHkWindow", toBool(hs.config.default.enableHkWindow))
    hs.config.default.enableHsAlias := IniRead(hs.config.default.file, "config", "enableHsAlias", toBool(hs.config.default.enableHsAlias))
    hs.config.default.enableHsAutoCorrect := IniRead(hs.config.default.file, "config", "enableHsAutoCorrect", toBool(hs.config.default.enableHsAutoCorrect))
    hs.config.default.enableHsCode := IniRead(hs.config.default.file, "config", "enableHsCode", toBool(hs.config.default.enableHsCode))
    hs.config.default.enableHsDates := IniRead(hs.config.default.file, "config", "enableHsDates", toBool(hs.config.default.enableHsDates))
    hs.config.default.enableHsDos := IniRead(hs.config.default.file, "config", "enableHsDos", toBool(hs.config.default.enableHsDos))
    hs.config.default.enableHsHtml := IniRead(hs.config.default.file, "config", "enableHsHtml", toBool(hs.config.default.enableHsHtml))
    hs.config.default.enableHsJira := IniRead(hs.config.default.file, "config", "enableHsJira", toBool(hs.config.default.enableHsJira))
    hs.config.default.enableHsVariables := IniRead(hs.config.default.file, "config", "enableHsVariables", toBool(hs.config.default.enableHsVariables))
    hs.config.default.enableVersionCheck := IniRead(hs.config.default.file, "config", "enableVersionCheck", toBool(hs.config.default.enableVersionCheck))
    hs.config.default.hkTotalCount := 0
    hs.config.default.hsTotalCount := 0
    hs.config.default.inputBoxFieldFont := IniRead(hs.config.default.file, "config", "inputBoxFieldFont", hs.config.default.inputBoxFieldFont)
    hs.config.default.inputBoxOptions := IniRead(hs.config.default.file, "config", "inputBoxOptions", hs.config.default.inputBoxOptions)
    hs.config.default.jiraPanels.format := IniRead(hs.config.default.file, "jira", "panelFormat", hs.config.default.jiraPanels.format)
    hs.config.default.jiraPanels.formatBlue := IniRead(hs.config.default.file, "jira", "panelFormatBlue", hs.config.default.jiraPanels.formatBlue)
    hs.config.default.jiraPanels.formatGreen := IniRead(hs.config.default.file, "jira", "panelFormatGreen", hs.config.default.jiraPanels.formatGreen)
    hs.config.default.jiraPanels.formatRed := IniRead(hs.config.default.file, "jira", "panelFormatRed", hs.config.default.jiraPanels.formatRed)
    hs.config.default.jiraPanels.formatYellow := IniRead(hs.config.default.file, "jira", "panelFormatYellow", hs.config.default.jiraPanels.formatYellow)
    hs.config.default.options.oracleTransformRemainderToLower := IniRead(hs.config.default.file, "options", "oracleTransformRemainderToLower", toBool(hs.config.default.options.oracleTransformRemainderToLower))
    hs.config.default.options.resolutions := IniRead(hs.config.default.file, "options", "resolutions")
    if (hs.config.default.options.resolutions == "ERROR" || getSize(hs.config.default.options.resolutions) == 0) {
        hs.config.default.options.resolutions := "640x480,&800x600,&1024x768,1280x720,1280x768,1280x800,1280x960,1&280x1024,1360x768,1&366x768,1&440x900,1600x900,1&600x1024,1680x1050,1&768x992,1&920x1080"
        saveDefault := true
    }
    hs.config.default.options.resolutions := listToArray(hs.config.default.options.resolutions, ",")
    hs.config.default.templates.html := IniRead(hs.config.default.file, "templates", "html", hs.config.default.templates.html)
    hs.config.default.templates.htmlKeys := IniRead(hs.config.default.file, "templates", "htmlKeys", hs.config.default.templates.htmlKeys)
    hs.config.default.templates.java := IniRead(hs.config.default.file, "templates", "java", hs.config.default.templates.java)
    hs.config.default.templates.javaKeys := IniRead(hs.config.default.file, "templates", "javaKeys", hs.config.default.templates.javaKeys)
    hs.config.default.templates.perl := IniRead(hs.config.default.file, "templates", "perl", hs.config.default.templates.perl)
    hs.config.default.templates.perlKeys := IniRead(hs.config.default.file, "templates", "perlKeys", hs.config.default.templates.perlKeys)
    hs.config.default.templates.sql := IniRead(hs.config.default.file, "templates", "sql", hs.config.default.templates.sql)
    hs.config.default.templates.sqlKeys := IniRead(hs.config.default.file, "templates", "sqlKeys", hs.config.default.templates.sqlKeys)
    if (loadHotKeyDefs(hs.config.default)) {
        saveDefault := true
    }
    sites := loadQuickLookupSites(hs.config.default)
    if (sites == "") {
        sites =
        (LTrim
            &Jira
            http://jira.powerschool.com/browse/@selection@
            &Confluence
            http://confluence.powerschool.com/dosearchsite.action?queryString=@selection@
            As &Application
            @selection@
            -
            -
            &Google
            http://www.google.com/search?q=@selection@
            Google &Maps
            http://www.google.com/maps/search/@selection@
            Google &Images
            http://images.google.com/images?q=@selection@
            Google Trans&late
            https://translate.google.com/#auto/en/@selection@
            -
            -
            &Dictionary
            http://dictionary.reference.com/browse/@selection@
            IMD&B
            http://www.imdb.com/find?q=@selection@
            &Thesaurus
            http://thesaurus.com/browse/@selection@
            &Urban Dictionary
            http://www.urbandictionary.com/define.php?term=@selection@
            &Wikipedia
            http://en.wikipedia.org/w/wiki.phtml?search=@selection@
            &YouTube
            http://www.youtube.com/results?search_query=@selection@
            -
            -
            AutoHotkey Manual
            http://ahkscript.org/docs/commands/@selection@.htm
            AutoHotKey Forum
            http://ahkscript.org/boards/search.php?keywords=@selection@
            -
            -
            Cancel
            Cancel
        )
        saveDefault := true
    }
    hs.config.default.quickLookupSites := sites
    if (saveDefault) {
        saveConfig(hs.config.default)
    }
    ; now load from the user config, using the values from default if necessary
    hs.config.user.editor := IniRead(hs.config.user.file, "config", "editor", hs.config.default.editor)
    hs.config.user.enableAutoStart := toBool(IniRead(hs.config.user.file, "config", "enableAutoStart", hs.config.default.enableAutoStart))
    hs.config.user.enableAutoUpdate := toBool(IniRead(hs.config.user.file, "config", "enableAutoUpdate", hs.config.default.enableAutoUpdate))
    hs.config.user.enableHkAction := toBool(IniRead(hs.config.user.file, "config", "enableHkAction", hs.config.default.enableHkAction))
    hs.config.user.enableHkDos := toBool(IniRead(hs.config.user.file, "config", "enableHkDos", hs.config.default.enableHkDos))
    hs.config.user.enableHkEpp := toBool(IniRead(hs.config.user.file, "config", "enableHkEpp", hs.config.default.enableHkEpp))
    hs.config.user.enableHkMisc := toBool(IniRead(hs.config.user.file, "config", "enableHkMisc", hs.config.default.enableHkMisc))
    hs.config.user.enableHkText := toBool(IniRead(hs.config.user.file, "config", "enableHkText", hs.config.default.enableHkText))
    hs.config.user.enableHkTransform := toBool(IniRead(hs.config.user.file, "config", "enableHkTransform", hs.config.default.enableHkTransform))
    hs.config.user.enableHkWindow := toBool(IniRead(hs.config.user.file, "config", "enableHkWindow", hs.config.default.enableHkWindow))
    hs.config.user.enableHsAlias := toBool(IniRead(hs.config.user.file, "config", "enableHsAlias", hs.config.default.enableHsAlias))
    hs.config.user.enableHsAutoCorrect := toBool(IniRead(hs.config.user.file, "config", "enableHsAutoCorrect", hs.config.default.enableHsAutoCorrect))
    hs.config.user.enableHsCode := toBool(IniRead(hs.config.user.file, "config", "enableHsCode", hs.config.default.enableHsCode))
    hs.config.user.enableHsDates := toBool(IniRead(hs.config.user.file, "config", "enableHsDates", hs.config.default.enableHsDates))
    hs.config.user.enableHsDos := toBool(IniRead(hs.config.user.file, "config", "enableHsDos", hs.config.default.enableHsDos))
    hs.config.user.enableHsHtml := toBool(IniRead(hs.config.user.file, "config", "enableHsHtml", hs.config.default.enableHsHtml))
    hs.config.user.enableHsJira := toBool(IniRead(hs.config.user.file, "config", "enableHsJira", hs.config.default.enableHsJira))
    hs.config.user.enableHsVariables := toBool(IniRead(hs.config.user.file, "config", "enableHsVariables", hs.config.default.enableHsVariables))
    hs.config.user.enableVersionCheck := toBool(IniRead(hs.config.user.file, "config", "enableVersionCheck", hs.config.default.enableVersionCheck))
    hs.config.user.hkTotalCount := IniRead(hs.config.user.file, "config", "hkTotalCount" . hs.vars.uniqueId, hs.config.default.hkTotalCount)
    hs.config.user.hsTotalCount := IniRead(hs.config.user.file, "config", "hsTotalCount" . hs.vars.uniqueId, hs.config.default.hsTotalCount)
    hs.config.user.inputBoxFieldFont := IniRead(hs.config.user.file, "config", "inputBoxFieldFont", hs.config.default.inputBoxFieldFont)
    hs.config.user.inputBoxOptions := IniRead(hs.config.user.file, "config", "inputBoxFieldFont", hs.config.default.inputBoxOptions)
    hs.config.user.jiraPanels.format := IniRead(hs.config.user.file, "jira", "panelFormat", hs.config.default.jiraPanels.format)
    hs.config.user.jiraPanels.formatBlue := IniRead(hs.config.user.file, "jira", "panelFormatBlue", hs.config.default.jiraPanels.formatBlue)
    hs.config.user.jiraPanels.formatGreen := IniRead(hs.config.user.file, "jira", "panelFormatGreen", hs.config.default.jiraPanels.formatGreen)
    hs.config.user.jiraPanels.formatRed := IniRead(hs.config.user.file, "jira", "panelFormatRed", hs.config.default.jiraPanels.formatRed)
    hs.config.user.jiraPanels.formatYellow := IniRead(hs.config.user.file, "jira", "panelFormatYellow", hs.config.default.jiraPanels.formatYellow)
    hs.config.user.options.oracleTransformRemainderToLower := toBool(IniRead(hs.config.user.file, "options", "oracleTransformRemainderToLower", hs.config.default.options.oracleTransformRemainderToLower))
    hs.config.user.options.resolutions := listToArray(IniRead(hs.config.user.file, "options", "resolutions", arrayToList(hs.config.default.options.resolutions, ",")), ",")
    hs.config.user.templates.html := IniRead(hs.config.user.file, "templates", "html", hs.config.default.templates.html)
    hs.config.user.templates.java := IniRead(hs.config.user.file, "templates", "java", hs.config.default.templates.java)
    hs.config.user.templates.perl := IniRead(hs.config.user.file, "templates", "perl", hs.config.default.templates.perl)
    hs.config.user.templates.sql := IniRead(hs.config.user.file, "templates", "sql", hs.config.default.templates.sql)
    ; set hotkeys to equal defaults, then override any from the user
    hs.config.user.hotkeys := hs.config.default.hotkeys
    loadHotKeyDefs(hs.config.user)
    sites := loadQuickLookupSites(hs.config.user)
    hs.config.user.quickLookupSites := (sites == "" ? hs.config.default.quickLookupSites : sites)
    ; save after loading to make sure any new values are persisted
    saveConfig(hs.config.user, hs.config.default)
    registerKeys()
    if (saveDefault || FileExist(hs.BASENAME . ".ico") == "") {
        createIcon()
    }
}

loadHotKeyDefs(config) {
    needToSave := false
    if (!loadHotKeys(config, "hkAction")) {
        needToSave := true
    }
    if (!loadHotKeys(config, "hkDos")) {
        needToSave := true
    }
    if (!loadHotKeys(config, "hkEpp")) {
        needToSave := true
    }
    if (!loadHotKeys(config, "hkHotScript")) {
        needToSave := true
    }
    if (!loadHotKeys(config, "hkMisc")) {
        needToSave := true
    }
    if (!loadHotKeys(config, "hkText")) {
        needToSave := true
    }
    if (!loadHotKeys(config, "hkTransform")) {
        needToSave := true
    }
    if (!loadHotKeys(config, "hkWindow")) {
        needToSave := true
    }
    return needToSave
}

loadHotKeys(config, section) {
    file := config.file
    keys := IniRead(file, section)
    keyArr := {}
    isDefault := containsIgnoreCase(config.file, "default")
    found := false
    Loop, Parse, keys, % hs.const.EOL_NIX
    {
        pos := InStr(A_LoopField, "=")
        key := SubStr(A_LoopField, 1, (pos - 1))
        value := SubStr(A_LoopField, (pos + 1))
        keyArr[(key)] := value
        found := true
    }
    if (not IsObject(config.hotkeys[(section)])) {
        config.hotkeys[(section)] := {}
    }
;    if (isDefault && !found) {
    if (isDefault) {
        keyArr := getDefaultHotKeyDefs(section)
    }
    for key, value in keyArr {
        config.hotkeys[(section)][(key)] := value
    }
    return found
}

loadQuickLookupSites(config) {
    file := config.file
    allSites := ""
    sites := IniRead(file, "quickLookup")
    Loop, Parse, sites, % hs.const.EOL_NIX
    {
        value := Trim(SubStr(A_LoopField, (InStr(A_LoopField, "=") + 1)))
        if (value != "") {
            allSites .= value . hs.const.EOL_NIX
        }
    }
    return allSites
}

maximize(hWnd:="") {
    hWnd := setCase(Trim(hWnd), "U")
    if (hWnd == "" || hWnd == "A") {
        hWnd := WinExist("A")
    }
    if (isWindow(hWnd)) {
        WinGet, minMaxState, MinMax, ahk_id %hWnd%
        if (minMaxState == 1) {
            WinRestore, ahk_id %hWnd%
        }
        else {
            WinMaximize, ahk_id %hWnd%
        }
    }
}

minimize(hWnd:="") {
    hWnd := setCase(Trim(hWnd), "U")
    if (hWnd == "" || hWnd == "A") {
        hWnd := WinExist("A")
    }
    if (isWindow(hWnd)) {
        WinGet, minMaxState, MinMax, ahk_id %hWnd%
        if (minMaxState == -1) {
            WinRestore, ahk_id %hWnd%
        }
        else {
            WinMinimize, ahk_id %hWnd%
        }
    }
}

message(msg) {
    MsgBox % msg
}

moveCurrentLineDown() {
    selText := getCurrentLine()
    eol := getEol(selText)
    hasEol := endsWith(selText, eol)
    if (!hasEol) {
        SendInput, {End}
        return
    }
    SendInput, ^x
    curText := getCurrentLine()
    eol := getEol(curText)
    hasEol := endsWith(curText, eol)
    if (hasEol) {
        SendInput, {Home}
    }
    else {
        SendInput, {End}{Enter}
    }
    SendInput, ^v
    if (hasEol) {
        SendInput, {Up}
    }
    else {
        SendInput, {Backspace}{Home}
    }
}

moveCurrentLineUp() {
    selText := getCurrentLine()
    eol := getEol(selText)
    hasEol := endsWith(selText, eol)
    SendInput, ^x{Up}^v
    if (!hasEol) {
        SendInput, {Enter}{Down}{Backspace}{Home}
    }
    SendInput, {Up}
}

moveToEdge(edge:="T", hWnd:="") {
    edge := setCase(edge, "U")
    hWnd := setCase(Trim(hWnd), "U")
    if (hWnd == "" || hWnd == "A") {
        hWnd := WinExist("A")
    }
    if (WinExist("ahk_id " . hWnd)) {
        WinGetPos, winX, winY, winW, winH, ahk_id %hWnd%
        monitor := getActiveMonitor()
        targetMon := hs.vars.monitors[monitor]
        if (edge == "B") {
            winY := (targetMon.workBottom - winH)
        }
        else if (edge == "L") {
            winX := targetMon.workLeft
        }
        else if (edge == "R") {
            winX := (targetMon.workRight - winW)
        }
        else {
            winY := targetMon.workTop
        }
        if (startsWith(A_OSVersion, "10")) {
            if (edge == "L") {
                winX += -7
            }
            else if (edge == "R") {
                winX += 7
            }
            else if (edge == "B") {
                winY += 7
            }
        }
        WinMove, ahk_id %hWnd%,, winX, winY, winW, winH
    }
}

moveToMonitor(hWnd:="", direction:=1, keepRelativeSize:=true) {
    hWnd := setCase(Trim(hWnd), "U")
    if (hWnd == "" || hWnd == "A") {
        hWnd := WinExist("A")
    }
    else if (hWnd == "M") {
        MouseGetPos(MouseX, MouseY, hWnd)
    }
    direction := (direction == -1 ? -1 : 1)
    if (!WinExist("ahk_id " . hWnd)) {
        SoundPlay, *64
        ;MsgBox, 16, moveToMonitor() - Error, Specified window does not exist. Window ID = %hWnd%
        return false
    }
    refreshMonitors()
    SysGet, monCount, MonitorCount
    if (monCount <= 1) {
        return true
    }

    Loop, % monCount
    {
        SysGet, Monitor%A_Index%, MonitorWorkArea, %A_Index%
        Monitor%A_Index%Width := Monitor%A_Index%Right - Monitor%A_Index%Left
        Monitor%A_Index%Height := Monitor%A_Index%Bottom - Monitor%A_Index%Top
    }
    WinGet, origMinMax, MinMax, ahk_id %hWnd%
    if (origMinMax == -1) {
        return false
    }
    if (origMinMax == 1) {
        WinRestore, ahk_id %hWnd%
    }
    WinGetPos, WinX, WinY, WinW, WinH, ahk_id %hWnd%
    WinCenterX := WinX + WinW / 2
    WinCenterY := WinY + WinH / 2
    curMonitor := 0
    Loop, % monCount
    {
        if ((WinCenterX >= Monitor%A_Index%Left) && (WinCenterX < Monitor%A_Index%Right) && (WinCenterY >= Monitor%A_Index%Top) && (WinCenterY < Monitor%A_Index%Bottom)) {
            curMonitor := A_Index
            break
        }
    }

    nextMonitor := curMonitor + direction
    if (nextMonitor > monCount) {
        nextMonitor := 1
    }
    else if (nextMonitor <= 0) {
        nextMonitor := monCount
    }

    WinMoveX := (WinX - Monitor%curMonitor%Left) * Monitor%NextMonitor%Width // Monitor%curMonitor%Width + Monitor%NextMonitor%Left
    WinMoveY := (WinY - Monitor%curMonitor%Top) * Monitor%NextMonitor%Height // Monitor%curMonitor%Height + Monitor%NextMonitor%Top

    WinGetClass, winClass, A
    if (winClass == "CalcFrame") {
        ; TODO - also for Windows Start menu (check Start Menu for Win10 too)
        keepRelativeSize := false
    }
    if (keepRelativeSize) {
        WinMoveW := WinW * Monitor%NextMonitor%Width // Monitor%curMonitor%Width
        WinMoveH := WinH * Monitor%NextMonitor%Height // Monitor%curMonitor%Height
    }
    else {
        WinMoveW := WinW
        WinMoveH := WinH
    }

    WinMove, ahk_id %hWnd%,, WinMoveX, WinMoveY, WinMoveW, WinMoveH
    if (origMinMax == 1) {
        WinMaximize, ahk_id %hWnd%
    }
    return true
}

numberRemoveSelected() {
    selText := getSelectedText()
    if (selText == "") {
        SendInput, {End}{Home}+{End}
        selText := getSelectedText()
    }
    if (selText != "") {
        eol := getEol(selText)
        first := true
        newText := ""
        Loop, Parse, selText, % hs.const.EOL_NIX, % hs.const.EOL_MAC
        {
            if (first) {
                first := false
            }
            else {
                newText .= eol
            }
            newText .= RegExReplace(A_LoopField, "^\d+\.\s?", "")
        }
        replaceSelected(newText)
    }
}

numberSelected(start:="1") {
    selText := getSelectedText()
    if (selText == "") {
        SendInput, {End}{Home}+{End}
        selText := getSelectedText()
    }
    if (selText != "") {
        eol := getEol(selText)
        hasEol := endsWith(selText, eol)
        if (hasEol) {
            selText := SubStr(selText, 1, 0 - StrLen(eol))
        }
        first := 1
        newText := ""
        count := start
        Loop, Parse, selText, % hs.const.EOL_NIX, % hs.const.EOL_MAC
        {
            newText .= count . ". " . A_LoopField . eol
            count++
        }
        if (!hasEol) {
            newText := SubStr(newText, 1, 0 - StrLen(eol))
        }
        replaceSelected(newText)
    }
}

numberSelectedPrompt() {
    promptNumber:
    start := ask("Auto-Number", "Starting number", 1)
    if (ErrorLevel) {
        return
    }
    if !is(start, "integer") {
        Sleep(100)
        message("Invalid starting number (" . start . ") - must be an integer.")
        goto promptNumber
    }
    else {
        numberSelected(start)
    }
}

parseTemplate(template, tokens:="") {
    for name, value in tokens {
        token := "{" . name . "}"
        template := StrReplace(template, token, value)
    }
    return template
}

pasteTemplate(template, tokens:="", keys:="", delay:=250) {
    sendText(parseTemplate(template, tokens), keys, delay)
}

pad(value, width, type:="R") {
    StringLower, type, type
    type := (type == "l" || type == "left" ? "L" : "R")
    Loop % (width - StrLen(value))
    {
        value := (type == "L" ? A_Space . value : value . A_Space)
    }
    return value
}

pasteText(text:="", delay:=250) {
    if (text != "") {
        prevClipboard := ClipboardAll
        Clipboard := ""
        eol := getEol(text)
        if (eol == hs.const.EOL_NIX) {
            ; because templates are often from a continuation section, convert EOLs to Windows (CRLF)
            text := StrReplace(text, hs.const.EOL_NIX, hs.const.EOL_WIN)
        }
        Clipboard := text
        ClipWait(1, 1)
        Sleep(50)
        if (isActiveDos()) {
            tmpCtrl := ControlGetFocus("A")
            SendMessage, 0x0111, 0xfff1, 0, %tmpCtrl%, A
            Sleep(50)
        }
        else {
            SendInput, ^v
        }
        Sleep(delay) ; wait or the clipboard is replaced with previous before it gets a chance to paste it, resulting in pasting the original clipboard
        Clipboard := prevClipboard
        Sleep(20)
        prevClipboard := ""
    }
    else {
        SendInput, {Del}
    }
    return
}

refreshMonitors() {
    SysGet, monCount, MonitorCount
    SysGet, monPrimary, MonitorPrimary
    hs.vars.monitors.count := monCount
    hs.vars.monitors.primary := monPrimary
    Loop, % hs.vars.monitors.count
    {
        SysGet, monName, MonitorName, %A_Index%
        SysGet, mon, Monitor, %A_Index%
        SysGet, monWork, MonitorWorkArea, %A_Index%
        curMon := new MonitorInfo
        curMon.idx := A_Index
        curMon.name := monName
        curMon.left := monLeft
        curMon.right := monRight
        curMon.top := monTop
        curMon.bottom := monBottom
        curMon.height := (monBottom - monTop)
        curMon.width := (monRight - monLeft)
        curMon.workLeft := monWorkLeft
        curMon.workRight := monWorkRight
        curMon.workTop := monWorkTop
        curMon.workBottom := monWorkBottom
        curMon.workHeight := (monWorkBottom - monWorkTop)
        curMon.workWidth := (monWorkRight - monWorkLeft)
        hs.vars.monitors[curMon.idx] := curMon
    }
}

registerHotkey(hkStr, funcName, restrict:="", args*) {
    static functions := {}
    static params := {}
    if (hkStr != "") {
        functions[hkStr] := Func(funcName)
        params[hkStr] := args
        ; if restricted to a particular app/window, turn on the restriction
        if (restrict != "") {
            Hotkey, IfWinActive, %restrict%
        }
        Hotkey, %hkStr%, handleHotkey
        ; turn off the restriction
        if (restrict != "") {
            Hotkey, IfWinActive
        }
    }
    return

    handleHotkey:
        addHotKey()
        functions[A_ThisHotkey].(params[A_ThisHotkey]*)
        return
}

registerKeys() {
    for section, svalue in hs.config.user.hotkeys {
        category := "enable" . setCase(SubStr(section, 1, 1), "U") . SubStr(section, 2)
        if (section == "hkHotScript" || hs.config.user[(category)]) {
            for action, kvalue in hs.config.user.hotkeys[(section)] {
                if (kvalue != "") {
                    funcName := RegExReplace(action, "-\d+$", "$1")
                    if (section == "hkDos") {
                        restrict := "ahk_class ConsoleWindowClass"
                    }
                    else if (section == "hkEpp") {
                        restrict := "ahk_exe i)EditPadPro\d*\.exe"
                    }
                    else {
                        restrict := ""
                    }
                    registerHotkey(kvalue, funcName, restrict)
                }
            }
        }
    }
}

repeatStr(value, count) {
    result := ""
    Loop, % count
    {
        result .= value
    }
    return result
}

replaceEachLine(value, line) {
    eol := getEol(value)
    hasEol := endsWith(value, eol)
    newText := ""
    Loop, Parse, value, % hs.const.EOL_NIX, % hs.const.EOL_MAC
    {
        newText .= line . eol
    }
    if (!hasEol) {
        newText := SubStr(newText, 1, 0 - StrLen(eol))
    }
    return newText
}

replaceSelected(text) {
    pasteText(text)
    ;len := StrLen(text)
    ; TODO - how to select multiple lines?
    ; get text before pasting
    ;   create an array to store leftCount
    ;   in a loop
    ;       increment leftCount for everything that is not an EOL
    ;           once an EOL is found, create new array entry for leftCount
    ;   after pasting, for each value in the array
    ;       do a Shift-Left x leftCount
    ;       then one more to handle the EOL
    ;SendInput, {Left %len%}+{Right %len%}
}

resizeTo(anchor) {
    anchor := setCase(anchor, "U")
    curMonitor := getActiveMonitor()
    curMon := hs.vars.monitors[curMonitor]
    WinGetClass, winClass, A
    ; TODO - this should also be for Start Menu, SysTray, and maybe others...
    ; TODO - need to adjust for Windows 10 calculator, too - Brady1 pushes it too far down
    if (winClass == "CalcFrame") {
        showSplash("Current window cannot be moved.", 2000)
        return
    }
    hWnd := WinExist("A")
    if (anchor == "T") {
        ; top - 100% width, 50% height
        newX := curMon.workLeft
        newY := curMon.workTop
        newH := (curMon.workHeight / 2)
        newW := curMon.workWidth
    }
    else if (anchor == "B") {
        ; bottom - 100% width, 50% height
        newX := curMon.workLeft
        newY := (curMon.workTop + (curMon.workHeight / 2))
        newH := (curMon.workHeight / 2)
        newW := curMon.workWidth
    }
    else if (anchor == "L") {
        ; left - 50% width, 100% height
        newX := curMon.workLeft
        newY := curMon.workTop
        newH := curMon.workHeight
        newW := (curMon.workWidth / 2)
    }
    else if (anchor == "R") {
        ; right - 50% width, 100% height
        newX := (curMon.workLeft + (curMon.workWidth / 2))
        newY := curMon.workTop
        newH := curMon.workHeight
        newW := (curMon.workWidth / 2)
    }
    else if (anchor == "TL") {
        ; top-left - 50% width, 50% height
        newX := curMon.workLeft
        newY := curMon.workTop
        newH := (curMon.workHeight / 2)
        newW := (curMon.workWidth / 2)
    }
    else if (anchor == "TR") {
        ; top-right - 50% width, 50% height
        newX := (curMon.workLeft + (curMon.workWidth / 2))
        newY := curMon.workTop
        newH := (curMon.workHeight / 2)
        newW := (curMon.workWidth / 2)
    }
    else if (anchor == "BL") {
        ; bottom-left - 50% width, 50% height
        newX := curMon.workLeft
        newY := (curMon.workTop + (curMon.workHeight / 2))
        newH := (curMon.workHeight / 2)
        newW := (curMon.workWidth / 2)
    }
    else if (anchor == "BR") {
        ; bottom-right - 50% width, 50% height
        newX := (curMon.workLeft + (curMon.workWidth / 2))
        newY := (curMon.workTop + (curMon.workHeight / 2))
        newH := (curMon.workHeight / 2)
        newW := (curMon.workWidth / 2)
    }
    else if (anchor == "NW") {
        ; north-west - 33% width, 33% height
        newX := curMon.workLeft
        newY := curMon.workTop
        newH := (curMon.workHeight / 3)
        newW := (curMon.workWidth / 3)
    }
    else if (anchor == "N") {
        ; north - 33% width, 33% height
        newX := (curMon.workLeft + (curMon.workWidth / 3))
        newY := curMon.workTop
        newH := (curMon.workHeight / 3)
        newW := (curMon.workWidth / 3)
    }
    else if (anchor == "NE") {
        ; north-east - 33% width, 33% height
        newX := (curMon.workLeft + ((curMon.workWidth / 3) * 2))
        newY := curMon.workTop
        newH := (curMon.workHeight / 3)
        newW := (curMon.workWidth / 3)
    }
    else if (anchor == "W") {
        ; west - 33% width, 33% height
        newX := curMon.workLeft
        newY := (curMon.workTop + (curMon.workHeight / 3))
        newH := (curMon.workHeight / 3)
        newW := (curMon.workWidth / 3)
    }
    else if (anchor == "C") {
        ; center - 33% width, 33% height
        newX := (curMon.workLeft + (curMon.workWidth / 3))
        newY := (curMon.workTop + (curMon.workHeight / 3))
        newH := (curMon.workHeight / 3)
        newW := (curMon.workWidth / 3)
    }
    else if (anchor == "E") {
        ; east - 33% width, 33% height
        newX := (curMon.workLeft + ((curMon.workWidth / 3) * 2))
        newY := (curMon.workTop + (curMon.workHeight / 3))
        newH := (curMon.workHeight / 3)
        newW := (curMon.workWidth / 3)
    }
    else if (anchor == "SW") {
        ; south-west - 33% width, 33% height
        newX := curMon.workLeft
        newY := (curMon.workTop + ((curMon.workHeight / 3) * 2))
        newH := (curMon.workHeight / 3)
        newW := (curMon.workWidth / 3)
    }
    else if (anchor == "S") {
        ; south - 33% width, 33% height
        newX := (curMon.workLeft + (curMon.workWidth / 3))
        newY := (curMon.workTop + ((curMon.workHeight / 3) * 2))
        newH := (curMon.workHeight / 3)
        newW := (curMon.workWidth / 3)
    }
    else if (anchor == "SE") {
        ; south-east - 33% width, 33% height
        newX := (curMon.workLeft + ((curMon.workWidth / 3) * 2))
        newY := (curMon.workTop + ((curMon.workHeight / 3) * 2))
        newH := (curMon.workHeight / 3)
        newW := (curMon.workWidth / 3)
    }
    else {
        message("Cannot resize window. Unknown anchor: " . anchor)
        return
    }
    if (startsWith(A_OSVersion, "10")) {
        newX += -6
        newY += -1
        newW += 16
        newH += 9
    }
    WinGet, minMaxState, MinMax, ahk_id %hWnd%
    if (minMaxState == 1) {
        WinRestore, ahk_id %hWnd%
    }
    WinMove, ahk_id %hWnd%,, %newX%, %newY%, %newW%, %newH%
}

resizeToResolution(width:=0, height:=0, title:="A") {
    addHotKey()
    resizeWindow(width, height, title)
}

resizeWindow(width:=0, height:=0, title:="A") {
    WinGetPos, x, y, w, h, %title%
    width := (width < 1 ? w : width)
    height := (height < 1 ? h : height)
    WinMove, %title%,, %x%, %y%, %width%, %height%
    centerWindow()
    showSplash("Window resized to " . width . "x" . height . "...")
}

restoreHiddenWindows() {
    Loop, Parse, % hs.vars.hiddenWindows, |
    {
        WinShow, ahk_id %A_LoopField%
        WinActivate, ahk_id %A_LoopField%
    }
    hs.vars.hiddenWindows := ""
}

reverse(str) {
    result := ""
    eol := getEol(str)
    str := StrReplace(str, eol, Chr(29))
    Loop, Parse, str
    {
        result := A_LoopField . result
    }
    result := StrReplace(result, Chr(29), eol)
    return result
}

runAhkHelp() {
    if (WinExist("AutoHotkey Help")) {
        WinActivate
    }
    else {
        SplitPath(A_AhkPath, , ahkPath)
        runTarget(ahkPath . "\AutoHotkey.chm")
    }
}

runDos(path:="") {
    exeStr := "ahk_exe cmd.exe"
    if (path == "" && WinExist(exeStr) && !WinActive(exeStr)) {
        WinActivate
    }
    else {
        if (!FileExist(path)) {
            path := ""
        }
        if (path == "") {
            path := EnvGet("SystemDrive") . "\"
        }
        runTarget(COMSPEC, path)
    }
}

runEditor(file:="") {
    SplitPath(hs.config.user.editor, editorName, editorPath)
    regExe := "i)" . StrReplace(editorName, ".", "\.")
    if (WinExist("ahk_exe " . regExe)) {
        WinActivate
    }
    target := hs.config.user.editor
    if (FileExist(target) == "") {
        target := findOnPath(target)
    }
    if (target != "") {
        target := """" . target . """"
        if (file != "") {
            target .= " """ file . """"
        }
        runTarget(target)
    }
    else {
        message("Unable to locate the configured editor: " . hs.config.user.editor)
    }
}

runQuickLookup() {
    text := getSelectedTextOrPrompt("Quick Lookup")
    text := Trim(text, (" `t" . hs.const.EOL_WIN))
    if (text != "") {
        text := urlEncode(text)
        menuDef := hs.config.user.quickLookupSites
        Loop, Parse, menuDef, % hs.const.EOL_NIX
        {
            if (Mod(A_Index, 2) == 1) {
                qtext := (A_LoopField == hs.const.MENU_SEP ? "" : A_LoopField)
                Menu, qLookupMenu, Add, %qtext%, doQuickLookup
            }
        }
        Menu qlookupMenu, Color, FFFFDD
        Menu qlookupMenu, Show
        Menu qlookupMenu, Delete
    }
    return

    doQuickLookup:
        Loop, Parse, menuDef, % hs.const.EOL_NIX
        {
            if (A_ThisMenuItemPos * 2 == A_Index) {
                if (A_LoopField != "Cancel") {
                    command := StrReplace(A_LoopField, "@selection@", text)
                    Run(command)
                    break
                }
            }
        }
        return
}

runQuickResolution() {
    for key, value in hs.config.user.options.resolutions {
        Menu, qResMenu, Add, %value%, doQuickResolution
    }
    Menu, qResMenu, Add
    Menu, qResMenu, Add, Cancel, doQuickResolution
    Menu qResMenu, Color, FFFFDD
    Menu qResMenu, Show
    Menu qResMenu, Delete
    return

    doQuickResolution:
        if (A_ThisMenuItem != "" && A_ThisMenuItem != "Cancel") {
            newRes := listToArray(StrReplace(A_ThisMenuItem, "&", ""), "x")
            resizeToResolution(newRes[1], newRes[2])
        }
        return
}

runSelectedText() {
    selText := getSelectedTextOrPrompt("Google Search")
    selText := Trim(selText, (" `t" . hs.const.EOL_WIN))
    if (selText != "") {
        if (isUrl(selText)) {
            if (!startsWith(selText, "http", 1) && !startsWith(selText, "ftp", 1) && !startsWith(selText, "www.", 1)) {
                selText := "http://" . selText
            }
            Run(selText)
        }
        else {
            tmpPath := RegexReplace(selText, "/", "\")
            if (isFile(tmpPath) || isDirectory(tmpPath) || isUNC(tmpPath)) {
                Run(tmpPath)
            }
            else {
                searchText := urlEncode(selText)
                Run("http://www.google.com/search?q=" . searchText)
            }
        }
    }
}

runServices() {
    if (WinExist("Services")) {
        WinActivate
    }
    else {
        runTarget("services.msc")
    }
}

runTarget(target, workDir:="") {
    pid := Run(target, workDir)
    if (pid != "") {
        WinWait, ahk_pid %pid%
        Sleep(250)
        WinActivate, ahk_pid %pid%
    }
}

saveConfig(config, defaultConfig:=-1) {
    file := config.file
    ; always save these values
    IniWrite(config.file, "config", "version", hs.VERSION)
    if (defaultConfig == -1) {
        ; save it, since nothing to compare against
        IniWrite(config.file, "config", "editor", config.editor)
        IniWrite(config.file, "config", "enableAutoStart", boolToStr(config.enableAutoStart))
        IniWrite(config.file, "config", "enableAutoUpdate", boolToStr(config.enableAutoUpdate))
        IniWrite(config.file, "config", "enableHkAction", boolToStr(config.enableHkAction))
        IniWrite(config.file, "config", "enableHkDos", boolToStr(config.enableHkDos))
        IniWrite(config.file, "config", "enableHkEpp", boolToStr(config.enableHkEpp))
        IniWrite(config.file, "config", "enableHkMisc", boolToStr(config.enableHkMisc))
        IniWrite(config.file, "config", "enableHkText", boolToStr(config.enableHkText))
        IniWrite(config.file, "config", "enableHkTransform", boolToStr(config.enableHkTransform))
        IniWrite(config.file, "config", "enableHkWindow", boolToStr(config.enableHkWindow))
        IniWrite(config.file, "config", "enableHsAlias", boolToStr(config.enableHsAlias))
        IniWrite(config.file, "config", "enableHsAutoCorrect", boolToStr(config.enableHsAutoCorrect))
        IniWrite(config.file, "config", "enableHsCode", boolToStr(config.enableHsCode))
        IniWrite(config.file, "config", "enableHsDates", boolToStr(config.enableHsDates))
        IniWrite(config.file, "config", "enableHsDos", boolToStr(config.enableHsDos))
        IniWrite(config.file, "config", "enableHsHtml", boolToStr(config.enableHsHtml))
        IniWrite(config.file, "config", "enableHsJira", boolToStr(config.enableHsJira))
        IniWrite(config.file, "config", "enableHsVariables", boolToStr(config.enableHsVariables))
        IniWrite(config.file, "config", "enableVersionCheck", boolToStr(config.enableVersionCheck))
        IniWrite(config.file, "config", "inputBoxFieldFont", config.inputBoxFieldFont)
        IniWrite(config.file, "config", "inputBoxOptions", config.inputBoxOptions)
        IniWrite(config.file, "jira", "panelFormat", config.jiraPanels.format)
        IniWrite(config.file, "jira", "panelFormatBlue", config.jiraPanels.formatBlue)
        IniWrite(config.file, "jira", "panelFormatGreen", config.jiraPanels.formatGreen)
        IniWrite(config.file, "jira", "panelFormatRed", config.jiraPanels.formatRed)
        IniWrite(config.file, "jira", "panelFormatYellow", config.jiraPanels.formatYellow)
        IniWrite(config.file, "options", "oracleTransformRemainderToLower", boolToStr(config.options.oracleTransformRemainderToLower))
        IniWrite(config.file, "options", "resolutions", arrayToList(config.options.resolutions, ","))
        IniWrite(config.file, "templates", "html", config.templates.html)
        IniWrite(config.file, "templates", "htmlKeys", config.templates.htmlKeys)
        IniWrite(config.file, "templates", "java", config.templates.java)
        IniWrite(config.file, "templates", "javaKeys", config.templates.javaKeys)
        IniWrite(config.file, "templates", "perl", config.templates.perl)
        IniWrite(config.file, "templates", "perlKeys", config.templates.perlKeys)
        IniWrite(config.file, "templates", "sql", config.templates.sql)
        IniWrite(config.file, "templates", "sqlKeys", config.templates.sqlKeys)
        saveQuickLookupSites(config)
        saveHotKeyDefs(config)
    }
    else {
        ; compare current against default, saving only the values that are different
        if (config.editor != defaultConfig.editor) {
            IniWrite(config.file, "config", "editor", config.editor)
        }
        if (boolToStr(config.enableAutoStart) != boolToStr(defaultConfig.enableAutoStart)) {
            IniWrite(config.file, "config", "enableAutoStart", boolToStr(config.enableAutoStart))
        }
        if (boolToStr(config.enableAutoUpdate) != boolToStr(defaultConfig.enableAutoUpdate)) {
            IniWrite(config.file, "config", "enableAutoUpdate", boolToStr(config.enableAutoUpdate))
        }
        if (boolToStr(config.enableHkAction) != boolToStr(defaultConfig.enableHkAction)) {
            IniWrite(config.file, "config", "enableHkAction", boolToStr(config.enableHkAction))
        }
        if (boolToStr(config.enableHkDos) != boolToStr(defaultConfig.enableHkDos)) {
            IniWrite(config.file, "config", "enableHkDos", boolToStr(config.enableHkDos))
        }
        if (boolToStr(config.enableHkEpp) != boolToStr(defaultConfig.enableHkEpp)) {
            IniWrite(config.file, "config", "enableHkEpp", boolToStr(config.enableHkEpp))
        }
        if (boolToStr(config.enableHkMisc) != boolToStr(defaultConfig.enableHkMisc)) {
            IniWrite(config.file, "config", "enableHkMisc", boolToStr(config.enableHkMisc))
        }
        if (boolToStr(config.enableHkText) != boolToStr(defaultConfig.enableHkText)) {
            IniWrite(config.file, "config", "enableHkText", boolToStr(config.enableHkText))
        }
        if (boolToStr(config.enableHkWindow) != boolToStr(defaultConfig.enableHkWindow)) {
            IniWrite(config.file, "config", "enableHkWindow", boolToStr(config.enableHkWindow))
        }
        if (boolToStr(config.enableHsAlias) != boolToStr(defaultConfig.enableHsAlias)) {
            IniWrite(config.file, "config", "enableHsAlias", boolToStr(config.enableHsAlias))
        }
        if (boolToStr(config.enableHsAutoCorrect) != boolToStr(defaultConfig.enableHsAutoCorrect)) {
            IniWrite(config.file, "config", "enableHsAutoCorrect", boolToStr(config.enableHsAutoCorrect))
        }
        if (boolToStr(config.enableHsCode) != boolToStr(defaultConfig.enableHsCode)) {
            IniWrite(config.file, "config", "enableHsCode", boolToStr(config.enableHsCode))
        }
        if (boolToStr(config.enableHsDates) != boolToStr(defaultConfig.enableHsDates)) {
            IniWrite(config.file, "config", "enableHsDates", boolToStr(config.enableHsDates))
        }
        if (boolToStr(config.enableHsDos) != boolToStr(defaultConfig.enableHsDos)) {
            IniWrite(config.file, "config", "enableHsDos", boolToStr(config.enableHsDos))
        }
        if (boolToStr(config.enableHsHtml) != boolToStr(defaultConfig.enableHsHtml)) {
            IniWrite(config.file, "config", "enableHsHtml", boolToStr(config.enableHsHtml))
        }
        if (boolToStr(config.enableHsJira) != boolToStr(defaultConfig.enableHsJira)) {
            IniWrite(config.file, "config", "enableHsJira", boolToStr(config.enableHsJira))
        }
        if (boolToStr(config.enableHsVairables) != boolToStr(defaultConfig.enableHsVariables)) {
            IniWrite(config.file, "config", "enableHsVariables", boolToStr(config.enableHsVariables))
        }
        if (boolToStr(config.enableVersionCheck) != boolToStr(defaultConfig.enableVersionCheck)) {
            IniWrite(config.file, "config", "enableVersionCheck", boolToStr(config.enableVersionCheck))
        }
        if (config.inputBoxFieldFont != defaultConfig.inputBoxFieldFont) {
            IniWrite(config.file, "config", "inputBoxFieldFont", config.inputBoxFieldFont)
        }
        if (config.inputBoxOptions != defaultConfig.inputBoxOptions) {
            IniWrite(config.file, "config", "inputBoxOptions", config.inputBoxOptions)
        }
        ; always save these values
        IniWrite(config.file, "config", "hkTotalCount" . hs.vars.uniqueId, config.hkTotalCount)
        IniWrite(config.file, "config", "hsTotalCount" . hs.vars.uniqueId, config.hsTotalCount)
        if (config.jiraPanels.format != defaultConfig.jiraPanels.format) {
            IniWrite(config.file, "jira", "panelFormat", config.jiraPanels.format)
        }
        if (config.jiraPanels.formatBlue != defaultConfig.jiraPanels.formatBlue) {
            IniWrite(config.file, "jira", "panelFormatBlue", config.jiraPanels.formatBlue)
        }
        if (config.jiraPanels.formatGreen != defaultConfig.jiraPanels.formatGreen) {
            IniWrite(config.file, "jira", "panelFormatGreen", config.jiraPanels.formatGreen)
        }
        if (config.jiraPanels.formatRed != defaultConfig.jiraPanels.formatRed) {
            IniWrite(config.file, "jira", "panelFormatRed", config.jiraPanels.formatRed)
        }
        if (config.jiraPanels.formatYellow != defaultConfig.jiraPanels.formatYellow) {
            IniWrite(config.file, "jira", "panelFormatYellow", config.jiraPanels.formatYellow)
        }
        if (config.options.oracleTransformRemainderToLower != defaultConfig.options.oracleTransformRemainderToLower) {
            IniWrite(config.file, "options", "oracleTransformRemainderToLower", boolToStr(config.options.oracleTransformRemainderToLower))
        }
        if (arrayToList(config.options.resolutions, ",") != arrayToList(defaultConfig.options.resolutions, ",")) {
            IniWrite(config.file, "options", "resolutions", arrayToList(config.options.resolutions, ","))
        }
        if (config.templates.html != defaultConfig.templates.html) {
            IniWrite(config.file, "templates", "html", config.templates.html)
        }
        if (config.templates.htmlKeys != defaultConfig.templates.htmlKeys) {
            IniWrite(config.file, "templates", "htmlKeys", config.templates.htmlKeys)
        }
        if (config.templates.java != defaultConfig.templates.java) {
            IniWrite(config.file, "templates", "java", config.templates.java)
        }
        if (config.templates.javaKeys != defaultConfig.templates.javaKeys) {
            IniWrite(config.file, "templates", "javaKeys", config.templates.javaKeys)
        }
        if (config.templates.perl != defaultConfig.templates.perl) {
            IniWrite(config.file, "templates", "perl", config.templates.perl)
        }
        if (config.templates.perlKeys != defaultConfig.templates.perlKeys) {
            IniWrite(config.file, "templates", "perlKeys", config.templates.perlKeys)
        }
        if (config.templates.sql != defaultConfig.templates.sql) {
            IniWrite(config.file, "templates", "sql", config.templates.sql)
        }
        if (config.templates.sqlKeys != defaultConfig.templates.sqlKeys) {
            IniWrite(config.file, "templates", "sqlKeys", config.templates.sqlKeys)
        }
        if (config.quickLookupSites != defaultConfig.quickLookupSites) {
            saveQuickLookupSites(config)
        }
        saveHotKeyDefs(config, defaultConfig)
    }
}

saveHotKeyDefs(config, defaultConfig:=false) {
    IniDelete(config.file, "hotkeys")
    for section, sectionValue in config.hotkeys {
        for key, keyValue in config.hotkeys[(section)] {
            doSave := false
            if (!defaultConfig) {
                doSave := true
            }
            else {
                defKeyValue := defaultConfig.hotkeys[(section)][(key)]
                if (keyValue != defKeyValue) {
                    doSave := true
                }
            }
            if (doSave) {
                IniWrite(config.file, section, key, keyValue)
            }
        }
    }
}

saveQuickLookupSites(config) {
    sites := config.quickLookupSites
    keyCount := 1
    key := ""
    IniDelete(config.file, "quickLookup")
    Loop, Parse, sites, % hs.const.EOL_NIX
    {
        value := Trim(A_LoopField)
        if (value != "") {
            key := "site" . keyCount . (endsWith(key, "Name") ? "URL" : "Name")
            IniWrite(config.file, "quickLookup", key, value)
            if (endsWith(key, "URL")) {
                keyCount++
            }
        }
    }
}

scrollWindow(direction, title:="A") {
    direction := StringLower(direction)
    ; see https://msdn.microsoft.com/en-us/library/windows/desktop/bb787577(v=vs.85).aspx
    if (direction == "bottom") {
        scroll := 7
    }
    else if (direction == "pgup") {
        scroll := 2
    }
    else if (direction == "pgdn") {
        scroll := 3
    }
    else if (direction == "top") {
        scroll := 6
    }
    control := ControlGetFocus("A")
    SendMessage, 0x115, %scroll%, 0, %control%, A
}

selectCurrentLine() {
    SendInput, {Home}+{Down}
    selText := getSelectedText()
    if (selText == "") {
        SendInput, {Home}+{End}
        selText := getSelectedText()
    }
    return selText
}

selectInExplorer(list) {
    if (WinActive("ahk_group ExplorerGroup")) {
        hwnd := WinExist("A")
        for win in ComObjCreate("Shell.Application").Windows {
            if (win.hwnd != hwnd) {
                continue
            }
            win.Refresh()
            doc := win.Document
            items := doc.Folder.Items
            for item in items {
                doc.SelectItem(item, contains(item.Name, list))
            }
        }
    }
}

selectOnDesktop(list) {
    if (WinActive("ahk_group DesktopGroup")) {
        shellWindows := ComObjCreate("Shell.Application").Windows
        VarSetCapacity(hwnd, 4, 0)
        desktop := shellWindows.FindWindowSW(0, "", 8, ComObj(0x4003, &hwnd), 1)
        doc := desktop.Document
        items := doc.SelectedItems
        Loop % items.Count {
            doc.SelectItem(items.Item(A_Index - 1), 0)
        }
        desktop.Refresh()
        items := doc.Folder.Items
        for item in items {
            doc.SelectItem(item, contains(item.Name, list))
        }
    }
}

selfReload(silent:=false) {
    if (!silent) {
        showSplash("Reloading script...", 500)
    }
    Reload
    Sleep(1000)
    MsgBox, 4,, The script could not be reloaded. Would you like to open it for editing?
    IfMsgBox, Yes
    {
        runEditor(A_ScriptFullPath)
    }
}

sendText(text, keys:="", delay:="250") {
    pasteText(text, delay)
    if (keys != "") {
        SendInput, %keys%
    }
}

setCase(value, case) {
    case := StringUpper(case)
    result := ""
    if (case == "I") {
        Loop, Parse, value
        {
            if is(A_LoopField, "upper") {
                result .= Chr(Asc(A_LoopField) + 32)
            }
            else if is(A_LoopField, "lower") {
                result .= Chr(Asc(A_LoopField) - 32)
            }
            else {
                result .= A_LoopField
            }
        }
    }
    else if (case == "L") {
        result := StringLower(value)
    }
    else if (case == "S") {
        result := StringLower(value)
        result := RegExReplace(result, "((?:^|[.!?]\s+)[a-z])", "$u1")
        result := RegExReplace(result, "(\bi\b)", "$u1")
    }
    else if (case == "T") {
        result := StringUpper(value, "T")
    }
    else if (case == "U") {
        result := StringUpper(value)
    }
    else {
        result := value
    }
    return result
}

setTransparency(increase:=true, hWnd:="A") {
    MAX := 255
    MIN := 7
    hWnd := setCase(Trim(hWnd), "U")
    if (hWnd == "" || hWnd == "A") {
        hWnd := WinExist("A")
    }
    if (isWindow(hWnd)) {
        WinGet, curTrans, Transparent, ahk_id %hWnd%
        if (!curTrans) {
            curTrans := MAX
        }
        newTrans := curTrans + (increase ? 8 : -8)
        if (newTrans > MAX) {
            newTrans := MAX
        }
        else if (newTrans < MIN) {
            newTrans := MIN
        }
        if (newTrans != curTrans) {
            WinGetTitle, currentTitle, ahk_id %hWnd%
            newTitle := RegExReplace(currentTitle, hs.const.MARKER.transparent . "\(\d{1,3}%\) ")
            WinSet, Transparent, %newTrans%, ahk_id %hWnd%
            if (newTrans < MAX) {
                percent := Round((newTrans / (MAX + 1)) * 100)
                newTitle := hs.const.MARKER.transparent . "(" . percent . "%) " + newTitle
            }
            WinSetTitle, ahk_id %hWnd%, , %newTitle%
        }
    }
}

showClipboard() {
    clipSize := StrLen(Clipboard)
    clipAll := ClipboardAll
    clipAllSize := StrLen(clipAll) * (A_IsUnicode ? 2 : 1)
    if (clipSize == 0 && clipAllSize > 0) {
        clipPreview := "{Complex data - image or advanced formatting}"
    }
    else {
        clipPreview := (clipSize == 0 ? "{Empty}" : Clipboard)
    }
    header := "Clipboard preview:" . hs.const.EOL_NIX . hs.const.LINE_SEP
    splashTitle := hs.TITLE . "Splash"
    Progress("B1 C00 CT000000 CWFFFFDD FM11 FS10 W1200 WM1200 ZH0", clipPreview, header, splashTitle, "Courier New")
    centerWindow(splashTitle)
    KeyWait("v")
    Progress("off")
}

showQuickHelp(waitforKey) {
    static isShowing := false
    if (isShowing) {
        KeyWait("h")
        Gui, 2: Destroy
        isShowing := false
        return
    }

    eol := hs.const.EOL_NIX
    vspace := hs.const.VIRTUAL_SPACE
    colLine := "`t"
    spacer := vspace . "`t`t`t`t`t"
    pointer := chr(9492) . chr(9472) . chr(9658)
    pointerExtend := chr(9474)
    trimChars := "`t " . vspace

    hkActionHelpEnabled =
    (LTrim
        Action hotkeys`t`t`t
        %colLine%
        [W]-A`t`tToggle always-on-top`t
        [CW]-A`t`tToggle click-through`t
        [W]-C`t`tRun Calculator`t`t
        [W]-D`t`tRun DOS`t`t`t
        [AW]-D`t`tRun DOS from Explorer`t
        [W]-E`t`tRun editor`t`t
        [W]-G`t`tGoogle (or goto)`t
        [W]-M`t`tCharacter Map`t`t
        [W]-Q`t`tQuick Lookup`t`t
        [W]-S`t`tRun Windows Services`t
        [AW]-S`t`tExplore 'Startup'`t
        [W]-X`t`tRun Windows Explorer`t
        [W]-PrintScreen`tRun Snipping tool`t
        [LC]-[RC]`tRun Control Panel`t
        [A]-Apps`tToggle desktop icons`t
    )
    hkActionHelpDisabled := replaceEachLine(hkActionHelpEnabled, spacer)
    hkActionHelp := (hs.config.user.enableHkAction ? hkActionHelpEnabled : hkActionHelpDisabled)

    hkDosHelpEnabled =
    (LTrim Comments
        %spacer%
        DOS hotkeys`t`t`t
        %colLine%
        [A]-C`t`t"copy "`t`t`t
        [A]-D`t`tPUSHD to Downloads`t
        [C]-Delete`tDelete to EOL`t`t
        [C]-End`t`tScroll to bottom`t
        [C]-Home`tScroll to top`t`t
        [A]-M`t`t"move "`t`t`t
        [A]-P`t`t"pushd "`t`t
        [C]-P`t`tPOP to last dir`t`t
        [C]-PgDn`tScroll down 1 page`t
        [C]-PgUp`tScroll up 1 page`t
        [A]-R`t`tCD to root dir`t`t
        [A]-T`t`t"type "`t`t`t
        [A]-Up / [A]-.`tCD to parent dir`t
        [C]-V`t`tPaste clipboard`t`t
        [A]-X`t`tRun 'exit'`t`t
    )
    hkDosHelpDisabled := replaceEachLine(hkDosHelpEnabled, spacer)
    hkDosHelp := (hs.config.user.enableHkDos ? hkDosHelpEnabled : hkDosHelpDisabled)

;    hkEppHelpEnabled =
;    (LTrim
;        EditPad Pro hotkeys`t`t`t
;        %colLine%
;        [A]-Delete`tDelete line`t`t`t
;        [A]-Down`tMove line down`t`t`t
;        [A]-Up`t`tMove line up`t`t`t
;        [C]-D`t`tDelete word`t`t`t
;        [C]-Delete`tDelete to EOL`t`t`t
;        [C]-G`t`tGo to line`t`t`t
;        XButton1`tPrevious file`t`t`t
;        XButton2`tNext file`t`t`t
;    )
;    hkEppHelpDisabled := replaceEachLine(hkEppHelpEnabled, spacer)
;    hkEppHelp := (hs.config.user.enableHkEpp ? hkEppHelpEnabled : hkEppHelpDisabled)

    title := hs.TITLE
    hkHotScriptHelp =
    (LTrim Comments
        %spacer%
        %title% hotkeys`t`t`t
        %colLine%
        [AW]-H`t`tExplore '%title%'`t
        [CW]-H`t`tToggle quick help`t
        [CW]-F12`tShow variable`t`t
        [W]-F12`t`tExit %title%`t`t
        [W]-H`t`tShow quick help`t`t
        [W]-1`t`tRun AHK help`t`t
        [W]-2`t`tReload %title%`t
        [W]-3`t`tEdit %title%`t`t
        [W]-4`t`tEdit user keys`t`t
        [W]-5`t`tEdit user strings`t
        [W]-6`t`tEdit user variables`t
        [W]-7`t`tEdit user functions`t
        [W]-8`t`tEdit user INI`t`t
        [W]-9`t`tEdit default INI`t
        [W]-0`t`t%title% home page`t`t
        [W]-Pause`tPause %title%`t`t
        [W]-```t`tRun DebugView`t`t
        %spacer%
        %spacer%
    )

    hkMiscHelpEnabled =
    (LTrim
        Miscellaneous hotkeys
        %colLine%
        [CA]-A`t`tCopy Append
        [CA]-C`t`tSwap to clipboard
        [CA]-D`t`tCreate directory
        [CA]-F`t`tCreate file
        [CA]-V`t`tPaste as text
        [CA]-X`t`tCut Append
        [W]-Enter`tPastes 'enter'
        [W]-Tab`t`tPastes 'tab'
        [W]-V`t`tPreview clipboard
        [W]-Z`t`tShow zoom window
        [AW]-ARROW`tMove mouse 1px
        [CAW]-ARROW`tDrag mouse 1px
    )
    hkMiscHelpDisabled := replaceEachLine(hkMiscHelpEnabled, spacer)
    hkMiscHelp := (hs.config.user.enableHkMisc ? hkMiscHelpEnabled : hkMiscHelpDisabled)

    hkTextHelpEnabled =
    (LTrim
        %spacer%
        Text hotkeys`t`t`t
        %colLine%
        [A]-Delete`tDelete line`t`t
        [A]-Down`tMove line down`t`t
        [A]-Up`t`tMove line up`t`t
        [CS]-Up`t`tDuplicate line`t`t
        %spacer%
    )
    hkTextHelpDisabled := replaceEachLine(hkTextHelpEnabled, spacer)
    hkTextHelp := (hs.config.user.enableHkText ? hkTextHelpEnabled : hkTextHelpDisabled)

    hkTransformHelpEnabled =
    (LTrim
        Transform hotkeys`t`t`t
        %colLine%
        [CS]-```t`tEscape text`t`t
        [CS]-A`t`tSort ascending`t`t
        [CAS]-A`t`tSort ascending (case)`t
        [CS]-D`t`tSort descending`t`t
        [CAS]-D`t`tSort descending (case)`t
        [CS]-E`t`tEncrypt text`t`t
        [CS]-I`t`tiNVERT cASE`t`t
        [CS]-L`t`tlower case`t`t
        [CA]-N`t`tAuto-Denumber`t`t
        [CAS]-N`t`tAuto-number (prompt)`t
        [CS]-N`t`tAuto-number (1)`t`t
        [CS]-O`t`tOracle words to UPPER`t
        [CS]-R`t`tReverse text`t`t
        [CS]-S`t`tSentence case`t`t
        [CS]-T`t`tTitle Case`t`t
        [CS]-U`t`tUPPER case`t`t
        [CA]-W`t`tUnwrap wrapped text`t
        [CS]-W`t`tWrap text at width`t
        [AS]-KEY`tTagify text`t`t
        %A_SPACE%%A_SPACE%%A_SPACE%%A_SPACE%%A_SPACE%%A_SPACE%%pointer% KEY is: < >`t`t`t
        [CA]-KEY`tWrap in SYMBOLS`t`t
        [AW]-KEY`tWrap each in SYMBOLS`t
        %A_SPACE%%A_SPACE%%A_SPACE%%A_SPACE%%A_SPACE%%A_SPACE%%pointer% KEY is: [ ] '`t`t`t
        [CS]-KEY`tWrap in SYMBOLS`t`t
        [SW]-KEY`tWrap each in SYMBOLS`t
        %A_SPACE%%A_SPACE%%A_SPACE%%A_SPACE%%A_SPACE%%A_SPACE%%pointer% KEY is: ( ) { } " < >`t`t
    )
    hkTransformHelpDisabled := replaceEachLine(hkTransformHelpEnabled, spacer)
    hkTransformHelp := (hs.config.user.enableHkTransform ? hkTransformHelpEnabled : hkTransformHelpDisabled)

    hkWindowHelpEnabled =
    (LTrim
        Window hotkeys`t`t`t
        %colLine%
        [A]-WheelDown`tPageDown`t`t
        [A]-WheelUp`tPageUp`t`t`t
        WheelLeftTilt`tMove to left monitor`t
        WheelRightTilt`tMove to right monitor`t
        [W]-- / [W]-Whl`tDecrease transparency`t
        [W]-+ / [W]-Whl`tIncrease transparency`t
        [W]-Delete`tHide active window`t
        [W]-Down`tMinimize the window`t
        [W]-Insert`tShow hidden windows`t
        [W]-Home`tCenter current window`t
        [W]-Left`tMove to prev. monitor`t
        [CW]-M`t`tToggle minimized`t
        [CW]-R`t`tQuick Resolutions`t
        [W]-Right`tMove to next monitor`t
        [W]-T`t`tToggle transparency`t
        [W]-Up`t`tMaximize the window`t
        [CW]-ARROW`tMove to edge`t`t
        [SW]-ARROW`tResize to edge (50`%)`t
        [SW]-DnLt`tResize to SW (25`%)`t
        [SW]-DnRt`tResize to SE (25`%)`t
        [SW]-UpLt`tResize to NW (25`%)`t
        [SW]-UpRt`tResize to NE (25`%)`t
        [W]-KEY`t`tResize to grid (11`%)`t
        %A_SPACE%%A_SPACE%%A_SPACE%%A_SPACE%%A_SPACE%%pointer% KEY is: NumPad # (1-9)`t`t
        %spacer%
        %spacer%
        %spacer%
        %spacer%
        %spacer%
        %spacer%
        %spacer%
        %spacer%
        %spacer%
        %spacer%
    )
    hkWindowHelpDisabled := replaceEachLine(hkWindowHelpEnabled, spacer)
    hkWindowHelp := (hs.config.user.enableHkWindow ? hkWindowHelpEnabled : hkWindowHelpDisabled)

    hkHeader := vspace . "`t`t`t`t`t[ C = Ctrl  |  A = Alt  |  S = Shift  |  W = Win  |  L = Left  |  R = Right ]" . eol . eol
    hkCol1 := hkActionHelp . eol . hkDosHelp
    hkCol2 := hkWindowHelp
    hkCol3 := hkTransformHelp . eol . hkTextHelp
    hkCol4 := hkMiscHelp . eol . hkHotScriptHelp
;    hkCol5 := hkEppHelp

    hkArr1 := listToArray(hkCol1)
    hkArr2 := listToArray(hkCol2)
    hkArr3 := listToArray(hkCol3)
    hkArr4 := listToArray(hkCol4)
;    hkArr5 := listToArray(hkCol5)

    hkResult := hkHeader
    for key, value in hkArr1
    {
        ;hkResult .= LTrim(RTrim(value . hkArr2[key] . hkArr3[key] . hkArr4[key] . hkArr5[key], trimChars)) . eol
        hkResult .= LTrim(RTrim(value . hkArr2[key] . hkArr3[key] . hkArr4[key], trimChars)) . eol
    }
    hkResult := RegexReplace(hkResult, "<", "&lt;")
    hkResult := RegexReplace(hkResult, ">", "&gt;")
    hkResult := RegexReplace(hkResult, "(C|A|S|W|L|R)( =)", "<span class=""mod"">$1</span>$2")
    hkResult := RegexReplace(hkResult, "([A-Z][^\t\n]+ )(hot)(keys)", "<span class=""section"">$1$3</span>`t")
    hkResult := RegexReplace(hkResult, "(\[\w+\])", "<span class=""mod"">$1</span>")
    hkResult := RegexReplace(hkResult, "(-)(KEY)", "$1<span class=""explain"">$2</span>")
    hkResult := RegexReplace(hkResult, vspace, "&nbsp;")

    hsAliasHelpEnabled =
    (LTrim
        Alias hotstrings`t`t`t
        %colLine%
        bbl`tbe back later`t`t`t
        bbs`tbe back soon`t`t`t
        bi#%vspace%`tback in # minutes`t`t
        brb`tbe right back`t`t`t
        brt`tbe right there`t`t`t
        g2g`tGood to go.`t`t`t
        gtg`tGot to go.`t`t`t
        idk`tI don't know.`t`t`t
        lmc`tLet me check on that...`t`t
        lmk`tLet me know `t`t`t
        nm%vspace%`tnever mind...`t`t`t
        nmif`tNever mind, I found it.`t`t
        np%vspace%`tno problem`t`t`t
        nw`tno worries`t`t`t
        okt`tOK, thanks...`t`t`t
        thok`tThat's OK...`t`t`t
        thx`tthanks`t`t`t`t
        ty%vspace%`tThank you.`t`t`t
        vg%vspace%`tvery good`t`t`t
        yw%vspace%`tYou're welcome`t`t`t
        wyb`tLet me know when you are back`t
        %spacer%
        %spacer%
        %spacer%
        %spacer%
        %spacer%
        %spacer%
        %spacer%
        %spacer%
        %spacer%
        %spacer%
    )
    hsAliasHelpDisabled := replaceEachLine(hsAliasHelpEnabled, spacer)
    hsAliasHelp := (hs.config.user.enableHsAlias ? hsAliasHelpEnabled : hsAliasHelpDisabled)

    hsAutoCorrectHelpEnabled =
    (LTrim
        %spacer%
        Auto-correct hotstrings`t`t
        %colLine%
        @ip`tCurrent IP address`t`t
        #/#`%`tdivide as percent`t`t
        #`%#%vspace%`tpercent of number`t`t
        #/#%vspace%`tCommon fractions (n/[2-6,8])`t
        [c-z]L`t[c-z]:`t`t`t`t
    )
    hsAutoCorrectHelpDisabled := replaceEachLine(hsAutoCorrectHelpEnabled, spacer)
    hsAutoCorrectHelp := (hs.config.user.enableHsAutoCorrect ? hsAutoCorrectHelpEnabled : hsAutoCorrectHelpDisabled)

    hsCodeHelpEnabled =
    (LTrim
        %spacer%
        Code hotstrings`t`t`t
        %colLine%
        @html`tHTML template`t`t`t
        @java`tJava template`t`t`t
        @perl`tPerl template`t`t`t
        @sql`tSQL template`t`t`t
        chh`tComment header: HTML`t`t
        chj`tComment header: Java/JS`t`t
        chp`tComment header: Perl`t`t
        chs`tComment header: SQL`t`t
        elif`t'else/if' block`t`t`t
        for(`t'for' block`t`t`t
        func(`t'function' block`t`t
        if(`t'if' block`t`t`t
        ifel`t'if/else' block`t`t`t
        sf%vspace%`tString.format("", )`t`t
        switch(`t'switch' block`t`t`t
        sysout`tSystem.out.println("");`t`t
        while(`t'while' block`t`t`t
    )
    hsCodeHelpDisabled := replaceEachLine(hsCodeHelpEnabled, spacer)
    hsCodeHelp := (hs.config.user.enableHsCode ? hsCodeHelpEnabled : hsCodeHelpDisabled)

    hsDatesHelpEnabled =
    (LTrim
        Date/Time hotstrings`t`t
        %colLine%
        dtms`tYYYYMDD_24MMSS`t`t`t
        dts`tYYYYMMDD`t`t`t
        tms`t24MMSS`t`t`t`t
        @date`tMM/DD/YYYY`t`t`t
        @day`tDay name`t`t`t
        @ddd`tDay name (abbr.)`t`t
        @mmm`tMonth name (abbr.)`t`t
        @month`tMonth name`t`t`t
        @now`tMM/DD/YYYY at 24:MM:SS`t`t
        @time`t24:MM:SS`t`t`t
    )
    hsDatesHelpDisabled := replaceEachLine(hsDatesHelpEnabled, spacer)
    hsDatesHelp := (hs.config.user.enableHsDates ? hsDatesHelpEnabled : hsDatesHelpDisabled)

    hsDosHelpEnabled =
    (LTrim
        DOS hotstrings`t`t`t
        %colLine%
        cd`tcd /d`t`t`t`t
    )
    hsDosHelpDisabled := replaceEachLine(hsDosHelpEnabled, spacer)
    hsDosHelp := (hs.config.user.enableHsDos ? hsDosHelpEnabled : hsDosHelpDisabled)

    hsHtmlHelpEnabled =
    (LTrim
        %spacer%
        HTML/XML hotstrings`t`t
        %colLine%
        <TAG`tMost HTML tags auto-complete`t
        %A_SPACE%%A_SPACE%%pointerExtend%`t(Some create child tags)`t
        %A_SPACE%%A_SPACE%%pointer% TAG is any of the following:`t
        `ta/b/big/block/body/br/but/cap`t
        `tcode/del/div/em/field/foot`t
        `tform/h[1-6]/head/header`t`t
        `thgroup/hr/html/i/iframe/img`t
        `tinput/label/legend/li/link/ol`t
        `toptg/opti/p/pre/q/script`t
        `tsection/select/small/source`t
        `tspan/strong/style/sub/sum`t
        `tsup/table/tbody/td/texta`t
        `ttfoot/th/thead/title/tr/u/ul`t
        <xml`tAuto-completes XML header`t
    )
    hsHtmlHelpDisabled := replaceEachLine(hsHtmlHelpEnabled, spacer)
    hsHtmlHelp := (hs.config.user.enableHsHtml ? hsHtmlHelpEnabled : hsHtmlHelpDisabled)

    hsJiraHelpEnabled =
    (LTrim
        %spacer%
        Jira/Confluence hotstrings`t`t
        %colLine%
        `{bpan`t'panel' tags (blue)`t`t`t
        `{code`t'code' tags for simple code`t`t
        `{color`t'color' tags`t`t`t
        `{gpan`t'panel' tags (green)`t`t`t
        `{info`t'info' tags`t`t`t
        `{java`t'code' tags for Java`t`t
        `{js`t'code' tags for JavaScript`t
        `{nof`t'noformat' tags`t`t`t
        `{note`t'note' tags`t`t`t
        `{pan`t'panel' tags`t`t`t
        `{quo`t'quote' tags`t`t`t
        `{rpan`t'panel' tags (red)`t`t`t
        `{sql`t'code' tags for SQL`t`t
        `{table`tA simple 5-column table`t`t`t
        `{tip`t'tip' tags`t`t`t
        `{warn`t'warn' tags`t`t`t
        `{xml`t'code' tags for XML`t`t
        `{ypan`t'panel' tags (yellow)`t`t`t
    )
    hsJiraHelpDisabled := replaceEachLine(hsJiraHelpEnabled, spacer)
    hsJiraHelp := (hs.config.user.enableHsJira ? hsJiraHelpEnabled : hsJiraHelpDisabled)

    hsVariableHelpEnabled =
    (LTrim
        Variable hotstrings`t`t
        %colLine%
        @@`temail address`t`t`t
        @#`tphone number`t`t`t
        @addr`taddress`t`t`t`t
        @dob`tyour D.o.B.`t`t`t
        @me`tyour name`t`t`t
        @sig`tyour signature`t`t`t
    )
    hsVariableHelpDisabled := replaceEachLine(hsVariableHelpEnabled, spacer)
    hsVariableHelp := (hs.config.user.enableHsVariables ? hsVariableHelpEnabled : hsVariableHelpDisabled)

    hsHeader := vspace . "`t`t`t`tHotStrings ending with " . vspace . " means any whitespace or punctuation character is required." . eol . eol
    hsCol1 := hsAliasHelp
    hsCol2 := hsVariableHelp . eol . hsAutoCorrectHelp . eol . hsHtmlHelp
    hsCol3 := hsDatesHelp . eol . hsCodeHelp
    hsCol4 := hsDosHelp . eol . hsJiraHelp

    hsArr1 := listToArray(hsCol1)
    hsArr2 := listToArray(hsCol2)
    hsArr3 := listToArray(hsCol3)
    hsArr4 := listToArray(hsCol4)

    hsResult := hsHeader
    for key, value in hsArr1 {
        hsResult .= LTrim(RTrim(value . hsArr2[key] . hsArr3[key] . hsArr4[key], trimChars)) . eol
    }
    hsResult := RegexReplace(hsResult, "<", "&lt;")
    hsResult := RegexReplace(hsResult, ">", "&gt;")
    hsResult := RegexReplace(hsResult, "(with )(" . vspace . ")( means)", "$1<span class=""sep"">&nbsp;</span>$3")
    hsResult := RegexReplace(hsResult, "([A-Z][^\t\n]+ )(hot)(strings)", "<span class=""section"">$1$3</span>`t")
    hsResult := RegexReplace(hsResult, "(\w|#)(" . vspace . ")(\t)", "$1<span class=""sep"">&nbsp;</span>$3")
    hsResult := RegexReplace(hsResult, "(&lt;)(TAG)", "$1<span class=""explain"">$2</span>")
    hsResult := RegexReplace(hsResult, vspace, "&nbsp;")

    hsVersion := hs.VERSION
    copyYear := SubStr(hsVersion, 3, 4)
    homeUrl := hs.vars.url.HotScript.home
    helpHtml =
    (Ltrim Join
        <!DOCTYPE html>
        <html>
            <head>
                <meta http-equiv="X-UA-Compatible" content="IE=EDGE" />
                <meta charset="UTF-8"/>
                <style type="text/css">
                    body {background-color:#FFFEE3;color:#333;font-size:13px;margin-top:2px;}
                    a {color:inherit;text-decoration:none;}
                    a:hover {color:blue;text-decoration:underline;}
                    .bigger {font-size:18px;}
                    .explain {background-color:#E4D6EF;padding:1px;}
                    .sep {background-color:#DEA5A4;padding:0px;}
                    .mod {color:#FF6961;font-weight:bold;}
                    .section {background-color:#DFE9F6;border-radius:5px;font-weight:bold;padding:2px 3px;border:1px solid #99BCE8;}
                    .title {background:#FFE7E7;border:1px solid #DF9898;border-radius:5px;color:#000;float:right;font-family:Roboto,'Helvetica Neue',Helvetica,Arial,sans-serif;font-size:14px;margin:-12px -7px 0 0;padding:1px 8px;text-align:right;}
                    pre {-moz-tab-size:8;-o-tab-size:8;tab-size:8;}
                </style>
            </head>
        <body>
            <div class="title"><a href="%homeUrl%">HotScript</a> v%hsVersion% &nbsp; <span class="bigger">&copy;</span> 2013-%copyYear%</div>
            <pre>${help}</pre>
        </body>
        </html>
    )

    hkContent := StrReplace(helpHtml, "${help}", hkResult)
    hsContent := StrReplace(helpHtml, "${help}", hsResult)

    static helpTab := ""
    static htmlHK := ""
    static htmlHS := ""

    Gui, 2: -DpiScale
    Gui, 2: +AlwaysOnTop -Caption +Border
    Gui, 2: Add, Tab2, x0 y0 w1275 h643 bottom vhelpTab, HotKeys|HotStrings
    Gui, 2: Add, ActiveX, x0 y0 w1272 h618 vhtmlHK, HtmlFile
    while (htmlHK.ReadyState != "complete") {
        Sleep, 100
    }
    Sleep, 50
    htmlHK.write(hkContent)
    Gui, 2: Tab, 2
    Gui, 2: Add, ActiveX, x0 y0 w1272 h618 vhtmlHS, HtmlFile
    while (htmlHS.ReadyState != "complete") {
        Sleep, 100
    }
    htmlHS.write(hsContent)
    Gui, 2: Tab
    Gui, 2: Color, FFEBCD
    Gui, 2: Show, Center w1272 h645

    isShowing := true
    if (waitForKey) {
        KeyWait("h")
        isShowing := false
        Gui, 2: Destroy
    }
    return

    2GuiEscape:
        Gui, 2: Destroy
        return
}

showSplash(msg,timeout:=1500) {
    splashTitle := hs.TITLE . "Splash"
    SplashImage("", "b1 cwFFA7A3 fs12", msg, "", splashTitle)
    centerWindow(splashTitle)
    Sleep(timeout)
    SplashImage("off")
}

showVariable(value:="") {
    msg := ""
    type := "Parameter"
    if (!IsObject(value) && value == "") {
        varName := trim(ask("Debug", "Please enter the name of the variable to inspect:", 330))
        if (varName == "") {
            return
        }
        try {
            value := getVar(varName)
        }
        catch e {
            MsgBox % e.Message
            return
        }
        type := varName
    }
    bracket := (IsObject(value) ? ["{", "}"] : ["[", "]"])
    msg := type . " = " . bracket[1] . toString(value) . bracket[2]
    ListVars
    debugWin := WinExist("A")
    WinActivate, ahk_id %debugWin%
    WinWaitActive, ahk_id %debugWin%
    ControlSetText, Edit1, %msg%
}

sortSelected(direction:="", ignoreCase:=true) {
    direction := setCase(direction, "L")
    selText := getSelectedText()
    if (selText != "") {
        Sort(selText, "F compareStr" . (direction == "d" ? "Desc" : "Asc") . (ignoreCase ? "NoCase" : ""))
        replaceSelected(selText)
    }
}

startsWith(str, value, caseInsensitive:="") {
    if (toBool(caseInsensitive)) {
        str := setCase(str, "L")
        value := setCase(value, "L")
    }
    return (SubStr(str, 1, StrLen(value)) == value)
}

stop() {
    hkSession := toComma(hs.config.user.hkSessionCount)
    hkTotal := toComma(hs.config.user.hkTotalCount)
    hsSession := toComma(hs.config.user.hsSessionCount)
    hsTotal := toComma(hs.config.user.hsTotalCount)
    msg := "Shutting down..." . hs.const.EOL_NIX . hs.const.EOL_NIX . "Session Usage" . hs.const.EOL_NIX . "    hotkeys: " . hkSession . hs.const.EOL_NIX . "    hotstrings: " . hsSession . hs.const.EOL_NIX . hs.const.EOL_NIX . "Total Usage" . hs.const.EOL_NIX . "    hotkeys: " . hkTotal . hs.const.EOL_NIX . "    hotstrings: " . hsTotal
    MsgBox,, % hs.VERSION, %msg%
    ExitApp
}

stripEol(str) {
    str := StrReplace(str, hs.const.EOL_MAC , "")
    str := StrReplace(str, hs.const.EOL_NIX , "")
    return str
}

tagifySelected() {
    selText := getSelectedText()
    if (selText == "") {
        SendInput, ^{Left}^+{Right}
        selText := getSelectedText()
    }
    if (selText != "") {
        isTagged := startsWith(selText, "<") && endsWith(selText, ">")
        if (isTagged) {
            pasteText(RegExReplace(selText, "(<[^>]+>)", ""))
        }
        else {
            moveLeft := "{Left " . (StrLen(selText) + 3) . "}"
            sendText("<" . selText . "></" . selText . ">", moveLeft)
        }
    }
}

templateHtml() {
    template := FileRead(hs.config.user.templates.html)
    templateKeys := hs.config.user.templates.htmlKeys
    if (template == "") {
        templateKeys := "{Up 3}{End}{Home}"
        template =
        (
<!DOCTYPE html>
<html lang='en'>
    <head>
        <meta charset='UTF-8'/>
        <title>Quick HTML template</title>
        <style type="text/css">
            table {
                border-collapse: collapse;
                margin-top: 20px;
            }
            table, td, th {
                border: 1px solid black;
            }
            tr:nth-child(even) {
                background: #c2d8f0;
            }
            tr:nth-child(odd) {
                background: #bbdabe;
            }
            tr:first-child {
                background: #dfc7c7;
            }
            td, th {
                padding: 10px;
            }
        </style>
    </head>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.2.2/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.8.3/underscore-min.js"></script>
    <script>
        function test() {
            //
        }
    </script>
<body>
    <h2>This is a simple HTML template. (generated by HotScript)</h2>
    <input type='button' value='Test' onclick='test()'/>
    <table>
        <tr>
            <th>Header 1</th>
            <th>Header 2</th>
            <th>Header 3</th>
        </tr>
        <tr>
            <td>C1-1</td>
            <td>C1-2</td>
            <td>C1-3</td>
        </tr>
        <tr>
            <td>C2-1</td>
            <td>C2-2</td>
            <td>C2-3</td>
        </tr>
        <tr>
            <td>C3-1</td>
            <td>C3-2</td>
            <td>C3-3</td>
        </tr>
    </table>
</body>
</html>

        )
        template := RegExReplace(template, hs.const.EOL_NIX, hs.const.EOL_WIN)
    }
    pasteTemplate(template, "", templateKeys)
}

templateJava() {
    template := FileRead(hs.config.user.templates.java)
    templateKeys := hs.config.user.templates.javaKeys
    if (template == "") {
        templateKeys := "{Up 3}{End}{Home}"
        template =
        (
import java.io.*;
import java.util.*;

public class Template {
    public static void main(String[] args) {
        System.out.println("This is a simple Java template. (generated by HotScript)");
    }
}

        )
        template := RegExReplace(template, hs.const.EOL_NIX, hs.const.EOL_WIN)
    }
    pasteTemplate(template, "", templateKeys)
}

templatePerl() {
    template := FileRead(hs.config.user.templates.perl)
    templateKeys := hs.config.user.templates.perlKeys
    if (template == "") {
        templateKeys := "^{Home}"
        template =
        (
use strict;
use warnings;
use File::Basename;
use File::Basename qw(dirname);
use File::Cwd;
use File::Cwd qw(abs_path);
use File::Find;
use File::Path;
use File::Spec;
use Getopt::Std;
use IO::Handle qw(); # for flush
use POSIX qw/strftime/;
use Sys::Hostname;

# ----------------------------------------------------------------------
#  Constants
# ----------------------------------------------------------------------
my $EXIT_OK = 0;
my $EXIT_GENERIC = 1;
my $LOG_LINE = "----------------------------------------------------------------------";
my $LOG_NAME = substr($0, 0, -3) . ".log";

# ----------------------------------------------------------------------
#  Variables
# ----------------------------------------------------------------------
my $doDebug = 0;

# ----------------------------------------------------------------------
#  Main
# ----------------------------------------------------------------------
init();

# ----------------------------------------------------------------------
# Functions
# ----------------------------------------------------------------------
sub debug {
    if ($doDebug) {
        logg($_[0]);
    }
}

sub dieCommon {
    my $logPath = File::Spec->rel2abs($LOG_NAME);
    my $msg = $_[0];
    my $exitCode = $EXIT_GENERIC;
    my $newCode = $_[1];
    if (defined($newCode)) {
        $exitCode = $newCode;
    }
    logg("$msg\n\nPlease refer to $logPath for more information.");
    exit $exitCode;
}

sub init {
    open(LOG, ">>$LOG_NAME") || dieCommon("Could not open log file: $LOG_NAME - $!");
    STDOUT->autoflush(1);
}

sub logg {
    print LOG $_[0]."\n";
    print $_[0]."\n";
}

sub now {
    return strftime('`%m/`%d/`%Y at `%H:`%M:`%S', localtime);
}

sub readFile {
    my $file = $_[0];
    my $contents = "";
    open("output", "<$file") || dieCommon("Unable to read file: $file - $!");
    chomp($contents = do { local $/; <output> });
    close("output");
    return $contents;
}

sub readProperties {
    my $propFile = $_[0];
    open my $in, "$propFile" or dieCommon("Unable to read properties from: $propFile - $!");
    my `%propMap;
    my `%tmpMap;
    for (<$in>) {
        #skip comment lines
        next if /^[\s]*#/;
        $tmpMap{$1}=$2 while m/([^=]*)(?:\s*?=\s*?)(.*)/g;
        if (defined $1 && $1 ne '') {
            my $name = trim($1);
            my $value = trim($2);
            $propMap{$name}=$value;
        }
    }
    close $in;
    return $propMap;
}

sub replace {
    my $str = $_[0];
    my $find = $_[1];
    my $replace = $_[2];
    $str ~= s/$find/$replace/g;
    return $str;
}

sub showMap {
    my $map = $_[0];
    my $key;
    my $value;
    while (($key, $value) = each($map)) {
        print "\t[".$key."] = [".$value."]\n";
    }
}

sub trace {
    my $caller = (caller(1))[3];
    my $now = now();
    if ($[0] == 1) {
        debug("$LOG_LINE\nBEGIN: $caller - $now");
    }
    else {
        debug("END: $caller - $now\n$LOG_LINE");
    }
}

sub trim {
    my $str = $_[0];
    $str ~= s/^\s+//;
    $str ~= s/\s+$//;
    return $str;
}

        )
        template := RegExReplace(template, hs.const.EOL_NIX, hs.const.EOL_WIN)
    }
    pasteTemplate(template, "", templateKeys)
}

templateSql() {
    template := FileRead(hs.config.user.templates.sql)
    templateKeys := hs.config.user.templates.sqlKeys
    if (template == "") {
        templateKeys := "{Up 2}{End}"
        template =
        (LTrim
            -- ----------------------------------------------------------------------
            -- This is a simple SQL template. (generated by HotScript)
            -- ----------------------------------------------------------------------
            SELECT *
            FROM%A_Space%
            WHERE

        )
        template := RegExReplace(template, hs.const.EOL_NIX, hs.const.EOL_WIN)
    }
    pasteTemplate(template, "", templateKeys)
}

toBool(value)
{
    static trueList := "1,active,enabled,on,t,true,y,yes"
    value := StringLower(value)
    value := Trim(value)
    result := false
    if (is(value, "Number") && value > 0) {
        result := true
    }
    else if value in %trueList%
    {
        result := true
    }
    return result
}

toComma(value) {
    value := RegExReplace(value, "(\d)(?=(?:\d{3})+(?:\.|$))", "$1,")
;    value := RegExReplace(value, "[1-9](?:\d{0,2})((?:,\d{3})*)(?:\.\d*[0-9])?|0?\.\d*[0-9]|0", "$1,")
    return value
}

toggleAlwaysOnTop(hWnd:="A") {
    hWnd := setCase(Trim(hWnd), "U")
    if (hWnd == "" || hWnd == "A") {
        hWnd := WinExist("A")
    }
    WinGet, ExStyle, ExStyle, ahk_id %hWnd%
    currentModeAoT := (ExStyle & 0x8 ? "on" : "off")
    currentModeCT := (ExStyle & 0x20 ? "on" : "off")
    newState := (currentModeAoT == "off" ? "on" : currentModeCT)

    ; remove any existing markers
    WinGetTitle, newTitle, ahk_id %hWnd%
    newTitle := StrReplace(newTitle, hs.const.MARKER.always_on_top)
    newTitle := StrReplace(newTitle, hs.const.MARKER.click_through)

    ; force click-through to be turned off
    WinSet, ExStyle, -0x20, ahk_id %hWnd%

    WinSet, AlwaysOnTop, %newState%, ahk_id %hWnd%
    if (newState == "on") {
        newTitle := hs.const.MARKER.always_on_top . newTitle
    }
    else {
        WinSet, Transparent, 255, ahk_id %hWnd%
    }
    WinSetTitle, ahk_id %hWnd%, , %newTitle%
    showSplash("'Always-on-top' mode is " . newState . "...")
}

toggleClickThrough(hWnd:="A") {
    hWnd := setCase(Trim(hWnd), "U")
    if (hWnd == "" || hWnd == "A") {
        hWnd := WinExist("A")
    }
    WinGet, ExStyle, ExStyle, ahk_id %hWnd%
    currentModeAoT := (ExStyle & 0x8 ? "on" : "off")
    currentModeCT := (ExStyle & 0x20 ? "on" : "off")
    newState := (currentModeCT == "off" ? "on" : "off")

    ; remove any existing markers
    WinGetTitle, newTitle, ahk_id %hWnd%
    newTitle := StrReplace(newTitle, hs.const.MARKER.always_on_top)
    newTitle := StrReplace(newTitle, hs.const.MARKER.click_through)

    if (newState == "on") {
        WinSet, Transparent, 127, ahk_id %hWnd%
        WinSet, ExStyle, +0x20, ahk_id %hWnd%
        WinSet, AlwaysOnTop, on, ahk_id %hWnd%
        ; 50% transparent
        newTitle := hs.const.MARKER.click_through . newTitle
    }
    else {
        WinSet, ExStyle, -0x28, ahk_id %hWnd%
        WinSet, AlwaysOnTop, off, ahk_id %hWnd%
        WinSet, Transparent, 255, ahk_id %hWnd%
    }
    WinSetTitle, ahk_id %hWnd%, , %newTitle%
    showSplash("'Click-through' mode is " . newState . "...")
}

toggleDesktopIcons() {
    hWnd := ControlGet("hWnd", "", "SysListView321", "ahk_class Progman")
    if (hWnd == "") {
        hWnd := ControlGet("hWnd", "", "SysListView321", "ahk_class WorkerW")
    }
    if (DllCall("IsWindowVisible", UInt, hWnd)) {
        WinHide, ahk_id %hWnd%
    }
    else {
        WinShow, ahk_id %hWnd%
    }
}

toggleMinimized() {
    static allMinimized := false
    static lastWindow
    if (allMinimized) {
        WinMinimizeAllUndo
        Sleep(100)
        WinActivate, ahk_id %lastWindow%
    }
    else {
        lastWindow := WinExist("A")
        WinMinimizeAll
    }
    allMinimized := !allMinimized
}

toggleSuspend() {
    if (A_IsSuspended) {
        state := "suspended"
        Menu, Tray, Rename, Pause, Resume
    }
    else {
        state := "enabled"
        Menu, Tray, Rename, Resume, Pause
    }
    tip := SubStr(A_IconTip, 1, InStr(A_IconTip, "-") + 1) . state
    Menu, Tray, Tip, % tip
    msg := hs.TITLE . " is " . state . "..."
    showSplash(msg)
}

toggleTransparency(hWnd:="A") {
    hWnd := setCase(Trim(hWnd), "U")
    if (hWnd == "" || hWnd == "A") {
        hWnd := WinExist("A")
    }
    if (isWindow(hWnd)) {
        WinGet, curTrans, Transparent, ahk_id %hWnd%
        WinGetTitle, currentTitle, ahk_id %hWnd%
        if (curTrans) {
            WinSet, Transparent, off, ahk_id %hWnd%
            newTitle := RegExReplace(currentTitle, hs.const.MARKER.transparent . "\(\d{1,3}%\) ")
        }
        else {
            WinSet, Transparent, 127, ahk_id %hWnd%
            newTitle := hs.const.MARKER.transparent . "(50%) " + currentTitle
        }
        WinSetTitle, ahk_id %hWnd%, , %newTitle%
    }
}

toString(obj, depth:=10, indent:="") {
    result := ""
    if (IsObject(obj)) {
        keyWidth := 1
        for key, value in obj {
            tmpWidth := StrLen(key)
            if (tmpWidth > keyWidth) {
                keyWidth := tmpWidth
            }
        }
        pad := indent . hs.const.INDENT
        for key, value in obj {
            result .= (depth == 10 && StrLen(result) == 0 && getSize(obj) > 1 ? hs.const.EOL_WIN : "") . pad
            if (IsObject(value) && depth > 1) {
                result .= key . " = {" . hs.const.EOL_WIN . toString(value, depth - 1, pad) . pad . "}" . hs.const.EOL_WIN
            }
            else {
                result .= pad(key, keyWidth) . " = [" . value . "]" . hs.const.EOL_WIN
            }
        }
    }
    else {
        result := obj
    }
    return result
}

transformSelected(type,types:="I|L|R|S|T|U") {
    type := setCase(type, "L")
    if (!InStr(types, type)) {
        MsgBox, 16, transformSelected() - Invalid parameter, illegal value for 'type' specified as: [%type%]
        return false
    }
    selText := getSelectedText()
    if (selText != "") {
        if (type == "r") {
            replaceSelected(reverse(selText))
        }
        else {
            replaceSelected(setCase(selText, type))
        }
    }
}

updateRegistry() {
    RegWrite("HKEY_CLASSES_ROOT", "AutoHotkeyScript\Shell\Edit\Command", "", """" . hs.config.user.editor . """ ""`%1""")
    RegWrite("HKEY_CLASSES_ROOT", "Applications\AutoHotkey.exe", "IsHostApp")
}

upperCaseOracle() {
    selText := getSelectedText()
    if (selText != "") {
        if (hs.config.user.options.oracleTransformRemainderToLower) {
            selText := setCase(selText, "L")
        }
        oracleWords := "i)\b(ABORT|ABS|ACCEPT|ACCESS|ACCOUNT|ACOS|ACTIVATE|ADD|ADD_MONTHS|ADJ_DATE|ADMIN|ADVISE|AFTER|AGENT|AGGREGATE|ALL|ALL_ROWS|ALLOCATE|ALTER|ANALYZE|AND|ANY|APPENDCHILDXML|ARCHIVE|ARCHIVELOG|ARRAY|ARRAYLEN|ARROW|AS|ASC|ASCII|ASCIISTR|ASIN|ASSERT|ASSIGN|AT|ATAN|ATAN2|ATTRIBUTE|AUDIT|AUTHENTICATED|AUTHID|AUTHORIZATION|AUTOEXTEND|AUTOMATIC|AVG|BACKUP|BASE_TABLE|BECOME|BEFORE|BEGIN|BETWEEN|BFILE|BFILE_BASE|BFILENAME|BIN_TO_NUM|BINARY|BINARY_INTEGER|BINARY2VARCHAR|BIT_COMPLEMENT|BIT_OR|BIT_XOR|BITAND|BITMAP|BLOB|BLOB_BASE|BLOCK|BODY|BOOL_TO_INT|BOOLEAN|BOTH|BOUND|BULK|BY|BYTE|CACHE|CACHE_INSTANCES|CALL|CALLING|CANCEL|CARDINALITY|CASCADE|CASE|CAST|CAST_FROM_BINARY|CAST_FROM_NUMBER|CAST_TO_BINARY|CAST_TO_BINARY_FLOAT|CAST_TO_NUMBER|CAST_TO_NVARCHAR2|CAST_TO_RAW|CAST_TO_VARCHAR|CEIL|CFILE|CHAINED|CHANGE|CHAR|CHAR_BASE|CHAR_CS|CHARACTER|CHARSET|CHARSETFORM|CHARSETID|CHARTOROWID|CHECK|CHECKPOINT|CHOOSE|CHR|CHUNK|CLEAR|CLOB|CLOB_BASE|CLONE|CLOSE|CLOSE_CACHED_OPEN_CURSORS|CLUSTER|CLUSTER_ID|CLUSTER_PROBABILITY|CLUSTER_SET|CLUSTERS|COALESCE|COBOL|COLAUTH|COLLECT|COLUMN|COLUMNS|COMMENT|COMMIT|COMMITTED|COMPATIBILITY|COMPILE|COMPILED|COMPLETE|COMPOSE|COMPOSITE_LIMIT|COMPRESS|COMPUTE|CONCAT|CONNECT|CONNECT_TIME|CONSTANT|CONSTRAINT|CONSTRAINTS|CONSTRUCTOR|CONTENTS|CONTEXT|CONTINUE|CONTROLFILE|CONVERT|CORR|CORR_K|CORR_S|COS|COSH|COST|COUNT|COVAR_POP|COVAR_SAMP|CPU_PER_CALL|CPU_PER_SESSION|CRASH|CREATE|CUME_DIST|CURRENT|CURRENT_DATE|CURRENT_SCHEMA|CURRENT_TIMESTAMP|CURRENT_USER|CURRVAL|CURSOR|CUSTOMDATUM|CV|CYCLE|DANGLING|DATA|DATA_BASE|DATABASE|DATAFILE|DATAFILES|DATAOBJNO|DATE|DATE_BASE|DAY|DBA|DBHIGH|DBLOW|DBMAC|DBTIMEZONE|DEALLOCATE|DEBUG|DEBUGOFF|DEBUGON|DEC|DECIMAL|DECLARE|DECODE|DECOMPOSE|DEFAULT|DEFERRABLE|DEFERRED|DEFINE|DEFINITION|DEGREE|DELAY|DELETE|DELETEXML|DELTA|DENSE_RANK|DEPTH|DEREF|DESC|DETERMINISTIC|DIGITS|DIRECTORY|DISABLE|DISCONNECT|DISMOUNT|DISPOSE|DISTINCT|DISTRIBUTED|DML|DO|DOUBLE|DROP|DUMP|DURATION|EACH|ELEMENT|ELSE|ELSIF|EMPTY|EMPTY_BLOB|EMPTY_CLOB|ENABLE|END|ENFORCE|ENTRY|ESCAPE|ESTIMATE_CPU_UNITS|EVENTS|EXCEPT|EXCEPTION|EXCEPTION_INIT|EXCEPTIONS|EXCHANGE|EXCLUDING|EXCLUSIVE|EXEC|EXECUTE|EXISTS|EXISTSNODE|EXIT|EXP|EXPIRE|EXPLAIN|EXTENT|EXTENTS|EXTERNAL|EXTERNALLY|EXTRACT|EXTRACTVALUE|FAILED_LOGIN_ATTEMPTS|FALSE|FAST|FEATURE_ID|FEATURE_SET|FEATURE_VALUE|FETCH|FILE|FINAL|FIRST|FIRST_ROWS|FIRST_VALUE|FIXED|FLAGGER|FLOAT|FLOB|FLOOR|FLUSH|FOR|FORALL|FORCE|FOREIGN|FORM|FORTRAN|FOUND|FREELIST|FREELISTS|FROM|FROM_TZ|FULL|FUNCTION|GENERAL|GENERIC|GET_CLOCK_TIME|GET_DDL|GET_DEPENDENT_DDL|GET_DEPENDENT_XML|GET_GRANTED_DDL|GET_GRANTED_XDL|GET_HASH|GET_REBUILD_COMMAND|GET_SCN|GET_XML|GLOBAL|GLOBAL_NAME|GLOBALLY|GO|GOTO|GRANT|GREATEST|GROUP|GROUP_ID|GROUPING|GROUPING_ID|GROUPS|HASH|HASHKEYS|HAVING|HEADER|HEAP|HEXTORAW|HIDDEN|HOUR|IDENTIFIED|IDGENERATORS|IDLE_TIME|IF|IMMEDIATE|IN|INCLUDING|INCREMENT|IND_PARTITION|INDEX|INDEXED|INDEXES|INDICATOR|INDICES|INFINITE|INITCAP|INITIAL|INITIALLY|INITRANS|INNER|INSERT|INSERTCHILDXML|INSERTXMLBEFORE|INSTANCE|INSTANCES|INSTANTIABLE|INSTEAD|INSTR|INSTR2|INSTR4|INSTRB|INSTRC|INT|INT_TO_BOOL|INTEGER|INTERFACE|INTERMEDIATE|INTERSECT|INTERVAL|INTO|INVALIDATE|IS|ISOLATION|ISOLATION_LEVEL|ITERATE|ITERATION_NUMBER|JAVA|JOIN|KEEP|KEY|KILL|LABEL|LAG|LANGUAGE|LARGE|LAST|LAST_DAY|LAST_VALUE|LAYER|LEAD|LEADING|LEAST|LEFT|LENGTH|LENGTH2|LENGTH4|LENGTHB|LENGTHC|LESS|LEVEL|LIBRARY|LIKE|LIKE2|LIKE4|LIKEC|LIMIT|LIMITED|LINK|LIST|LISTS|LN|LNNVL|LOB|LOCAL|LOCALTIMESTAMP|LOCK|LOCKED|LOG|LOGFILE|LOGGING|LOGICAL_READS_PER_CALL|LOGICAL_READS_PER_SESSION|LONG|LOOP|LOWER|LPAD|LTRIM|MAKE_REF|MAKEREF|MANAGE|MANUAL|MAP|MASTER|MAX|MAXARCHLOGS|MAXDATAFILES|MAXEXTENTS|MAXINSTANCES|MAXLEN|MAXLOGFILES|MAXLOGHISTORY|MAXLOGMEMBERS|MAXSIZE|MAXTRANS|MAXVALUE|MEDIAN|MEMBER|MERGE|MIN|MINEXTENTS|MINIMUM|MINUS|MINUTE|MINVALUE|MLS_LABEL_FORMAT|MLSLABEL|MOD|MODE|MODIFY|MODULE|MONTH|MONTHS_BETWEEN|MOUNT|MOVE|MTS_DISPATCHERS|MULTISET|NAN|NANVL|NATIONAL|NATIVE|NATURAL|NCHAR|NCHAR_CS|NCLOB|NEEDED|NESTED|NETWORK|NEW|NEW_TIME|NEXT|NEXT_DAY|NEXTVAL|NHEXTORAW|NLS_CHARSET_DECL_LEN|NLS_CHARSET_ID|NLS_CHARSET_NAME|NLS_INITCAP|NLS_LOWER|NLS_UPPER|NLSSORT|NOARCHIVELOG|NOAUDIT|NOCACHE|NOCOMPRESS|NOCOPY|NOCYCLE|NOFORCE|NOLOGGING|NOMAXVALUE|NOMINVALUE|NONE|NOORDER|NOOVERRIDE|NOPARALLEL|NORESETLOGS|NOREVERSE|NORMAL|NOSORT|NOT|NOTFOUND|NOTHING|NOWAIT|NTILE|NULL|NULLFN|NULLIF|NULLS FIRST|NULLS LAST|NUMBER|NUMBER_BASE|NUMERIC|NUMTODSINTERVAL|NUMTOHEX|NUMTOHEX2|NUMTOYMINTERVAL|NVARCHAR2|NVL|NVL2|OBJECT|OBJNO|OBJNO_REUSE|OCICOLL|OCIDATE|OCIDATETIME|OCIDURATION|OCIINTERVAL|OCILOBLOCATOR|OCINUMBER|OCIRAW|OCIREF|OCIREFCURSOR|OCIROWID|OCISTRING|OCITYPE|OF|OFF|OFFLINE|OID|OIDINDEX|OLD|ON|ONLINE|ONLY|OPAQUE|OPCODE|OPEN|OPERATOR|OPTIMAL|OPTIMIZER_GOAL|OPTION|OR|ORA_HASH|ORACLE|ORADATA|ORDER|ORGANIZATION|ORLANY|ORLVARY|OSLABEL|OTHERS|OUT|OUTER|OVERFLOW|OVERLAPS|OVERRIDING|OWN|PACKAGE|PARALLEL|PARALLEL_ENABLE|PARAMETER|PARAMETERS|PARTITION|PASCAL|PASSWORD|PASSWORD_GRACE_TIME|PASSWORD_LIFE_TIME|PASSWORD_LOCK_TIME|PASSWORD_REUSE_MAX|PASSWORD_REUSE_TIME|PASSWORD_VERIFY_FUNCTION|PATH|PCTFREE|PCTINCREASE|PCTTHRESHOLD|PCTUSED|PCTVERSION|PERCENT|PERCENT_RANK|PERCENTILE_CONT|PERCENTILE_DISC|PERMANENT|PIPE|PIPELINED|PIVOT|PLAN|PLI|PLSQL_DEBUG|POSITIVE|POST_TRANSACTION|POWER|POWERMULTISET|POWERMULTISET_BY_CARDINALITY|PRAGMA|PRECISION|PREDICTION|PREDICTION_BOUNDS|PREDICTION_COST|PREDICTION_DETAILS|PREDICTION_PROBABILITY|PREDICTION_SET|PRESENTNNV|PRESENTV|PRESERVE|PREVIOUS|PRIMARY|PRIOR|PRIVATE|PRIVATE_SGA|PRIVILEGE|PRIVILEGES|PROCEDURE|PROFILE|PUBLIC|PURGE|QUEUE|QUOTA|QUOTE DELIMITERS|RAISE|RANDOMBYTES|RANDOMINTEGER|RANDOMNUMBER|RANGE|RANK|RATIO_TO_REPORT|RAW|RAW_TO_CHAR|RAW_TO_NCHAR|RAW_TO_VARCHAR2|RAWTOHEX|RAWTONHEX|RAWTONUM|RAWTONUM2|RBA|READ|READUP|REAL|REBUILD|RECORD|RECOVER|RECOVERABLE|RECOVERY|REF|REFERENCE|REFERENCES|REFERENCING|REFRESH|REFTOHEX|REGEXP_COUNT|REGEXP_INSTR|REGEXP_REPLACE|REGEXP_SUBSTR|REGR_AVGX|REGR_AVGY|REGR_COUNT|REGR_INTERCEPT|REGR_R2|REGR_SLOPE|REGR_SXX|REGR_SXY|REGR_SYY|RELEASE|REM|REMAINDER|REMR|RENAME|REPLACE|RESET|RESETLOGS|RESIZE|RESOURCE|RESTRICTED|RESULT|RETURN|RETURNING|REUSE|REVERSE|REVOKE|RIGHT|ROLE|ROLES|ROLLBACK|ROUND|ROW|ROW_NUMBER|ROWID|ROWIDTOCHAR|ROWIDTONCHAR|ROWLABEL|ROWNUM|ROWS|ROWTYPE|RPAD|RTRIM|RULE|RUN|SAMPLE|SAVE|SAVEPOINT|SB1|SB2|SB4|SCAN_INSTANCES|SCHEMA|SCN|SCN_TO_TIMESTAMP|SCOPE|SD_ALL|SD_INHIBIT|SD_SHOW|SECOND|SECTION|SEG_BLOCK|SEG_FILE|SEGMENT|SELECT|SELF|SEPARATE|SEQUENCE|SERIALIZABLE|SESSION|SESSION_CACHED_CURSORS|SESSIONS_PER_USER|SESSIONTIMEZONE|SET|SHARE|SHARED|SHARED_POOL|SHORT|SHRINK|SIGN|SIN|SINH|SIZE|SIZE_T|SKIP|SKIP_UNUSABLE_INDEXES|SMALLINT|SNAPSHOT|SOME|SORT|SOUNDEX|SPACE|SPARSE|SPECIFICATION|SPLIT|SQL|SQL_TRACE|SQLBUF|SQLCODE|SQLDATA|SQLERRM|SQLERROR|SQLNAME|SQLSTATE|SQRT|STANDARD|STANDBY|START|STATEMENT|STATEMENT_ID|STATIC|STATISTICS|STATS_BINOMIAL_TEST|STATS_CROSSTAB|STATS_F_TEST|STATS_KS_TEST|STATS_MODE|STATS_MW_TEST|STATS_ONE_WAY_ANOVA|STATS_T_TEST|STATS_T_TEST_ONE|STATS_T_TEST_PAIRED|STATS_T_TEST_INDEP|STATS_T_TEST_INDEPU|STATS_WSR_TEST|STDDEV|STDDEV_POP|STDDEV_SAMP|STOP|STORAGE|STORE|STORED|STRING|STRING_TO_RAW|STRUCT|STRUCTURE|STYLE|SUBMULTISET|SUBPARTITION|SUBSTITUTABLE|SUBSTR|SUBSTR2|SUBSTR4|SUBSTRB|SUBSTRC|SUBTYPE|SUCCESSFUL|SUM|SWITCH|SYNONYM|SYS_CONNECT_BY_PATH|SYS_CONTEXT|SYS_DBURIGEN|SYS_EXTRACT_UTC|SYS_GUID|SYS_OP_COMBINED_HASH|SYS_OP_DESCEND|SYS_OP_DISTINCT|SYS_OP_GUID|SYS_OP_LBID|SYS_OP_MAP_NONNULL|SYS_OP_RAWTONUM|SYS_OP_RPB|SYS_OP_TOSETID|SYS_TYPEID|SYS_XMLAGG|SYS_XMLGEN|SYSDATE|SYSDBA|SYSOPER|SYSTEM|SYSTIMESTAMP|TABAUTH|TABLE|TABLES|TABLESPACE|TABLESPACE_NO|TABNO|TAN|TANH|TASK|TDO|TEMPORARY|TERMINATE|THAN|THE|THEN|THREAD|TIME|TIMESTAMP|TIMESTAMP_TO_SCN|TIMEZONE_ABBR|TIMEZONE_HOUR|TIMEZONE_MINUTE|TIMEZONE_REGION|TO|TO_BINARY_DOUBLE|TO_BINARY_FLOAT|TO_BINARYDOUBLE|TO_BINARYFLOAT|TO_CHAR|TO_CLOB|TO_DATE|TO_DSINTERVAL|TO_LOB|TO_MULTI_BYTE|TO_NCHAR|TO_NCLOB|TO_NUMBER|TO_SINGLE_BYTE|TO_TIMESTAMP|TO_TIMESTAMP_TZ|TO_YMINTERVAL|TOPLEVEL|TRACE|TRACING|TRAILING|TRANSAC|TRANSACTION|TRANSACTIONAL|TRANSITIONAL|TRANSLATE|TRANSLITERATE|TREAT|TRIGGER|TRIGGERS|TRIM|TRUE|TRUNC|TRUNCATE|TRUSTED|TX|TYPE|TZ_OFFSET|UB1|UB2|UB4|UBA|UID|UNBOUNDED FOLLOWING|UNBOUNDED PRECEDING|UNDER|UNION|UNIQUE|UNISTR|UNLIMITED|UNLOCK|UNRECOVERABLE|UNSIGNED|UNTIL|UNTRUSTED|UNUSABLE|UNUSED|UPDATABLE|UPDATE|UPDATEXML|UPPER|USAGE|USE|USER|USERENV|USING|VALIDATE|VALIDATION|VALIST|VALUE|VALUES|VAR_POP|VAR_SAMP|VARCHAR|VARCHAR2|VARIABLE|VARIANCE|VARRAY|VARYING|VERIFY_OWNER|VERIFY_TABLE|VERTICAL BARS|VIEW|VIEWS|VOID|VSIZE|WHEN|WHENEVER|WHERE|WHILE|WIDTH_BUCKET|WITH|WITHOUT|WORK|WRAPPED|WRITE|WRITEDOWN|WRITEUP|XID|XMLAGG|XMLCAST|XMLCDATA|XMLCOLATTVAL|XMLCOLLATVAL|XMLCOMMENT|XMLCONCAT|XMLDIFF|XMLELEMENT|XMLEXISTS|XMLFOREST|XMLISVALID|XMLPARSE|XMLPATCH|XMLPI|XMLQUERY|XMLROOT|XMLSEQUENCE|XMLSERIALIZE|XMLTABLE|XMLTRANSFORM|XOR|YEAR|ZONE)\b"
        inComment := false
        upper := ""
        Loop, Parse, selText, % hs.const.EOL_NIX
        {
            if (inComment) {
                pos := InStr(A_LoopField, "*/")
                if (pos > 0) {
                    line1 := Substr(A_LoopField, 1, (pos - 1))
                    line2 := Substr(A_LoopField, pos)
                    inComment := false
                }
                else {
                    line1 := A_LoopField
                    line2 := ""
                }
                upper .= line1 . RegExReplace(line2, oracleWords, "$U{1}") . hs.const.EOL_NIX
            }
            else {
                pos := InStr(A_LoopField, "/*")
                if (pos > 0) {
                    line1 := Substr(A_LoopField, 1, (pos - 1))
                    line2 := Substr(A_LoopField, pos)
                    inComment := true
                }
                else {
                    pos := InStr(A_LoopField, "--")
                    if (pos > 0) {
                        line1 := Substr(A_LoopField, 1, (pos - 1))
                        line2 := Substr(A_LoopField, pos)
                    }
                    else {
                        line1 := A_LoopField
                        line2 := ""
                    }
                }
                upper .= RegExReplace(line1, oracleWords, "$U{1}") . line2 . hs.const.EOL_NIX
            }
        }
        upper := SubStr(upper, 1, StrLen(upper) - 1)
        pasteText(upper)
    }
}

urlEncode(text) {
    text := StrReplace(text, "%", "%25") ; This needs to be first
    text := StrReplace(text, """", "%22")
    text := StrReplace(text, "#", "%23")
    text := StrReplace(text, "$", "%24")
    text := StrReplace(text, "&", "%26")
    text := StrReplace(text, "'", "%27")
    text := StrReplace(text, "(", "%28")
    text := StrReplace(text, ")", "%29")
    text := StrReplace(text, "+", "%2B")
    text := StrReplace(text, ",", "%2C")
    text := StrReplace(text, "/", "%2F")
    text := StrReplace(text, ":", "%3A")
    text := StrReplace(text, ";", "%3B")
    text := StrReplace(text, "<", "%3C")
    text := StrReplace(text, "=", "%3D")
    text := StrReplace(text, ">", "%3D")
    text := StrReplace(text, "?", "%3F")
    text := StrReplace(text, "@", "%40")
    text := StrReplace(text, "`", "%60")
    text := StrReplace(text, A_Tab, A_Space)
    text := StrReplace(text, A_Space, "%20")
    text := StrReplace(text, hs.const.EOL_WIN, A_Space)
    text := StrReplace(text, hs.const.EOL_MAC, A_Space)
    text := StrReplace(text, hs.const.EOL_NIX, A_Space)
    return text
}

urlToVar(url) {
    result := ""
    try {
        http := ComObjCreate("WinHttp.WinHttpRequest.5.1")
        http.Open("GET", url)
        http.Send()
        result := http.ResponseText
    }
    return result
}

wrapSelected(start, end) {
    selText := getSelectedText()
    if (selText == "") {
        SendInput, {End}{Home}+{End}
        selText := getSelectedText()
    }
    if (startsWith(selText, start) && endsWith(selText, end)) {
        lenSel := StrLen(selText)
        lenStart := StrLen(start)
        lenEnd := StrLen(end)
        newText := SubStr(selText, 1 + lenStart, 0 - lenEnd)
    }
    else {
        newText := start . selText . end
    }
    pair := start . end
    if (newText != pair) {
        replaceSelected(newText)
    }
}

wrapSelectedEach(start, end) {
    selText := getSelectedText()
    if (selText == "") {
        SendInput, {End}{Home}+{End}
        selText := getSelectedText()
    }
    eol := getEol(selText)
    hasEol := endsWith(selText, eol)
    if (hasEol) {
        selText := SubStr(selText, 1, 0 - StrLen(eol))
    }
    lenStart := StrLen(start)
    lenEnd := StrLen(end)
    newText := ""
    Loop, Parse, selText, % hs.const.EOL_NIX, % hs.const.EOL_MAC
    {
        lineText := A_LoopField
        if (startsWith(lineText, start) && endsWith(lineText, end)) {
            lenLine := StrLen(lineText)
            newText .= SubStr(lineText, 1 + lenStart, 0 - lenEnd)
        }
        else {
            newText .= start . lineText . end
        }
        newText .= eol
    }
    if (!hasEol) {
        newText := SubStr(newText, 1, 0 - StrLen(eol))
    }
    pair := start . end
    if (newText != pair) {
        replaceSelected(newText)
    }
}

zoomAdjust(direction) {
    static zoomFactor := 1.189207115 ; sqrt(sqrt(2))
    global zoomAmount
    if (direction == -1) {
        if (zoomAmount < 4) {
            zoomAmount *= zoomFactor
        }
    }
    else if (direction == 1) {
        if (zoomAmount > zoomFactor) {
            zoomAmount /= zoomFactor
        }
    }
}

zoomStart() {
    ; TODO - refactor global variables into HS
    global zoomAmount := 2
    global zoomWindowDimension := 0
    global zoomWindowH := 100
    global zoomWindowW := 240
    global zoomFollow := true
    global zoomHdcFrame
    global zoomHddFrame

    Process("Priority", "", "High")
    Hotkey, Escape, zoomExit, On
    Hotkey, Space, zoomToggleFollow, On
    Hotkey, WheelDown, zoomChange, On
    Hotkey, !Down, zoomChange, On
    Hotkey, WheelUp, zoomChange, On
    Hotkey, !Up, zoomChange, On
    Hotkey, +WheelDown, zoomWindowChange, On
    Hotkey, +Down, zoomWindowChange, On
    Hotkey, +WheelUp, zoomWindowChange, On
    Hotkey, +Up, zoomWindowChange, On

    Gui, 26: +AlwaysOnTop +Owner -Resize -ToolWindow +E0x00000020
    Gui, 26: Show, NoActivate W%zoomWindowW% H%zoomWindowH% X-10000 Y-10000, zoomWindow
    WinSet, Transparent, 254, zoomWindow
    Gui, 26: -Caption
    Gui, 26: +Border
    WinGet, zoomId, id
    zoomHddFrame := DllCall("GetDC", UInt, zoomId)
    WinGet, zoomId, id, zoomWindow
    zoomHdcFrame := DllCall("GetDC", UInt, zoomId)
    DllCall("gdi32.dll\SetStretchBltMode", UInt, zoomHdcFrame, Int, 4)
    GoSub zoomRepaint
    return

    zoomChange:
        zcKey := StringLower(A_ThisHotKey)
        if (endsWith(zcKey, "wheelup") || zcKey == "!up") {
            direction := -1
        }
        else if (endsWith(zcKey, "wheeldown") || zcKey == "!down") {
            direction := 1
        }
        if (direction) {
            zoomAdjust(direction)
        }
        return

    zoomExit:
        SetTimer("zoomRepaint", "off")
        DllCall("gdi32.dll\DeleteDC", UInt, zoomHdcFrame)
        DllCall("gdi32.dll\DeleteDC", UInt, zoomHddFrame)
        Gui, 26: Destroy
        Process("Priority", "", "Normal")
        Hotkey, Escape,, Off
        Hotkey, Space,, Off
        Hotkey, WheelDown,, Off
        Hotkey, !Down,, Off
        Hotkey, WheelUp,, Off
        Hotkey, !Up,, Off
        Hotkey, +WheelDown,, Off
        Hotkey, +Down,, Off
        Hotkey, +WheelUp,, Off
        Hotkey, +Up,, Off
        return

    zoomRepaint:
        CoordMode("Mouse", "Screen")
        MouseGetPos(zoomMouseX, zoomMouseY)
        WinGetPos, tmpX, tmpY, zoomWindowW, zoomWindowH, zoomWindow
        if (zoomWindowDimension != 0)
        {
            zoomWindowW += zoomWindowDimension
            zoomWindowH += zoomWindowDimension
            zoomWindowDimension := 0
        }
        DllCall("gdi32.dll\StretchBlt"
            , UInt, zoomHdcFrame
            , Int , 2                                               ; nXOriginDest
            , Int , 2                                               ; nYOriginDest
            , Int , (zoomWindowW - 6)                               ; nWidthDest
            , Int , (zoomWindowH - 6)                               ; nHeightDest
            , UInt, zoomHddFrame                                    ; hdcSrc
            , Int , (zoomMouseX - (zoomWindowW / 2 / zoomAmount))   ; nXOriginSrc
            , Int , (zoomMouseY - (zoomWindowH / 2 / zoomAmount))   ; nYOriginSrc
            , Int , (zoomWindowW / zoomAmount)                      ; nWidthSrc
            , Int , (zoomWindowH / zoomAmount)                      ; nHeightSrc
            , UInt, 0xCC0020)                                       ; dwRop (raster operation)
        if (zoomFollow) {
            WinMove, zoomWindow, , (zoomMouseX - zoomWindowW / 2), (zoomMouseY - zoomWindowH / 2), %zoomWindowW%, %zoomWindowH%
        }
        SetTimer("zoomRepaint", 10)
        return

    zoomToggleFollow:
        zoomFollow := !zoomFollow
        return

    zoomWindowChange:
        zwcKey := StringLower(A_ThisHotKey)
        if (zwcKey == "+wheelup" || zwcKey == "+up") {
            zoomWindowDimension := 32
        }
        else if (zwcKey == "+wheeldown" || zwcKey == "+down") {
            zoomWindowDimension := -32
        }
        else {
            zoomWindowDimension := 0
        }
        GoSub zoomRepaint
        return
}


;__________________________________________________
;classes
class ArrayList {
    __New(values*) {
        this.values := []
        if (values.MaxIndex() > 0) {
            this.put(values*)
        }
        this.iterator := new ArrayList.Iterator(this)
    }

    class Iterator {
        __New(parent) {
            this.values := parent.values
            this.currentIdx := 0
        }

        current() {
            result := ""
            if (this.values.MinIndex() <= this.currentIdx && this.currentIdx <= this.values.MaxIndex()) {
                result := this.values[this.currentIdx]
            }
            return result
        }

        first() {
            this.currentIdx := 1
            return this.current()
        }

        hasNext() {
            return this.currentIdx < this.values.MaxIndex()
        }

        hasPrevious() {
            return this.values.MinIndex() < this.currentIdx
        }

        index() {
            return this.currentIdx
        }

        last() {
            this.currentIdx := this.values.MaxIndex()
            return this.current()
        }

        next() {
            result := ""
            if (this.hasNext()) {
                this.currentIdx++
                result := this.current()
            }
            else {
                this.currentIdx := this.values.MaxIndex() + 1
            }
            return result
        }

        previous() {
            result := ""
            if (this.hasPrevious()) {
                this.currentIdx--
                result := this.current()
            }
            else {
                this.reset()
            }
            return result
        }

        reset() {
            this.currentIdx := 0
        }
    }

    clear() {
        this.values := ""
        this.values := []
    }

    containsKey(key) {
        result := 0
        for i, kv in this.values {
            this.getKeyValue(kv, k, v)
            if (key == k) {
                result := 1
                break
            }
        }
        return result
    }

    containsValue(value) {
        result := 0
        for i, kv in this.values {
            this.getKeyValue(kv, k, v)
            if (value == v) {
                result := 1
                break
            }
        }
        return result
    }

    getAt(index, ByRef key, ByRef value) {
        kv := this.values[index]
        this.getKeyValue(kv, key, value)
    }

    getKey(value) {
        result := ""
        for i, kv in this.values {
            this.getKeyValue(kv, k, v)
            if (value == v) {
                result := k
                break
            }
        }
        return result
    }

    getKeys() {
        result := []
        for i, kv in this.values {
            this.getKeyValue(kv, k, v)
            result.insert(k)
        }
        return result
    }

    getKeyValue(keyValue, ByRef key, ByRef value) {
        key := ""
        value := ""
        for k, v in keyValue {
            key := k
            value := v
        }
    }

    getValue(key) {
        result := ""
        for i, kv in this.values {
            this.getKeyValue(kv, k, v)
            if (key == k) {
                result := v
                break
            }
        }
        return result
    }

    getValues() {
        result := []
        for i, kv in this.values {
            this.getKeyValue(kv, k, v)
            result.insert(v)
        }
        return result
    }

    indexOfKey(key) {
        result := ""
        for i, kv in this.values {
            this.getKeyValue(kv, k, v)
            if (key == k) {
                result := i
                break
            }
        }
        return result
    }

    indexOfValue(value) {
        result := ""
        for i, kv in this.values {
            this.getKeyValue(kv, k, v)
            if (value == v) {
                result := i
                break
            }
        }
        return result
    }

    insert(values*) {
        idx := this.size() + 1
        this.insertAt(idx, values*)
    }

    insertAfterKey(key, values*) {
        idx := this.indexOfKey(key)
        idx := (idx != "" ? idx : this.size())
        this.insertAt(idx, values*)
    }

    insertAfterValue(value, values*) {
        idx := this.indexOfValue(value)
        idx := (idx != "" ? idx : this.size())
        this.insertAt(idx, values*)
    }

    insertAt(index, values*) {
        if (values.MaxIndex() > 0) {
            arr := this.toAssociativeArray(values*)
            if (index > this.values.MaxIndex()) {
                index := this.values.MaxIndex()
            }
            else if (index < 0) {
                index := 0
            }
            for i, kv in arr {
                this.values.Insert(index + i, kv)
            }
        }
    }

    insertBeforeKey(key, values*) {
        idx := this.indexOfKey(key)
        idx := (idx != "" ? idx - 1 : this.size())
        this.insertAt(idx, values*)
    }

    insertBeforeValue(value, values*) {
        idx := this.indexOfValue(value)
        idx := (idx != "" ? idx - 1 : this.size())
        this.insertAt(idx, values*)
    }

    isEmpty() {
        return (this.size() == 0)
    }

    put(values*) {
        if (values.MaxIndex() > 0) {
            arr := this.toAssociativeArray(values*)
            for i, kv in arr {
                for k, v in kv {
                    idx := this.indexOfKey(k)
                    if (idx != "") {
                        this.values[idx] := kv
                    }
                    else {
                        this.values.Insert(kv)
                    }
                }
            }
        }
    }

    remove(index*) {
        indexes := []
        for i, idx in index {
            indexes[idx] := idx
        }
        max := indexes.MaxIndex()
        while (max != "") {
            this.values.Remove(max)
            indexes.Remove(max)
            max := indexes.MaxIndex()
        }
    }

    removeByKey(key*) {
        for i, k in key {
            idx := this.indexOfKey(k)
            if (idx != "") {
                this.values.Remove(idx)
            }
        }
    }

    removeByValue(value*) {
        for i, v in value {
            idx := this.indexOfValue(v)
            if (idx != "") {
                this.values.Remove(idx)
            }
        }
    }

    size() {
        count := 0
        for key, val in this.values {
            count++
        }
        return count
    }

    toAssociativeArray(values*) {
        arr := []
        if (values.MaxIndex() > 0) {
            if (Mod(values.MaxIndex(), 2) != 0) {
                values.Insert("")
            }
            while (values.MaxIndex() > 0) {
                kv := {values[1]:values[2]}
                arr.Insert(kv)
                values.Remove(1, 2)
            }
        }
        return arr
    }
}

class OldConfig {
    __New(rootName:="") {
        this.editor := "notepad.exe"
        this.enableHkAction := true
        this.enableHkDos := true
        this.enableHkEpp := true
        this.enableHkMisc := true
        this.enableHkText := true
        this.enableHkTransform := true
        this.enableHkWindow := true
        this.enableHsAlias := true
        this.enableHsAutoCorrect := true
        this.enableHsCode := true
        this.enableHsDates := true
        this.enableHsDos := true
        this.enableHsHtml := true
        this.enableHsJira := true
        this.enableHsVariables := true
        this.enableVersionCheck := true
        this.enableAutoStart := true
        this.enableAutoUpdate := true
        this.file := ""
        this.hkSessionCount := 0
        this.hsSessionCount := 0
        this.hkTotalCount := 0
        this.hsTotalCount := 0
        this.hotkeys := {}
        this.inputBoxFieldFont := "Font(Calibri|s10 cBlack Normal)"
        this.inputBoxOptions := "w500 Font(Segoe UI|s9 c0F0F80)"
        this.jiraPanels := new JiraPanels
        this.options := new Options
        this.quickLookupSites := ""
        this.templates := new Templates(rootName)
        this.version := ""
   }
}

class Coords {
    __New() {
        this.height := 0
        this.width := 0
        this.x := 0
        this.y := 0
    }
}

class JiraPanels {
    __New() {
        this.format := "borderStyle=solid|borderColor=#9EB6D4|titleBGColor=#C0CFDD|bgColor=#E0EFFF"
        this.formatBlue := "borderStyle=solid|borderColor=#99BCE8|titleBGColor=#C2D8F0|bgColor=#DFE9F6"
        this.formatGreen := "borderStyle=solid|borderColor=#9EC49F|titleBGColor=#BBDABE|bgColor=#DDFADE"
        this.formatRed := "borderStyle=solid|borderColor=#DF9898|titleBGColor=#DFC7C7|bgColor=#FFE7E7"
        this.formatYellow := "borderStyle=solid|borderColor=#F7DF92|titleBGColor=#DFDFBD|bgColor=#FFFFDD"
    }
}

class MonitorInfo {
    __New() {
        this.idx := 0
        this.name := ""
        this.height := 0
        this.width := 0
        this.top := 0
        this.bottom := 0
        this.left := 0
        this.right := 0
        this.workHeight := 0
        this.workWidth := 0
        this.workTop := 0
        this.workBottom := 0
        this.workLeft := 0
        this.workRight := 0
    }
}

class Options {
    __New() {
        this.oracleTransformRemainderToLower := false
        this.resolutions := ""
    }
}

class Templates {
    __New(rootName:="") {
        this.html := A_ScriptDir . "\" . rootName . "-template.html"
        this.htmlKeys := "^{Home}"
        this.java := A_ScriptDir . "\" . rootName . "-template.java"
        this.javaKeys := "^{Home}"
        this.perl := A_ScriptDir . "\" . rootName . "-template.pl"
        this.perlKeys := "^{Home}"
        this.sql := A_ScriptDir . "\" . rootName . "-template.sql"
        this.sqlKeys := "^{Home}"
    }
}