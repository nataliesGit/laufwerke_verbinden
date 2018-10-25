#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=nw5.ico
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <AutoItConstants.au3>
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <MsgBoxConstants.au3>

#Region ### START Koda GUI section ### Form=E:\autoit_connect_user_version2\Form1.kxf
Global $Form1 = GUICreate("", 239, 359, -1, -1)
Global $input1 = GUICtrlCreateInput("Loginname", 71, 134, 144, 21)
GUICtrlSetFont(-1, 7, 400, 0, "MS Sans Serif")

$passStyle = BitOr($ES_PASSWORD, $GUI_SS_DEFAULT_INPUT )
Global $input2 = GUICtrlCreateInput("", 71, 162, 144, 21,$passStyle,0)


GUICtrlSetFont(-1, 7, 400, 0, "MS Sans Serif")
Global $Button1 = GUICtrlCreateButton("Home", 134, 218, 82, 26)
GUICtrlSetFont(-1, 7, 400, 0, "MS Sans Serif")
Global $Button3 = GUICtrlCreateButton("Ressourcen", 18, 218, 88, 26)
GUICtrlSetFont(-1, 7, 400, 0, "MS Sans Serif")
Global $Button2 = GUICtrlCreateButton("Home (x)", 134, 314, 84, 26)
GUICtrlSetFont(-1, 7, 400, 0, "MS Sans Serif")
Global $Button4 = GUICtrlCreateButton("Ressourcen (y)", 18, 314, 90, 26)
GUICtrlSetFont(-1, 6, 400, 0, "MS Sans Serif")
;~ $Group1 = GUICtrlCreateGroup("", 8, 38, 222, 36)
Global $Radio1 = GUICtrlCreateRadio("1772", 16, 49, 49, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlSetFont(-1, 7, 400, 0, "MS Sans Serif")
Global $Radio2 = GUICtrlCreateRadio("1887", 72, 49, 81, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
;~ $Group2 = GUICtrlCreateGroup("", 8, 77, 223, 44)
Global $Radio3 = GUICtrlCreateRadio("Lehrer", 16, 92, 56, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlSetFont(-1, 7, 400, 0, "MS Sans Serif")
Global $Radio4 = GUICtrlCreateRadio("Schüler", 72, 92, 65, 17)
GUICtrlSetFont(-1, 7, 400, 0, "MS Sans Serif")
Global $Radio5 = GUICtrlCreateRadio("Support", 160, 92, 65, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Label1 = GUICtrlCreateLabel("Nutzer", 16, 137, 35, 17)
GUICtrlSetFont(-1, 7, 400, 0, "MS Sans Serif")
$Graphic1 = GUICtrlCreateGraphic(0, 0, 239, 37)
GUICtrlSetColor(-1, 0x0078D7)
GUICtrlSetBkColor(-1, 0x0066CC)
$Label2 = GUICtrlCreateLabel("Bitte Schule und Rolle auswählen", 31, 10, 163, 17)
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlSetBkColor(-1, 0x0066CC)
$Label3 = GUICtrlCreateLabel("Passwort", 16, 166, 47, 17)
GUICtrlSetFont(-1, 7, 400, 0, "MS Sans Serif")
$Graphic2 = GUICtrlCreateGraphic(0, 259, 239, 4)
GUICtrlSetBkColor(-1, 0x008000)
$Label4 = GUICtrlCreateLabel("Laufwerke entfernen (Laufwerk x und y)", 14, 281, 192, 17)
$Label5 = GUICtrlCreateLabel("Laufwerke verbinden", 71, 194, 104, 17)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###




Global $role
Global $school
Global $server
checkRolle()
checkSchule()

;~ Global $laufwerk
Global $Clear1 = 0
Global $Clear2 = 0

func checkUsername()
;~ 	MsgBox($MB_SYSTEMMODAL, "", "user: "&@UserName)
   if StringInStr(@UserName,"pruefung") then
	  return false
   else
	  return true
   endif
EndFunc

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
;~    Button1 : Homelaufwerk einhängen
	Case $Button1

		 Local $laufwerk
	     checkRolle()
		 checkSchule()
		 $user = GUICtrlRead($input1)
		 $pwd =  GUICtrlRead($input2)

;~ 		MsgBox($MB_SYSTEMMODAL, "", "user und passwort: "&$user&" "&$pwd)
;~ 		MsgBox($MB_SYSTEMMODAL, "", "server: "&$server)
;~ 		MsgBox($MB_SYSTEMMODAL, "", "schule: "&$school)
;~ 		MsgBox($MB_SYSTEMMODAL, "", "Rolle: "&$role)

;~ 	     pruefungsaccounts sollen keine Laufwerke mounten duerfen
		 if not (checkUsername()) Then
			MsgBox($MB_SYSTEMMODAL, "", "Pruefungs-Accounts können kein Laufwerk einhängen")
			ContinueLoop ;"BREAK CASE"
		endif

;~ 		 falls laufwerk x schon vorhanden - entfernen
		 entferneLW("x:",0)

		 Local $mapadd = DriveMapAdd("X:", "\\"&$server&"\"&$school&"\"&$role&"\"&$user, $DMA_AUTHENTICATION, $user, $pwd)
;~ 		 MsgBox($MB_SYSTEMMODAL, "", "Return wert DriveMapAdd: "&$mapadd)
		Sleep(400)
		  if $mapadd = 1 Then
			MsgBox($MB_SYSTEMMODAL, "", "Laufwerk verbunden")
		  Else
			MsgBox($MB_SYSTEMMODAL, "", "Bitte Schule, Rolle, Nutzer und Passwort überprüfen")
		  endif

;~    Button1 : Homelaufwerk entfernen
    Case $Button2
		entferneLW("x:",1)

;~    Button3 : Ressourcen einhängen
   Case $Button3
		 Local $mapadd
		 $user = GUICtrlRead($input1)
		 $pwd =  GUICtrlRead($input2)
	     checkRolle()
		 checkSchule()


;~ 	     pruefungsaccounts sollen keine Laufwerke mounten duerfen
		if not (checkUsername()) Then
			MsgBox($MB_SYSTEMMODAL, "", "Pruefungs-Accounts können kein Laufwerk einhängen")
			ContinueLoop ;"BREAK CASE"
		endif

         entferneLW("y:",0)
;~ 		MsgBox($MB_SYSTEMMODAL, "", "school wert" &$school)
		if ($school ="Support$" Or $school ="SPUV$") then
			 $mapadd = DriveMapAdd("y:", "\\sc029903.mschool-ad.muenchen.musin.de\SPUV", $DMA_AUTHENTICATION)
		Else
			 $mapadd = DriveMapAdd("y:", "\\sc029903.mschool-ad.muenchen.musin.de\FUGE", $DMA_AUTHENTICATION)
		endif

		 Sleep(700)
		if $mapadd = 1 Then
			MsgBox($MB_SYSTEMMODAL, "", "Laufwerk verbunden")
		  Else
			MsgBox($MB_SYSTEMMODAL, "", "Fehler beim Verbinden des Ressourcen-Laufwerkes")
		  endif


;~    Button3 : Ressourcen entfernen - Laufwerk y
   Case $Button4
		entferneLW("y:",1)


	Case $GUI_EVENT_CLOSE
			Exit

	EndSwitch
	    If _IsFocused ($Form1, $input1) And $Clear1 = 0 Then
			   GUICtrlSetData ($input1, "")
			   $Clear1 = 1
		 ElseIf $Clear1 = 1  And Not _IsFocused ($Form1, $input1) Then
			$Clear1 = 0
		 EndIf
	    If _IsFocused ($Form1, $input2) And $Clear2 = 0 Then
			   GUICtrlSetData ($input2, "")
			   $Clear2 = 1
		 ElseIf $Clear2 = 1  And Not _IsFocused ($Form1, $input2) Then
			$Clear2 = 0
		 EndIf
WEnd




Func entferneLW($lw,$ohneMeldung)
	Local $laufwerk = listDrives($lw)
	 if $laufwerk = 1 Then
			DriveMapDel($lw)
			if ($ohneMeldung = 1) Then
				MsgBox($MB_SYSTEMMODAL, "", "Laufwerk "&$lw&" entfernt")
			endif
			Else
				if ($ohneMeldung = 1) Then
					MsgBox($MB_SYSTEMMODAL, "", "Kein Laufwerk "&$lw&" vorhanden")
				EndIf
		 endif

EndFunc


 Func _IsFocused($hWnd, $nCID)
    Return ControlGetHandle($hWnd, '', $nCID) = ControlGetHandle($hWnd, '', ControlGetFocus($hWnd))
EndFunc   ;==>_IsFocused


func checkRolle()
   if GUICtrlRead($Radio3) = 1 Then
	  $role = "home_lehrer"
   EndIf
   if GUICtrlRead($Radio4) = 1 Then
	  $role = "home_schueler"
	EndIf
   if GUICtrlRead($Radio5) = 1 Then
	  $role = "home_support"
	EndIf
EndFunc

func checkSchule()
   if GUICtrlRead($Radio1) = 1 Then
	  $school = "SPUV$"
	  $server = "10.86.5.63"
   EndIf
   if GUICtrlRead($Radio2) = 1 Then
	  $school = "FUGE$"
	  $server = "10.86.5.63"
	EndIf
   if GUICtrlRead($Radio5) = 1 Then
	 $school = "Support$"
	 $server = "10.86.28.64"
	EndIf

EndFunc




func listDrives($searchedDrive)
   Local $aArray = DriveGetDrive($DT_ALL)
   local $driveFound
      For $i = 1 To $aArray[0]
        ; Show all the drives found and convert the drive letter to uppercase.
;~         MsgBox($MB_SYSTEMMODAL, "", "Drive " & $i & "/" & $aArray[0] & ":" & @CRLF & StringUpper($aArray[$i]))
;~ 		ConsoleWrite($aArray[$i])
		   if $aArray[$i] = $searchedDrive Then
;~ 			   MsgBox($MB_SYSTEMMODAL, "", "drive x found")
			   $driveFound = 1
			Else
			   $driveFound = 0
			EndIf
		 Next
		 return $driveFound
	  EndFunc
