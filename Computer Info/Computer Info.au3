#NoTrayIcon
#region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_icon=app.ico
#AutoIt3Wrapper_UseX64=n
#AutoIt3Wrapper_Res_Description=Computer Info
#AutoIt3Wrapper_Res_Fileversion=1.0.0.0
#endregion ;**** Directives created by AutoIt3Wrapper_GUI ****

#comments-start
	------------------------------
	Descriptiopn: Computer Info for bug reports
	Author: Neil Younger
	------------------------------
#comments-end

#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <Date.au3>

;Set Registry paths based on 32bit or 64bit OS
If @OSArch = "X64" And @AutoItX64 <> 1 Then
	$HKCU = "HKEY_CURRENT_USER64"
	$HKLM = "HKEY_LOCAL_MACHINE64"
	$HKU = "HKEY_USERS64"
	$HKCR = "HKEY_CLASSES_ROOT64"
	$HKCC = "HKEY_CURRENT_CONFIG64"
Else
	$HKCU = "HKEY_CURRENT_USER"
	$HKLM = "HKEY_LOCAL_MACHINE"
	$HKU = "HKEY_USERS"
	$HKCR = "HKEY_CLASSES_ROOT"
	$HKCC = "HKEY_CURRENT_CONFIG"
EndIf

;Declare Globals
Global $strcomputer = "." ;used in WMI Setup
Global $objWMIService = ObjGet("winmgmts:" & "{impersonationLevel=impersonate}!\\" & $strcomputer & "\root\cimv2") ;used in WMI Setup
;Ini file name based on the script name. Strips off the extension before adding *.ini
Global $iniName = StringTrimRight(@ScriptName, 4) & ".ini"

;Checks to see if program is already running
$windowTitle = "Test Tool - Computer Info"
If WinExists($windowTitle) Then Exit ; It's already running
AutoItWinSetTitle($windowTitle)

;Start of the Gui
$CompInfo = GUICreate("Computer Information", 527, 542, -1, -1)
$EditCompInfo = GUICtrlCreateEdit("", 10, 39, 503, 297, $GUI_SS_DEFAULT_EDIT)
$GroupSelect = GUICtrlCreateGroup("Selection", 10, 345, 503, 149)
GUICtrlSetFont(-1, 9, 800, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0x000000)
$CheckboxBios = GUICtrlCreateCheckbox("Bios", 172, 398, 119, 21)
$CheckboxWEI = GUICtrlCreateCheckbox("Experience Index", 321, 457, 153, 21)
$CheckboxManufacturer = GUICtrlCreateCheckbox("Manufacturer", 30, 418, 125, 21)
$CheckboxCPU = GUICtrlCreateCheckbox("CPU", 172, 437, 87, 21)
$CheckboxOS = GUICtrlCreateCheckbox("Operating System", 172, 418, 150, 21)
$CheckboxTimestamp = GUICtrlCreateCheckbox("Timestamp", 30, 398, 119, 21)
$CheckboxPrimaryRes = GUICtrlCreateCheckbox("Display Resolution", 321, 398, 149, 21)
$CheckboxHdFreeSpace = GUICtrlCreateCheckbox("Hard Drive Free Space", 321, 437, 183, 21)
$CheckboxGPU = GUICtrlCreateCheckbox("Graphics Card", 172, 457, 135, 21)
$CheckboxCompName = GUICtrlCreateCheckbox("Computer Name", 30, 437, 137, 21)
$CheckboxUsername = GUICtrlCreateCheckbox("Logged on as", 30, 457, 119, 21)
$CheckboxMemory = GUICtrlCreateCheckbox("Physical Memory", 321, 418, 151, 21)
$CheckboxSelectAll = GUICtrlCreateCheckbox("Select All", 30, 368, 99, 21)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$CheckboxRemember = GUICtrlCreateCheckbox("Remember Selections on Exit", 312, 7, 198, 21)
$LabelCompInfo = GUICtrlCreateLabel("Computer Information", 10, 10, 211, 28, 0)
GUICtrlSetFont(-1, 12, 800, 0, "Arial")
GUICtrlSetColor(-1, 0x000000)
$ButtonGatherInfo = GUICtrlCreateButton("Gather Information", 353, 502, 161, 31, $BS_NOTIFY)
GUICtrlSetFont(-1, 9, 800, 0, "MS Sans Serif")
$LabelVersion = GUICtrlCreateLabel("Version 1.02", 10, 512, 77, 20, 0)
GUISetState(@SW_SHOW)
#endregion ### END Koda GUI section ###

