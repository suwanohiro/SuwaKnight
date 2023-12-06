extends Control

class_name Buttons

enum ButtonColors {
	Blue,
	White
};

################################################################################
# export
################################################################################
export(String) var _ButtonText: String = "";
export(ButtonColors) var _ButtonColor: int = ButtonColors.Blue;
export(Vector2) var _Position: Vector2 = Vector2(0, 0);
export(Vector2) var _ButtonSize: Vector2 = Vector2(80, 40);


################################################################################
# 通常メンバ変数
################################################################################
var _buttonElemMargin: Vector2 = Vector2(3, 3);

var _buttonElem: Button;
var _backGround: TextureRect;
var _Light: TextureRect;
var _buttonTextLabel: Label;
var _border: ReferenceRect;

################################################################################
# 押下時関連
################################################################################
# 押下中かどうか
var _isPress: bool = false;

# 縮小最小値 (見た目が最も小さくなるスケール値)
const _scale: float = 0.95;
const _scaleMin: Vector2 = Vector2(_scale, _scale);

# 縮小最大値 (見た目が最も大きくなるスケール値)
const _scaleMax: Vector2 = Vector2(1, 1);

# 拡大/縮小スピード
const _reductionSpd: float = 0.5;

func Initialize(Text: String, Colors: int, Pos: Vector2, Size: Vector2) -> void:
	_getNode();
	
	_ButtonText = Text;
	_ButtonColor = Colors;
	_Position = Pos;
	_ButtonSize = Size;
	
	_ready();
	return;

func connectEvent():
	return;

# Called when the node enters the scene tree for the first time.
func _ready():
	# ノードを取得する
	_getNode();
	
	# 全体の座標と中心座標を指定する
	rect_position = _Position;
	rect_pivot_offset = _ButtonSize / 2;
	
	# 各種要素のサイズ変更
	_setSize();
	
	# ボタンノードの位置を変更
	_buttonElem.rect_position = _buttonElemMargin;
	
	# ボタンラベルの文字列を変更
	_buttonTextLabel.text = _ButtonText;
	
	
	if (_ButtonColor == ButtonColors.White):
		var white: Texture = load("res://Assets/Images/UI/diamond_white.png");
		_backGround.texture = white;
		
	pass # Replace with function body.

# ノードを取得する
func _getNode():
	_buttonElem = get_node("ButtonElem");
	_backGround = get_node("BackGround");
	_Light = get_node("Light");
	_buttonTextLabel = get_node("ButtonText");
	_border = get_node("Border");
	return;

# 各種要素のサイズ変更
func _setSize():
	_buttonElem.rect_size = _ButtonSize - _buttonElemMargin * 2;
	_backGround.rect_size = _ButtonSize;
	_Light.rect_size = _ButtonSize;
	_buttonTextLabel.rect_size = _ButtonSize;
	_border.rect_size = _ButtonSize;
	return;

func _process(delta):
	var work: Vector2 = Vector2(delta * _reductionSpd, delta * _reductionSpd);
	
	# 押下中かどうかを判別し、徐々に縮小/拡大させる
	rect_scale += -work if (_isPress) else work;
	
	# 範囲外になった場合は修正する
	if (rect_scale > _scaleMax):
		rect_scale = _scaleMax;
	if (rect_scale < _scaleMin):
		rect_scale = _scaleMin
	pass

func _on_Button_pressed():
	print("click!");
	pass # Replace with function body.


func _on_Button_button_down():
	_isPress = true;
	pass # Replace with function body.


func _on_Button_button_up():
	_isPress = false;
	pass # Replace with function body.
