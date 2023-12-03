extends Area2D


signal player_item_collide(id)


func _process(_delta):
	pass


func _on_body_entered(body):
	if body.name == "Player":
		player_item_collide.emit(self.get_instance_id())
	pass # Replace with function body.
