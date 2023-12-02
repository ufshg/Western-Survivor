extends Node2D

var rng = RandomNumberGenerator.new()

var player_tex1 = preload("res://assets/img/player1_right.png")
var player_tex2 = preload("res://assets/img/player2_right.png")
var player_tex3 = preload("res://assets/img/player3_right.png")

var portrait_tex1 = preload("res://assets/img/portrait1.png")
var portrait_tex2 = preload("res://assets/img/portrait2.png")
var portrait_tex3 = preload("res://assets/img/portrait3.png")

# player info
var player_hp
var player_max_hp
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
var monster
var player_collide_vector
var player_exp
var player_need_exp
var player_level
var player_invincible

# timer
@onready var FireTimer = $FireTimer
@onready var PlayerShieldTimer = $PlayerShieldTimer
@onready var MonsterLv1GenTimer = $Monster_Lv1_GenTimer
@onready var MonsterLv2GenTimer = $Monster_Lv2_GenTimer
@onready var DamageTimer = $DamageTimer


func _init_player():
	player = preload("res://Scenes/Player.tscn").instantiate()
	player.position = Vector2(960, 540)
	score = 0
	
	player_invincible = false
	
	'''
	player_shield
	0 => None
	1 => player2
	2 => shield active
	'''
	player_shield_active = false
	player_shield_timer_MAX = 5
	
	# 1 => player3 unique bullet
	player3_bullet = false
	
	if Global.player_type == 1:
		player_hp = 100
		player_atk = 5
		player.speed = 200
		fire_duration = float(2)
		$UI/portrait.set_texture(portrait_tex1)
	elif Global.player_type == 2:
		player_hp = 50
		player_atk = 4
		player.speed = 300
		PlayerShieldTimer.start(player_shield_timer_MAX)
		fire_duration = float(1)
		player.get_node("Sprite2D").set_texture(player_tex2)
		$UI/portrait.set_texture(portrait_tex2)
	elif Global.player_type == 3:
		player_hp = 150
		player_atk = 3
		player.speed = 150
		player3_bullet = true
		fire_duration = float(3)
		player.get_node("Sprite2D").set_texture(player_tex3)
		$UI/portrait.set_texture(portrait_tex3)
	
	player_max_hp = player_hp
	
	FireTimer.wait_time = fire_duration
	add_child(player)
	get_node("Camera2D").player = player


func _ready():
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_HIDDEN)
	print("Welcome to Our Game")
	print("Your name is " + Global.player_name)
	_init_player()
	
	game_time = 0
	
	# about player exp
	player_exp = 0
	player_level = 1
	player_need_exp = 10
	
	# init about normal monster gen duration
	#MonsterLv1GenTimer.wait_time = 2
	MonsterLv1GenTimer.start(2)
	#MonsterLv2GenTimer.wait_time = 5
	MonsterLv2GenTimer.start(5)
	
	temp = get_node("Node2D/Sprite2D")
	monster = preload("res://Scenes/Monster.tscn")
	Bullet = preload("res://Scenes/Bullet.tscn")
	
	Bgm.stop()
	Bgm.stream = load("res://assets/sound/lost_saga.mp3")
	Bgm.play()


func _process(delta):
	game_time += delta
	
	# 마우스 커서 임시 
	temp.position = get_global_mouse_position()
	

func _on_monster_lv1_gen_timer_timeout():
	var enemy = monster.instantiate()
	# init( monster level, self.player )
	enemy.init(1, self.player)
	enemy.enemy_collide.connect(enemy_collide)
	add_child(enemy)


func _on_monster_lv2_gen_timer_timeout():
	var enemy = monster.instantiate()
	enemy.init(2, self.player)
	enemy.enemy_collide.connect(enemy_collide)
	add_child(enemy)
	

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
	player_invincible = true
	# 1s invincible after hit with enemy
	DamageTimer.start(1)
	
	print('hp %d' % player_hp)
	
	if player_hp <= 0:
		# game over
		Global.result_time = get_node("UI")._result()
		Global.result_score = str(score)
		
		DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_VISIBLE)
		queue_free()
		
		# go to game over scene TODO
		get_tree().change_scene_to_file("res://Scenes/Result.tscn")


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
	$GunSound.play()


func enemy_collide(vector, atk):
	if not player_invincible:
		player.position += vector * 50
		_player_damage(atk)
		$HitSound.play()


func add_exp(monster_exp):
	player_exp += monster_exp
	if player_exp >= player_need_exp:
		player_level += 1
		player_exp -= player_need_exp
		player_need_exp = player_level * 10


func _player_bullet_collide(bullet_id, target_id):
	if not player3_bullet:
		remove_child(instance_from_id(bullet_id))
	
	var temp_enemy = instance_from_id(target_id)
	temp_enemy.hp -= player_atk
	
	if temp_enemy.hp <= 0:
		add_exp(temp_enemy.exp)
		remove_child(temp_enemy)
		score += 1
		$MonsterSound.play()
		print(player_exp, "/", player_need_exp)

func _on_player_shield_timer_timeout():
	self.player_shield_active = true


func _on_damage_timer_timeout():
	self.player_invincible = false
