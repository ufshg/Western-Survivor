extends CharacterBody2D

signal player_bullet_collide(bullet_id, target_id)

var set

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = Vector2(1, 1)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		# 그린의 관통능력
		if Global.player_type == 3:
			add_collision_exception_with(collision_info.get_collider())
		player_bullet_collide.emit(self.get_instance_id(), collision_info.get_collider_id())
