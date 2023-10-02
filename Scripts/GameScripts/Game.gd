extends Node2D

var fire_count = 0
var fire_count_box


func _ready():
	fire_count_box = get_node("Panel/Fire_count")


func _process(delta):
	pass


func _add_score():
	fire_count_box.text = str(int(fire_count_box.text) + 1)


func _on_player_shoot(Bullet, direction, location):
	var bullet = Bullet.instantiate()
	add_child(bullet)
	bullet.rotation = get_angle_to(direction)
	bullet.position = location
	bullet.velocity = direction * 500
	_add_score()
