extends Control

class_name Buttons

var ButtonColors = preload("res://Assets/Scene/Button/ButtonColors.gd");



################################################################################
# export
################################################################################
export(String) var _ButtonText: String = "";
export(ButtonColors.Colors) var _ButtonColor: int = ButtonColors.Colors.Blue;
export(Vector2) var _Position: Vector2 = Vector2(0, 0);
export(Vector2) var _ButtonSize: Vector2 = Vector2(80, 40);


################################################################################
# 通常メンバ変数
################################################################################
var _buttonElemMargin: Vector2 = Vector2(3, 3);
var _allBorderSize: Vector2 = Vector2(3, 3);

var _allBorder: ReferenceRect;
var _shadow: ColorRect;
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

# エフェクトが表示中かどうか
var _isEffectShow: bool = false;

# エフェクトのファイル名 (差分のみ)
var _effectFileName = [
	"orange",
	"white"
];

# エフェクトのテクスチャ
var _effectTexture: Texture;

# エフェクトの表示先
var _effects: Control;
var _effectLeft: TextureRect;
var _effectRight: TextureRect;

# エフェクト表示時間 (秒)
const _effectShowTime: float = 0.2;

# 現在のエフェクト表示時間
var _effectShowNowTime: float = 0;

func Initialize(Text: String, Colors: int, Pos: Vector2, Size: Vector2) -> void:
	_getNode();
	
	_ButtonText = Text;
	_ButtonColor = Colors;
	_Position = Pos;
	_ButtonSize = Size;
	
	_ready();
	return;

func connectEvent():
	_buttonElem.connect("button_down", self, "_on_Button_button_down");
	_buttonElem.connect("button_up", self, "_on_Button_button_up");
	_buttonElem.connect("pressed", self, "_on_Button_pressed");
	return;


# Called when the node enters the scene tree for the first time.
func _ready():
	# ノードを取得する
	_getNode();
	
	# イベントを紐付ける
	connectEvent();
	
	# 全体の座標と中心座標を指定する
	rect_position = _Position;
	rect_pivot_offset = _ButtonSize / 2;
	
	# 各種要素のサイズ変更
	_setSize();
	
	# ノードの位置を修正
	_buttonElem.rect_position = _buttonElemMargin;
	_allBorder.rect_position = -_allBorderSize;
	
	# ボタンラベルの文字列を変更
	_buttonTextLabel.text = _ButtonText;
	
	_createEffect();
	
	if (_ButtonColor == ButtonColors.Colors.White):
		var white: Texture = load("res://Assets/Images/UI/diamond_white.png");
		_backGround.texture = white;
		
	pass # Replace with function body.

# ノードを取得する
func _getNode():
	_allBorder = get_node("AllBorder");
	_buttonElem = get_node("ButtonElem");
	_backGround = get_node("BackGround");
	_Light = get_node("Light");
	_buttonTextLabel = get_node("ButtonText");
	_border = get_node("Border");
	_shadow = get_node("Shadow");
	
	_effects = get_node("Effects");
	_effectLeft = get_node("Effects/Left");
	_effectRight = get_node("Effects/Right");
	return;

# 各種要素のサイズ変更
func _setSize():
	_allBorder.rect_size = _ButtonSize + (_allBorderSize * 2);
	_buttonElem.rect_size = _ButtonSize - _buttonElemMargin * 2;
	_backGround.rect_size = _ButtonSize;
	_Light.rect_size = _ButtonSize;
	_buttonTextLabel.rect_size = _ButtonSize;
	_border.rect_size = _ButtonSize;
	_shadow.rect_size = _ButtonSize + (_allBorderSize * 2);
	return;

# エフェクトを作成する
func _createEffect():
	var fileName: String = _effectFileName[_ButtonColor];
	var texture: Texture = load("res://Assets/Images/UI/check_" + fileName + ".png");
	_effectLeft.texture = texture;
	_effectRight.texture = texture;
	
	# 座標を指定する
	var adjustment: Vector2 = Vector2(5, 5);
	_effectLeft.rect_position = -(texture.get_size()) + adjustment;
	_effectRight.rect_position = Vector2(_ButtonSize.x, -_ButtonSize.y) + Vector2(-adjustment.x, adjustment.y);
	
	# 初期状態では非表示にさせる
	_effects.visible = false;

func _process(delta):
	var work: Vector2 = Vector2(delta * _reductionSpd, delta * _reductionSpd);
	
	# 押下中かどうかを判別し、徐々に縮小/拡大させる
	rect_scale += -work if (_isPress) else work;
	
	# 範囲外になった場合は修正する
	if (rect_scale > _scaleMax):
		rect_scale = _scaleMax;
	if (rect_scale < _scaleMin):
		rect_scale = _scaleMin
	
	_process_effect(delta);
	
	pass

# エフェクト関連更新処理
func _process_effect(delta):
	# エフェクトが非表示なら何も処理をしない
	if (not _effects.visible):
		return;
	
	# エフェクト表示中なら
	
	# 経過時間分を足す
	_effectShowNowTime += delta;

	# 表示中に最大表示時間を超えた場合は非表示にする
	if (_effectShowNowTime > _effectShowTime):
		_effects.visible = false;
		_effectShowNowTime = 0;

func _on_Button_pressed():
	print(_ButtonText + " click!");
	pass


func _on_Button_button_down():
	_isPress = true;
	pass # Replace with function body.


func _on_Button_button_up():
	_isPress = false;
	
	# エフェクトを表示する
	_effects.visible = true;
	pass # Replace with function body.
