extends CharacterBody2D

signal shoot(bullet, direction, location)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var vel = Vector2.ZERO
var rot = Vector2.ZERO
var speed = 200
var fire_timer = 0

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
func _gun_fire():
	print("fire")
	var mouse = get_global_mouse_position()
	rot.x = mouse.x - position.x
	rot.y = mouse.y - position.y
	shoot.emit(Bullet, rot.normalized(), position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	_player_move(delta)
	
	fire_timer += delta
	
	if fire_timer >= 2:
		fire_timer = 0
		_gun_fire()
