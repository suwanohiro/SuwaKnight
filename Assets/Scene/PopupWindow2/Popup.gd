extends Popup

func _on_Button_pressed():
	# ボタンがクリックされたらインスタンスを消す
	queue_free()
