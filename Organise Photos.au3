#include <FileConstants.au3>
#include <File.au3>

;Change this for main location of photos to sort
Local $sPhotoFolder = "C:\foldername\"
;Change this to "Year" or "Date" for the foldername created based in the file properties
;Local $sFolderNameFormat = "Date" ;for example '2020_08_28 (Unknown)'
Local $sFolderNameFormat = "Year" ;for example '2020'

;Get photos to an array
$sPhotoFolder = _AddTrailingSlash($sPhotoFolder)
Local $aPhotosFoundinDirectory = _FileListToArray($sPhotoFolder, "*.*", $FLTA_FILES)
;Quit if no files returned or path is invalid.
If @error = 4 Or @error = 1 Then
	ConsoleWrite("No files found in the directory " & $sPhotoFolder & @CRLF)
	Exit
EndIf

;Loop over photos
ConsoleWrite("Processing " & $aPhotosFoundinDirectory[0] & " photos" & @CRLF)
For $i = 1 To $aPhotosFoundinDirectory[0] Step 1
	ConsoleWrite("Filename: " & $aPhotosFoundinDirectory[$i] & @CRLF)
	;Get file date
	Local $sFileTime = FileGetTime($sPhotoFolder & $aPhotosFoundinDirectory[$i], $FT_MODIFIED, $FT_STRING)
	ConsoleWrite("Time: " & $sFileTime & @CRLF)
	;Change Folder name
	If $sFolderNameFormat = "Date" Then
		Local $sFolderName = StringLeft($sFileTime, 4) & "_" & StringMid($sFileTime, 5, 2) & "_" & StringMid($sFileTime, 7, 2) & " (Unknown)"
	ElseIf $sFolderNameFormat = "Year" Then
		Local $sFolderName = StringLeft($sFileTime, 4)
	EndIf
	ConsoleWrite("Folder: " & $sFolderName & @CRLF)
	;Copy Photo to folder (comment this out if you want to test)
	FileMove($sPhotoFolder & $aPhotosFoundinDirectory[$i], $sPhotoFolder & $sFolderName & "\" & $aPhotosFoundinDirectory[$i], $FC_CREATEPATH)
Next

Func _AddTrailingSlash($sDirectoryToCheck)
	Local $sDirectory = $sDirectoryToCheck
	If StringRight($sDirectory, 1) <> "\" Then
		$sDirectory = $sDirectory & "\"
	EndIf
	Return $sDirectory
EndFunc   ;==>_AddTrailingSlash

Exit
