extends CharacterBody2D

var player
var speed
var vector

# Called when the node enters the scene tree for the first time.
func _ready():
	speed = 100
	pass # Replace with function body.


func _enemy_move(delta):
	vector = Vector2.ZERO
	vector.x = player.position.x - position.x
	vector.y = player.position.y - position.y
	
	# normalized
	vector = vector.normalized()
	
	# image flip
	if vector.x:
		get_node("Sprite2D").set_flip_h(vector.x < 0)
	
	# move without collide between enemy - enemy
	move_and_collide(vector * speed * delta)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_enemy_move(delta)
	pass
