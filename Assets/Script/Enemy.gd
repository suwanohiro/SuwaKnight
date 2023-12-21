extends "res://Assets/Script/Character.gd"



class_name Enemy

var target : Player = null

#Called when the node enters the scene tree for the first time.
func _ready():
	damage = Grobal.enemy_damage
	speed = 100.0
	change_state(State.Wait)
#end func

func _process(delta):
	if target == null:
		target = Grobal.player
	#end if
#end func

func input():
	if target == null:
		return
	#end if
	var distance = target.position - position
	if abs(distance.x) > 100:
		if distance.x < 0:
			keys[key_code.left] = true
		else:
			keys[key_code.right] = true
		#end if
	#end if

	if abs(distance.y) > 100:
		if distance.y < 0:
			keys[key_code.up] = true
		else:
			keys[key_code.down] = true
		#end if
	#end if
	
#end func