;//////////////////////
;Now populate the checkboxes as read from the ini file if it exists
;//////////////////////

If FileExists(@ScriptDir & "\" & $iniName) = 1 Then ;If the ini file exists then read from it
	;Read from ini file
	If IniRead(@ScriptDir & "\" & $iniName, "Configuration", "Bios", "1") = 1 Then GUICtrlSetState($CheckboxBios, $GUI_CHECKED)
	If IniRead(@ScriptDir & "\" & $iniName, "Configuration", "Experience Index", "1") = 1 Then GUICtrlSetState($CheckboxWEI, $GUI_CHECKED)
	If IniRead(@ScriptDir & "\" & $iniName, "Configuration", "Manufacturer", "1") = 1 Then GUICtrlSetState($CheckboxManufacturer, $GUI_CHECKED)
	If IniRead(@ScriptDir & "\" & $iniName, "Configuration", "CPU", "1") = 1 Then GUICtrlSetState($CheckboxCPU, $GUI_CHECKED)
	If IniRead(@ScriptDir & "\" & $iniName, "Configuration", "Operating System", "1") = 1 Then GUICtrlSetState($CheckboxOS, $GUI_CHECKED)
	If IniRead(@ScriptDir & "\" & $iniName, "Configuration", "Logged on as", "1") = 1 Then GUICtrlSetState($CheckboxUsername, $GUI_CHECKED)
	If IniRead(@ScriptDir & "\" & $iniName, "Configuration", "Graphics Card", "1") = 1 Then GUICtrlSetState($CheckboxGPU, $GUI_CHECKED)
	If IniRead(@ScriptDir & "\" & $iniName, "Configuration", "Timestamp", "1") = 1 Then GUICtrlSetState($CheckboxTimestamp, $GUI_CHECKED)
	If IniRead(@ScriptDir & "\" & $iniName, "Configuration", "Primary display resolution", "1") = 1 Then GUICtrlSetState($CheckboxPrimaryRes, $GUI_CHECKED)
	If IniRead(@ScriptDir & "\" & $iniName, "Configuration", "HD free space", "1") = 1 Then GUICtrlSetState($CheckboxHdFreeSpace, $GUI_CHECKED)
	If IniRead(@ScriptDir & "\" & $iniName, "Configuration", "Computer Name", "1") = 1 Then GUICtrlSetState($CheckboxCompName, $GUI_CHECKED)
	If IniRead(@ScriptDir & "\" & $iniName, "Configuration", "Physical Memory", "1") = 1 Then GUICtrlSetState($CheckboxMemory, $GUI_CHECKED)

Else ;If no ini file is found then check all check boxes by default
	_SelectAllCheckboxes()
	;Change name of select all checkbox and make it checked.
	GUICtrlSetData($CheckboxSelectAll, "Deselect All")
	GUICtrlSetState($CheckboxSelectAll, $GUI_CHECKED)
EndIf

;Here we want to disable the checkbox for WMI info it's on a unsupported OS
If @OSVersion = "WIN_XP" Or @OSVersion = "WIN_2000" Or @OSVersion = "WIN_XPe" Then
	GUICtrlSetState($CheckboxWEI, $GUI_UNCHECKED)
	GUICtrlSetState($CheckboxWEI, $GUI_DISABLE)
EndIf

;//////////////////////
;Now generate information based on the selected checkboxes
;//////////////////////
_DisplayComputerInfo()

;//////////////////////
;Main Loop
;//////////////////////

While 1

	;--------------------
	;GUI Messages including button presses and closing
	;--------------------
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			;Check save settings checkbox and save to a ini file. Need to get check box states as well.
			If BitAND(GUICtrlRead($CheckboxRemember), $GUI_CHECKED) = 1 Then
				IniWrite(@ScriptDir & "\" & $iniName, "Configuration", "Bios", BitAND(GUICtrlRead($CheckboxBios), $GUI_CHECKED))
				IniWrite(@ScriptDir & "\" & $iniName, "Configuration", "Experience Index", BitAND(GUICtrlRead($CheckboxWEI), $GUI_CHECKED))
				IniWrite(@ScriptDir & "\" & $iniName, "Configuration", "Manufacturer", BitAND(GUICtrlRead($CheckboxManufacturer), $GUI_CHECKED))
				IniWrite(@ScriptDir & "\" & $iniName, "Configuration", "CPU", BitAND(GUICtrlRead($CheckboxCPU), $GUI_CHECKED))
				IniWrite(@ScriptDir & "\" & $iniName, "Configuration", "Operating System", BitAND(GUICtrlRead($CheckboxOS), $GUI_CHECKED))
				IniWrite(@ScriptDir & "\" & $iniName, "Configuration", "Logged on as", BitAND(GUICtrlRead($CheckboxUsername), $GUI_CHECKED))
				IniWrite(@ScriptDir & "\" & $iniName, "Configuration", "Graphics Card", BitAND(GUICtrlRead($CheckboxGPU), $GUI_CHECKED))
				IniWrite(@ScriptDir & "\" & $iniName, "Configuration", "Timestamp", BitAND(GUICtrlRead($CheckboxTimestamp), $GUI_CHECKED))
				IniWrite(@ScriptDir & "\" & $iniName, "Configuration", "Primary display resolution", BitAND(GUICtrlRead($CheckboxPrimaryRes), $GUI_CHECKED))
				IniWrite(@ScriptDir & "\" & $iniName, "Configuration", "HD free space", BitAND(GUICtrlRead($CheckboxHdFreeSpace), $GUI_CHECKED))
				IniWrite(@ScriptDir & "\" & $iniName, "Configuration", "Computer Name", BitAND(GUICtrlRead($CheckboxCompName), $GUI_CHECKED))
				IniWrite(@ScriptDir & "\" & $iniName, "Configuration", "Physical Memory", BitAND(GUICtrlRead($CheckboxMemory), $GUI_CHECKED))
				Exit
			Else
				Exit
			EndIf

			;Gather Info button
		Case $ButtonGatherInfo
			_DisplayComputerInfo()

		Case $CheckboxSelectAll
			;Select/deselect all checkboxes depending on state of the box
			If BitAND(GUICtrlRead($CheckboxSelectAll), $GUI_CHECKED) = 1 Then
				_SelectAllCheckboxes()
				GUICtrlSetData($CheckboxSelectAll, "Deselect All")
			ElseIf BitAND(GUICtrlRead($CheckboxSelectAll), $GUI_CHECKED) = 0 Then
				_DeselectAllCheckboxes()
				GUICtrlSetData($CheckboxSelectAll, "Select All")
			EndIf

	EndSwitch

WEnd

;//////////////////////
;Functions
;//////////////////////

;Select all checkboxes
Func _SelectAllCheckboxes()
	GUICtrlSetState($CheckboxBios, $GUI_CHECKED)
	GUICtrlSetState($CheckboxWEI, $GUI_CHECKED)
	GUICtrlSetState($CheckboxManufacturer, $GUI_CHECKED)
	GUICtrlSetState($CheckboxCPU, $GUI_CHECKED)
	GUICtrlSetState($CheckboxOS, $GUI_CHECKED)
	GUICtrlSetState($CheckboxGPU, $GUI_CHECKED)
	GUICtrlSetState($CheckboxTimestamp, $GUI_CHECKED)
	GUICtrlSetState($CheckboxPrimaryRes, $GUI_CHECKED)
	GUICtrlSetState($CheckboxHdFreeSpace, $GUI_CHECKED)
	GUICtrlSetState($CheckboxCompName, $GUI_CHECKED)
	GUICtrlSetState($CheckboxUsername, $GUI_CHECKED)
	GUICtrlSetState($CheckboxMemory, $GUI_CHECKED)
EndFunc   ;==>_SelectAllCheckboxes

;Select all checkboxes
Func _DeselectAllCheckboxes()
	GUICtrlSetState($CheckboxBios, $GUI_UNCHECKED)
	GUICtrlSetState($CheckboxWEI, $GUI_UNCHECKED)
	GUICtrlSetState($CheckboxManufacturer, $GUI_UNCHECKED)
	GUICtrlSetState($CheckboxCPU, $GUI_UNCHECKED)
	GUICtrlSetState($CheckboxOS, $GUI_UNCHECKED)
	GUICtrlSetState($CheckboxGPU, $GUI_UNCHECKED)
	GUICtrlSetState($CheckboxTimestamp, $GUI_UNCHECKED)
	GUICtrlSetState($CheckboxPrimaryRes, $GUI_UNCHECKED)
	GUICtrlSetState($CheckboxHdFreeSpace, $GUI_UNCHECKED)
	GUICtrlSetState($CheckboxCompName, $GUI_UNCHECKED)
	GUICtrlSetState($CheckboxUsername, $GUI_UNCHECKED)
	GUICtrlSetState($CheckboxMemory, $GUI_UNCHECKED)
EndFunc   ;==>_DeselectAllCheckboxes

;Bios Infomation
Func _ComputerBios()
	Local $Win32_BIOSSerialNumber, $Win32_BIOSReleaseDate, $Win32_SMBIOSBIOSVersion

	$Win32_BIOS = $objWMIService.ExecQuery("SELECT * FROM Win32_BIOS")
	For $objComputer In $Win32_BIOS
		$Win32_BIOSSerialNumber = $objComputer.SerialNumber
		$Win32_BIOSReleaseDate = $objComputer.ReleaseDate
		$Win32_SMBIOSBIOSVersion = $objComputer.SMBIOSBIOSVersion
	Next

	GUICtrlSetData($EditCompInfo, @CRLF & "System Bios: Version " & $Win32_SMBIOSBIOSVersion & " built " & _Format8CharDate($Win32_BIOSReleaseDate), "insert")

EndFunc   ;==>_ComputerBios

;Windows Experience Index
Func _ComputerWMI()
	Local $CPUScore, $MemoryScore, $DiskScore, $GraphicsScore, $D3DScore, $WinSPRLevel ;Used in Winsat scores
	Local $WMIWinSat;WMI

	;Get performance stats. Not for XP and 2K
	If @OSVersion <> "WIN_XP" And @OSVersion <> "WIN_2000" And @OSVersion <> "WIN_XPe" Then
		$WMIWinSat = $objWMIService.ExecQuery("SELECT * FROM Win32_WinSAT")
		For $objComputer In $WMIWinSat
			$D3DScore = Round($objComputer.D3DScore, 1) ;round to 1dp
			$CPUScore = Round($objComputer.CPUScore, 1)
			$MemoryScore = Round($objComputer.MemoryScore, 1)
			$DiskScore = Round($objComputer.DiskScore, 1)
			$GraphicsScore = Round($objComputer.GraphicsScore, 1)
			$WinSPRLevel = Round($objComputer.WinSPRLevel, 1)
		Next
	EndIf

	;No point adding the WEI score for XP/2K
	If @OSVersion <> "WIN_XP" And @OSVersion <> "WIN_2000" And @OSVersion <> "WIN_XPe" Then
		GUICtrlSetData($EditCompInfo, @CRLF & "Experience Index:  " & "Base Score " & $WinSPRLevel & " (CPU=" & $CPUScore & " RAM=" & $MemoryScore & " GPU=" & $GraphicsScore & " Gaming=" & $D3DScore & " Disk=" & $DiskScore & ")", "insert")
	EndIf

EndFunc   ;==>_ComputerWMI

;Operating System
Func _ComputerOS()
	Local $OsFull, $Debug ;Used in OS
	Local $OSServicePack
	Local $WMIOperatingSystem;WMI

	;Operating System Info
	$WMIOperatingSystem = $objWMIService.ExecQuery("SELECT * FROM Win32_OperatingSystem")
	For $objComputer In $WMIOperatingSystem
		$OsFull = $objComputer.Caption
		$Debug = $objComputer.Debug
	Next

	;A check so that if @OSServicePack returns null output "No Service Pack"
	Select
		Case @OSServicePack = ""
			$OSServicePack = "No Service Pack"
		Case Else
			$OSServicePack = @OSServicePack
	EndSelect

	GUICtrlSetData($EditCompInfo, @CRLF & "OS:  " & $OsFull & " (" & @OSArch & "), " & $OSServicePack & ", " & _Language(), "insert")
	GUICtrlSetData($EditCompInfo, @CRLF & "OS Build:  " & @OSBuild & " (Debug = " & $Debug & ")", "insert")
EndFunc   ;==>_ComputerOS

;CPU
Func _ComputerCPU()
	Local $processor
	Local $numberOfCores = EnvGet("NUMBER_OF_PROCESSORS")

	$processor = StringReplace(StringStripWS(RegRead($HKLM & "\HARDWARE\DESCRIPTION\System\CentralProcessor\0", "ProcessorNameString"), 1), "®", "", 0, 0)

	GUICtrlSetData($EditCompInfo, @CRLF & "CPU:  " & $processor, "insert")
	;Get the number of cores
	GUICtrlSetData($EditCompInfo, @CRLF & "Number of Cores:  " & $numberOfCores, "insert")

EndFunc   ;==>_ComputerCPU

;GPU
Func _ComputerGPU()

	Local $WMIVideoController ;WMI
	Local $DriverName, $DriverDate, $DriverVersion, $DriverAdapterCompatibility ;Used in Video Adapter

	$WMIVideoController = $objWMIService.ExecQuery("SELECT * FROM Win32_VideoController")

	;Get Graphics adapter Info
	For $objComputer In $WMIVideoController
		$DriverName = $objComputer.Name
		$DriverDate = $objComputer.DriverDate
		$DriverVersion = $objComputer.DriverVersion
		$DriverAdapterCompatibility = $objComputer.AdapterCompatibility
		GUICtrlSetData($EditCompInfo, @CRLF & "Graphics Card:  " & $DriverName & " (" & $DriverAdapterCompatibility & ")", "insert")
		GUICtrlSetData($EditCompInfo, @CRLF & "Graphics Driver:  " & $DriverVersion & " Dated " & _Format8CharDate($DriverDate), "insert")
	Next
	;Get Graphics adapter Info End
EndFunc   ;==>_ComputerGPU

;Time and date
Func _DateStamp()
	GUICtrlSetData($EditCompInfo, @CRLF & "Timestamp:  " & _Now(), "insert")
EndFunc   ;==>_DateStamp

;Computer Name
Func _CompterName()
	GUICtrlSetData($EditCompInfo, @CRLF & "Computer Name:  " & @ComputerName, "insert")
EndFunc   ;==>_CompterName

;Primary Size
Func _CompterPrimarySize()
	GUICtrlSetData($EditCompInfo, @CRLF & "Display Resolution:  " & @DesktopWidth & "x" & @DesktopHeight & "x" & @DesktopDepth, "insert")
EndFunc   ;==>_CompterPrimarySize

;Free Space
Func _ComputerFreespace()
	Local $driveSpaceFree

	$driveSpaceFree = Round(DriveSpaceFree(@HomeDrive)) ;Does it in MB. Added Rounding. Shows space for current OS drive.

	GUICtrlSetData($EditCompInfo, @CRLF & "Hard Drive Free Space:  " & @HomeDrive & "\ " & Round($driveSpaceFree / 1000) & " GB" & " (" & $driveSpaceFree & " MB)", "insert")

EndFunc   ;==>_ComputerFreespace

;User Name
Func _UserName()
	GUICtrlSetData($EditCompInfo, @CRLF & "Logged on as:  " & @UserName, "insert")
EndFunc   ;==>_UserName

;Computer Memory
Func _ComputerMemory()

	Local $WMIComputerSystem ;WMI
	Local $TotalPhysicalMemory ;Used in ComputerSystem, given in bytes.

	;Set details returned from query to variables
	$WMIComputerSystem = $objWMIService.ExecQuery("SELECT * FROM Win32_ComputerSystem")
	For $objComputer In $WMIComputerSystem
		$TotalPhysicalMemory = $objComputer.TotalPhysicalMemory
	Next

	GUICtrlSetData($EditCompInfo, @CRLF & "Physical Memory:  " & Round($TotalPhysicalMemory / 1048576) & " MB", "insert")

EndFunc   ;==>_ComputerMemory

;Get computer information
Func _ComputerInfo()
	Local $WMIComputerSystem ;WMI
	Local $Manufacturer, $Model;Used in ComputerSystem
	Local $Win32_BIOS, $Win32_BIOSSerialNumber

	;Set details returned from query to variables
	$WMIComputerSystem = $objWMIService.ExecQuery("SELECT * FROM Win32_ComputerSystem")
	For $objComputer In $WMIComputerSystem
		$Manufacturer = $objComputer.Manufacturer
		$Model = $objComputer.Model
	Next

	$Win32_BIOS = $objWMIService.ExecQuery("SELECT * FROM Win32_BIOS")
	For $objComputer In $Win32_BIOS
		$Win32_BIOSSerialNumber = $objComputer.SerialNumber
	Next

	GUICtrlSetData($EditCompInfo, @CRLF & "Computer:  " & $Manufacturer & " - " & StringStripWS($Model, 3) & " " & $Win32_BIOSSerialNumber, "insert")

EndFunc   ;==>_ComputerInfo

;Display data depending on checkboxes
Func _DisplayComputerInfo()
	GUICtrlSetData($EditCompInfo, ""); Clear edit box
	;Only gathers information if checkbox is checked
	If BitAND(GUICtrlRead($CheckboxTimestamp), $GUI_CHECKED) = 1 Then
		_DateStamp()
	EndIf
	If BitAND(GUICtrlRead($CheckboxManufacturer), $GUI_CHECKED) = 1 Then
		_ComputerInfo()
	EndIf
	If BitAND(GUICtrlRead($CheckboxCompName), $GUI_CHECKED) = 1 Then
		_CompterName()
	EndIf
	If BitAND(GUICtrlRead($CheckboxUsername), $GUI_CHECKED) = 1 Then
		_UserName()
	EndIf
	If BitAND(GUICtrlRead($CheckboxBios), $GUI_CHECKED) = 1 Then
		_ComputerBios()
	EndIf
	If BitAND(GUICtrlRead($CheckboxOS), $GUI_CHECKED) = 1 Then
		_ComputerOS()
	EndIf
	If BitAND(GUICtrlRead($CheckboxCPU), $GUI_CHECKED) = 1 Then
		_ComputerCPU()
	EndIf
	If BitAND(GUICtrlRead($CheckboxGPU), $GUI_CHECKED) = 1 Then
		_ComputerGPU()
	EndIf
	If BitAND(GUICtrlRead($CheckboxPrimaryRes), $GUI_CHECKED) = 1 Then
		_CompterPrimarySize()
	EndIf
	If BitAND(GUICtrlRead($CheckboxMemory), $GUI_CHECKED) = 1 Then
		_ComputerMemory()
	EndIf
	If BitAND(GUICtrlRead($CheckboxHdFreeSpace), $GUI_CHECKED) = 1 Then
		_ComputerFreespace()
	EndIf
	If BitAND(GUICtrlRead($CheckboxWEI), $GUI_CHECKED) = 1 Then
		_ComputerWMI()
	EndIf
	;Blankline
	GUICtrlSetData($EditCompInfo, @CRLF, "insert")
EndFunc   ;==>_DisplayComputerInfo

;Format 8 character dates in YYYYMMDD to YYYY-MM-DD
Func _Format8CharDate($8CharDate)
	Return StringLeft(StringLeft($8CharDate, 8), 4) & "-" & StringMid(StringLeft($8CharDate, 8), 5, 2) & "-" & StringRight(StringLeft($8CharDate, 8), 2)
EndFunc   ;==>_Format8CharDate

;This determines the language of the OS
Func _Language()
	Select
		Case StringInStr("0413,0813", @OSLang)
			Return "Dutch"

		Case StringInStr("0409,0809,0c09,1009,1409,1809,1c09,2009, 2409,2809,2c09,3009,3409", @OSLang)
			Return "English"

		Case StringInStr("040c,080c,0c0c,100c,140c,180c", @OSLang)
			Return "French"

		Case StringInStr("0407,0807,0c07,1007,1407", @OSLang)
			Return "German"

		Case StringInStr("0410,0810", @OSLang)
			Return "Italian"

		Case StringInStr("0414,0814", @OSLang)
			Return "Norwegian"

		Case StringInStr("0415", @OSLang)
			Return "Polish"

		Case StringInStr("0416,0816", @OSLang)
			Return "Portuguese"

		Case StringInStr("040a,080a,0c0a,100a,140a,180a,1c0a,200a, 240a,280a,2c0a,300a,340a,380a,3c0a,400a, 440a,480a,4c0a,500a", @OSLang)
			Return "Spanish"

		Case StringInStr("041d,081d", @OSLang)
			Return "Swedish"

		Case Else
			Return "Other (can't determine with @OSLang directly)"

	EndSelect
EndFunc   ;==>_Language
