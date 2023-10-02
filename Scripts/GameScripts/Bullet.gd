extends Area2D

var velocity = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity.x = 1
	velocity.y = 1
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position += velocity * delta
