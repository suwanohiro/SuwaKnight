extends KinematicBody2D



class_name Character

enum State {
	Wait,
	Idle,
	Run,
	Attack,
	Hurt,
	Die,
}

static func get_state_name(state : int) -> String:
	if state == State.Wait:
		return "Wait"
	#end if
	if state == State.Idle:
		return "Idle"
	#end if
	if state == State.Run:
		return "Run"
	#end if
	if state == State.Attack:
		return "Attack"
	#end if
	if state == State.Hurt:
		return "Hurt"
	#end if
	if state == State.Die:
		return "Die"
	#end if
	
	return ""
#end func

#onready var [param_name] = $[object_name]

onready var anim = $Anim

var state_anim = -1


enum key_code{
	up,
	down,
	left,
	right,
	act0,
	act1,
	act2,
	count,
}

var keys = [false, false, false, false, false, false, false]


var speed : float
var velocity : Vector2
var damage : Resource = null



#Called when the node enters the scene tree for the first time.
func _ready():
	speed = 50.0
	change_state(State.Wait)
#end func


#Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if state_anim != State.Run and state_anim != State.Wait:
		var fs = anim.frames.get_frame_count(get_state_name(state_anim))
		var f = anim.frame
		if fs == f + 1:
			change_state(State.Wait)
		#end if
	#end if
	input_init()
	input()
	for i in range(3):
		var code = key_code.act0
		code += i
		if keys[code]:
			_attack(i)
			break
		#end if
	#end for

	_calc_velocity()
	if velocity.x != 0:
		var left := velocity.x < 0
		if anim.flip_h != left:
			anim.flip_h = left
		#end if
	#end if
#end func


func _physics_process(delta):
	if velocity.x != 0 or velocity.y != 0:
		velocity = move_and_slide(velocity)
		change_state(State.Run)
	else:
		if state_anim == State.Run:
			change_state(State.Wait)
		#end if
	#end if
	
	
	
#end func


func change_state(state : int) ->bool:
	if state_anim == state:
		return false
	#end if
	
	anim.play(get_state_name(state))
	state_anim = state
	return true
#end func


func input_init():
	for i in range(key_code.count):
		keys[i] = false
	pass
#end func


func input():
	pass
#end func

func _calc_velocity():
	velocity.x = 0
	velocity.y = 0
	if keys[key_code.left] != keys[key_code.right] :
		var accele : float = speed
		if keys[key_code.left] :
			accele *= -1
		#end if
		velocity.x += accele
	#end if
	if keys[key_code.up] != keys[key_code.down] :
		var accele : float = speed
		if keys[key_code.up] :
			accele *= -1
		#end if
		velocity.y += accele
	#end if
#end func


func _attack(code : int):
	change_state(State.Attack)

	if damage == null:
		return
	#end if

	##Error!
	#var d = damage.instantiate()
	#d.damage = 1
	#d.position = position
	pass
#end func



