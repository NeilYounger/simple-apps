#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_icon=stats.ico
#AutoIt3Wrapper_UseX64=n
#AutoIt3Wrapper_Res_Comment=Simple Counter
#AutoIt3Wrapper_Res_Description=Counter
#AutoIt3Wrapper_Res_Fileversion=1.0.0.0
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <TabConstants.au3>
#include <WindowsConstants.au3>
#include <Array.au3>

;Ini file name based on the script name. Strips of the extension before adding *.ini
Global $iniName = StringTrimRight(@ScriptName, 4) & ".ini"
Global $windowTitle
Global $MonthData
Global $PreviousMonthDate
Global $MonthPreviousData
Global $Jan, $Feb, $Mar, $Apr, $May, $Jun, $Jul, $Aug, $Sep, $Oct, $Nov, $Dec
Global $JanPrev, $FebPrev, $MarPrev, $AprPrev, $MayPrev, $JunPrev, $JulPrev, $AugPrev, $SepPrev, $OctPrev, $NovPrev, $DecPrev
Global $MonthTotal, $PreviousMonthTotal
Global $MonthAverage, $PreviousMonthAverage
Global $BestMonthValue = 0
Global $BestMonth = "N/A"

;Checks to see if program is already running
$windowTitle = "CompCounter"
If WinExists($windowTitle) Then Exit ; It's already running
AutoItWinSetTitle($windowTitle)

FileInstall("samplerButton.wav", @TempDir & "\click.wav")

