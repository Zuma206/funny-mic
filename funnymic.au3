#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <FileConstants.au3>

$title="Funny Mic"

func initialQuestion()
	$placement=msgbox(4, $title, "Is this file placed in it's own folder?")
	$msgbox_yes=6
	$msgbox_no=7
	if $placement=$msgbox_no Then
		MsgBox(0, $title, "Please place this exe into it's own folder.")
		Exit
	EndIf
	IniWrite("settings.ini", "isDone", "initialQuestion", "y")
EndFunc

func grabPath()
	$loopdir=True
	while $loopdir=True
		MsgBox(0, $title, "Please point to the EqualiserAPO install folder.")
		$dir=FileSelectFolder("Please point to the EqualiserAPO install folder.", "")
		if FileExists($dir & "\editor.exe") Then
			$loopdir=False
		EndIf
	WEnd
	IniWrite("settings.ini", "isDone", "grabPath", "y")
	IniWrite("settings.ini", "settings", "dir", $dir)
EndFunc

#region checkup
$grabPath=IniRead("settings.ini", "isDone", "grabPath", "n")
$initialQuestion=IniRead("settings.ini", "isDone", "initialQuestion", "n")

if $initialQuestion="n" Then
	initialQuestion()
EndIf
if $grabPath="n" Then
	grabPath()
EndIf
#EndRegion end checkup

#Region ### START Koda GUI section ### Form=
$maingui = GUICreate("Funny Mic", 280, 114, 214, 176)
GUISetBkColor(0xFFFFFF)
$title = GUICtrlCreateLabel("Funny Mic is up and running", 8, 8, 269, 29)
GUICtrlSetFont(-1, 14, 400, 0, "Microsoft YaHei UI")
$status = GUICtrlCreateLabel("Current Status: Regular Mic", 8, 40, 257, 29)
GUICtrlSetFont(-1, 14, 400, 0, "Microsoft YaHei UI")
$hotkeys = GUICtrlCreateLabel("Press Insert to enable Funny Mic", 8, 72, 158, 17)
$Label1 = GUICtrlCreateLabel("Press Home to enable Regular Mic", 8, 91, 168, 17)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

$config=IniRead("settings.ini", "settings", "dir", "") & "\config\config.txt"
$nobass="Preamp: 0 dB"
$bass="Preamp: 50 dB"

Func bass()
	FileDelete($config)
	FileWrite($config, $bass)
	GUICtrlSetData($status, "Current Status: Ha Ha Mic")
EndFunc

Func nobass()
	FileDelete($config)
	FileWrite($config, $nobass)
	GUICtrlSetData($status, "Current Status: Regular Mic")
EndFunc

HotKeySet("{Ins}", "bass")
HotKeySet("{Home}", "nobass")

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			nobass()
			Exit

	EndSwitch
WEnd
