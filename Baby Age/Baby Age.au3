#NoTrayIcon
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=userb.ico
#AutoIt3Wrapper_Res_requestedExecutionLevel=asInvoker
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#Include <Date.au3>

;Ini file name based on the script name. Strips of the extension before adding *.ini
Global $iniName = StringTrimRight(@ScriptName, 4) & ".ini"

;If no InI file is found then create one, first attempt to look for the backup file
If Not FileExists(@ScriptDir & "\" & $iniName) Then
	;Writes a sample ini file
	IniWrite(@ScriptDir & "\" & $iniName, "Details", "Name", "Child")
	IniWrite(@ScriptDir & "\" & $iniName, "Born", "Year", @YEAR)
	IniWrite(@ScriptDir & "\" & $iniName, "Born", "Month", @MON)
	IniWrite(@ScriptDir & "\" & $iniName, "Born", "Day", @MDAY)
	IniWrite(@ScriptDir & "\" & $iniName, "Born", "Hours", @HOUR)
	IniWrite(@ScriptDir & "\" & $iniName, "Born", "Minutes", @MIN)
	;Message the user
	MsgBox(0, "Message", "The file " & @ScriptDir & "\" & $iniName & " doesn't exist so a default one has been created." & @CRLF & @CRLF & "Please add child details to this file and rerun.")
	Exit
Else
	$Name = IniRead(@ScriptDir & "\" & $iniName, "Details", "Name", "Unknown")
	$Year = IniRead(@ScriptDir & "\" & $iniName, "Born", "Year", "2000")
	$Month = IniRead(@ScriptDir & "\" & $iniName, "Born", "Month", "01")
	$Day = IniRead(@ScriptDir & "\" & $iniName, "Born", "Day", "01")
	$Hours = IniRead(@ScriptDir & "\" & $iniName, "Born", "Hours", "01")
	$Minutes = IniRead(@ScriptDir & "\" & $iniName, "Born", "Minutes", "01")
EndIf

$Born = $Year & "/" & $Month & "/" & $Day & " " & $Hours & ":" & $Minutes

$ageInDays = _DateDiff('D',$Born, _NowCalc())
$ageInWeeks = _DateDiff('w',$Born, _NowCalc())
$ageInMonths = _DateDiff('M',$Born, _NowCalc())
$ageInYears = _DateDiff('Y',$Born, _NowCalc())
$ageInHours = _DateDiff('h',$Born, _NowCalc())
$ageInMins = _DateDiff('n',$Born, _NowCalc())

MsgBox(0, $Name & "'s Age", "Born on " & $Born & @CRLF & @CRLF & "Minutes:  " & $ageInMins & @CRLF & "Hours:  " & $ageInHours & @CRLF & "Days:  " & $ageInDays & @CRLF & "Weeks:  " & $ageInWeeks & @CRLF & "Months:  " & $ageInMonths & @CRLF & "Years:  " & $ageInYears)









