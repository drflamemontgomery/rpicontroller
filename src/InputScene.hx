package;

import GUI;
import Keys;
import Controller;

class InputScene {
    var style = null;
    var socket : sys.net.Socket;
    var controller : ControllerState;
    var buttonFuncs : Map<String,Dynamic>;
    var axisFuncs   : Map<String,Dynamic>;
    var dpadFuncs   : Map<String,Dynamic>;
    public var center : h2d.Flow;
    var connected : Bool;
    var keys : Map<String,Array<String>>;

    function createSocket(host:String, port:Int) {
	var sysHost = new sys.net.Host(${host});
	socket.connect(sysHost, port);
    }

    function sendReport(data:haxe.io.Bytes) {
	socket.output.write(data);
	socket.output.flush();
    }
    
    public function new(?parent:h2d.Object) {
	controller = new ControllerState();
	socket = new sys.net.Socket();
	socket.setFastSend(true);
	
	center = new h2d.Flow(parent);
	center.horizontalAlign = center.verticalAlign = Middle;
	var root = new ContainerComp(Right, center);
	// Override
	root.btn.label = "Connect to Host";
	root.config.label = "Reload Config";
	root.host.backgroundColor = 0xffffff;
	root.status.text = "status: Disconnected";

	root.btn.onClick = function() {
	    if(!connected) {
		try {
		    root.status.text = "status: Connecting...";
		    createSocket(root.host.text, 8080);
		    sendReport(controller.encode());
		    trace('Connected to ${root.host.text}:8080');
		    connected = true;
		    root.status.text = 'status: Connected to ${root.host.text}:8080';
		}
		catch(e) {
		    trace(e.message);
		    root.status.text = 'status: Failed';
		}
	    }
	};
	
	root.config.onClick = function() { keys = Loader.loadKeys(); };
	
	style = new h2d.domkit.Style();
	style.load(hxd.Res.style);
	style.addObject(root);
	keys = Loader.loadKeys();
	buttonFuncs = Loader.getButtons(controller);
	dpadFuncs = Loader.getDpad(controller);
	axisFuncs = Loader.getAxis(controller);
    }

    public function dispose() {
	if(connected) {
	    var closeReport = new haxe.io.BytesBuffer();
	    for(i in 0...8) {
		closeReport.addByte(0xff);
	    }
	    
	    sendReport(closeReport.getBytes());
	    socket.close();
	}
    }

    public function update(dt:Float) {
	style.sync();
	if(connected) {
	    for(key in keys.keys()) {
		if(hxd.Key.isPressed(KeyCodes.fromString(key))) {
		    for(i in keys[key]) {
			if(buttonFuncs.exists(i)) {
			    buttonFuncs[i](true);
			}
			else if(dpadFuncs.exists(i)) {
			    dpadFuncs[i](true, key);
			}
			else if(axisFuncs.exists(i.split(" ")[0])) {
			    var value:Float = Std.parseFloat(i.split(" ")[1]);
			    axisFuncs[i.split(" ")[0]](true, key, value);
			}
			else {
			    continue;
			}
			sendReport(controller.encode());
		    }
		}
		else if(hxd.Key.isReleased(KeyCodes.fromString(key))) {
		    for(i in keys[key]) {
			if(buttonFuncs.exists(i)) {
			    buttonFuncs[i](false);
			}
			else if(dpadFuncs.exists(i)) {
			    dpadFuncs[i](false, key);
			}
			else if(axisFuncs.exists(i.split(" ")[0])) {
			    var value:Float = Std.parseFloat(i.split(" ")[1]);
			    axisFuncs[i.split(" ")[0]](false, key, value);
			}
			else {
			    continue;
			}
			sendReport(controller.encode());
		    }
		}
	    }
	}
    }
}
