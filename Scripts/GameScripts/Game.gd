extends Node2D

var rng = RandomNumberGenerator.new()
var player_hp
var player_hp_box
var game_time
var monster_gen_duration
var temp
var player
var normal_enemy
var player_collide_vector


func _ready():
	# set player hp
	player_hp = 100
	player_hp_box = get_node("UI/Hp_display")
	player_hp_box.text = str(player_hp)
	
	game_time = 0
	monster_gen_duration = 2
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
	enemy.normal_enemy_collide.connect(_normal_enemy_collide)
	add_child(enemy)
	enemy.player = Player
	enemy.position = Vector2(rng.randf_range(0, 1920), rng.randf_range(0, 1080))


func _player_damage(damage):
	player_hp -= damage
	player_hp_box.text = str(player_hp)
	
	if player_hp <= 0:
		# game over
		queue_free()
		
		# go to game over scene TODO
		get_tree().change_scene_to_file("res://Scenes/Start.tscn")
	
	#fire_count_box.text = str(int(fire_count_box.text) + 1)


func _on_player_shoot(Bullet, direction, location):
	var bullet = Bullet.instantiate()
	add_child(bullet)
	bullet.rotation = get_angle_to(direction)
	bullet.position = location
	# direction x bullet speed
	bullet.velocity = direction * 200


func _normal_enemy_collide(vector):
	player.position += vector * 50
	_player_damage(10)
	print("hi")
