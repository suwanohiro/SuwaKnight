extends Button

# ポップアップウィンドウをプリロード
var Popups = preload("res://Assets/Scene/PopupWindow/PopupWindow.tscn");

func _on_pouse_button_pressed():
		# ポップアップウィンドウ呼び出し
	var popup = Popups.instance()

	# ポーズ開始。ゲームを止める
	get_tree().paused = true
	add_child(popup)
	popup.show_modal(true)

	# popup終了時に "_resume()" を呼び出す
	popup.connect('tree_exited', self, '_resume')
	pass # Replace with function body.

func _resume():
	# ウィンドウを閉じたときのコールバック
	var tree = get_tree()
	if tree:
		# ポーズ解除
		tree.paused = false 
