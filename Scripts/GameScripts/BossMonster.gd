extends CharacterBody2D

signal enemy_collide(vector)

var rng = RandomNumberGenerator.new()

var player
var speed
var vector
var hp
var atk
var Exp
var score

@onready var PatternTimer = $PatternTimer
@onready var MoveTimer = $MoveTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	vector = Vector2.ZERO
	speed = 0
	pass # Replace with function body.


func init(Player, player_level):
	player = Player
	$Sprite2D.set_scale(Vector2(0.75, 0.75))
	
	# 보스가 맵 내부에 떨어지도록
	var tempPos = player.position + Vector2(500, 0).rotated(rng.randf_range(0, 360))
	while (tempPos.x < -2000) or (4000 < tempPos.x) or (tempPos.y < -2500) or (3500 < tempPos.y):
		tempPos = player.position + Vector2(500, 0).rotated(rng.randf_range(0, 360))		
	position = tempPos
	
	# boss value
	hp = 500
	atk = 30
	score = 300
	Exp = 10
	


func _boss_move(delta):
	# image flip
	if vector.x:
		$Sprite2D.set_flip_h(vector.x > 0)
	
	# move without collide between enemy - enemy
	velocity = vector * speed
	move_and_slide()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_boss_move(delta)
	
	#print(get_last_slide_collision())
	pass


func anim():
	$AnimationPlayer.play("damage")


func randMove():
	print("call")
	# normalized and random direction
	vector = Vector2(1, 0)
	vector = vector.normalized().rotated(rng.randf_range(0, 360))
	
	# boss had random speed every move
	speed = rng.randi_range(150, 500)
	
	# next move delay time
	$MoveTimer.start(rng.randi_range(1, 3))


func _on_move_timer_timeout():
	randMove()
