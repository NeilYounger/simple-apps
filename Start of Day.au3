#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=Boomy\app.ico
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

;To Run Windows10 Apps https://www.autoitscript.com/forum/topic/187123-win10-run-windows-store-apps/?do=findComment&comment=1343748
;Hit Win-R to open a "Run" input, and type "shell:Appsfolder"
;When in that, hit F-10 to get a menu bar, and from that menu bar select "View / Choose Details"
;Select the radio box for "AppUserModelID". That ID is what you are going to want to execute.
;Select "Details" from the little "View" gadget" on the right hand side.
;"shell:Appsfolder\"+AppUserModelID found in the right column
;Run(@ComSpec & ' /c start "" "shell:Appsfolder\Microsoft.Messaging_8wekyb3d8bbwe!x27e26f40ye031y48a6yb130yd1f20388991ax"', '', @SW_HIDE)

Global $sWindowTimeOutFiveSeconds = 5

;Normal Programs
;================

;THUNDERBIRD
Run("C:\Program Files (x86)\Mozilla Thunderbird\thunderbird.exe", "" , @SW_MAXIMIZE)
WinWait("Thunderbird", "", $sWindowTimeOutFiveSeconds)
WinSetState("Thunderbird", "", @SW_MAXIMIZE)

;EXPLORER
Run("C:\Windows\explorer.exe", "", @SW_MAXIMIZE)
WinWait("File Explorer", "", $sWindowTimeOutFiveSeconds)
WinSetState("File Explorer", "", @SW_MAXIMIZE)

;Store Apps
;================

;Trello
Run(@ComSpec & ' /c start "" "shell:Appsfolder\45273LiamForsyth.PawsforTrello_7pb5ddty8z1pa!trello"', '', @SW_HIDE)
WinWait("Trello", "", $sWindowTimeOutFiveSeconds)
WinSetState("Trello", "", @SW_MAXIMIZE)

;Slack
Run(@ComSpec & ' /c start "" "shell:Appsfolder\91750D7E.Slack_8she8kybcnzg4!Slack"', '', @SW_HIDE)
WinWait("Slack", "", $sWindowTimeOutFiveSeconds)
WinSetState("Slack", "", @SW_MAXIMIZE)

;Chrome
Run(@ComSpec & ' /c start "" "shell:Appsfolder\Chrome"', '', @SW_HIDE)
WinWait("Chrome", "", $sWindowTimeOutFiveSeconds)
WinSetState("Chrome", "", @SW_MAXIMIZE)

;WhatsApp
Run(@ComSpec & ' /c start "" "shell:Appsfolder\5319275A.WhatsAppDesktop_cv1g1gvanyjgm!WhatsAppDesktop"', '', @SW_HIDE)
WinWait("WhatsApp", "", $sWindowTimeOutFiveSeconds)
Sleep(1000)
WinSetState("WhatsApp", "", @SW_MAXIMIZE)