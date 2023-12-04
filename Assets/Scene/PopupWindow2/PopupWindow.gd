extends Node2D

enum PopupTypes {
	OK,
	OK_Cancel
}

class_name PoppupWindow2

# ウィンドウタイトル
export var _title: String;
export(PopupTypes) var _popupType;

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var child: Popup = get_node("Popup");
	# child.popup();
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
