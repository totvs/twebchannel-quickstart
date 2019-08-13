#include "totvs.ch"

function u_quickstart()
    private oDlg
    private channel
    private port
    private webview

    oDlg := TWindow():New(0, 0, 960, 540, "TOTVS - CloudBridge", NIL, NIL, NIL, NIL, NIL, NIL, NIL, CLR_BLACK, CLR_WHITE, NIL, NIL, NIL, NIL, NIL, NIL, .T. )
    oDlg:bStart:= {|| _WindowStarted() }

    channel := TWebChannel():New()
    channel:bJsToAdvpl := {|channel, codeType, content| _ReceivedMessage(codeType, content) }

    port:= channel:connect()

    webview := TWebEngine():New(oDlg, 0, 0, 100, 100,, port)
    webview:bLoadFinished := {|webview, url| _OnLoadFinished(url) }
    webview:setAsMain()
    webview:Align := CONTROL_ALIGN_ALLCLIENT

    oPanelBtn:= TPanel():New(0, 0, "", oDlg,,,,,,60,60)
    oPanelBtn:align := CONTROL_ALIGN_RIGHT

    oTButton1 := TButton():New(10, 10, "ADVPL Button", oPanelBtn, {|| channel:advplToJs('js', 'alert("YAHOO");') }, 80, 15,,,.F.,.T.,.F.,,.F.,,,.F. )
    oTButton1:align :=  CONTROL_ALIGN_TOP

    _ExtractResources()

    oDlg:Activate()
return

static function _WindowStarted()
    Local tempPath:= GetTempPath()
    Local root:= "file:///" + StrTran(tempPath, "\", "/")

    //Local root := "http://127.0.0.1:9999/"
  
    webview:navigate(root + "index.html")
return

static function _OnLoadFinished(url)
	ConOut("LoadFinished '" + url + "'")
return


static function _ReceivedMessage(key, value)
    if (key == "ALERT")
        Alert(value, "TWebChannel QuickStart")
    else 
        conout(key + " - " + value)
    endif
return


static function _ExtractResources()
	local i, nHandle, file
	local tempPath := GetTempPath()
	local files:= {;
		"index.html",;
		"twebchannel.js",;
		"quickstart.js";
 	}

	For i := 1 to len(files)
		file:= tempPath + files[i]

		ConOut("writing: " + file)

		nHandle := fCreate(file)
		fWrite(nHandle, GetApoRes(files[i]))
		fClose(nHandle)
	Next i
return