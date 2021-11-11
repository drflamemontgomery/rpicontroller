package;
import GUI;
class ConfigScene {

    var style = null;
    var controller : h2d.Bitmap;
    public var center : h2d.Flow;
    var width : Int = 0;
    var height : Int = 0;
    
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
	};
	
	root.btn_l_stick.tile = circle_large;
	root.btn_l_stick.onHover = function() { root.btn_l_stick.tile = circle_large_hover; };
	root.btn_l_stick.onOut = function() { root.btn_l_stick.tile = circle_large; };
	root.btn_r_stick.tile = circle_large;
	root.btn_r_stick.onHover = function() { root.btn_r_stick.tile = circle_large_hover; };
	root.btn_r_stick.onOut = function() { root.btn_r_stick.tile = circle_large; };

	root.btn_y.tile = circle_medium;
	root.btn_y.onHover = function() { root.btn_y.tile = circle_medium_hover; };
	root.btn_y.onOut = function() { root.btn_y.tile = circle_medium; };
	
	root.btn_b.tile = circle_medium;
	root.btn_b.onHover = function() { root.btn_b.tile = circle_medium_hover; };
	root.btn_b.onOut = function() { root.btn_b.tile = circle_medium; };


	root.btn_a.tile = circle_medium;
	root.btn_a.onHover = function() { root.btn_a.tile = circle_medium_hover; };
	root.btn_a.onOut = function() { root.btn_a.tile = circle_medium; };
	
	root.btn_x.tile = circle_medium;
	root.btn_x.onHover = function() { root.btn_x.tile = circle_medium_hover; };
	root.btn_x.onOut = function() { root.btn_x.tile = circle_medium; };
	
	root.btn_up.tile = circle_medium;
	root.btn_up.onHover = function() { root.btn_up.tile = circle_medium_hover; };
	root.btn_up.onOut = function() { root.btn_up.tile = circle_medium; };
	
	root.btn_down.tile = circle_medium;
	root.btn_down.onHover = function() { root.btn_down.tile = circle_medium_hover; };
	root.btn_down.onOut = function() { root.btn_down.tile = circle_medium; };
	
	root.btn_left.tile = circle_medium;
	root.btn_left.onHover = function() { root.btn_left.tile = circle_medium_hover; };
	root.btn_left.onOut = function() { root.btn_left.tile = circle_medium; };
	
	root.btn_right.tile = circle_medium;
	root.btn_right.onHover = function() { root.btn_right.tile = circle_medium_hover; };
	root.btn_right.onOut = function() { root.btn_right.tile = circle_medium; };

	root.btn_plus.tile = circle_small;
	root.btn_plus.onHover = function() { root.btn_plus.tile = circle_small_hover; };
	root.btn_plus.onOut = function() { root.btn_plus.tile = circle_small; };
	
	root.btn_minus.tile = circle_small;
	root.btn_minus.onHover = function() { root.btn_minus.tile = circle_small_hover; };
	root.btn_minus.onOut = function() { root.btn_minus.tile = circle_small; };
	
	root.btn_home.tile = circle_small;
	root.btn_home.onHover = function() { root.btn_home.tile = circle_small_hover; };
	root.btn_home.onOut = function() { root.btn_home.tile = circle_small; };
	
	root.btn_capture.tile = circle_small;
	root.btn_capture.onHover = function() { root.btn_capture.tile = circle_small_hover; };
	root.btn_capture.onOut = function() { root.btn_capture.tile = circle_small; };

	root.btn_l.tile = rect_wide;
	root.btn_l.onHover = function() { root.btn_l.tile = rect_wide_hover; };
	root.btn_l.onOut = function() { root.btn_l.tile = rect_wide; };
	
	root.btn_r.tile = rect_wide;
	root.btn_r.onHover = function() { root.btn_r.tile = rect_wide_hover; };
	root.btn_r.onOut = function() { root.btn_r.tile = rect_wide; };

	root.btn_zl.tile = rect_tall;
	root.btn_zl.onHover = function() { root.btn_zl.tile = rect_tall_hover; };
	root.btn_zl.onOut = function() { root.btn_zl.tile = rect_tall; };
	
	root.btn_zr.tile = rect_tall;
	root.btn_zr.onHover = function() { root.btn_zr.tile = rect_tall_hover; };
	root.btn_zr.onOut = function() { root.btn_zr.tile = rect_tall; };
	
	style = new h2d.domkit.Style();
	style.load(hxd.Res.style);
	style.addObject(root);    
    }
    
    public function update(dt:Float) {
	style.sync();
	
    }
}
