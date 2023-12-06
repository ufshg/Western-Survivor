extends CharacterBody2D

var monster_tex1 = preload("res://assets/img/monster_rat.png")
var monster_tex2 = preload("res://assets/img/monster_snake.png")
var monster_tex3 = preload("res://assets/img/monster_robber.png")
var monster_tex4 = preload("res://assets/img/monster_coyote.png")
var monster_tex1_night = preload("res://assets/img/monster_shade.png")
var monster_tex2_night = preload("res://assets/img/monster_trace.png")
var monster_tex3_night = preload("res://assets/img/monster_wraith.png")
var monster_tex4_night = preload("res://assets/img/monster_shadow.png")

signal enemy_collide(vector)

var rng = RandomNumberGenerator.new()

var player
var speed
var vector
var hp
var atk
var exp

# Called when the node enters the scene tree for the first time.
func _ready():
	vector = Vector2.ZERO
	pass # Replace with function body.


func init(level, Player, player_level):
	player = Player
	$Sprite2D.set_scale(Vector2(0.4, 0.4))
	position = player.position + Vector2(1200, 0).rotated(rng.randf_range(0, 360))	
	var temp = (player_level - 1) / 10
	# rat
	if level == 1:
		atk = 3 + player_level/5 * 2
		speed = 170
		hp = 4 + player_level/5
		exp = 1 + player_level/5
		if temp & 1:
			$Sprite2D.set_texture(monster_tex1_night)
		else:
			$Sprite2D.set_texture(monster_tex1)
	# snake
	elif level == 2:
		atk = 5 + player_level/5 * 2
		speed = 220
		hp = 5 + player_level/5
		exp = 2 + player_level/5
		if temp & 1:
			$Sprite2D.set_texture(monster_tex2_night)
		else:
			$Sprite2D.set_texture(monster_tex2)
	# robber
	elif level == 3:
		atk = 20 + player_level/5 * 2
		speed = 230
		hp = 7 + player_level/5
		exp = 5 + player_level/5
		if temp & 1:
			$Sprite2D.set_texture(monster_tex3_night)
		else:
			$Sprite2D.set_texture(monster_tex3)
	# coyote
	elif level == 4:
		atk = 15 + player_level/5 * 2
		speed = 250
		hp = 6 + player_level/5
		exp = 10 + player_level/5
		if temp & 1:
			$Sprite2D.set_texture(monster_tex4_night)
		else:
			$Sprite2D.set_texture(monster_tex4)


func _enemy_move(delta):
	vector = Vector2.ZERO
	vector.x = player.position.x - position.x
	vector.y = player.position.y - position.y
	
	# normalized
	vector = vector.normalized()
	
	# image flip
	if vector.x:
		$Sprite2D.set_flip_h(vector.x > 0)
	
	# move without collide between enemy - enemy
	var collision_info = move_and_collide(vector * speed * delta)
	if collision_info:
		enemy_collide.emit(vector, atk)
		position -= vector * 150
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_enemy_move(delta)
	pass
