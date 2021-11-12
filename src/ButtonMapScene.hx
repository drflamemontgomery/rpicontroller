package;
import GUI;

class ButtonMapScene {

    var style : Null<h2d.domkit.Style> = null;
    var controller : h2d.Bitmap;
    public var top : h2d.Flow;
    public var body : h2d.Flow;
    var width : Int = 0;
    var height : Int = 0;
    var genNewKey : Bool = false;
    var newKey : ButtonBodyComp;
    public var header : ButtonHeaderComp;
    var keys : Array<Null<ButtonBodyComp>>;
    var parent : h2d.Object;
    
    function onEvent(event : hxd.Event) {
        switch(event.kind) {
	case EKeyDown:
	    if(genNewKey) {
		newKey.key_id.text = hxd.Key.getKeyName(event.keyCode);
		genNewKey = false;
	    }
	default: null;
	}
    }
    
    function createKey() {
	var a = new ButtonBodyComp(Left, body);
	a.key_id.text = "Press any Key...";
	style.addObject(a);
	a.delete.label = "Delete";
	a.delete.onClick = function() {
	    if(genNewKey && newKey == a) {
		genNewKey = false;
	    }
	    style.removeObject(a);
	    keys.remove(a);
	    a.remove();
	};
	keys.push(a);
	genNewKey = true;
	newKey = a;
    }
    
    function confKey(id:String) {
	var a = new ButtonBodyComp(Left, body);
	a.key_id.text = id;
	style.addObject(a);
	a.delete.label = "Delete";
	a.delete.onClick = function() {
	    if(genNewKey && newKey == a) {
		genNewKey = false;
	    }
	    style.removeObject(a);
	    keys.remove(a);
	    a.remove();
	};
	keys.push(a);
    }
    
    public function load(id:String) {
	header.button_id.text = id;
	
        while(keys.length > 0) {
	    var key = keys.pop();
	    style.removeObject(key);
	    key.remove();
	}

	var config = Main.ME.inputScene.keys;

	for(key in config.keys()) {
	    if(config[key].contains(header.button_id.text)) {
		confKey(key);
	    }
	}
    }
    
    public function saveConfig() {
        var config = Main.ME.inputScene.keys;

	for(key in config.keys()) {
	    config[key].remove(header.button_id.text);
	}
	
        for(key in keys) {
	    if(config.exists(key.key_id.text)) {
		config[key.key_id.text].push(new String(header.button_id.text));
	    }
	    else {
		config.set(key.key_id.text, [new String(header.button_id.text)]);
	    }
	}
	
	Main.ME.inputScene.keys = config;
    }
    
    public function new(?parent:h2d.Object) {
	hxd.Window.getInstance().addEventTarget(onEvent);
	this.parent = parent;
	
	keys = new Array();
	
	top = new h2d.Flow(parent);
	top.horizontalAlign = Left;
	top.verticalAlign = Top;
	
	body = new h2d.Flow(parent);
	body.layout = Vertical;
	body.paddingTop = 50;
	body.borderRight = 300;
	
	
        header = new ButtonHeaderComp(Right, top);

	header.button_id.text = "NULL";
        header.new_btn.label = "New";
        header.back.label = "Back";
	header.back.onClick = function() {
	    saveConfig();
	    
	    Main.ME.inputLayer.visible = false;
	    Main.ME.configLayer.visible = true;
	    Main.ME.buttonMapLayer.visible = false;
	    Main.ME.axisMapLayer.visible = false;
	};

	header.new_btn.onClick = function() {
	    if(!genNewKey) {
		createKey();
	    }
	};
	
	style = new h2d.domkit.Style();
	style.load(hxd.Res.mappingStyle);
	style.addObject(header);
	
	
	style.allowInspect = true;
    }

    public function update(dt:Float) {
	style.sync();
    }
    
}
