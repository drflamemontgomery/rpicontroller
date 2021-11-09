@:uiComp("button")
    class ButtonComp extends h2d.Flow implements h2d.domkit.Object {

	static var SRC = <button>
	    <text public id="labelTxt" />
	    </button>

	    public var label(get, set): String;
	function get_label() return labelTxt.text;
	function set_label(s) {
	    labelTxt.text = s;
	    return s;
	}

	public function new( ?parent ) {
	    super(parent);
	    initComponent();
	    enableInteractive = true;
	    interactive.onClick = function(_) onClick();
	    interactive.onOver = function(_) {
		dom.hover = true;
	    };
	    interactive.onPush = function(_) {
		dom.active = true;
	    };
	    interactive.onRelease = function(_) {
		dom.active = false;
	    };
	    interactive.onOut = function(_) {
		dom.hover = false;
	    };
	}

	public dynamic function onClick() {
	}
    }

@:uiComp("container")
    class ContainerComp extends h2d.Flow implements h2d.domkit.Object {

	static var SRC = <container>
	    <button public id="btn"/>
	    <input public id="host"/>
	    </container>;

	public function new(align:h2d.Flow.FlowAlign, ?parent) {
	    super(parent);
	    initComponent();
	}

    }

class KeyCodes {
    static public function fromString(c:String):Null<Int> {
	return switch(c) {
	case "Backspace": hxd.Key.BACKSPACE;
	case "Tab": hxd.Key.TAB;
	case "Enter": hxd.Key.ENTER;
	case "Shift": hxd.Key.SHIFT;
	case "Ctrl": hxd.Key.CTRL;
	case "Alt": hxd.Key.ALT;
	case "Escape": hxd.Key.ESCAPE;
	case "Space": hxd.Key.SPACE;
	case "PageUp": hxd.Key.PGUP;
	case "PageDown": hxd.Key.PGDOWN;
	case "End": hxd.Key.END;
	case "Home": hxd.Key.HOME;
	case "Left": hxd.Key.LEFT;
	case "Up": hxd.Key.UP;
	case "Right": hxd.Key.RIGHT;
	case "Down": hxd.Key.DOWN;
	case "Insert": hxd.Key.INSERT;
	case "Delete": hxd.Key.DELETE;
	case "NumPad*": hxd.Key.NUMPAD_MULT;
	case "NumPad+": hxd.Key.NUMPAD_ADD;
	case "NumPadEnter": hxd.Key.NUMPAD_ENTER;
	case "NumPad-" : hxd.Key.NUMPAD_SUB;
	case "NumPad.": hxd.Key.NUMPAD_DOT;
	case "NumPad/": hxd.Key.NUMPAD_DIV;
	case "LShift": hxd.Key.LSHIFT;
	case "RShift": hxd.Key.RSHIFT;
	case "LCtrl": hxd.Key.LCTRL;
	case "RCtrl": hxd.Key.RCTRL;
	case "LAlt": hxd.Key.LALT;
	case "RAlt": hxd.Key.RALT;
	case "Tilde": hxd.Key.QWERTY_TILDE;
	case "Minus": hxd.Key.QWERTY_MINUS;
	case "Equals": hxd.Key.QWERTY_EQUALS;
	case "BracketLeft": hxd.Key.QWERTY_BRACKET_LEFT;
	case "BacketRight": hxd.Key.QWERTY_BRACKET_RIGHT;
	case "Semicolon": hxd.Key.QWERTY_SEMICOLON;
	case "Quote": hxd.Key.QWERTY_QUOTE;
	case "Backslash": hxd.Key.QWERTY_BACKSLASH;
	case "Comma": hxd.Key.QWERTY_COMMA;
	case "Period": hxd.Key.QWERTY_PERIOD;
	case "Slash": hxd.Key.QWERTY_SLASH;
	case "IntlBackslash": hxd.Key.INTL_BACKSLASH;
	case "LeftWindowKey": hxd.Key.LEFT_WINDOW_KEY;
	case "RightWindowKey": hxd.Key.RIGHT_WINDOW_KEY;
	case "ContextMenu": hxd.Key.CONTEXT_MENU;
	case "PauseBreak": hxd.Key.PAUSE_BREAK;
	case "CapsLock": hxd.Key.CAPS_LOCK;
	case "ScrollLock": hxd.Key.SCROLL_LOCK;
	case "NumLock": hxd.Key.NUM_LOCK;
	case "MouseLeft": hxd.Key.MOUSE_LEFT;
	case "MouseMiddle": hxd.Key.MOUSE_MIDDLE;
	case "MouseRight": hxd.Key.MOUSE_RIGHT;
	case "Mouse3": hxd.Key.MOUSE_BACK;
	case "Mouse4": hxd.Key.MOUSE_FORWARD;
	default:
	    if(StringTools.contains(c, "NumPad")) {
	        hxd.Key.NUMPAD_0 + Std.parseInt(c.charAt(6));
	    }
	    else if( c.charAt(0) == "F") {
	        hxd.Key.F1 + Std.parseInt(c.substr(1, c.length-1)) - 1;
	    }
	    else if( c.length == 1 ) {
		if(c.charCodeAt(0) >= "A".code && c.charCodeAt(0) <= "Z".code) {
		    c.charCodeAt(0);
		}
		else if(c.charCodeAt(0) >= "0".code && c.charCodeAt(0) <= "9".code) {
		    hxd.Key.NUMBER_0 + Std.parseInt(c);
		}
		else {
		    null;
		}
	    }
	    else {
		null;
	    }
	}
    }
}

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
	socket.close();
	return true;
    }
    
    override function init() {
	hxd.Window.getInstance().onClose = this.onClose;
	controller = new ControllerState();
	socket = new sys.net.Socket();
	//socket.setFastSend(true);
	center = new h2d.Flow(s2d);
	center.horizontalAlign = center.verticalAlign = Middle;
	onResize();
	var root = new ContainerComp(Right, center);

	// Override
	root.btn.label = "Connect to Host";
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
		
	style = new h2d.domkit.Style();
	style.load(hxd.Res.style);
	style.addObject(root);
	var json = haxe.Json.parse(hxd.Res.load("config.json").toText());
	keys = new Map();
	for(field in Reflect.fields(json)) {
	    keys.set(field, Reflect.field(json, field));
	}
	dpadFuncs = [
	    "left" => function(isDown:Bool, key:String) {
		if(isDown) {
		    controller.dpad.horizontal.push({ key : key,
				value : HatStickHorizontalState.LEFT }
			);
		} else {
		    for( i in controller.dpad.horizontal) {
			if(i.key == key && i.value == HatStickHorizontalState.LEFT) {
			    controller.dpad.horizontal.remove(i);
			}
		    }
		}
	    },
	    "right" => function(isDown:Bool, key:String) {
		if(isDown) {
		    controller.dpad.horizontal.push({ key : key,
				value : HatStickHorizontalState.RIGHT }
			);
		} else {
		    for( i in controller.dpad.horizontal) {
			if(i.key == key && i.value == HatStickHorizontalState.RIGHT) {
			    controller.dpad.horizontal.remove(i);
			}
		    }
		}
	    },
	    "up" => function(isDown:Bool, key:String) {
		if(isDown) {
		    controller.dpad.vertical.push({ key : key,
				value : HatStickVerticalState.UP }
			);
		} else {
		    for( i in controller.dpad.vertical) {
			if(i.key == key && i.value == HatStickVerticalState.UP) {
			    controller.dpad.vertical.remove(i);
			}
		    }
		}
	    },
	    "down" => function(isDown:Bool, key:String) {
		if(isDown) {
		    controller.dpad.vertical.push({ key : key,
				value : HatStickVerticalState.DOWN }
			);
		} else {
		    for( i in controller.dpad.vertical) {
			if(i.key == key && i.value == HatStickVerticalState.DOWN) {
			    controller.dpad.vertical.remove(i);
			}
		    }
		}
	    },
		     ];
	buttonFuncs = [
	    "a" => function(isDown:Bool) {
		controller.a = isDown;
	    },
	    "b" => function(isDown:Bool) {
		controller.b = isDown;
	    },
	    "x" => function(isDown:Bool) {
		controller.x = isDown;
	    },
	    "y" => function(isDown:Bool) {
		controller.y = isDown;
	    },
	    "l" => function(isDown:Bool) {
		controller.l = isDown;
	    },
	    "r" => function(isDown:Bool) {
		controller.r = isDown;
	    },
	    "zl" => function(isDown:Bool) {
		controller.zl = isDown;
	    },
	    "zr" => function(isDown:Bool) {
		controller.zr = isDown;
	    },
	    "home" => function(isDown:Bool) {
		controller.home = isDown;
	    },
	    "capture" => function(isDown:Bool) {
		controller.capture = isDown;
	    },
	    "plus" => function(isDown:Bool) {
		controller.plus = isDown;
	    },
	    "minus" => function(isDown:Bool) {
		controller.minus = isDown;
	    },
	    "lClick" => function(isDown:Bool) {
		controller.l_stick.clicked = isDown;
	    },
	    "rClick" => function(isDown:Bool) {
		controller.r_stick.clicked = isDown;
	    },
		       ];
	axisFuncs = [
	    "lStickX" => function(isDown:Bool, key:String, value:Float) {
	        if(isDown) {
		    controller.l_stick.axisX.push({ key : key,
				value : value }
			);
		} else {
		    for( i in controller.l_stick.axisX) {
			if(i.key == key && i.value == value) {
			    controller.l_stick.axisX.remove(i);
			}
		    }
		}
	    },
	    "lStickY" => function(isDown:Bool, key:String, value:Float) {
	        if(isDown) {
		    controller.l_stick.axisY.push({ key : key,
				value : value }
			);
		} else {
		    for( i in controller.l_stick.axisY) {
			if(i.key == key && i.value == value) {
			    controller.l_stick.axisY.remove(i);
			}
		    }
		}
	    },
	    "rStickX" => function(isDown:Bool, key:String, value:Float) {
	        if(isDown) {
		    controller.r_stick.axisX.push({ key : key,
				value : value }
			);
		} else {
		    for( i in controller.r_stick.axisX) {
			if(i.key == key && i.value == value) {
			    controller.r_stick.axisX.remove(i);
			}
		    }
		}
	    },
	    "rStickY" => function(isDown:Bool, key:String, value:Float) {
	        if(isDown) {
		    controller.r_stick.axisY.push({ key : key,
				value : value }
			);
		} else {
		    for( i in controller.r_stick.axisY) {
			if(i.key == key && i.value == value) {
			    controller.r_stick.axisY.remove(i);
			}
		    }
		}
	    },
	    
		 ];

	
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
			    trace(value);
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
			    trace(value);
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


class ControllerState {
    public var a : Bool;
    public var b : Bool;
    public var x : Bool;
    public var y : Bool;
    public var l : Bool;
    public var r : Bool;
    public var zl : Bool;
    public var zr : Bool;
    public var home : Bool;
    public var capture : Bool;
    public var plus : Bool;
    public var minus : Bool;
    public var l_stick : JoystickState;
    public var r_stick : JoystickState;
    public var dpad : HatStickState;

    public function new(?a = false, ?b = false, ?x = false, ?y = false, ?l = false, ?r = false, ?zl = false, ?zr = false, ?home = false, ?capture = false, ?plus = false, ?minus = false) {
	this.a = a;
	this.b = b;
	this.x = x;
	this.y = y;
	this.l = l;
	this.r = r;
	this.zl = zl;
	this.zr = zr;
	this.home = home;
	this.capture = capture;
	this.plus = plus;
	this.minus = minus;
	this.l_stick = new JoystickState();
	this.r_stick = new JoystickState();
	this.dpad = new HatStickState();
    }

    function fromArray(values:Array<Bool>):Int {
	var val : Int = 0x00;
	for(i in 0...values.length) {
	    val |= values[i] ? 1<<i : 0;
	}
	return val;
    }

    function fromAxis(axis:Array<AxisElement>) : Int {
	if(axis.length > 0) {
	    return Std.int(axis[axis.length-1].value * 0x7f + 0x7f);
	}
	else {
	    return 0x7f;
	}
    
    }
    
    public function encode():haxe.io.Bytes {
	var byte1 = fromArray([y,b,a,x,l,r,zl,zr]);
	var byte2 = fromArray([minus, plus, l_stick.clicked, r_stick.clicked, home, capture]);
	var byte3 = dpad.encode();
	var byte4 = fromAxis(l_stick.axisX);
	var byte5 = fromAxis(l_stick.axisY);
	var byte6 = fromAxis(r_stick.axisX);
	var byte7 = fromAxis(r_stick.axisY);
	var byte8 = 0x00;

	var report = new haxe.io.BytesBuffer();
	report.addByte(byte1);
	report.addByte(byte2);
	report.addByte(byte3);
	report.addByte(byte4);
	report.addByte(byte5);
	report.addByte(byte6);
	report.addByte(byte7);
	report.addByte(byte8);
	
	return report.getBytes();
    }
}

class JoystickState {
    public var axisX : Array<AxisElement>;
    public var axisY : Array<AxisElement>;
    public var clicked : Bool;

    public function new(?clicked = false) {
	this.axisX = new Array<AxisElement>();
	this.axisY = new Array<AxisElement>();
	this.clicked = clicked;
    }
}

typedef AxisElement = {key:String, value:Float};

enum HatStickHorizontalState {
    LEFT;
    RIGHT;
}

enum HatStickVerticalState {
    UP;
    DOWN;
}

typedef HatStickHorizontalElement = {key:String, value:HatStickHorizontalState};
typedef HatStickVerticalElement = {key:String, value:HatStickVerticalState};


class HatStickState {
    public var horizontal : Array<HatStickHorizontalElement>;
    public var vertical : Array<HatStickVerticalElement>;

    public function new() {
	this.horizontal = new Array<HatStickHorizontalElement>();
	this.vertical = new Array<HatStickVerticalElement>();
    }

    public function encode():Int {
	var retVal : Int = 0x00;
	var horizontalVal:Null<HatStickHorizontalState> = null;
	if(horizontal.length > 0) {
	    horizontalVal = horizontal[horizontal.length-1].value;
	}
	var verticalVal:Null<HatStickVerticalState> = null;
	if(vertical.length > 0) {
	    verticalVal = vertical[vertical.length-1].value;
	}
	
        if(horizontalVal == null && verticalVal == UP) {
	    retVal = 0x0;
	}
	else if(horizontalVal == RIGHT && verticalVal == UP) {
	    retVal = 0x1;
	}
	else if(horizontalVal == RIGHT && verticalVal == null) {
	    retVal = 0x2;
	}
	else if(horizontalVal == RIGHT && verticalVal == DOWN) {
	    retVal = 0x3;
	}
	else if(horizontalVal == null && verticalVal == DOWN) {
	    retVal = 0x4;
	}
	else if(horizontalVal == LEFT && verticalVal == DOWN) {
	    retVal = 0x5;
	}
	else if(horizontalVal == LEFT && verticalVal == null) {
	    retVal = 0x6;
	}
	else if(horizontalVal == LEFT && verticalVal == UP) {
	    retVal = 0x7;
	}
	else {
	    retVal = 0xf;
	}

	return retVal;
    }
}
    


    
