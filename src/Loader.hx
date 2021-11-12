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
		"btn_a" => function(isDown:Bool) {
		    controller.a = isDown;
		},
		"btn_b" => function(isDown:Bool) {
		    controller.b = isDown;
		},
		"btn_x" => function(isDown:Bool) {
		    controller.x = isDown;
		},
		"btn_y" => function(isDown:Bool) {
		    controller.y = isDown;
		},
		"btn_l" => function(isDown:Bool) {
		    controller.l = isDown;
		},
		"btn_r" => function(isDown:Bool) {
		    controller.r = isDown;
		},
		"btn_zl" => function(isDown:Bool) {
		    controller.zl = isDown;
		},
		"btn_zr" => function(isDown:Bool) {
		    controller.zr = isDown;
		},
		"btn_home" => function(isDown:Bool) {
		    controller.home = isDown;
		},
		"btn_capture" => function(isDown:Bool) {
		    controller.capture = isDown;
		},
		"btn_plus" => function(isDown:Bool) {
		    controller.plus = isDown;
		},
		"btn_minus" => function(isDown:Bool) {
		    controller.minus = isDown;
		},
		"btn_l_stick" => function(isDown:Bool) {
		    controller.l_stick.clicked = isDown;
		},
		"btn_r_stick" => function(isDown:Bool) {
		    controller.r_stick.clicked = isDown;
		},
		];
    }

    static public function getDpad(controller:ControllerState):Map<String, Dynamic> {
	return [
		"btn_left" => function(isDown:Bool, key:String) {
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
		"btn_right" => function(isDown:Bool, key:String) {
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
		"btn_up" => function(isDown:Bool, key:String) {
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
		"btn_down" => function(isDown:Bool, key:String) {
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
		"btn_l_stick_x" => function(isDown:Bool, key:String, value:Float) {
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
		"btn_l_stick_y" => function(isDown:Bool, key:String, value:Float) {
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
		"btn_r_stick_x" => function(isDown:Bool, key:String, value:Float) {
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
		"btn_r_stick_y" => function(isDown:Bool, key:String, value:Float) {
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
