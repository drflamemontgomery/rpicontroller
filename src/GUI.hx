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

@:uiComp("bitmapButton")
class BitmapButtonComp extends h2d.Flow implements h2d.domkit.Object {

    static var SRC = <bitmapButton>
	<bitmap public id="bitmapBtn" />
	</bitmapButton>

	public var tile(get, set): h2d.Tile;
    function get_tile() return bitmapBtn.tile;
    function set_tile(t) {
        bitmapBtn.tile = t;
	return t;
    }

    public function new( ?parent ) {
	super(parent);
	initComponent();
	enableInteractive = true;
	interactive.onClick = function(_) onClick();
	interactive.onOver = function(_) {
	    dom.hover = true;
	    onHover();
	};
	interactive.onPush = function(_) {
	    dom.active = true;
	};
	interactive.onRelease = function(_) {
	    dom.active = false;
	};
	interactive.onOut = function(_) {
	    dom.hover = false;
	    onOut();
	};
    }

    public dynamic function onClick() {
    }

    public dynamic function onHover() {
    }

    public dynamic function onOut() {
    }
}


@:uiComp("container")
class ContainerComp extends h2d.Flow implements h2d.domkit.Object {

    static var SRC = <container>
	<button public id="config"/>
	<button public id="save"/>
	<button public id="disconnect"/>
	<button public id="btn"/>
	<input public id="host"/>
	<text public id="status"/>
	</container>;

    public function new(align:h2d.Flow.FlowAlign, ?parent) {
	super(parent);
	initComponent();
    }

}

@:uiComp("controller")
class ConfigContainer extends h2d.Flow implements h2d.domkit.Object {

    static var SRC = <controller>
	<bitmap src={tile} public id="outline"/>
	<bitmapButton public id="back" />
	<bitmapButton public id="btn_l_stick"/>
	<bitmapButton public id="btn_r_stick"/>
	<bitmapButton public id="btn_y"/>
	<bitmapButton public id="btn_b"/>
	<bitmapButton public id="btn_a"/>
	<bitmapButton public id="btn_x"/>
	<bitmapButton public id="btn_l"/>
	<bitmapButton public id="btn_r"/>
	<bitmapButton public id="btn_zl"/>
	<bitmapButton public id="btn_zr"/>
	<bitmapButton public id="btn_minus"/>
	<bitmapButton public id="btn_plus"/>
	<bitmapButton public id="btn_home"/>
	<bitmapButton public id="btn_capture"/>
	<bitmapButton public id="btn_up"/>
	<bitmapButton public id="btn_down"/>
	<bitmapButton public id="btn_left"/>
	<bitmapButton public id="btn_right"/>
	
	<bitmap public id="btn_l_stick_label"/>
	<bitmap public id="btn_r_stick_label"/>
	<bitmap public id="btn_y_label"/>
	<bitmap public id="btn_b_label"/>
	<bitmap public id="btn_a_label"/>
	<bitmap public id="btn_x_label"/>
	<bitmap public id="btn_l_label"/>
	<bitmap public id="btn_r_label"/>
	<bitmap public id="btn_zl_label"/>
	<bitmap public id="btn_zr_label"/>
	<bitmap public id="btn_minus_label"/>
	<bitmap public id="btn_plus_label"/>
	<bitmap public id="btn_home_label"/>
	<bitmap public id="btn_capture_label"/>
	<bitmap public id="btn_up_label"/>
	<bitmap public id="btn_down_label"/>
	<bitmap public id="btn_left_label"/>
	<bitmap public id="btn_right_label"/>
	</controller>;

    public function new(align:h2d.Flow.FlowAlign, tile:h2d.Tile, ?parent) {
	super(parent);
	initComponent();
    }

}


@:uiComp("buttonHeader")
class ButtonHeaderComp extends h2d.Flow implements h2d.domkit.Object {
    static var SRC = <buttonHeader>
	<text public id="button_id" />
	<button public id="new_btn" />
	<button public id="back" />
	</buttonHeader>;

    public function new(align:h2d.Flow.FlowAlign, ?parent) {
	super(parent);
	initComponent();
    }
}

@:uiComp("buttonBody")
class ButtonBodyComp extends h2d.Flow implements h2d.domkit.Object {
    static var SRC = <buttonBody>
	<text public id="key_id" />
	<button public id="delete" />
	</buttonBody>;

    public function new(align:h2d.Flow.FlowAlign, ?parent) {
	super(parent);
	initComponent();
    }
}


@:uiComp("joystickChoice")
class JoystickChoiceComp extends h2d.Flow implements h2d.domkit.Object {
    static var SRC = <joystickChoice>
        <bitmap src={tile} public id="border"/>
	<button public id="axis_x" />
	<button public id="axis_y" />
	<button public id="click" />
        <bitmapButton public id="close" />
	</joystickChoice>;

    public function new(align:h2d.Flow.FlowAlign, tile:h2d.Tile, ?parent) {
	super(parent);
	initComponent();
    }
}


@:uiComp("axisBody")
class AxisBodyComp extends h2d.Flow implements h2d.domkit.Object {
    static var SRC = <axisBody>
	<text public id="key_id" />
	<input public id="value" />
	<button public id="delete" />
	</axisBody>;

    public function new(align:h2d.Flow.FlowAlign, ?parent) {
	super(parent);
	initComponent();
    }
}
