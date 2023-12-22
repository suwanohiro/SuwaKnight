extends Control

enum ButtonTypeLabel {
	OK = 1,
	OK_Cancel = 2,
	Cancel = 2
	Other = 3
};

enum HAlign {
	Left,
	Center,
	Right
}

################################################################################
# export
################################################################################

# ウィンドウタイトル
export(String) var _WindowTitle: String = "";

# 本文
export(String, MULTILINE) var _Message: String = "";

# ウィンドウサイズ
export var _windowSize: Vector2 = Vector2(750, 400);

# ボタン配置
export(HAlign) var _ButtonAlign: int = HAlign.Right;

# ボタンの種類
export(ButtonTypeLabel) var _ButtonType: int = ButtonTypeLabel.OK;

# ボタンラベル (ボタンの種類でOtherが選ばれた際のみ)
export(Array, String) var _ButtonLabels: Array;

################################################################################
# 通常メンバ変数
################################################################################

# ボタン要素
var _Button;

# ボタン要素配列
var _ButtonList: Array;

################################################################################
# ノード関連
################################################################################
# 背景
var _allBackGround: ColorRect;

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

func popup(
	windowTitle: String, message: String,
	windowSize: Vector2, buttonType: int = ButtonTypeLabel.OK,
	buttonLabels: Array = []
):
	_WindowTitle = windowTitle;
	_Message = message;
	_windowSize = windowSize;
	_ButtonType = buttonType;
	_ButtonLabels = buttonLabels;
	
	visible = true;
	return;

# ノードが初めてシーンツリーに入るときに呼び出される。
func _ready():
	# 最初は非表示にする
	# visible = false;
	
	# 各種要素を取得
	_getNode();
	
	_createShadow();
	
	# ボタン要素を読み込み
	_Button = preload("res://Assets/Scene/Button/Button.tscn");
	
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
	_createButton();
	pass

func _createShadow():
	_allBackGround.color = WebColor.getColor(WebColor.Gray, 128);
	_allBackGround.rect_size = rect_size;
	return;

func _createButton():
	# ボタンラベル
	var buttonLabel: Array;
	buttonLabel.push_front("*OK");
	
	if (_ButtonType == ButtonTypeLabel.OK_Cancel):
		buttonLabel.push_front("キャンセル");
	if (_ButtonType == ButtonTypeLabel.Other):
		# インスペクターで定義したラベル名をそのまま代入
		buttonLabel = _ButtonLabels;
	
	for cnt in range(buttonLabel.size()):
		var btnPos: Vector2 = Vector2(100 + 300 * cnt, 300);

		if (_ButtonAlign == HAlign.Left):
			btnPos = Vector2(100 + 300 * cnt, 300);
		elif (_ButtonAlign == HAlign.Center):
			pass
		
		
		var work = _createButtonInstance(buttonLabel[cnt], btnPos);
		_ButtonList.push_back(work);
		continue;
	return;

func _createButtonInstance(label: String, pos: Vector2):
	var size: Vector2 = Vector2(240, 40);
	
	var work = _Button.instance();
		
	# ボタンの色を設定
	var buttonColor: int = ButtonColors.Colors.White;
	
	# 文字列先頭に[*]があるかどうかの正規表現
	var regex = RegEx.new();
	regex.compile("^[*]");
	
	# 文字列先頭に[*]があれば青ボタン
	if (regex.search(label)):
		buttonColor = ButtonColors.Colors.Blue;

		# 識別用文字を削除
		label = regex.sub(label, "");
		pass

	work.Initialize(label, buttonColor, pos, size, _windowElem);

	return work;

# ノード情報を設定する
func _getNode():
	# 背景
	_allBackGround = get_node("AllBackGround");
	
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

################################################################################
# イベント処理設定
################################################################################

func setBtnDownEvent(target: int, event: FuncRef) -> void:
	return;

func setBtnUPEvent(target: int, event: FuncRef) -> void:
	return;

func setBtnPressedEvent(target: int, event: FuncRef) -> void:
	return;
