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
