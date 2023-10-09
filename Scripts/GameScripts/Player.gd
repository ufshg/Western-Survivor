extends CharacterBody2D

# var about player
var vel
var speed


func _ready():
	vel = Vector2.ZERO
	speed = 200


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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	_player_move(delta)
