extends Control

var _Button;

var _backGround: ColorRect;


# Called when the node enters the scene tree for the first time.
func _ready():
	_backGround = get_node("BackGround");
	
	# 背景色を指定
	_backGround.color = WebColor.Lightblue;
	
	# ボタン要素を読み込み
	_Button = preload("res://Assets/Scene/Button/Button.tscn");
	
	var size: Vector2 = Vector2(240, 40);
	
	var _btn1 = _Button.instance();
	_btn1.Initialize("1ボタン", ButtonColors.Colors.Blue, Vector2(100, 100), size, self);
	
	var _btn2 = _Button.instance();
	_btn2.Initialize("2ボタン", ButtonColors.Colors.White, Vector2(400, 100), size, self);
	
	
	var num: float = 100.526;
	print(num);
	print(Math.Floor(num));
	print(Math.DecToHex(255));
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
