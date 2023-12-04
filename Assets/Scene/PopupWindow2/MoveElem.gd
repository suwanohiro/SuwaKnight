extends ColorRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector2(200, 100);

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta):
	var windowSize: Rect2 = get_viewport_rect();
	var position: Vector2 = rect_position;
	position += velocity * delta
	if position.x < 0:
		position.x = 0
		velocity.x *= -1
	if position.y < 0:
		position.y = 0
		velocity.y *= -1
	if position.x > windowSize.size.x:
		position.x = windowSize.size.x;
		velocity.x *= -1
	if position.y > windowSize.size.y:
		position.y = windowSize.size.y;
		velocity.y *= -1
	
	rect_position = position;

