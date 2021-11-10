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
	    var value = axis[axis.length-1].value;
	    value = value > 1 ? 1 : value;
	    value = value < -1 ? -1 : value;
	    return Std.int(value * 0x7f + 0x7f);
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
    


    
