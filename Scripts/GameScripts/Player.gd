extends CharacterBody2D

# var about player
var vel
var tmp
var speed

func _ready():
	$NICKNAME.text = Global.player_name
	pass

# 플레이어 이동 제어 함수
func _player_move():
	tmp = Vector2.ZERO
	tmp.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	tmp.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	# 정규화 : 대각선 방향 움직임 잡기
	tmp = tmp.normalized()
	
	if tmp.x:
		get_node("Sprite2D").set_flip_h(tmp.x < 0)
	
	velocity = tmp * speed
	
	#move_and_collide(vel * delta * speed)
	move_and_slide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	_player_move()
