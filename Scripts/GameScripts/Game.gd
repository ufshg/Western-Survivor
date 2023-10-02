extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_player_shoot(Bullet, direction, location):
	var bullet = Bullet.instantiate()
	add_child(bullet)
	bullet.rotation = get_angle_to(direction)
	bullet.position = location
	print(bullet.velocity)
	bullet.velocity = direction * 500
	print(bullet.velocity)
