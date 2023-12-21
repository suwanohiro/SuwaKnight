extends Node2D



func _ready():
	var child = $Body
	child.position += position
	position = Vector2(0, 0)
#end func


