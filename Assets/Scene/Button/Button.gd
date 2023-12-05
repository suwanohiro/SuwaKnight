extends Control

# 青ボタンと白ボタンを切り替えれるようにする

enum ButtonColors {
	Blue,
	White
};

export(String) var _ButtonText: String = "";
export(ButtonColors) var _ButtonColor: int = ButtonColors.Blue;
export(Vector2) var _Position: Vector2 = Vector2(0, 0);
export(Vector2) var _ButtonSize: Vector2 = Vector2(80, 40);

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var _buttonElem: Button;
var _buttonElemMargin: Vector2 = Vector2(3, 3);
var _backGround: TextureRect;
var _Light: TextureRect;
var _buttonTextLabel: Label;
var _border: ReferenceRect;


# Called when the node enters the scene tree for the first time.
func _ready():
	_buttonElem = get_node("Button");
	_backGround = get_node("BackGround");
	_Light = get_node("Light");
	_buttonTextLabel = get_node("ButtonText");
	_border = get_node("Border");
	
	rect_position = _Position;
	
	_buttonElem.rect_size = _ButtonSize - _buttonElemMargin * 2;
	_buttonElem.rect_position = _buttonElemMargin;
	_backGround.rect_size = _ButtonSize;
	_Light.rect_size = _ButtonSize;
	_buttonTextLabel.rect_size = _ButtonSize;
	_border.rect_size = _ButtonSize;
	_buttonTextLabel.text = _ButtonText;
	
	if (_ButtonColor == ButtonColors.White):
		_backGround.texture.resource_path = "res://Assets/Images/UI/diamond_white.png";
		
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	print("click!");
	pass # Replace with function body.
