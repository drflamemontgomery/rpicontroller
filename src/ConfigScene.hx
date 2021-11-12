package;
import GUI;
class ConfigScene {

    var style : h2d.domkit.Style = null;
    var controller : h2d.Bitmap;
    public var center : h2d.Flow;
    var width : Int = 0;
    var height : Int = 0;

    function genBtn(btn:BitmapButtonComp, light:h2d.Tile, dark:h2d.Tile) {
	btn.tile = light;
        btn.onHover = function() { btn.tile = dark; };
        btn.onOut = function() { btn.tile = light; };
	btn.onClick = function() {
	    
	    Main.ME.buttonmapScene.load(btn.name);

	    Main.ME.inputLayer.visible = false;
	    Main.ME.configLayer.visible = false;
	    Main.ME.buttonMapLayer.visible = true;
	    Main.ME.axisMapLayer.visible = false;
	};
    }
    
    function genAxis(btn:BitmapButtonComp, light:h2d.Tile, dark:h2d.Tile) {
	genBtn(btn, light, dark);

	btn.onClick = function() {
	    var win = new JoystickChoiceComp(Right, hxd.Res.load("border.png").toTile(), center);
	    win.axis_x.label = "Axis X";

	    win.axis_x.onClick = function() {
		Main.ME.axismapScene.load('${btn.name}_x');

		Main.ME.inputLayer.visible = false;
		Main.ME.configLayer.visible = false;
		Main.ME.buttonMapLayer.visible = false;
		Main.ME.axisMapLayer.visible = true;
	    };
	    
	    win.axis_y.label = "Axis Y";
	    win.axis_y.onClick = function() {
		Main.ME.axismapScene.load('${btn.name}_y');

		Main.ME.inputLayer.visible = false;
		Main.ME.configLayer.visible = false;
		Main.ME.buttonMapLayer.visible = false;
		Main.ME.axisMapLayer.visible = true;
	    };
	    
	    win.click.label  = "Click";

	    win.click.onClick = function() {
		Main.ME.buttonmapScene.load(btn.name);

		Main.ME.inputLayer.visible = false;
		Main.ME.configLayer.visible = false;
		Main.ME.buttonMapLayer.visible = true;
		Main.ME.axisMapLayer.visible = false;
	    };
	    
	    style.addObject(win);

	    win.close.tile = hxd.Res.load("back.png").toTile();
	    win.close.onClick = function() {
	        style.removeObject(win);
		win.remove();
	    };
	};
    }
    
    public function new(?parent:h2d.Object) {
	center = new h2d.Flow(parent);
	center.horizontalAlign = center.verticalAlign = Middle;

	var root = new ConfigContainer(Right,
				       hxd.Res.load("controller_outline.png").toTile(), center);

	var circle_large = hxd.Res.load("circle_large.png").toTile();
	var circle_large_hover = hxd.Res.load("circle_large_hover.png").toTile();
	var circle_medium = hxd.Res.load("circle_medium.png").toTile();
	var circle_medium_hover = hxd.Res.load("circle_medium_hover.png").toTile();
	var circle_small = hxd.Res.load("circle_small.png").toTile();
	var circle_small_hover = hxd.Res.load("circle_small_hover.png").toTile();

	var rect_wide = hxd.Res.load("rect_wide.png").toTile();
	var rect_wide_hover = hxd.Res.load("rect_wide_hover.png").toTile();

	var rect_tall = hxd.Res.load("rect_tall.png").toTile();
	var rect_tall_hover = hxd.Res.load("rect_tall_hover.png").toTile();

	root.back.tile = hxd.Res.load("back.png").toTile();
	root.back.onClick = function() {
	    Main.ME.inputLayer.visible = true;
	    Main.ME.configLayer.visible = false;
	    Main.ME.buttonMapLayer.visible = false;
	    Main.ME.axisMapLayer.visible = false;
	};

	genAxis(root.btn_l_stick, circle_large, circle_large_hover);
	genAxis(root.btn_r_stick, circle_large, circle_large_hover);
	
	genBtn(root.btn_y, circle_medium, circle_medium_hover);
	genBtn(root.btn_b, circle_medium, circle_medium_hover);
	genBtn(root.btn_a, circle_medium, circle_medium_hover);
	genBtn(root.btn_x, circle_medium, circle_medium_hover);

	genBtn(root.btn_up, circle_medium, circle_medium_hover);
	genBtn(root.btn_down, circle_medium, circle_medium_hover);
	genBtn(root.btn_left, circle_medium, circle_medium_hover);
	genBtn(root.btn_right, circle_medium, circle_medium_hover);

	genBtn(root.btn_plus, circle_small, circle_small_hover);
	genBtn(root.btn_minus, circle_small, circle_small_hover);
	genBtn(root.btn_home, circle_small, circle_small_hover);
	genBtn(root.btn_capture, circle_small, circle_small_hover);

	genBtn(root.btn_l, rect_wide, rect_wide_hover);
	genBtn(root.btn_r, rect_wide, rect_wide_hover);

	genBtn(root.btn_zl, rect_tall, rect_tall_hover);
	genBtn(root.btn_zr, rect_tall, rect_tall_hover);
	
	
	style = new h2d.domkit.Style();
	style.load(hxd.Res.style);
	style.addObject(root);    
    }
    
    public function update(dt:Float) {
	style.sync();
	
    }
}
