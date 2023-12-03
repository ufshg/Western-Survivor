extends CharacterBody2D

var monster_tex1 = preload("res://assets/img/monster_rat.png")
var monster_tex2 = preload("res://assets/img/monster_snake.png")

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
	pass # Replace with function body.


func init(level, Player):
	player = Player
	$Sprite2D.set_scale(Vector2(0.4, 0.4))
	position = player.position + Vector2(1200, 0).rotated(rng.randf_range(0, 360))	
	
	# rat
	if level == 1:
		atk = 2
		speed = 100
		hp = 3
		exp = 2
		$Sprite2D.set_texture(monster_tex1)
	# snake
	elif level == 2:
		atk = 5
		speed = 250
		hp = 6
		exp = 5
		$Sprite2D.set_texture(monster_tex2)


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
		position -= vector * 50
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_enemy_move(delta)
	pass
