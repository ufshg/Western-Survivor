extends Node2D

<<<<<<< Updated upstream
var fire_count = 0
var fire_count_box
var temp


func _ready():
	fire_count_box = get_node("Panel/Fire_count")
	temp = get_node("Node2D/Sprite2D")


func _process(delta):
=======
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
var player_collide_vector
var Bullet


func _ready():
	# set player hp
	player_hp = 100
	player_hp_box = get_node("UI/Hp_display")
	player_hp_box.text = str(player_hp)
	
	# 플레이어 씬 분리, 인스턴스로 불러옴
	player = preload("res://Scenes/Player.tscn").instantiate()
	player.position.x = 960
	player.position.y = 540
	add_child(player)
	
	# 발사 주기는 여기서 관리
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
		fire_timer = 0
		_player_shoot()
		
	# 마우스 커서 임시 
>>>>>>> Stashed changes
	temp.position = get_global_mouse_position()
	pass


func _add_score():
	fire_count_box.text = str(int(fire_count_box.text) + 1)


func _player_shoot():
	var bullet = Bullet.instantiate()
	var angle = get_angle_to(get_global_mouse_position() - player.position)
	add_child(bullet)
	bullet.rotation = angle
	bullet.position = player.position
	# direction x bullet speed
<<<<<<< Updated upstream
	bullet.velocity = direction * 200
	_add_score()
=======
	bullet.velocity = (Vector2(1, 0).rotated(angle)) * 200


func _normal_enemy_collide(vector):
	player.position += vector * 50
	_player_damage(10)
	print("hi")
>>>>>>> Stashed changes
