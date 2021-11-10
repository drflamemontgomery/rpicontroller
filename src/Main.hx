import GUI;
import Keys;
import Controller;

//PARAM=-lib domkit
class Main extends hxd.App {

    var center : h2d.Flow;
    var style = null;
    var socket : sys.net.Socket;
    var connected : Bool;
    var report_desc : Array<Int>;
    var controller : ControllerState;
    var buttonFuncs : Map<String,Dynamic>;
    var axisFuncs   : Map<String,Dynamic>;
    var dpadFuncs   : Map<String,Dynamic>;
    var keys : Map<String,Array<String>>;

    function onClose():Bool {
        var closeReport = new haxe.io.BytesBuffer();
	for(i in 0...8) {
	    closeReport.addByte(0xff);
	}
	socket.output.write(closeReport.getBytes());
	socket.output.flush();
	socket.close();
	return true;
    }
    
    override function init() {
	hxd.Window.getInstance().onClose = this.onClose;
	controller = new ControllerState();
	socket = new sys.net.Socket();
	socket.setFastSend(true);
	center = new h2d.Flow(s2d);
	center.horizontalAlign = center.verticalAlign = Middle;
	onResize();
	var root = new ContainerComp(Right, center);
	// Override
	root.btn.label = "Connect to Host";
	root.config.label = "Reload Config";
	root.host.backgroundColor = 0xffffff;

	root.btn.onClick = function() {
	    try {
		var host = new sys.net.Host(${root.host.text});
		socket.connect(host, 8080);
		socket.output.write(controller.encode());
		socket.output.flush();
		trace('Connected to $host:8080');
		connected = true;
	    }
	    catch(e) {
		trace(e.message);
	    }
	}

	root.config.onClick = function() { keys = Loader.loadKeys(); };
	
	style = new h2d.domkit.Style();
	style.load(hxd.Res.style);
	style.addObject(root);
	keys = Loader.loadKeys();
	buttonFuncs = Loader.getButtons(controller);
	dpadFuncs = Loader.getDpad(controller);
	axisFuncs = Loader.getAxis(controller);
	
    }

    override function onResize() {
	center.minWidth = center.maxWidth = s2d.width;
	center.minHeight = center.maxHeight = s2d.height;
    }

    override function update(dt:Float) {
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
			socket.output.write(controller.encode());
			socket.output.flush();
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
			socket.output.write(controller.encode());
			socket.output.flush();
		    }
		}
	    }
	}
    }

    static function main() {
	#if hl
	    hxd.res.Resource.LIVE_UPDATE = true;
	hxd.Res.initLocal();
	#else
	    hxd.Res.initEmbed();
	#end
	    new Main();
    }

}
