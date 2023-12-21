extends "res://Assets/Script/Character.gd"





class_name Player


#Called when the node enters the scene tree for the first time.
func _ready():
	Grobal.player = $"."
	damage = Grobal.player_damage
	speed = 200.0
	change_state(State.Wait)
#end func




func input():
	keys[key_code.left] = Input.is_action_pressed("ui_left")
	keys[key_code.right] = Input.is_action_pressed("ui_right")
	keys[key_code.up] = Input.is_action_pressed("ui_up")
	keys[key_code.down] = Input.is_action_pressed("ui_down")
	keys[key_code.act0] = Input.is_action_pressed("ui_act0")
	keys[key_code.act1] = Input.is_action_pressed("ui_act1")
	keys[key_code.act2] = Input.is_action_pressed("ui_act2")
#end func

