extends KinematicBody2D


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


var key_up : bool
var key_down : bool
var key_left : bool
var key_right : bool
var key_act0 : bool
var key_act1 : bool
var key_act2 : bool

var speed : float
var velocity : Vector2



func change_state(state : int) ->bool:
	if state_anim == state:
		return false
	#end if
	
	anim.play(get_state_name(state))
	state_anim = state
	return true
#end func

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
	input()
	if key_act0 or key_act1 or key_act2:
		change_state(State.Attack)
	#end if
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


func input():
	key_left = Input.is_action_pressed("ui_left")
	key_right = Input.is_action_pressed("ui_right")
	key_up = Input.is_action_pressed("ui_up")
	key_down = Input.is_action_pressed("ui_down")
	key_act0 = Input.is_action_pressed("ui_act0")
	key_act1 = Input.is_action_pressed("ui_act1")
	key_act2 = Input.is_action_pressed("ui_act2")
#end func

func _calc_velocity():
	velocity.x = 0
	velocity.y = 0
	if key_left != key_right :
		var accele : float = speed
		if key_left :
			accele *= -1
		#end if
		velocity.x += accele
	#end if
	if key_up != key_down :
		var accele : float = speed
		if key_up :
			accele *= -1
		#end if
		velocity.y += accele
	#end if
#end func


