extends Node2D

var rng = RandomNumberGenerator.new()

var player_tex1 = preload("res://assets/img/player1_right.png")
var player_tex2 = preload("res://assets/img/player2_right.png")
var player_tex3 = preload("res://assets/img/player3_right.png")


# player info
var player_hp
var player_max_hp
var player_atk
var player_speed
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
var monster
var Item
var player_collide_vector
var player_exp
var player_need_exp
var player_level

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
		player_speed = 200
		fire_duration = float(2)
	elif Global.player_type == 2:
		player_hp = 50
		player_atk = 4
		player_speed = 300
		PlayerShieldTimer.start(player_shield_timer_MAX)
		fire_duration = float(1)
		player.get_node("Sprite2D").set_texture(player_tex2)
	elif Global.player_type == 3:
		player_hp = 150
		player_atk = 3
		player_speed = 150
		player3_bullet = true
		fire_duration = float(3)
		player.get_node("Sprite2D").set_texture(player_tex3)
	
	player_max_hp = player_hp
	player.speed = player_speed
	
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
	
	monster = preload("res://Scenes/Monster.tscn")
	Item = preload("res://Scenes/Item.tscn")
	Bullet = preload("res://Scenes/Bullet.tscn")
	
	Bgm.stop()
	Bgm.stream = load("res://assets/sound/lost_saga.mp3")
	Bgm.play()


func _process(delta):
	game_time += delta


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
	player.set_collision_layer_value(1, false)
	DamageTimer.start(1)
	player.get_node("AnimationPlayer").play("damage")
	
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
	bullet.velocity = Vector2(1, 0).rotated(bullet_angle) * 800
	$GunSound.play()


func enemy_collide(vector, atk):
	player.position += vector * 50
	_player_damage(atk)
	$HitSound.play()


func add_exp(monster_exp):
	player_exp += monster_exp
	if player_exp >= player_need_exp:
		player_level += 1
		player_exp -= player_need_exp
		player_hp = player_max_hp
		player_need_exp = player_level * 10
		show_ItemSelect()
		get_tree().paused = true


func show_ItemSelect():
	# 4개중 제외할 아이템 번호 
	var randnumber = rng.randi_range(0, 3)
	$UI/ItemSelect.init(randnumber)
	$UI/ItemSelect.visible = true


func _drop_item(pos):
	var prob = rng.randi_range(1, 10)
	print("prob result :", str(prob))
	# prob > 20%
	if prob > 2:return
	print("success")
	var item = Item.instantiate()
	item.player_item_collide.connect(player_item_collide)
	item.position = pos
	add_child(item)


func player_item_collide(id):
	remove_child(instance_from_id(id))
	player_hp = min(player_hp + 20, player_max_hp)


func _player_bullet_collide(bullet_id, target_id):
	if not player3_bullet:
		remove_child(instance_from_id(bullet_id))
	
	var temp_enemy = instance_from_id(target_id)
	temp_enemy.hp -= player_atk
	temp_enemy.position -= temp_enemy.vector * 50
	#temp_enemy.get_node("AnimationPlayer").play("damage")
	
	if temp_enemy.hp <= 0:
		add_exp(temp_enemy.exp)
		var temp_pos = temp_enemy.position
		remove_child(temp_enemy)
		_drop_item(temp_pos)
		score += 1
		$MonsterSound.play()
		print(player_exp, "/", player_need_exp)


func _on_player_shield_timer_timeout():
	self.player_shield_active = true


func _on_damage_timer_timeout():
	player.set_collision_layer_value(1, true)


func _item_select_handler(number):
	if number == 0:
		print("Atk Up")
		player_atk += 1
	elif number == 1:
		print("Speed Up")
		player_speed += 20
		player.speed = player_speed
	elif number == 2:
		print("Hp Up")
		player_max_hp += 20
		player_hp += 20
	elif number == 3:
		print("duration Up")
		fire_duration = max(fire_duration - 0.1, 0.1)
		FireTimer.start(fire_duration)
	
	
	$UI._slot_set(number)
	$UI/ItemSelect.visible = false
	get_tree().paused = false
