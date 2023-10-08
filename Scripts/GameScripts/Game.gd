extends Node2D

var rng = RandomNumberGenerator.new()
var fire_count
var fire_count_box
var game_time
var monster_gen_duration
var temp
var player
var normal_enemy


func _ready():
	fire_count = 0
	game_time = 0
	monster_gen_duration = 2
	fire_count_box = get_node("Panel/Fire_count")
	temp = get_node("Node2D/Sprite2D")
	player = get_node("Player")
	normal_enemy = preload("res://Scenes/Enemy_normal.tscn")


func _process(delta):
	game_time += delta
	
	if game_time >= monster_gen_duration:
		game_time = 0
		_add_normal_enemy(player)
	
	# 마우스 커서 임시 
	temp.position = get_global_mouse_position()
	pass


func _add_normal_enemy(Player):
	var enemy = normal_enemy.instantiate()
	add_child(enemy)
	enemy.player = Player
	enemy.position = Vector2(rng.randf_range(0, 1920), rng.randf_range(0, 1080))
	


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
