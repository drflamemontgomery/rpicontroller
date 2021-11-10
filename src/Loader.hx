import Controller;

class Loader {
    static public function loadKeys():Map<String,Array<String>> {
	var keys = new Map();
	try {
	    var json = haxe.Json.parse(hxd.Res.load("config.json").toText());
	    for(field in Reflect.fields(json)) {
		keys.set(field, Reflect.field(json, field));
	    }
	}
	catch(e) {
	    trace(e.message);
	}
	return keys;
    }

    static public function getButtons(controller:ControllerState):Map<String, Dynamic> {
        return [
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
    }

    static public function getDpad(controller:ControllerState):Map<String, Dynamic> {
	return [
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
    }
    
    static public function getAxis(controller:ControllerState):Map<String, Dynamic> {
	
	return [
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
}
