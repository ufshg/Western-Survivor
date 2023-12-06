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
var score

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
		if temp & 1:
			$Sprite2D.set_texture(monster_tex1_night)
			atk = 5 + player_level/5 * 2
			speed = 180
			hp = 3 + player_level/5
			exp = 4 + player_level/5
			score = 5
		else:
			$Sprite2D.set_texture(monster_tex1)
			atk = 3 + player_level/5 * 2
			speed = 170
			hp = 3 + player_level/5
			exp = 2 + player_level/5
			score = 10
	# snake
	elif level == 2:
		if temp & 1:
			$Sprite2D.set_texture(monster_tex2_night)
			atk = 7 + player_level/5 * 2
			speed = 230
			hp = 5 + player_level/5
			exp = 6 + player_level/5
			score = 10
		else:
			$Sprite2D.set_texture(monster_tex2)
			atk = 5 + player_level/5 * 2
			speed = 220
			hp = 5 + player_level/5
			exp = 4 + player_level/5
			score = 20
	# robber
	elif level == 3:
		if temp & 1:
			$Sprite2D.set_texture(monster_tex3_night)
			atk = 25 + player_level/5 * 2
			speed = 240
			hp = 8 + player_level/5
			exp = 15 + player_level/5
			score = 50
		else:
			$Sprite2D.set_texture(monster_tex3)
			atk = 20 + player_level/5 * 2
			speed = 230
			hp = 8 + player_level/5
			exp = 10 + player_level/5
			score = 50
	# coyote
	elif level == 4:
		if temp & 1:
			$Sprite2D.set_texture(monster_tex4_night)
			atk = 20 + player_level/5 * 2
			speed = 280
			hp = 6 + player_level/5
			exp = 25 + player_level/5
			score = 30
		else:
			$Sprite2D.set_texture(monster_tex4)
			atk = 15 + player_level/5 * 2
			speed = 270
			hp = 6 + player_level/5
			exp = 20 + player_level/5
			score = 60


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
