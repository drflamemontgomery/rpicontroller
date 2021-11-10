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
	<button public id="config"/>
	<button public id="btn"/>
	<input public id="host"/>
	</container>;

    public function new(align:h2d.Flow.FlowAlign, ?parent) {
	super(parent);
	initComponent();
    }

}
