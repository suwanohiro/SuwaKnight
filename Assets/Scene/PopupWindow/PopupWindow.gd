extends Control

enum ButtonTypeLabel {
	None,
	OK,
	OK_Cancel,
	Other
};

################################################################################
# export
################################################################################

# ウィンドウタイトル
export(String) var _WindowTitle: String = "";

# 本文
export(String, MULTILINE) var _Message: String = "";

# ウィンドウサイズ
export var _windowSize: Vector2 = Vector2(750, 400);

# ボタンの種類
export(ButtonTypeLabel) var _ButtonType: int = ButtonTypeLabel.OK;

# ボタンラベル (ボタンの種類でOtherが選ばれた際のみ)
export(Array, String) var _ButtonLabels;


################################################################################
# 通常メンバ変数
################################################################################

# ウィンドウ要素
var _windowElem: Control;

# 背景要素
var _backGroundElem: ColorRect;
var _backGroundBorder: ReferenceRect;

# タイトル要素
var _windowTitleBK: TextureRect;
var _windowTitleBKBorder: ReferenceRect;
var _windowTitleText: Label;

# メインコンテンツ
var _mainContentMargin: float = 10;
var _mainContent: ColorRect;
var _message: Label;

# ノードが初めてシーンツリーに入るときに呼び出される。
func _ready():
	# 各種要素を取得
	_setNode();
	
	# ウィンドウのサイズを全て設定
	_setWindowSize();
	
	# ウィンドウ位置を画面中央に設定
	_setCenterWindowPos();
	
	# ウィンドウタイトルを設定
	_windowTitleText.text = _WindowTitle;
	
	# 本文を設定
	_message.text = _Message;
	
	#######################
	# ここからテスト
	#######################
	
	var Buttons = preload("res://Assets/Scene/Button/Button.tscn");
	var a = Buttons.instance();
	
	
	var asd: Buttons = Buttons.instance();
	asd.Initialize("test", 0, Vector2(100, 100), Vector2(60, 40));
	
	a.set_script(asd);
	# a.Initialize("test", Buttons.ButtonColors.Blue, Vector2(100, 100), Vector2(60, 40));
	# add_child(a.getNode());
	add_child(a);
	pass

# ノード情報を設定する
func _setNode():
	# Window
	_windowElem = get_node("Window");
	
	# BackGround
	_backGroundElem = get_node("Window/BackGround/BackGround");
	_backGroundBorder = get_node("Window/BackGround/BackGround_Border");

	# TitleElem
	_windowTitleBK = get_node("Window/TitleElem/TitleBackGround");
	_windowTitleBKBorder = get_node("Window/TitleElem/TitleElem_Border");
	_windowTitleText = get_node("Window/TitleElem/TitleText");
	
	# MainContent
	_mainContent = get_node("Window/MainContent/MainContent");
	_message = get_node("Window/MainContent/Message");
	return;

# ウィンドウのサイズを全て設定
func _setWindowSize() -> void:
	# BackGround
	_backGroundElem.rect_size = _windowSize;
	_backGroundBorder.rect_size = _windowSize;
	
	# Title
	_windowTitleBK.rect_size.x = _windowSize.x;
	_windowTitleBKBorder.rect_size.x = _windowSize.x;
	_windowTitleText.rect_size.x = _windowSize.x;
	
	# MainContent
	var titleHeight: float = _windowTitleBK.rect_size.y;
	var work: Vector2 = Vector2(_mainContentMargin * 2, _mainContentMargin * 2 + titleHeight);
	_mainContent.rect_size = _windowSize - work;
	_message.rect_size = _windowSize - work;
	return;

# ウィンドウ位置を画面中央に設定
func _setCenterWindowPos():
	var windowMargin: Vector2 = (rect_size - _windowSize) / 2;

	if (windowMargin < Vector2(0, 0)):
		windowMargin = Vector2(0, 0);
		

	_windowElem.rect_position = windowMargin;
	return;
