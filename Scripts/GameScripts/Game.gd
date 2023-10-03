extends Node2D

var fire_count = 0
var fire_count_box
var temp


func _ready():
	fire_count_box = get_node("Panel/Fire_count")
	temp = get_node("Node2D/Sprite2D")


func _process(delta):
	temp.position = get_global_mouse_position()
	pass


func _add_score():
	fire_count_box.text = str(int(fire_count_box.text) + 1)


func _on_player_shoot(Bullet, direction, location):
	var bullet = Bullet.instantiate()
	add_child(bullet)
	bullet.rotation = get_angle_to(direction)
	bullet.position = location
	# direction x bullet speed
	bullet.velocity = direction * 200
	_add_score()
