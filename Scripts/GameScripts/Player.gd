extends CharacterBody2D

signal shoot(bullet, direction, location)

# var about player
var vel
var speed
var fire_timer
var fire_duration
var player_hp


func _ready():
	vel = Vector2.ZERO
	speed = 200
	fire_timer = 0
	fire_duration = 0.5
	player_hp = 100


# 플레이어 이동 제어 함수
func _player_move(delta):
	var vector = Vector2.ZERO
	vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	# 정규화 : 대각선 방향 움직임 잡기
	vector = vector.normalized()
	
	if vector.x:
		get_node("Sprite2D").set_flip_h(vector.x < 0)
		
	if vector != Vector2.ZERO:
		vel = vector
	else:
		vel = Vector2.ZERO
	
	move_and_collide(vel * delta * speed)
	

var Bullet = preload("res://Scenes/Bullet.tscn")

# 플레이어 총알 발사 함수
func _gun_fire(delta):
	fire_timer += delta
	
	if fire_timer >= fire_duration:
		fire_timer = 0
		print("fire")
		var mouse = get_global_mouse_position()
		# bullet, player -> mouse direction, player now position
		shoot.emit(Bullet, Vector2(mouse.x - position.x, mouse.y - position.y).normalized(), position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	_player_move(delta)
	_gun_fire(delta)