;If no InI file is found then create one, first attempt to look for the backup file
If FileExists(@ScriptDir & "\" & $iniName) = 0 And FileExists(@ScriptDir & "\" & $iniName & ".bak") = 0 Then
	;Writes a sample ini file
	IniWrite(@ScriptDir & "\" & $iniName, "CurrentYear", "01", "0")
	IniWrite(@ScriptDir & "\" & $iniName, "CurrentYear", "02", "0")
	IniWrite(@ScriptDir & "\" & $iniName, "CurrentYear", "03", "0")
	IniWrite(@ScriptDir & "\" & $iniName, "CurrentYear", "04", "0")
	IniWrite(@ScriptDir & "\" & $iniName, "CurrentYear", "05", "0")
	IniWrite(@ScriptDir & "\" & $iniName, "CurrentYear", "06", "0")
	IniWrite(@ScriptDir & "\" & $iniName, "CurrentYear", "07", "0")
	IniWrite(@ScriptDir & "\" & $iniName, "CurrentYear", "08", "0")
	IniWrite(@ScriptDir & "\" & $iniName, "CurrentYear", "09", "0")
	IniWrite(@ScriptDir & "\" & $iniName, "CurrentYear", "10", "0")
	IniWrite(@ScriptDir & "\" & $iniName, "CurrentYear", "11", "0")
	IniWrite(@ScriptDir & "\" & $iniName, "CurrentYear", "12", "0")
	IniWrite(@ScriptDir & "\" & $iniName, "PreviousYear", "01", "0")
	IniWrite(@ScriptDir & "\" & $iniName, "PreviousYear", "02", "0")
	IniWrite(@ScriptDir & "\" & $iniName, "PreviousYear", "03", "0")
	IniWrite(@ScriptDir & "\" & $iniName, "PreviousYear", "04", "0")
	IniWrite(@ScriptDir & "\" & $iniName, "PreviousYear", "05", "0")
	IniWrite(@ScriptDir & "\" & $iniName, "PreviousYear", "06", "0")
	IniWrite(@ScriptDir & "\" & $iniName, "PreviousYear", "07", "0")
	IniWrite(@ScriptDir & "\" & $iniName, "PreviousYear", "08", "0")
	IniWrite(@ScriptDir & "\" & $iniName, "PreviousYear", "09", "0")
	IniWrite(@ScriptDir & "\" & $iniName, "PreviousYear", "10", "0")
	IniWrite(@ScriptDir & "\" & $iniName, "PreviousYear", "11", "0")
	IniWrite(@ScriptDir & "\" & $iniName, "PreviousYear", "12", "0")
	IniWrite(@ScriptDir & "\" & $iniName, "Settings", "OnTop", "yes")
	IniWrite(@ScriptDir & "\" & $iniName, "Settings", "CurrentYear", @YEAR)
ElseIf FileExists(@ScriptDir & "\" & $iniName) = 0 And FileExists(@ScriptDir & "\" & $iniName & ".bak") = 1 Then
	MsgBox(0, "Message", "The file " & @ScriptDir & "\" & $iniName & " doesn't exist but a backup does." & @CRLF & @CRLF & "Restoring backup file.")
	If FileCopy(@ScriptDir & "\" & $iniName & ".bak", @ScriptDir & "\" & $iniName) = 1 Then
		MsgBox(0, "Message", "The backup file has been restored.")
	Else
		MsgBox(0, "Message", "Unable to restore the backup file " & @ScriptDir & "\" & $iniName & ".bak")
		Exit
	EndIf
EndIf

;Read current and previous history from the ini file
_GetCurrentData()
_GetPreviousData()

;See if the current year matches and if not copy current data to previous year
If IniRead(@ScriptDir & "\" & $iniName, "Settings", "CurrentYear", @YEAR) <> @YEAR Then
	If MsgBox(262436, "Message", "Looks like another year has passed! Would you like to start a new year and move your current data into the previous year?" & @CRLF & @CRLF & "Note: Please make sure you have made a note of any previous year history as this will be replaced.") = 6 Then
		IniWrite(@ScriptDir & "\" & $iniName, "PreviousYear", "01", $Jan)
		IniWrite(@ScriptDir & "\" & $iniName, "PreviousYear", "02", $Feb)
		IniWrite(@ScriptDir & "\" & $iniName, "PreviousYear", "03", $Mar)
		IniWrite(@ScriptDir & "\" & $iniName, "PreviousYear", "04", $Apr)
		IniWrite(@ScriptDir & "\" & $iniName, "PreviousYear", "05", $May)
		IniWrite(@ScriptDir & "\" & $iniName, "PreviousYear", "06", $Jun)
		IniWrite(@ScriptDir & "\" & $iniName, "PreviousYear", "07", $Jul)
		IniWrite(@ScriptDir & "\" & $iniName, "PreviousYear", "08", $Aug)
		IniWrite(@ScriptDir & "\" & $iniName, "PreviousYear", "09", $Sep)
		IniWrite(@ScriptDir & "\" & $iniName, "PreviousYear", "10", $Oct)
		IniWrite(@ScriptDir & "\" & $iniName, "PreviousYear", "11", $Nov)
		IniWrite(@ScriptDir & "\" & $iniName, "PreviousYear", "12", $Dec)
		;Clear existing current values
		IniWrite(@ScriptDir & "\" & $iniName, "CurrentYear", "01", "0")
		IniWrite(@ScriptDir & "\" & $iniName, "CurrentYear", "02", "0")
		IniWrite(@ScriptDir & "\" & $iniName, "CurrentYear", "03", "0")
		IniWrite(@ScriptDir & "\" & $iniName, "CurrentYear", "04", "0")
		IniWrite(@ScriptDir & "\" & $iniName, "CurrentYear", "05", "0")
		IniWrite(@ScriptDir & "\" & $iniName, "CurrentYear", "06", "0")
		IniWrite(@ScriptDir & "\" & $iniName, "CurrentYear", "07", "0")
		IniWrite(@ScriptDir & "\" & $iniName, "CurrentYear", "08", "0")
		IniWrite(@ScriptDir & "\" & $iniName, "CurrentYear", "09", "0")
		IniWrite(@ScriptDir & "\" & $iniName, "CurrentYear", "10", "0")
		IniWrite(@ScriptDir & "\" & $iniName, "CurrentYear", "11", "0")
		IniWrite(@ScriptDir & "\" & $iniName, "CurrentYear", "12", "0")
		;Set year to current
		IniWrite(@ScriptDir & "\" & $iniName, "Settings", "CurrentYear", @YEAR)
		MsgBox(0, "Message", "All done, Please restart the program")
		Exit
	Else
		Exit
	EndIf
EndIf

;Calculate all month totals
$MonthTotal = Number($Jan) + Number($Feb) + Number($Mar) + Number($Apr) + Number($May) + Number($Jun) + Number($Jul) + Number($Aug) + Number($Sep) + Number($Oct) + Number($Nov) + Number($Dec)

;Calculate average per month
$MonthAverage = Round($MonthTotal / @MON)

;Calculate Previous all month totals
$PreviousMonthTotal = Number($JanPrev) + Number($FebPrev) + Number($MarPrev) + Number($AprPrev) + Number($MayPrev) + Number($JunPrev) + Number($JulPrev) + Number($AugPrev) + Number($SepPrev) + Number($OctPrev) + Number($NovPrev) + Number($DecPrev)

;Calculate Previous average per month
$PreviousMonthAverage = Round($PreviousMonthTotal / 12)

;Calculate the best month
If Number($Jan) > $BestMonthValue Then
	$BestMonthValue = $Jan
	$BestMonth = "Jan"
EndIf
If Number($Feb) > $BestMonthValue Then
	$BestMonthValue = $Feb
	$BestMonth = "Feb"
EndIf
If Number($Mar) > $BestMonthValue Then
	$BestMonthValue = $Mar
	$BestMonth = "Mar"
EndIf
If Number($Apr) > $BestMonthValue Then
	$BestMonthValue = $Apr
	$BestMonth = "Apr"
EndIf
If Number($May) > $BestMonthValue Then
	$BestMonthValue = $May
	$BestMonth = "May"
EndIf
If Number($Jun) > $BestMonthValue Then
	$BestMonthValue = $Jun
	$BestMonth = "Jun"
EndIf
If Number($Jul) > $BestMonthValue Then
	$BestMonthValue = $Jul
	$BestMonth = "Jul"
EndIf
If Number($Aug) > $BestMonthValue Then
	$BestMonthValue = $Aug
	$BestMonth = "Aug"
EndIf
If Number($Sep) > $BestMonthValue Then
	$BestMonthValue = $Sep
	$BestMonth = "Sep"
EndIf
If Number($Oct) > $BestMonthValue Then
	$BestMonthValue = $Oct
	$BestMonth = "Oct"
EndIf
If Number($Nov) > $BestMonthValue Then
	$BestMonthValue = $Nov
	$BestMonth = "Nov"
EndIf
If Number($Dec) > $BestMonthValue Then
	$BestMonthValue = $Dec
	$BestMonth = "Dec"
EndIf

;GUI
#Region ### START Koda GUI section ### Form=C:\Personal\AutoIT\Comp Counter\Comp Counter v2.kxf
$Counter = GUICreate("Counter", 223, 257, -1, -1)
$Tab1 = GUICtrlCreateTab(8, 8, 209, 241)
$Counter = GUICtrlCreateTabItem("Counter")
$GroupMonth = GUICtrlCreateGroup("Current Month", 20, 33, 185, 105)
$LabelCurrent = GUICtrlCreateLabel("0000", 38, 49, 148, 79, $SS_CENTER)
GUICtrlSetFont(-1, 48, 800, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
$GroupBest = GUICtrlCreateGroup("Best", 148, 145, 57, 57)
$LabelBestMonth = GUICtrlCreateLabel("Current", 153, 161, 47, 18, $SS_CENTER)
GUICtrlSetFont(-1, 8, 800, 0, "Arial")
$LabelBestData = GUICtrlCreateLabel("0000", 160, 176, 28, 18, $SS_CENTER)
GUICtrlSetFont(-1, 8, 800, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
$GroupLastMonth = GUICtrlCreateGroup("Previous", 20, 145, 57, 57)
$LabelLast = GUICtrlCreateLabel("0000", 28, 171, 40, 23, $SS_CENTER)
GUICtrlSetFont(-1, 12, 800, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
$GroupAverageMonth = GUICtrlCreateGroup("Average", 84, 145, 57, 57)
$LabelAverage = GUICtrlCreateLabel("0000", 92, 171, 40, 23, $SS_CENTER)
GUICtrlSetFont(-1, 12, 800, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
$ButtonCount = GUICtrlCreateButton("Count", 19, 209, 187, 33)
GUICtrlSetFont(-1, 12, 800, 0, "Arial")
$TabSheet3 = GUICtrlCreateTabItem("Current")
$InputJan = GUICtrlCreateInput("0000", 17, 63, 41, 21)
GUICtrlSetState(-1, $GUI_DISABLE)
$InputOct = GUICtrlCreateInput("0000", 113, 135, 41, 21)
GUICtrlSetState(-1, $GUI_DISABLE)
$InputMar = GUICtrlCreateInput("0000", 17, 111, 41, 21)
GUICtrlSetState(-1, $GUI_DISABLE)
$InputSep = GUICtrlCreateInput("0000", 113, 111, 41, 21)
GUICtrlSetState(-1, $GUI_DISABLE)
$InputMay = GUICtrlCreateInput("0000", 17, 159, 41, 21)
GUICtrlSetState(-1, $GUI_DISABLE)
$InputFeb = GUICtrlCreateInput("0000", 17, 87, 41, 21)
GUICtrlSetState(-1, $GUI_DISABLE)
$InputJun = GUICtrlCreateInput("0000", 17, 183, 41, 21)
GUICtrlSetState(-1, $GUI_DISABLE)
$InputAug = GUICtrlCreateInput("0000", 113, 87, 41, 21)
GUICtrlSetState(-1, $GUI_DISABLE)
$InputNov = GUICtrlCreateInput("0000", 113, 159, 41, 21)
GUICtrlSetState(-1, $GUI_DISABLE)
$InputApr = GUICtrlCreateInput("0000", 17, 135, 41, 21)
GUICtrlSetState(-1, $GUI_DISABLE)
$InputJul = GUICtrlCreateInput("0000", 113, 63, 41, 21)
GUICtrlSetState(-1, $GUI_DISABLE)
$InputDec = GUICtrlCreateInput("0000", 113, 183, 41, 21)
GUICtrlSetState(-1, $GUI_DISABLE)
$LabelJan = GUICtrlCreateLabel("January", 64, 64, 41, 17)
$LabelFeb = GUICtrlCreateLabel("Feburary", 64, 88, 45, 17)
$LabelMar = GUICtrlCreateLabel("March", 64, 112, 34, 17)
$LabelApr = GUICtrlCreateLabel("April", 64, 136, 24, 17)
$LabelMay = GUICtrlCreateLabel("May", 64, 160, 24, 17)
$LabelJun = GUICtrlCreateLabel("June", 64, 184, 27, 17)
$LabelJul = GUICtrlCreateLabel("July", 160, 64, 22, 17)
$LabelAug = GUICtrlCreateLabel("August", 160, 88, 37, 17)
$LabelSep = GUICtrlCreateLabel("September", 160, 112, 55, 17)
$LabelOct = GUICtrlCreateLabel("October", 160, 136, 42, 17)
$LabelNov = GUICtrlCreateLabel("November", 160, 160, 53, 17)
$LabelDec = GUICtrlCreateLabel("December", 160, 184, 53, 17)
$ButtonHistoryEdit = GUICtrlCreateButton("Edit History", 22, 216, 83, 25)
$ButtonHistoryApply = GUICtrlCreateButton("Apply Changes", 120, 216, 83, 25)
$LabelCurrentYear = GUICtrlCreateLabel("0000", 17, 38, 32, 17)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
$TabSheet1 = GUICtrlCreateTabItem("Previous")
$InputJanPrev = GUICtrlCreateInput("0000", 17, 63, 41, 21)
GUICtrlSetState(-1, $GUI_DISABLE)
$LabelPrevJan = GUICtrlCreateLabel("January", 64, 64, 41, 17)
$InputJulPrev = GUICtrlCreateInput("0000", 113, 63, 41, 21)
GUICtrlSetState(-1, $GUI_DISABLE)
$LabelPreJul = GUICtrlCreateLabel("July", 160, 64, 22, 17)
$InputFebPrev = GUICtrlCreateInput("0000", 17, 87, 41, 21)
GUICtrlSetState(-1, $GUI_DISABLE)
$LabelPrevFeb = GUICtrlCreateLabel("Feburary", 64, 88, 45, 17)
$InputAugPrev = GUICtrlCreateInput("0000", 113, 87, 41, 21)
GUICtrlSetState(-1, $GUI_DISABLE)
$LabelPrevAug = GUICtrlCreateLabel("August", 160, 88, 37, 17)
$InputMarPrev = GUICtrlCreateInput("0000", 17, 111, 41, 21)
GUICtrlSetState(-1, $GUI_DISABLE)
$LabelPrevMar = GUICtrlCreateLabel("March", 64, 112, 34, 17)
$InputSepPrev = GUICtrlCreateInput("0000", 113, 111, 41, 21)
GUICtrlSetState(-1, $GUI_DISABLE)
$LabelPrevSep = GUICtrlCreateLabel("September", 160, 112, 55, 17)
$InputAprPrev = GUICtrlCreateInput("0000", 17, 135, 41, 21)
GUICtrlSetState(-1, $GUI_DISABLE)
$LabelPrevApr = GUICtrlCreateLabel("April", 64, 136, 24, 17)
$InputOctPrev = GUICtrlCreateInput("0000", 113, 135, 41, 21)
GUICtrlSetState(-1, $GUI_DISABLE)
$LabelPrevOct = GUICtrlCreateLabel("October", 160, 136, 42, 17)
$InputMayPrev = GUICtrlCreateInput("0000", 17, 159, 41, 21)
GUICtrlSetState(-1, $GUI_DISABLE)
$LabelPrevMay = GUICtrlCreateLabel("May", 64, 160, 24, 17)
$InputNovPrev = GUICtrlCreateInput("0000", 113, 159, 41, 21)
GUICtrlSetState(-1, $GUI_DISABLE)
$LabelPrevNov = GUICtrlCreateLabel("November", 160, 160, 53, 17)
$InputJunPrev = GUICtrlCreateInput("0000", 17, 183, 41, 21)
GUICtrlSetState(-1, $GUI_DISABLE)
$InputDecPrev = GUICtrlCreateInput("0000", 113, 183, 41, 21)
GUICtrlSetState(-1, $GUI_DISABLE)
$LabelPrevDec = GUICtrlCreateLabel("December", 160, 184, 53, 17)
$LabelPrevJun = GUICtrlCreateLabel("June", 64, 184, 27, 17)
$LabelPreviousYear = GUICtrlCreateLabel("0000", 17, 38, 32, 17)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
$LabelPrevTotal = GUICtrlCreateLabel("Total: ", 17, 208, 34, 17)
$LabelPrevAve = GUICtrlCreateLabel("Average: ", 17, 226, 50, 17)
$LabelPreviousTotal = GUICtrlCreateLabel("000000", 72, 208, 40, 17)
$LabelPreviousAverage = GUICtrlCreateLabel("000000", 72, 226, 40, 17)
$TabSheet2 = GUICtrlCreateTabItem("Settings")
$CheckboxOnTop = GUICtrlCreateCheckbox("Always On Top", 24, 48, 97, 17)
$ButtonApplySettings = GUICtrlCreateButton("Apply", 128, 211, 75, 25)
GUICtrlCreateTabItem("")
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

;Update the labels for current and previous
GUICtrlSetData($LabelCurrentYear, @YEAR)
GUICtrlSetData($LabelPreviousYear, @YEAR - 1)

;Hide History Apply Button
GUICtrlSetState($ButtonHistoryApply, $GUI_HIDE)

If IniRead(@ScriptDir & "\" & $iniName, "Settings", "OnTop", "yes") = "yes" Then
	;Make the window on top by default
	WinSetOnTop("Counter", "", 1)
	GUICtrlSetState($CheckboxOnTop, $GUI_CHECKED)
EndIf

;Read data for current month
$MonthData = IniRead(@ScriptDir & "\" & $iniName, "CurrentYear", @MON, "0")
GUICtrlSetData($LabelCurrent, $MonthData)

;Calculates the previous month. For every month apart from Jan it's just month -1
If @MON - 1 = 0 Then
	$PreviousMonthDate = "12"
Else
	$PreviousMonthDate = @MON - 1
EndIf

;Pad with zero as @mon uses 01, 02 etc
Select
	Case $PreviousMonthDate = 1
		$PreviousMonthDate = "01"
	Case $PreviousMonthDate = 2
		$PreviousMonthDate = "02"
	Case $PreviousMonthDate = 3
		$PreviousMonthDate = "03"
	Case $PreviousMonthDate = 4
		$PreviousMonthDate = "04"
	Case $PreviousMonthDate = 5
		$PreviousMonthDate = "05"
	Case $PreviousMonthDate = 6
		$PreviousMonthDate = "06"
	Case $PreviousMonthDate = 7
		$PreviousMonthDate = "07"
	Case $PreviousMonthDate = 8
		$PreviousMonthDate = "08"
	Case $PreviousMonthDate = 9
		$PreviousMonthDate = "09"
EndSelect

;Read data for previous month
$MonthPreviousData = IniRead(@ScriptDir & "\" & $iniName, "CurrentYear", $PreviousMonthDate, "No data")
GUICtrlSetData($LabelLast, $MonthPreviousData)

;Set Month Average
GUICtrlSetData($LabelAverage, $MonthAverage)

;Set Month Best
GUICtrlSetData($LabelBestMonth, $BestMonth)
GUICtrlSetData($LabelBestData, $BestMonthValue)

;Set Previous month totals and averages
GUICtrlSetData($LabelPreviousTotal, $PreviousMonthTotal)
GUICtrlSetData($LabelPreviousAverage, $PreviousMonthAverage)

;Populate Current Tab
GUICtrlSetData($InputJan, $Jan)
GUICtrlSetData($InputFeb, $Feb)
GUICtrlSetData($InputMar, $Mar)
GUICtrlSetData($InputApr, $Apr)
GUICtrlSetData($InputMay, $May)
GUICtrlSetData($InputJun, $Jun)
GUICtrlSetData($InputJul, $Jul)
GUICtrlSetData($InputAug, $Aug)
GUICtrlSetData($InputSep, $Sep)
GUICtrlSetData($InputOct, $Oct)
GUICtrlSetData($InputNov, $Nov)
GUICtrlSetData($InputDec, $Dec)

;Populate Previous Tab
GUICtrlSetData($InputJanPrev, $JanPrev)
GUICtrlSetData($InputFebPrev, $FebPrev)
GUICtrlSetData($InputMarPrev, $MarPrev)
GUICtrlSetData($InputAprPrev, $AprPrev)
GUICtrlSetData($InputMayPrev, $MayPrev)
GUICtrlSetData($InputJunPrev, $JunPrev)
GUICtrlSetData($InputJulPrev, $JulPrev)
GUICtrlSetData($InputAugPrev, $AugPrev)
GUICtrlSetData($InputSepPrev, $SepPrev)
GUICtrlSetData($InputOctPrev, $OctPrev)
GUICtrlSetData($InputNovPrev, $NovPrev)
GUICtrlSetData($InputDecPrev, $DecPrev)

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		;Window CLose
		Case $GUI_EVENT_CLOSE
			$CurrentCount = GUICtrlRead($LabelCurrent)
			;Write the current data to the ini file
			If IniWrite(@ScriptDir & "\" & $iniName, "CurrentYear", @MON, $CurrentCount) = 1 Then ;Only exit if ini file has been written to
				;Make a backup of the ini file
				FileCopy(@ScriptDir & "\" & $iniName, @ScriptDir & "\" & $iniName & ".bak", 9)
				Exit
			Else
				MsgBox(0, "Message", "Unable to write the current count to the file " & @ScriptDir & "\" & $iniName)
			EndIf

		;Count Button
		Case $ButtonCount
			$CurrentCount = GUICtrlRead($LabelCurrent)
			SoundPlay(@TempDir & "\click.wav")
			GUICtrlSetData($LabelCurrent, $CurrentCount + 1)
			;Update average count
			$MonthTotal = $MonthTotal + 1
			$MonthAverage = Round($MonthTotal / @MON)
			GUICtrlSetData($LabelAverage, $MonthAverage)
			;Check if the best month has been exceeded
			If Number($CurrentCount + 1) > $BestMonthValue Then
				$BestMonthValue = $CurrentCount + 1
				$BestMonth = "Current"
				GUICtrlSetData($LabelBestMonth, $BestMonth)
				GUICtrlSetData($LabelBestData, $BestMonthValue)
			EndIf

		;Apply Settings Button
		Case $ButtonApplySettings
			If BitAND(GUICtrlRead($CheckboxOnTop), $GUI_CHECKED) = 1 Then
				WinSetOnTop("Counter", "", 1)
				IniWrite(@ScriptDir & "\" & $iniName, "Settings", "OnTop", "yes")
			Else
				WinSetOnTop("Counter", "", 0)
				IniWrite(@ScriptDir & "\" & $iniName, "Settings", "OnTop", "no")
			EndIf

		;Edit History
		Case $ButtonHistoryEdit
			GUICtrlSetState($ButtonHistoryApply, $GUI_SHOW)
			GUICtrlSetState($ButtonHistoryEdit, $GUI_DISABLE)
			GUICtrlSetState($InputJan, $GUI_ENABLE)
			GUICtrlSetState($InputFeb, $GUI_ENABLE)
			GUICtrlSetState($InputMar, $GUI_ENABLE)
			GUICtrlSetState($InputApr, $GUI_ENABLE)
			GUICtrlSetState($InputMay, $GUI_ENABLE)
			GUICtrlSetState($InputJun, $GUI_ENABLE)
			GUICtrlSetState($InputJul, $GUI_ENABLE)
			GUICtrlSetState($InputAug, $GUI_ENABLE)
			GUICtrlSetState($InputSep, $GUI_ENABLE)
			GUICtrlSetState($InputOct, $GUI_ENABLE)
			GUICtrlSetState($InputNov, $GUI_ENABLE)
			GUICtrlSetState($InputDec, $GUI_ENABLE)

		;Apply History
		Case $ButtonHistoryApply
			;Message box, are you sure? 6=yes
			If MsgBox(262436, "Make Changes to History", "Are you sure you want to make changes to the history?") = 6 Then
				IniWrite(@ScriptDir & "\" & $iniName, "CurrentYear", "01", GUICtrlRead($InputJan))
				GUICtrlSetState($InputJan, $GUI_DISABLE)
				IniWrite(@ScriptDir & "\" & $iniName, "CurrentYear", "02", GUICtrlRead($InputFeb))
				GUICtrlSetState($InputFeb, $GUI_DISABLE)
				IniWrite(@ScriptDir & "\" & $iniName, "CurrentYear", "03", GUICtrlRead($InputMar))
				GUICtrlSetState($InputMar, $GUI_DISABLE)
				IniWrite(@ScriptDir & "\" & $iniName, "CurrentYear", "04", GUICtrlRead($InputApr))
				GUICtrlSetState($InputApr, $GUI_DISABLE)
				IniWrite(@ScriptDir & "\" & $iniName, "CurrentYear", "05", GUICtrlRead($InputMay))
				GUICtrlSetState($InputMay, $GUI_DISABLE)
				IniWrite(@ScriptDir & "\" & $iniName, "CurrentYear", "06", GUICtrlRead($InputJun))
				GUICtrlSetState($InputJun, $GUI_DISABLE)
				IniWrite(@ScriptDir & "\" & $iniName, "CurrentYear", "07", GUICtrlRead($InputJul))
				GUICtrlSetState($InputJul, $GUI_DISABLE)
				IniWrite(@ScriptDir & "\" & $iniName, "CurrentYear", "08", GUICtrlRead($InputAug))
				GUICtrlSetState($InputAug, $GUI_DISABLE)
				IniWrite(@ScriptDir & "\" & $iniName, "CurrentYear", "09", GUICtrlRead($InputSep))
				GUICtrlSetState($InputSep, $GUI_DISABLE)
				IniWrite(@ScriptDir & "\" & $iniName, "CurrentYear", "10", GUICtrlRead($InputOct))
				GUICtrlSetState($InputOct, $GUI_DISABLE)
				IniWrite(@ScriptDir & "\" & $iniName, "CurrentYear", "11", GUICtrlRead($InputNov))
				GUICtrlSetState($InputNov, $GUI_DISABLE)
				IniWrite(@ScriptDir & "\" & $iniName, "CurrentYear", "12", GUICtrlRead($InputDec))
				GUICtrlSetState($InputDec, $GUI_DISABLE)
				GUICtrlSetState($ButtonHistoryApply, $GUI_HIDE)
				GUICtrlSetState($ButtonHistoryEdit, $GUI_ENABLE)
			Else
				GUICtrlSetState($InputJan, $GUI_DISABLE)
				GUICtrlSetState($InputFeb, $GUI_DISABLE)
				GUICtrlSetState($InputMar, $GUI_DISABLE)
				GUICtrlSetState($InputApr, $GUI_DISABLE)
				GUICtrlSetState($InputMay, $GUI_DISABLE)
				GUICtrlSetState($InputJun, $GUI_DISABLE)
				GUICtrlSetState($InputJul, $GUI_DISABLE)
				GUICtrlSetState($InputAug, $GUI_DISABLE)
				GUICtrlSetState($InputSep, $GUI_DISABLE)
				GUICtrlSetState($InputOct, $GUI_DISABLE)
				GUICtrlSetState($InputNov, $GUI_DISABLE)
				GUICtrlSetState($InputDec, $GUI_DISABLE)
				GUICtrlSetState($ButtonHistoryApply, $GUI_HIDE)
				GUICtrlSetState($ButtonHistoryEdit, $GUI_ENABLE)
			EndIf

	EndSwitch
WEnd


;Functions
;=================

Func _GetCurrentData()
	Local $GetAllMonthDataArray
	;Get current month data
	$GetAllMonthDataArray = IniReadSection(@ScriptDir & "\" & $iniName, "CurrentYear")
	If @error Then
		MsgBox(4096, "Message", "Error occurred, probably no INI file.")
		Exit
	Else
		$Jan = $GetAllMonthDataArray[1][1]
		$Feb = $GetAllMonthDataArray[2][1]
		$Mar = $GetAllMonthDataArray[3][1]
		$Apr = $GetAllMonthDataArray[4][1]
		$May = $GetAllMonthDataArray[5][1]
		$Jun = $GetAllMonthDataArray[6][1]
		$Jul = $GetAllMonthDataArray[7][1]
		$Aug = $GetAllMonthDataArray[8][1]
		$Sep = $GetAllMonthDataArray[9][1]
		$Oct = $GetAllMonthDataArray[10][1]
		$Nov = $GetAllMonthDataArray[11][1]
		$Dec = $GetAllMonthDataArray[12][1]
	EndIf
EndFunc   ;==>_GetCurrentData

Func _GetPreviousData()
	Local $GetAllPreviousMonthDataArray
	;Get previous month data
	$GetAllPreviousMonthDataArray = IniReadSection(@ScriptDir & "\" & $iniName, "PreviousYear")
	If @error Then
		MsgBox(4096, "Message", "Error occurred, probably no INI file.")
		Exit
	Else
		$JanPrev = $GetAllPreviousMonthDataArray[1][1]
		$FebPrev = $GetAllPreviousMonthDataArray[2][1]
		$MarPrev = $GetAllPreviousMonthDataArray[3][1]
		$AprPrev = $GetAllPreviousMonthDataArray[4][1]
		$MayPrev = $GetAllPreviousMonthDataArray[5][1]
		$JunPrev = $GetAllPreviousMonthDataArray[6][1]
		$JulPrev = $GetAllPreviousMonthDataArray[7][1]
		$AugPrev = $GetAllPreviousMonthDataArray[8][1]
		$SepPrev = $GetAllPreviousMonthDataArray[9][1]
		$OctPrev = $GetAllPreviousMonthDataArray[10][1]
		$NovPrev = $GetAllPreviousMonthDataArray[11][1]
		$DecPrev = $GetAllPreviousMonthDataArray[12][1]
	EndIf
EndFunc   ;==>_GetPreviousData