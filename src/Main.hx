//PARAM=-lib domkit
class Main extends hxd.App {

    public var inputScene : InputScene;
    var configScene : ConfigScene;
    public var buttonmapScene : ButtonMapScene;
    public var axismapScene : AxisMapScene;
    
    public var inputLayer : h2d.Layers;
    public var configLayer : h2d.Layers;
    public var buttonMapLayer : h2d.Layers;
    public var axisMapLayer : h2d.Layers;
    var background : h2d.Bitmap;

    public static var ME : Main;
    
    function onClose():Bool {
	inputScene.dispose();
	return true;
    }
    
    override function init() {
	hxd.Window.getInstance().onClose = this.onClose;
	ME = this;
        background = new h2d.Bitmap(h2d.Tile.fromColor(0xFFFFFF, 800, 600, 1), s2d);
	inputLayer = new h2d.Layers(s2d);
	configLayer = new h2d.Layers(s2d);
	buttonMapLayer = new h2d.Layers(s2d);
	axisMapLayer = new h2d.Layers(s2d);
	
	inputScene = new InputScene(inputLayer);
	configScene = new ConfigScene(configLayer);
	buttonmapScene = new ButtonMapScene(buttonMapLayer);
	axismapScene = new AxisMapScene(axisMapLayer);
	onResize();

	inputLayer.visible = true;
	configLayer.visible = false;
	buttonMapLayer.visible = false;
	axisMapLayer.visible = false;
    }

    override function onResize() {
	background.width = s2d.width;
	background.height = s2d.height;
	inputScene.center.minWidth = inputScene.center.maxWidth = s2d.width;
	inputScene.center.minHeight = inputScene.center.maxHeight = s2d.height;
        configScene.center.minWidth = configScene.center.maxWidth = s2d.width;
	configScene.center.minHeight = configScene.center.maxHeight = s2d.height;
    }

    override function update(dt:Float) {
	if(inputLayer.visible) {
	    inputScene.update(dt);
	}
        if(configLayer.visible) {
	    configScene.update(dt);
	}
	if(buttonMapLayer.visible) {
	    buttonmapScene.update(dt);
	}
	if(axisMapLayer.visible) {
	    axismapScene.update(dt);
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
