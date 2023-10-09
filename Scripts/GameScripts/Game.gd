extends Node2D

var rng = RandomNumberGenerator.new()
var player_hp
var player_hp_box
var fire_timer
var fire_duration
var game_time
var monster_gen_duration
var temp
var player
var normal_enemy
var Bullet
var player_collide_vector


func _ready():
	# set player hp
	player_hp = 100
	player_hp_box = get_node("UI/Hp_display")
	player_hp_box.text = str(player_hp)
	
	# player instantiate
	player = preload("res://Scenes/Player.tscn").instantiate()
	player.position = Vector2(960, 540)
	add_child(player)
	
	fire_timer = 0
	fire_duration = 2
	
	game_time = 0
	monster_gen_duration = 2
	temp = get_node("Node2D/Sprite2D")
	normal_enemy = preload("res://Scenes/Enemy_normal.tscn")
	
	Bullet = preload("res://Scenes/Bullet.tscn")


func _process(delta):
	game_time += delta
	fire_timer += delta
	
	if game_time >= monster_gen_duration:
		game_time = 0
		_add_normal_enemy(player)
		
	if fire_timer >= fire_duration:
		fire_timer -= fire_duration
		_player_shoot()
	
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


func _player_shoot():
	var bullet = Bullet.instantiate()
	var bullet_angle = get_angle_to(get_global_mouse_position() - player.position)
	add_child(bullet)
	bullet.rotation = bullet_angle
	bullet.position = player.position
	# direction x bullet speed
	bullet.velocity = Vector2(1, 0).rotated(bullet_angle) * 200


func _normal_enemy_collide(vector):
	player.position += vector * 50
	_player_damage(10)
	print("hi")
