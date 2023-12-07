extends CharacterBody2D

signal boss_bullet_collide(bullet_id, vector)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		boss_bullet_collide.emit(self.get_instance_id(), velocity.normalized())
