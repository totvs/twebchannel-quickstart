function onDocumentReady() {
	// Inicia conexao com o TWebChannel
    twebchannel.connect(onTWebChannelConnected)

    var button = document.querySelector('button');

    button.addEventListener("click", function() {
        twebchannel.jsToAdvpl("ALERT", "YAHOOOO!");
    });
}

function onTWebChannelConnected() {
    // define uma funcao para recebimento dos advplToJs
    twebchannel.advplToJs = function(key, value) {
		if (key == "js") {
			var fileref = document.createElement('script');
			fileref.setAttribute("type", "text/javascript");
			fileref.innerText = value;

			document.getElementsByTagName("head")[0].appendChild(fileref);
		}
		else if (key == "css") {
			var linkref = document.createElement("link");
			linkref.setAttribute("rel", "stylesheet");
			linkref.setAttribute("type", "text/css");
			linkref.innerText = value;

			document.getElementsByTagName("head")[0].appendChild(linkref);
		}
    }

    // envia um comando via jsToAdvpl
    twebchannel.advplToJs('KEY', 'VALUE');
}

document.addEventListener("DOMContentLoaded", onDocumentReady, false);