extends Node2D

var player_tex1 = preload("res://assets/img/player1_right.png")
var player_tex2 = preload("res://assets/img/player2_right.png")
var player_tex3 = preload("res://assets/img/player3_right.png")

var rng = RandomNumberGenerator.new()
var player_hp
var player_hp_box
var player_atk
var fire_timer
var fire_duration
var score
var game_time
var monster_gen_duration
var temp
var player
var normal_enemy
var Bullet
var player_collide_vector
var UI

func _init_player():
	player = preload("res://Scenes/Player.tscn").instantiate()
	player.position = Vector2(960, 540)
	fire_timer = 0
	score = 0
	
	
	if Global.player_type == 1:
		player_hp = 100
		player_atk = 5
		player.speed = 200
		fire_duration = float(2)
	elif Global.player_type == 2:
		player_hp = 50
		player_atk = 4
		player.speed = 300
		fire_duration = float(1)
		player.get_node("Sprite2D").set_texture(player_tex2)
	elif Global.player_type == 3:
		player_hp = 150
		player_atk = 3
		player.speed = 150
		fire_duration = float(3)
		player.get_node("Sprite2D").set_texture(player_tex3)
	
	add_child(player)
	get_node("Camera2D").player = player


func _set_UI(name):
	if name == "Hp":
		UI[name].text = str(player_hp)
	elif name == "Atk":
		UI[name].text = str(player_atk)
	elif name == "Speed":
		var s = str(player.speed)
		UI[name].text = s[0] + "." + s[1]
	elif name == "Firetime":
		UI[name].text = str(fire_duration)
	elif name == "Score":
		UI[name].text = str(score)


func _init_UI():
	UI = {}
	var front = "UI/Panel/"
	var back = "_display"
	
	for name in ["Hp", "Atk", "Speed", "Firetime", "Score"]:
		UI[name] = get_node(front + name + back)
		_set_UI(name)


func _ready():
	# set player hp
	_init_player()
	# UI 초기화 
	_init_UI()
	
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
	enemy.hp = 10
	enemy.position = Vector2(rng.randf_range(0, 1920), rng.randf_range(0, 1080))


func _player_damage(damage):
	player_hp -= damage
	_set_UI("Hp")
	
	if player_hp <= 0:
		# game over
		queue_free()
		
		# go to game over scene TODO
		get_tree().change_scene_to_file("res://Scenes/Start.tscn")


func _player_shoot():
	var bullet = Bullet.instantiate()
	var bullet_angle = get_angle_to(get_global_mouse_position() - player.position)
	bullet.player_bullet_collide.connect(_player_bullet_collide)
	add_child(bullet)
	bullet.rotation = bullet_angle
	bullet.position = player.position
	# direction x bullet speed
	bullet.velocity = Vector2(1, 0).rotated(bullet_angle) * 500


func _normal_enemy_collide(vector):
	player.position += vector * 50
	_player_damage(10)
	print("hi")


func _player_bullet_collide(bullet_id, target_id):
	remove_child(instance_from_id(bullet_id))
	var temp_enemy = instance_from_id(target_id)
	temp_enemy.hp -= player_atk
	
	if temp_enemy.hp <= 0:
		remove_child(temp_enemy)
		score += 1
		_set_UI("Score")
	
	pass
