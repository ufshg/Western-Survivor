extends CharacterBody2D

signal player_bullet_collide(bullet_id, target_id)

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = Vector2(1, 1)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		player_bullet_collide.emit(self.get_instance_id(), collision_info.get_collider_id())
