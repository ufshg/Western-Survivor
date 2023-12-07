extends CharacterBody2D

signal boss_collide(vector, atk)
signal boss_bullet(vector)

var rng = RandomNumberGenerator.new()

var player
var speed
var vector
var hp_max
var hp
var atk
var Exp
var score


# Called when the node enters the scene tree for the first time.
func _ready():
	vector = Vector2.ZERO
	speed = 0
	$PatternTimer.start(5)
	pass # Replace with function body.


func init(Player, player_level):
	player = Player
	$Sprite2D.set_scale(Vector2(0.75, 0.75))

	position = Vector2(500, 9900)
	
	# boss value
	hp_max = 25 * player_level
	hp = hp_max
	atk = 30
	score = 300
	Exp = 10


func _boss_move(delta):
	# image flip
	if vector.x:
		$Sprite2D.set_flip_h(vector.x > 0)
	
	velocity = vector * speed
	move_and_slide()
	
	'''
	var temp = move_and_collide(velocity * delta)
	if temp and temp.get_collider().name == "Player":
		boss_collide.emit(vector, atk)
	'''

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_boss_move(delta)
	
	var temp = get_last_slide_collision()
	if temp and temp.get_collider().name == "Player":
		boss_collide.emit(vector, atk)
	pass


func anim():
	$AnimationPlayer.play("damage")


func randMove():
	# normalized and random direction
	vector = Vector2(1, 0)
	vector = vector.normalized().rotated(rng.randf_range(0, 360))
	
	# boss had random speed every move
	speed = rng.randi_range(250, 500)
	
	# next move delay time
	$MoveTimer.start(rng.randi_range(1, 3))


# self healing
func pattern1():
	print("pattern 1")
	self.hp = min(self.hp + self.hp_max / 10, self.hp_max)
	$PatternTimer.start(5)


# shoot player direaction
func pattern2():
	print("pattern 2 start")
	$FireTimer.start(0.2)
	$FireStopTimer.start(3)


func pattern3():
	var temp = Vector2(1, 0)
	for i in range(30):
		boss_bullet.emit(temp)
		temp = temp.rotated(12)
	$PatternTimer.start(5)


func _on_move_timer_timeout():
	randMove()
	

func _on_pattern_timer_timeout():
	print("call pattern timer")
	var prob = rng.randi_range(1, 10)
	print(prob)
	
	if prob == 10:
		pattern1()
	elif prob < 7:
		pattern2()
	else:
		pattern3()
	pass # Replace with function body.


func _on_fire_timer_timeout():
	var temp = player.position - self.position
	boss_bullet.emit(temp.normalized())
	pass # Replace with function body.


func _on_fire_stop_timer_timeout():
	$FireTimer.stop()
	$PatternTimer.start(2)
	pass # Replace with function body.


func end():
	$FireTimer.stop()
	$MoveTimer.stop()
	$PatternTimer.stop()
	$FireStopTimer.stop()
