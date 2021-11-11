package;
import GUI;

class ButtonMapScene {

    var style : Null<h2d.domkit.Style> = null;
    var controller : h2d.Bitmap;
    public var top : h2d.Flow;
    public var body : h2d.Flow;
    var width : Int = 0;
    var height : Int = 0;
    var key_pressed : Int = 0;

    function onEvent(event : hxd.Event) {
        switch(event.kind) {
	case EKeyDown: key_pressed = event.keyCode;
	case EKeyUp: key_pressed = 0;
	default: null;
	}
    }
    
    function newKey() {
	var a = new ButtonBodyComp(Left, body);
	a.key_id.text = "Key";
	style.addObject(a);
	a.delete.label = "Delete";
	// while(key_pressed == 0) {
	// }
	// a.key_id.text = hxd.Key.getKeyName(key_pressed);
	a.delete.onClick = function() { style.removeObject(a); a.remove(); };
    }
    
    public function new(?parent:h2d.Object) {
	hxd.Window.getInstance().addEventTarget(onEvent);
	top = new h2d.Flow(parent);
	top.horizontalAlign = Left;
	top.verticalAlign = Top;
	
	body = new h2d.Flow(parent);
	body.layout = Vertical;
	body.maxWidth = 100;
	body.paddingTop = 50;
	body.borderRight = 300;
	
	
	var header = new ButtonHeaderComp(Right, top);

	header.button_id.text = "NULL";
        header.new_btn.label = "New";
        header.back.label = "Back";
	header.back.onClick = function() {
	    Main.ME.inputLayer.visible = false;
	    Main.ME.configLayer.visible = true;
	    Main.ME.buttonMapLayer.visible = false;
	};

	header.new_btn.onClick = function() {
	    newKey();
	};
	
	style = new h2d.domkit.Style();
	style.load(hxd.Res.mappingStyle_css);
	style.addObject(header);
	
	
	style.allowInspect = true;
    }

    public function update(dt:Float) {
	style.sync();
    }
    
}
