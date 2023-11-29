extends Node2D

var player_tex1 = preload("res://assets/img/player1_right.png")
var player_tex2 = preload("res://assets/img/player2_right.png")
var player_tex3 = preload("res://assets/img/player3_right.png")

var rng = RandomNumberGenerator.new()
# player info
var player_hp
var player_atk
var fire_duration
var player
var Bullet

# player skill info
var player_shield_timer_MAX
var player_shield_active
var player3_bullet

# game info
var score
var game_time
var temp
var normal_enemy
var player_collide_vector

# timer
var FireTimer
var NormalMonsterGenTimer
var PlayerShieldTimer


func _init_player():
	player = preload("res://Scenes/Player.tscn").instantiate()
	player.position = Vector2(960, 540)
	FireTimer = get_node("FireTimer")
	score = 0
	
	'''
	player_shield
	0 => None
	1 => player2
	2 => shield active
	'''
	PlayerShieldTimer = $PlayerShieldTimer
	player_shield_active = false
	player_shield_timer_MAX = 5
	
	# 1 => player3 unique bullet
	player3_bullet = false
	
	if Global.player_type == 1:
		player_hp = 100
		player_atk = 5
		player.speed = 200
		fire_duration = float(2)
	elif Global.player_type == 2:
		player_hp = 50
		player_atk = 4
		player.speed = 300
		PlayerShieldTimer.start(player_shield_timer_MAX)
		fire_duration = float(1)
		player.get_node("Sprite2D").set_texture(player_tex2)
	elif Global.player_type == 3:
		player_hp = 150
		player_atk = 3
		player.speed = 150
		player3_bullet = true
		fire_duration = float(3)
		player.get_node("Sprite2D").set_texture(player_tex3)
	
	FireTimer.wait_time = fire_duration
	add_child(player)
	get_node("Camera2D").player = player


func _ready():
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_HIDDEN)
	_init_player()
	
	game_time = 0
	
	# init about normal monster gen duration
	NormalMonsterGenTimer = get_node("NormalMonsterGenTimer")
	NormalMonsterGenTimer.wait_time = 2
	
	temp = get_node("Node2D/Sprite2D")
	normal_enemy = preload("res://Scenes/Enemy_normal.tscn")
	Bullet = preload("res://Scenes/Bullet.tscn")


func _process(delta):
	game_time += delta
	
	# 마우스 커서 임시 
	temp.position = get_global_mouse_position()
	pass

# add_normal_enemy

func _on_normal_monster_gen_timer_timeout():
	var enemy = normal_enemy.instantiate()
	enemy.normal_enemy_collide.connect(_normal_enemy_collide)
	add_child(enemy)
	enemy.player = self.player
	enemy.hp = 3
	enemy.position = player.position + Vector2(1200, 0).rotated(rng.randf_range(0, 360))
	#enemy.position = Vector2(rng.randf_range(0, 1920), rng.randf_range(0, 1080))


func _player_damage(damage):
	if Global.player_type != 2:
		player_hp -= damage
	else:
		if player_shield_active:
			player_shield_active = false
			PlayerShieldTimer.start(player_shield_timer_MAX)
		else:
			player_hp -= damage
			PlayerShieldTimer.start(player_shield_timer_MAX)
	
	if player_hp <= 0:
		# game over
		DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_VISIBLE)
		queue_free()
		
		# go to game over scene TODO
		get_tree().change_scene_to_file("res://Scenes/Start.tscn")

# player_shoot()
func _on_fire_timer_timeout():
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
	if not player3_bullet:
		remove_child(instance_from_id(bullet_id))
	
	var temp_enemy = instance_from_id(target_id)
	temp_enemy.hp -= player_atk
	
	if temp_enemy.hp <= 0:
		remove_child(temp_enemy)
		score += 1

func _on_player_shield_timer_timeout():
	self.player_shield_active = true
	
